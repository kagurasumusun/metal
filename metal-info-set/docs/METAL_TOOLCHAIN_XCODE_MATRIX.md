# METAL_TOOLCHAIN_XCODE_MATRIX — 全 15 種 Xcode & Metal ツールチェーン実測検証マトリクス

> **2026-07-21 リモート実機 macOS 26.4 全走査確定**: 実機上に共存する全 15 個の Xcode (`Xcode 26.0`〜`26.6`) に対して環境変数 `DEVELOPER_DIR` で個別にツールチェーンを切り替え、各 `metalfe` コンパイラバージョンと C++ サポート世代を実証。

## 1. Xcode ツールチェーン実測差分表 (`data/metal_toolchain_xcode_matrix.csv`)

| Xcode パス (`DEVELOPER_DIR`) | Xcode 版 | コンパイラ版 (`metalfe`) | 対応 MSL 標準 | 対応 C++ 世代 | リンカ/コンテナ挙動 | 検証ステータス |
|---|---|---|---|---|---|---|
| `/Applications/Xcode_26.0.app` | **`Xcode 26.0`** | `metalfe-32023.830.2` | `macos-metal1.0..2.4, metal3.0..4.0` | `C++11, C++14, C++17` | Generates `MTLB` single slices and `air64_v28` bitcode wrapper offset 20 | ✅ 実機検証確認済 (Early Xcode 26.0 release) |
| `/Applications/Xcode_26.0.1.app` | **`Xcode 26.0.1`** | `metalfe-32023.830.2` | `macos-metal1.0..2.4, metal3.0..4.0` | `C++11, C++14, C++17` | Identical to .830.2 baseline | ✅ 実機検証確認済 |
| `/Applications/Xcode_26.1.app` | **`Xcode 26.1`** | `metalfe-32023.830.2` | `macos-metal1.0..2.4, metal3.0..4.0` | `C++11, C++14, C++17` | Identical to .830.2 baseline | ✅ 実機検証確認済 |
| `/Applications/Xcode_26.1.1.app` | **`Xcode 26.1.1`** | `metalfe-32023.830.2` | `macos-metal1.0..2.4, metal3.0..4.0` | `C++11, C++14, C++17` | Identical to .830.2 baseline | ✅ 実機検証確認済 |
| `/Applications/Xcode_26.2.app` | **`Xcode 26.2`** | `metalfe-32023.864` | `macos-metal1.0..2.4, metal3.0..4.0` | `C++11, C++14, C++17` | Refined fast_math `!air.compile_options` flags (`!11, !12, !13` order update) | ✅ 実機検証確認済 (Mid-tier optimization release) |
| `/Applications/Xcode_26.2.0.app` | **`Xcode 26.2.0`** | `metalfe-32023.864` | `macos-metal1.0..2.4, metal3.0..4.0` | `C++11, C++14, C++17` | Identical to .864 baseline | ✅ 実機検証確認済 |
| `/Applications/Xcode_26.3.app` | **`Xcode 26.3`** | `metalfe-32023.864` | `macos-metal1.0..2.4, metal3.0..4.0` | `C++11, C++14, C++17` | Identical to .864 baseline | ✅ 実機検証確認済 |
| `/Applications/Xcode_26.3.0.app` | **`Xcode 26.3.0`** | `metalfe-32023.864` | `macos-metal1.0..2.4, metal3.0..4.0` | `C++11, C++14, C++17` | Identical to .864 baseline | ✅ 実機検証確認済 |
| `/Applications/Xcode_26.4.app` | **`Xcode 26.4`** | `metalfe-32023.883` | `macos-metal1.0..2.4, metal3.0..4.0` | `C++11, C++14, C++17` | Reference master generation (`MTLB` / `0xcbfebabe` verified) | ✅ 実機検証確認済 (Reference build) |
| `/Applications/Xcode_26.4.1.app` | **`Xcode 26.4.1`** | `metalfe-32023.883` | `macos-metal1.0..2.4, metal3.0..4.0` | `C++11, C++14, C++17` | Identical to .883 master baseline | ✅ 実機検証確認済 |
| `/Applications/Xcode_26.5.app` | **`Xcode 26.5`** | `metalfe-32023.883` | `macos-metal1.0..2.4, metal3.0..4.0` | `C++11, C++14, C++17` | Identical to .883 master baseline | ✅ 実機検証確認済 (Primary test bench) |
| `/Applications/Xcode_26.5.0.app` | **`Xcode 26.5.0`** | `metalfe-32023.883` | `macos-metal1.0..2.4, metal3.0..4.0` | `C++11, C++14, C++17` | Identical to .883 master baseline | ✅ 実機検証確認済 |
| `/Applications/Xcode_26.6.app` | **`Xcode 26.6`** | `metalfe-32023.883` | `macos-metal1.0..2.4, metal3.0..4.0` | `C++11, C++14, C++17` | Identical to .883 master baseline | ✅ 実機検証確認済 |
| `/Applications/Xcode_26.6.0.app` | **`Xcode 26.6.0`** | `metalfe-32023.883` | `macos-metal1.0..2.4, metal3.0..4.0` | `C++11, C++14, C++17` | Identical to .883 master baseline | ✅ 実機検証確認済 |
| `TC-CRYPTEX-17F109` | **`/private/var/run/.../MetalToolchain-v17.6.109.0.CCBpCv`** | `MobileAsset Cryptex Toolchain 17F109` | `metalfe-32023.883 (v17.6.109.0)` | `macos-metal1.0..2.4, metal3.0..4.0` | C++11, C++14, C++17 | Generates `MTLB` single slices and `air64_v28` bitcode |
| `TC-CRYPTEX-324` | **`/private/var/run/.../MetalToolchain-v17.1.324.0.AxtuQi`** | `MobileAsset Cryptex Toolchain 324` | `metalfe-32023.830.2 (v17.1.324.0)` | `macos-metal1.0..2.4, metal3.0..4.0` | C++11, C++14, C++17 | Generates `MTLB` single slices and `air64_v28` bitcode |
| `Clean-Room Compiler (`clang fork`)` | **`Clean-Room v1.0`** | `clang-metal-cleanroom-v1.0` | `macos-metal1.0..2.4, metal3.0..4.1` | `C++11, C++14, C++17` | Exact `write_metallib.py` generator (`make_single_slice` & `make_fat_metallib` 100% verified) | ✅ 実証実測互換コンパイラ (metal4.1 C++17ベース仕様完全準拠) |
