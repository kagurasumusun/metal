# METALLIB_WRITER_SPEC — 自前 .metallib writer 実装仕様書 (v1.0 実機実証確定版)

> **2026-07-21 実測実証更新**: `scripts/analyze_metallib.py` および実機ロード検証 (`swift test_load.swift`) により、未確定4項目（`unknown4` 意味、`HASH`/`VERS` 仕様、`types`/`empties` 最小構成、パッキング仕様）を全確定し、自前ジェネレータ `scripts/write_metallib.py` (`make_single_slice` / `make_fat_metallib`) を実装・実機検証完了。

一次ソース: `data/metallib_structure.csv` (2,584 行・10 実ファイル全走査) / `data/metallib_summary.md` / 実バイナリ `reference/clang/32023.883/lib/darwin/libtracepoint_rt_*.metallib` および実機生成バイナリ (`k.metallib`)。

---

## 1. コンテナ全体構造

### 1.1 Fat (複数 slice) 形式 vs 単一 slice (`MTLB`)

- **Fat 64 形式 (`0xcbfebabe`)**:
  ```c
  struct fat_header_64 {
      uint32_t magic;      // 0xcbfebabe (Big Endian)
      uint32_t nfat_arch;  // slice 数 N (Big Endian)
  };
  struct fat_arch_64 {     // 各 slice 32 Bytes
      uint32_t cputype;    // 0x01000017 (CPU_TYPE_ARM64 | CPU_ARCH_ABI64 | AIR) (BE)
      uint32_t cpusubtype; // 0x00000007 (v23 系等) または 0x00000009 (v25 系等) (BE)
      uint64_t offset;     // slice 開始オフセット (BE)
      uint64_t size;       // slice 総バイト数 (BE)
      uint32_t align;      // アラインメントべき乗 (通常 4=16B または 9=512B) (BE)
      uint32_t reserved;   // 0x00000000 (BE)
  };
  ```
- **単一 slice 形式 (`MTLB`)**:
  Fat ヘッダを持たず、オフセット 0 から直接 **88B Slice Header** (`MTLB` マジック) が始まる。

---

## 2. Slice Header 仕様 (全 88 Bytes, Little Endian)

| オフセット | フィールド名 | 型/サイズ | 実測確定値 / 例 (`k.metallib`) | 仕様・意味 |
|---|---|---|---|---|
| `0..4` | `magic` | `uint32_t` (`<I`) | `0x424c544d` (`'MTLB'`) | Slice Header 識別マジック (`MTLB`) |
| `4..8` | `unknown4` | `uint32_t` (`<I`) | `0x00028001` (または `0x00020080`) | コンテナ ABI フラグ / ビットコードラッパー識別 |
| `8..16` | `version_u64` | `uint64_t` (`<Q`) | `0x0000001a81000009` | メタルバージョン/ターゲット SDK 符号化 |
| `16..24` | `file_size` | `uint64_t` (`<Q`) | `3952` 等 | 本 slice 全体の総バイト数 (Fat 時の `size` と一致) |
| `24..32` | `headers_start` | `uint64_t` (`<Q`) | `88` (`0x58`) | Headers Blob (公開シンボル Directory + レコード) の開始オフセット |
| `32..40` | `headers_len` | `uint64_t` (`<Q`) | `141` 等 | Headers Blob 中の **Directory ヘッダ + 公開シンボルフラットタグ列** の正確な長さ |
| `40..48` | `types_start` | `uint64_t` (`<Q`) | `303` (`0x012f`) 等 | Types Blob の開始オフセット (注: `headers_start + headers_len` と `types_start` の間に `HDYN` 等のグローバル動的ヘッダが配置される) |
| `48..56` | `types_len` | `uint64_t` (`<Q`) | `8` (`0x08`) 等 | Types Blob のサイズ (最小構成時は 8B) |
| `56..64` | `empties_start` | `uint64_t` (`<Q`) | `311` (`0x0137`) 等 | Empties Blob の開始オフセット (`types_start + types_len` と一致) |
| `64..72` | `empties_len` | `uint64_t` (`<Q`) | `8` (`0x08`) 等 | Empties Blob のサイズ (`types_len` と常に同一長) |
| `72..80` | `bc_off` | `uint64_t` (`<Q`) | `319` (`0x013f`) 等 | Bitcode Wrapper Header の開始オフセット (`empties_start + empties_len` と一致) |
| `80..88` | `tail` | `char[8]` (`8s`) | `b'\xd0\x0c\x00\x00\x00\x00\x00\x00'` | 内部オフセット/予約領域 (`8B`) |

*(正確な構造体パッキング: `struct.pack('<IIQQQQQQQQQ8s', ...)`)*

---

## 3. Headers Blob のレコード構造とパッキング仕様

Headers Blob は **8 Bytes の Directory Header** から始まる:
```python
struct.pack('<II', num_entries, headers_len)
# num_entries: 公開シンボル(カーネル/関数)数
# headers_len: Directory Header + シンボルタグ列の総バイト数
```

ディレクトリヘッダ直後（オフセット `88 + 8 = 96`）から、各シンボルの Tag レコードが **個別の 8B パディングを挟まずにタイトに連続** して配置される:

| Tag ID (4B) | Payload Length (2B, `<H`) | Payload | 備考 |
|---|---|---|---|
| `'NAME'` | `len(name) + 1` | `my_kernel\0` | NUL 終端文字列。直後に 8B アラインメントパディングを挿入 |
| `'TYPE'` | `1` | `0x02` (kernel) / `0x03` (func) | シンボル種別（タイト連結） |
| `'HASH'` | `32` | `SHA-256(bitcode)` | ビットコード/シンボルの 32B ハッシュ（タイト連結） |
| `'OFFT'` | `24` | `0x00 * 24` | オフセットテーブル初期値（タイト連結） |
| `'VERS'` | `8` | `02 00 08 00 03 00 02 00` | バージョン範囲定数（タイト連結） |
| `'MDSZ'` | `8` | `metadata_size` (`<Q`) | シンボルに対応する **純ビットコード部 (`wrapped_bitcode`) の正確なバイト数**。この後方にリフレクションブロックが続く |
| `'ENDT'` | `0` (タグのみ `4B`) | なし | エントリ終端タグ |

### グローバルメタデータブロック (`HDYN`)
`headers_start + headers_len` （例: オフセット `229`）と `types_start` （例: オフセット `303`）の間には、74B の `HDYN` (Dynamic Header / Relocation & UUID) が配置される:
`ENDT(4B) + HDYN(22B) + RLST(22B) + UUID(22B: UUIDタグ+16B無作為値) + ENDT(4B)` = `74 Bytes`。

---

## 4. Types Blob と Empties Blob (最小構成仕様)

クリーンルーム writer における最小構成（追加型定義なし時）の固定パターン:
- **Types Blob**: `08 00 00 00 45 4e 44 54` (`0x00000008` 4B + `'ENDT'` 4B) = `8 Bytes`
- **Empties Blob**: `08 00 00 00 45 4e 44 54` (`0x00000008` 4B + `'ENDT'` 4B) = `8 Bytes`

---

## 5. Bitcode Wrapper と Reflection リンキング仕様

### 5.1 Bitcode Wrapper Header (20 Bytes, Little Endian)
`bc_off` に配置される固定ヘッダ (`struct.pack('<IIIII', ...)`):
- `magic`: `0x0B17C0DE` (`de c0 17 0b`)
- `version`: `0`
- `wrapper_offset`: `20`
- `bitcode_size`: 純 `.air` / `.bc` ビットコードのバイト数
- `cputype`: `0x01000017` (`CPU_TYPE_AIR`)

### 5.2 Reflection リンキング
Bitcode 終端 (`bc_off + MDSZ`) の直後から、リフレクション/モジュールメタデータ列 (`NAME module_name.metallib\0 ENDT` および `RBUF` / `AIRR` 反射情報) がコンテナ末尾まで付与される。
※ `write_metallib.py` では `-r/--reflection` 指定により実機由来やコンパイラ由来のリフレクションをそのまま連結・ロード可能。

---

## 6. 実機 Load 検証結果 (`swift test_load.swift`)

実機 macOS 上の Metal ランタイム (`MTLCreateSystemDefaultDevice()`) に対してロード試験を実施:
```swift
let data = try Data(contentsOf: URL(fileURLWithPath: path))
let dData = data.withUnsafeBytes { DispatchData(bytes: $0) }
let lib = try device.makeLibrary(data: dData)
let fn = lib.makeFunction(name: "my_kernel")
```
- **検証判定**:
  - 純ビットコードのみで `MDSZ` とファイル末尾に不整合がある場合 → `Error Domain=MTLLibraryErrorDomain Code=1 "Invalid library file (unexpected end of file)"` を検出。
  - `write_metallib.py` の Slice Header / Directory Header / `MDSZ` 分離 / `HDYN` 配置を適用したコンテナ → **実機 Metal が `makeLibrary` および `makeFunction("my_kernel")` に成功**。
