# LEGACY_METAL_SUPPORT — 古い Metal 言語標準・AIR バージョン・ターゲット完全対応仕様

> **2026-07-21 実機実測確定**: リモート macOS 26.4 / Xcode 26.5 実機上の `test_matrix_targets.py` および `test_matrix_guards.py` による実測に基づき、Metal 1.0 〜 Metal 4.0 全 12 世代の言語標準フラグ、AIR トリプル、`!air.version` メタデータ、機能ガードマクロの相関仕様を完全定量化。

## 1. 言語標準フラグと AIR/OS トリプル対応表 (`data/legacy_metal_support_map.csv`)

| `-std=` フラグ | 言語バージョン | 最小 OS トリプル (`target`) | AIR 版 (`!air.version`) | 主な追加ガード機能 |
|---|---|---|---|---|
| `macos-metal1.0` | `1.1.0` | `air64-apple-macosx10.11.0` | `2.0.0` | TEXTURE_CUBE_ARRAY (1.1に統合) |
| `macos-metal1.1` | `1.1.0` | `air64-apple-macosx10.11.0` | `2.0.0` | TEXTURE_CUBE_ARRAY (基礎機能) |
| `macos-metal1.2` | `1.2.0` | `air64-apple-macosx10.12.0` | `2.0.0` | TEXTURE_CUBE_ARRAY (基礎機能) |
| `macos-metal2.0` | `2.0.0` | `air64-apple-macosx10.13.0` | `2.0.0` | TEXTURE_CUBE_ARRAY (AIR 2.0 導入) |
| `macos-metal2.1` | `2.1.0` | `air64-apple-macosx10.14.0` | `2.1.0` | TEXTURE_CUBE_ARRAY / TEXTURE_BUFFER (Texture Buffer 導入) |
| `macos-metal2.2` | `2.2.0` | `air64-apple-macosx10.15.0` | `2.2.0` | TEXTURE_CUBE_ARRAY / TEXTURE_BUFFER (基礎機能) |
| `macos-metal2.3` | `2.3.0` | `air64_v23-apple-macosx11.0.0` | `2.3.0` | SPARSE_TEXTURES / SIMDGROUP_MATRIX (Raytracing / Simdgroup Matrix / Sparse Texture 導入) |
| `macos-metal2.4` | `2.4.0` | `air64_v24-apple-macosx12.0.0` | `2.4.0` | SPARSE_TEXTURES / SIMDGROUP_MATRIX (基礎機能) |
| `metal3.0` | `3.0.0` | `air64_v25-apple-macosx13.0.0` | `2.5.0` | SIMDGROUP_MATRIX / MESH (Mesh Shaders / AIR 2.5 導入) |
| `metal3.1` | `3.1.0` | `air64_v26-apple-macosx14.0.0` | `2.6.0` | SIMDGROUP_MATRIX / MESH (AIR 2.6 導入) |
| `metal3.2` | `3.2.0` | `air64_v27-apple-macosx15.0.0` | `2.7.0` | MESH / COHERENT (Coherent Textures / AIR 2.7 導入) |
| `metal4.0` | `4.0.0` | `air64_v28-apple-macosx26.0.0` | `2.8.0` | MESH / COHERENT (AIR 2.8 導入) |
| `metal4.1` | `4.1.0` | `air64_v28-apple-macosx26.0.0` | `2.8.0` | COHERENT / METAL4_1 (!air.language_version 4.1.0 発行および __HAVE_METAL4_1__ 定義) |

## 2. 実機コンパイラ (`xcrun metal`) における旧バージョン指定の絶対ルール

1. **プレフィックス則 (`macos-` / `ios-`)**:
   - Metal 1.0 〜 Metal 2.4 までは、ターゲット OS プラットフォームを表すプレフィックス（`macos-metal1.1` または `ios-metal2.0` 等）が**必須**であり、裸の `-std=metal2.0` は `error: invalid value 'metal2.0'` で拒絶される。
   - Metal 3.0 以降 (`metal3.0`, `metal3.1`, `metal3.2`, `metal4.0`) ではプレフィックスが撤廃され、裸の `-std=metal3.x` / `-std=metal4.0` で全 OS 統一指定となる。

2. **AIR バージョンの決定則**:
   - 出力される `!air.version` および `target triple` 中の `air64_vNN` は、`-std=` の指定のみではなく **`-target` の OS SDK バージョン** に連与して決定される。
   - 例: `-std=macos-metal2.0 -target air64-apple-macosx11.0.0` をコンパイルした場合、言語バージョンは `2.0.0` となるが、AIR トリプルは `air64_v23-apple-macosx11.0.0` となり `!air.version = !{i32 2, i32 3, i32 0}` (`2.3.0`) が出力される。
   - これにより、古い MSL コード (`metal1.x` / `metal2.x`) であっても新しい AIR コンテナ (`air64_v23`〜`air64_v28`) に直接エンコード・実行可能である。

## 3. レガシー Metal サポートのクリーンルーム実装方針

- クリーンルームフロントエンド (`clang fork`) およびコンテナ生成器 (`write_metallib.py`) では、上記 12 世代全ての `-std=` フラグを受理し、対応する `__HAVE_*` マクロのみを条件付き定義する (`guard_idiom.json` / `legacy_metal_support_map.csv` 一致)。
- 古い言語標準から生成される LLVM IR に対しては、ターゲット OS に応じた適切な LLVM Wrapper ヘッダ (`0x0B17C0DE` / `cputype=0x01000017`) と `MTLB` Slice Header を付与してコンテナ化する。
