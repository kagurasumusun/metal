# reference/clang/32023.883 全ファイル棚卸 (generate: 2026-07-21T05:18Z)

生成器 `scripts/build_reference_inventory.py` が reference ツリー 145 ファイル全てを実体走査。
一行一ファイル。全値は実体観測 (sha256_16/magic/size/行数/builtin 数)。**推測欄なし**。

## kind 分布

| kind | files |
|---|---|
| header | 71 |
| rtlib(bitcode_archive) | 32 |
| static_archive(macho+bitcode) | 32 |
| metallib | 10 |

- header 総計: 4,229,091 bytes (n_lines 合計 101,046)
- binary 総計: 14,054,576 bytes
- ar メンバ合計: 1792

## platform 別バイナリ数

| platform | files |
|---|---|
| (対象外/共通) | 3 |
| ios | 7 |
| iosmac | 7 |
| iossim | 7 |
| osx | 8 |
| tvos | 7 |
| tvossim | 7 |
| watchos | 7 |
| watchossim | 7 |
| xros | 7 |
| xrossim | 7 |

## ヘッダ側注記

- `include/metal/__bits/` は texture/depth クラス実体 (17)。
- `metal_types.h`/`packed.h`/`simd.h`/`vector_types.h`/`matrix_types.h`/`extents.h`/`units.h` は型基底。
- 0-builtin の infrastructure ヘッダ (metal_limits/metal_type_traits 等) も本表で **存在・内容量が一次確定**済。
- 個別 builtin/クラスの詳細対応は `stdlib_header_inventory.csv` (stage1 43) と `stdlib_runtime_impl_map.csv` (1,380 行) を参照。
