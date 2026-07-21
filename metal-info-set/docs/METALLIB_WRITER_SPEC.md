# METALLIB_WRITER_SPEC — 自前 .metallib writer 実装仕様書 (draft v0.1)

一次ソース: `data/metallib_structure.csv` (2,584 行・10 実ファイル全走査) /
`data/metallib_summary.md` / 実バイナリ `reference/clang/32023.883/lib/darwin/libtracepoint_rt_*.metallib`。
本書はクリーンルーム writer (=自前 LLVM IR → .metallib コンテナ生成器) の実装起点。全値は実測由来。

## 1. コンテナ全体構造 (実測)

### 1.1 fat (複数 slice) 形式

```
mach-o fat header: magic=0xcafebabe, nfat_arch=N
fat_arch 配列: 各 slice {cputype=0x01000017, cpusubtype=0x00000007,
              offset, size, align=4 (2^4=16)}
```

- **cputype = 0x01000017** (CPU_ARCH_ABI64 | 23 = AIR)、subtype 7 全 slice 共通 (10/10 ファイル実測)
- slice ↔ triple 対応は `metallib_summary.md` 確定表:
  v23=air64_v23 (2.3 系), v25=air64_v25 (2.5 系)… OSX では v23→macosx11.0, v25→macosx13.0。
  参照: `data/os_triple_map.csv` (全 Apple OS 展開)、`!air.version={major,minor,0}` ↔ `air64_v<major*10+minor>` (例 {2,8,0} ↔ v28)。

### 1.2 slice 内部レイアウト (offset は先頭から、全実測値は metallib_structure.csv)

| 領域 | 説明 | 実測例 (libtracepoint_rt_osx slice0) |
|---|---|---|
| slice header | 先頭 88B。存在フィールド (実測順) | 下記 §2 |
| headers blob | 公開シンボル tag 列 (NAME/TYPE/HASH/VERS/MDSZ/ENDT) | headers_start=88, len=2754 |
| types blob | 型リスト | types_start=2938, len=144 |
| empties blob | 空領域 (実測で常に types と同長 144B) | empties_start=3082, len=144 |
| bitcode wrapper | LLVM bitcode wrapper ラップ済み AIR bitcode | offset=3274 |

## 2. slice header フィールド (観測名と実測値)

| フィールド | 値例 | 備考 |
|---|---|---|
| unknown4 | `0x00020080` → bytes `01800200` (LE の可能性注) | 全ファイル同一系。意味未確定 (要実機生成比較) |
| version_u64 | 131077 (= 0x0000000000020005 → 2.5?) | u64 LE。`air.version` との関係は次候補: 131077 = (2<<16)|5 |
| file_size | 17074 | slice 総バイト (fat_arch.size と一致) |
| headers_start/len | 88 / 2754 | headers blob 位置 |
| types_start/len | 2938 / 144 | |
| empties_start/len | 3082 / 144 | |
| bitcode_wrapper_offset | 3274 | = empties_end + 48 の実測関係か (次回定量) |

(フィールドの正確な構造体パッキングは metallib_structure.csv の pos_or_param 列が一次記録)

## 3. headers blob の tag レコード仕様 (917 ENDT = 917 エントリ実測)

```
NAME: 4B tag id + name bytes (NUL 終端)
TYPE: tag id + 1B (観測値 0x03 = function)
HASH: tag id + 32B (SHA-256 らしい一様値。同一 md 持つエントリで同一 HASH)
VERS: tag id + 8B = 02 00 03 00 02 00 03 00 (major=2 minor=3 が 2 連 — 最低/現在のペアか)
MDSZ: tag id + 8B LE (metadata サイズ; 例 0x3550=13648)
ENDT: tag id, 次エントリは 8B アライン頭出し (NAME@228→次 NAME@236)
```

- シンボル名は IR 上の**マングル名 / 変数名そのまま** (例 `_Z24kernel_thread_tracepointPU11MTLConstantKj`, `__tracepoint_data.p1i8`)
- public にする全関数・全グローバル定数が 1 エントリ

## 4. writer 出力要件 (=実装 TODO)

1. AIR bitcode (自前 clang fork の -emit-llvm 出力、air64_vN triple + `!air.version` + エントリ metadata `!air.kernel` 等 — 正本 `docs/IR_GROUND_TRUTH.md` §6.2) を LLVM bitcode wrapper (固定ヘッダ: magic 0x0B17C0DE, version, offset/size, CPU type, から構成) でラップ
2. slice header を §2 のフィールド順・値則で生成
3. headers blob: 公開シンボル走査し §3 レコードを 8B アラインで連結、blob 先頭/長を slice header に記録
4. types blob / empties blob の生成則 (要追加解析 — 現状 144B 同一長のみ確定)
5. fat 化: 複数 ABI 版を emit する場合は fat_arch を align=4 で積む
6. triple↔cputype/version_u64 の対応表は `data/os_triple_map.csv` + §1.1

## 5. 検証計画 (generate-and-verify 原則)

- **byte ident 検証**: 同一 bitcode/同一シンボル集合で自前 writer 出力と Apple `metal -o` 出力を byte 比較 (差分は metallib_structure 互換パーサで構造比較)
- **load 検証**: macOS `MTLDevice -newLibraryWithData:` で自前生成 .metallib をロード → function 参照取得 (実機セッションで XCTest/swiftc 1 枚)
- 現状の未確定項目 (unknown4 意味, HASH 入力範囲, VERS 値則, types/empties 内容則) は**実機で Apple 出力を生成して差分観測**で埋める (推測で埋めない)

## 6. 参照

- 一次表: `data/metallib_structure.csv` (10 ファイル 2,584 フィールド)
- 集約: `data/metallib_summary.md` (tag 度数, slice↔triple)
- IR 側要件: `docs/IR_GROUND_TRUTH.md`, `docs/AIR_VOCABULARY.md`
- 後続工程: AIRNT C API (`docs/GPUCOMPILER_SYMBOLS.md` §2 — 98 symbol) で AIR→GPU binary への JIT 経路を実機検証
