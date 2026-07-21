# clang frontend 実装 対応表 (機械生成)

生成: 2026-07-21 by build_frontend_impl_map.py — `.metal` を clang が parse して
LLVM IR (AIR) にするために必要な要素の棚卸対応表。

**注意**: `clang_impl_point` は我々の fork の配置設計であり、Apple 内部実装の
推測ではない。evidence 列が一次情報の種類を示す。

## レイヤ分布

| layer | rows | 内容 |
|---|---|---|
| attr | 90 | [[...]] attribute spelling |
| codegen | 106 | CodeGen が発行する IR 構造 (metadata/module flag/triple) |
| driver | 1 | AIR 版世代/triple 対応 |
| langopt | 965 | driver フラグ・feature macro |
| lexer | 13 | キーワード (address space/関数クラス) |
| sema | 10 | 実機 clang が出した診断 (Sema チェック必須項目) |
| type | 25 | opaque builtin 型 (IR に出る実体) |

## 主要サマリ

- attribute spelling: 90 (header ∪ spec PDF 採掘)
- opaque 型: 25 (golden IR 実測)
- sema 診断: 10 (収束ループの実エラー文)
- help flag: 964

## 正本 CSV

`data/clang_frontend_impl_map.csv` (本ドキュメントはその要約機械生成版)

core の builtin 対応 (sema→codegen の中心) は `data/builtin_to_air_map.v2.csv` が正本。
