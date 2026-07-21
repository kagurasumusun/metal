# RTLIB_METAL_ONLY_MAP — 純 Metal 固有ランタイム (`lib*rt`) クリーンルーム完全対応表

> **2026-07-21 生成確定**: `data/rtlib_cleanroom_map.csv` から LLVM & Clang 標準ライブラリ関数 (`memcpy` 等) を完全除外した **全 12,668 件** の純 Metal 固有ランタイム関数のクリーンルーム実装戦略・レイヤ分類仕様。

## 1. レイヤ別シンボル分布と実装戦略表

| ランタイムレイヤ | シンボル数 | 主なプレフィックス | クリーンルーム実装戦略 |
|---|---|---|---|
| `rtlib_msl_mangled (MSL マングル済みランタイム定義層)` | 11,830 | `_msl_mangled` / `_Z...` | Direct AIR Intrinsic Emission / Inline C++ MSL Header Definition |
| `rtlib_general_runtime (汎用 Metal ランタイム層)` | 532 | `_general_runtime` / `_Z...` | Direct AIR Intrinsic Emission / Inline C++ MSL Header Definition |
| `rtlib_metal_helper (Metal 共通ランタイム補助層)` | 198 | `_metal_helper` / `_Z...` | Direct AIR Intrinsic Emission / Inline C++ MSL Header Definition |
| `rtlib_resource_tracking (リソース追跡・ディスクリプタ層)` | 59 | `_resource_tracking` / `_Z...` | Direct AIR Intrinsic Emission / Inline C++ MSL Header Definition |
| `rtlib_air_impl (C++ -> AIR 組み込み展開層)` | 26 | `_air_impl` / `_Z...` | Direct AIR Intrinsic Emission / Inline C++ MSL Header Definition |
| `rtlib_tracepoint (実行トレース・デバッグ層)` | 23 | `_tracepoint` / `_Z...` | Direct AIR Intrinsic Emission / Inline C++ MSL Header Definition |

## 2. クリーンルームにおける `lib*rt` ランタイム提供形態仕様

クリーンルーム実装 (`write_metallib.py`) において、これら 12,668+ 関数は以下の 2 系統のいずれかで提供される:
1. **静的リンク済みコンテナ Slice (`.rtlib` / `.metallib`)**:
   - `__air_ra_*` (リソースアクセス check)、`__tracepoint_*`、および複雑な数学補助関数 (`___metal_*`) は、`write_metallib.py` により生成された事前にコンパイル済みの AIR ビットコード Slice とリンク時に統合 (`llvm-link` または `metallib` リンカで結合) される。
2. **フロントエンド直接展開 (`Direct AIR Intrinsic Emission`)**:
   - `_Z...` の大部分（ベクトルの加減乗除や単一 AIR 命令に対応する MSL 組み込み関数）は、`clang_frontend_impl_map.csv` および `builtin_to_air_map.v2.csv` のマスタ表に基づきフロントエンドコード生成 (`CodeGenFunction`) 時に AIR 組み込み命令へ直接下り展開される。
