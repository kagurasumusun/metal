# STDLIB_CLEANROOM_COMPLETE_MAP — MSL 標準ライブラリ (`metal_stdlib` / `lib*rt`) クリーンルーム完全対応仕様

> **2026-07-21 生成確定**: Apple 公式参照ツリー (`reference/clang/32023.883/`) に収録される **全 71 ヘッダモジュール** および **全 42 事前コンパイルライブラリモジュール** (計 113 エントリ) のクリーンルーム自前実装・コンテナ化完全対応表。

## 1. モジュール種別内訳と実装戦略サマリー

- **ヘッダモジュール (`.metal` / `.h`) — 全 71 件**:
  `simd/simd.h` -> `simd.metal`、`metal_stdlib`、`metal_graphics`、`metal_raytracing`、`metal_tensor` 等。全てクリーンルーム実装においてはインライン C++/MSL ヘッダとして実装され、`builtin_to_air_map.v2.csv` の `__metal_*` 関数を直接 wrap する。
- **事前コンパイルライブラリ (`.metallib` / `.rtlib`) — 全 42 件**:
  `libair_rt_*.rtlib` -> `libair_rt.metallib`、`libtracepoint_rt_*.metallib` -> `libtracepoint_rt.metallib`、`MTLRaytracingRuntime.rtlib` -> `MTLRaytracingRuntime.metallib` 等。これらは自前コンテナ生成器 (`write_metallib.py`) により各ターゲット OS プラットフォーム向けの Slice としてコンパイルされ提供される。

## 2. 主要モジュール別クリーンルーム対応表 (`data/stdlib_cleanroom_complete_map.csv`)

| 原本パス (`entity_path`) | 種別 | クリーンルーム置換名 | 主な機能ガード | クリーンルーム実装仕様 |
|---|---|---|---|---|
| `include/module.modulemap` | `header_module` | `module.modulemap.metal` | `0` | Standard MSL Header (`module.modulemap.metal`) — `builtin_to_air_map.v2.csv` 直結組み込みラッパー |
| `include/opencl-c-base.h` | `header_module` | `opencl-c-base.metal` | `0` | Standard MSL Header (`opencl-c-base.metal`) — `builtin_to_air_map.v2.csv` 直結組み込みラッパー |
| `include/opencl-c.h` | `header_module` | `opencl-c.metal` | `0` | Standard MSL Header (`opencl-c.metal`) — `builtin_to_air_map.v2.csv` 直結組み込みラッパー |
| `include/metal/TargetConditionals.h` | `header_module` | `TargetConditionals.metal` | `0` | Standard MSL Header (`TargetConditionals.metal`) — `builtin_to_air_map.v2.csv` 直結組み込みラッパー |
| `include/metal/metal_array` | `header_module` | `metal_array.metal` | `5` | Standard MSL Header (`metal_array.metal`) — `builtin_to_air_map.v2.csv` 直結組み込みラッパー |
| `include/metal/metal_assert` | `header_module` | `metal_assert.metal` | `0` | Standard MSL Header (`metal_assert.metal`) — `builtin_to_air_map.v2.csv` 直結組み込みラッパー |
| `include/metal/metal_atomic` | `header_module` | `metal_atomic.metal` | `7` | Standard MSL Header (`metal_atomic.metal`) — `builtin_to_air_map.v2.csv` 直結組み込みラッパー |
| `include/metal/metal_command_buffer` | `header_module` | `metal_command_buffer.metal` | `16` | Standard MSL Header (`metal_command_buffer.metal`) — `builtin_to_air_map.v2.csv` 直結組み込みラッパー |
| `include/metal/metal_common` | `header_module` | `metal_common.metal` | `2` | Standard MSL Header (`metal_common.metal`) — `builtin_to_air_map.v2.csv` 直結組み込みラッパー |
| `include/metal/metal_compute` | `header_module` | `metal_compute.metal` | `7` | Standard MSL Header (`metal_compute.metal`) — `builtin_to_air_map.v2.csv` 直結組み込みラッパー |
| `include/metal/metal_config` | `header_module` | `metal_config.metal` | `0` | Standard MSL Header (`metal_config.metal`) — `builtin_to_air_map.v2.csv` 直結組み込みラッパー |
| `include/metal/metal_cooperative_tensor` | `header_module` | `metal_cooperative_tensor.metal` | `1` | Inline MSL Header (`metal_tensor.metal`) — テンソル演算・不透明構造体定義ラッパー |
| `include/metal/metal_curves` | `header_module` | `metal_curves.metal` | `1` | Standard MSL Header (`metal_curves.metal`) — `builtin_to_air_map.v2.csv` 直結組み込みラッパー |
| `include/metal/metal_extended_vector` | `header_module` | `metal_extended_vector.metal` | `4` | Standard MSL Header (`metal_extended_vector.metal`) — `builtin_to_air_map.v2.csv` 直結組み込みラッパー |
| `include/metal/metal_functional` | `header_module` | `metal_functional.metal` | `4` | Standard MSL Header (`metal_functional.metal`) — `builtin_to_air_map.v2.csv` 直結組み込みラッパー |
| `include/metal/metal_geometric` | `header_module` | `metal_geometric.metal` | `2` | Standard MSL Header (`metal_geometric.metal`) — `builtin_to_air_map.v2.csv` 直結組み込みラッパー |
| `include/metal/metal_graphics` | `header_module` | `metal_graphics.metal` | `4` | Standard MSL Header (`metal_graphics.metal`) — `builtin_to_air_map.v2.csv` 直結組み込みラッパー |
| `include/metal/metal_imageblocks` | `header_module` | `metal_imageblocks.metal` | `2` | Standard MSL Header (`metal_imageblocks.metal`) — `builtin_to_air_map.v2.csv` 直結組み込みラッパー |
| `include/metal/metal_initializer_list` | `header_module` | `metal_initializer_list.metal` | `0` | Standard MSL Header (`metal_initializer_list.metal`) — `builtin_to_air_map.v2.csv` 直結組み込みラッパー |
| `include/metal/metal_integer` | `header_module` | `metal_integer.metal` | `8` | Standard MSL Header (`metal_integer.metal`) — `builtin_to_air_map.v2.csv` 直結組み込みラッパー |
| `include/metal/metal_interpolate` | `header_module` | `metal_interpolate.metal` | `1` | Standard MSL Header (`metal_interpolate.metal`) — `builtin_to_air_map.v2.csv` 直結組み込みラッパー |
| `include/metal/metal_limits` | `header_module` | `metal_limits.metal` | `2` | Standard MSL Header (`metal_limits.metal`) — `builtin_to_air_map.v2.csv` 直結組み込みラッパー |
| `include/metal/metal_logging` | `header_module` | `metal_logging.metal` | `1` | Standard MSL Header (`metal_logging.metal`) — `builtin_to_air_map.v2.csv` 直結組み込みラッパー |
| `include/metal/metal_math` | `header_module` | `metal_math.metal` | `12` | Standard MSL Header (`metal_math.metal`) — `builtin_to_air_map.v2.csv` 直結組み込みラッパー |
| `include/metal/metal_matrix` | `header_module` | `metal_matrix.metal` | `9` | Standard MSL Header (`metal_matrix.metal`) — `builtin_to_air_map.v2.csv` 直結組み込みラッパー |
| `include/metal/metal_mesh` | `header_module` | `metal_mesh.metal` | `1` | Standard MSL Header (`metal_mesh.metal`) — `builtin_to_air_map.v2.csv` 直結組み込みラッパー |
| `include/metal/metal_numeric` | `header_module` | `metal_numeric.metal` | `0` | Standard MSL Header (`metal_numeric.metal`) — `builtin_to_air_map.v2.csv` 直結組み込みラッパー |
| `include/metal/metal_pack` | `header_module` | `metal_pack.metal` | `1` | Standard MSL Header (`metal_pack.metal`) — `builtin_to_air_map.v2.csv` 直結組み込みラッパー |
| `include/metal/metal_packed_numeric` | `header_module` | `metal_packed_numeric.metal` | `3` | Standard MSL Header (`metal_packed_numeric.metal`) — `builtin_to_air_map.v2.csv` 直結組み込みラッパー |
| `include/metal/metal_packed_vector` | `header_module` | `metal_packed_vector.metal` | `4` | Standard MSL Header (`metal_packed_vector.metal`) — `builtin_to_air_map.v2.csv` 直結組み込みラッパー |
| `include/metal/metal_pixel` | `header_module` | `metal_pixel.metal` | `5` | Standard MSL Header (`metal_pixel.metal`) — `builtin_to_air_map.v2.csv` 直結組み込みラッパー |
| `include/metal/metal_quadgroup` | `header_module` | `metal_quadgroup.metal` | `9` | Standard MSL Header (`metal_quadgroup.metal`) — `builtin_to_air_map.v2.csv` 直結組み込みラッパー |
| `include/metal/metal_raytracing` | `header_module` | `metal_raytracing.metal` | `18` | Inline MSL Header (`metal_raytracing.metal`) — intersector/query/result 組み込み関数ラッパー |
| `include/metal/metal_relational` | `header_module` | `metal_relational.metal` | `5` | Standard MSL Header (`metal_relational.metal`) — `builtin_to_air_map.v2.csv` 直結組み込みラッパー |
| `include/metal/metal_simdgroup` | `header_module` | `metal_simdgroup.metal` | `10` | Inline MSL Header (`simd.metal`) — SIMD/ベクトル/行列演算 C++ インライン展開ラッパー |

*(全 113 件の完全一覧は `data/stdlib_cleanroom_complete_map.csv` を参照)*
