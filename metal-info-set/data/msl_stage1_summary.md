# MSL API → 変換経路 分類結果 (stage1 抽出)

| 分類 | 件数 | clang対応の要否 |
|---|---:|---|
| builtin_direct (本体が単一 `__metal_*` 呼出) | 2915 | **必要**: CodeGenで `air.*` 等へ lower |
| builtin_composed (分岐/合成を含む) | 30 | **必要**: 複数 builtin の合成 lowering |
| header_composed (__builtin_*/as_type 等のみ) | 195 | 概ね不要 (header内で合成済・最終的に既存表現へ) |
| header_only (純粋なヘッダ実装) | 670 | 不要 (pure C++) |

合計 3810 API (free functions, 9 headers)

## header 別件数

| header | APIs |
|---|---:|
| `metal_math` | 1650 |
| `metal_integer` | 1080 |
| `metal_matrix` | 444 |
| `metal_relational` | 270 |
| `metal_geometric` | 168 |
| `metal_common` | 132 |
| `metal_array` | 32 |
| `metal_pack` | 32 |
| `metal_numeric` | 2 |

## builtin_direct/composed が参照するユニーク __metal_* builtin 数: **93**
(カタログ 686 個のうち free function 経由で使われるもの。残りは texture 等クラスメソッド経由)
