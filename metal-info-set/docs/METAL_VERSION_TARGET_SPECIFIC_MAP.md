# METAL_VERSION_TARGET_SPECIFIC_MAP — 特定 Metal バージョン特有・特定ターゲット特有機能完全対応表

> **2026-07-21 実測確定**: 言語標準世代 (`metal1.x`〜`metal4.0`) および OS プラットフォーム (`macosx`, `ios`, `xros`, `simulator`) 別に発与・制約される全固有仕様・組み込み関数・ランタイム Slice の完全マトリクス表。

## 1. 特定 Metal バージョン特有機能対応表 (`version_specific`)

| 機能名 (`feature_name`) | 導入標準 | 最低 AIR トリプル | 制御マクロ | 対象型・組み込み関数 | クリーンルーム生成制御 |
|---|---|---|---|---|---|
| **Cube Array Textures** | `metal1.1` | `air64_v20-apple-macosx10.11.0` | `__HAVE_TEXTURE_CUBE_ARRAY__` | `texturecube_array<T>, sample, read, write, atomic_exchange` | Enable `texturecube_array` opaque type layout and AIR sample/read/write intrinsics |
| **Texture Buffer (texture_buffer)** | `metal2.1` | `air64_v21-apple-macosx10.14.0` | `__HAVE_TEXTURE_BUFFER__` | `texture_buffer<T>, read, write, atomic_*_texture_buffer_1d_t` | Enable `texture_buffer` opaque `_t` layout as1 and `air.atomic_*.texture_buffer_1d` |
| **Raytracing Acceleration Structure (AS1/AS2)** | `metal2.3` | `air64_v23-apple-macosx11.0.0` | `__HAVE_RAYTRACING__` | `primitive_acceleration_structure, instance_acceleration_structure, intersector<>, ray, intersection_query, intersection_result` | Enable `__metal_intersection_query_t`, `!air.kernel` metadata `ray_data` address space |
| **Sparse Textures (sparse_color)** | `metal2.3` | `air64_v23-apple-macosx11.0.0` | `__HAVE_SPARSE_TEXTURES__` | `sparse_color<T>, sparse_sample, sparse_read, __metal_sample_compare_*_grad` | Emit struct `sparse_color` return type and `air.sparse_sample.*` calls |
| **Simdgroup Matrix 8x8 Operations** | `metal2.3` | `air64_v23-apple-macosx11.0.0` | `__HAVE_SIMDGROUP_MATRIX__` | `simdgroup_matrix<T,C,R>, simdgroup_matrix_8x8_load/store/multiply_accumulate` | Emit `air.simdgroup_matrix_8x8.*` intrinsics |
| **Pull Model Interpolation** | `metal2.3` | `air64_v23-apple-macosx11.0.0` | `__HAVE_PULL_MODEL_INTERPOLATION__` | `interpolant<T,N>, interpolate_at_center, interpolate_at_centroid, interpolate_at_offset` | Emit `air.interpolate.*` intrinsics with `interpolant` handle |
| **Function Constants & Specialized Pipelines** | `metal1.2` | `air64_v20-apple-macosx10.12.0` | `__HAVE_FUNCTION_CONSTANTS__` | `function_constant<T>, is_function_constant_defined, function_handle` | Emit `air.is_function_constant_defined` and specialized constant folding passes |
| **Mesh Shaders & Object Shaders** | `metal3.0` | `air64_v25-apple-macosx13.0.0` | `__HAVE_MESH__` | `mesh<T,V,P>, payload<T>, mesh_grid_properties, set_primitive_count, set_vertex, set_index` | Emit `!air.mesh` / `!air.object` entry metadata and `air.set_primitive_count` |
| **BFloat16 & Half Precision Math** | `metal3.0` | `air64_v25-apple-macosx13.0.0` | `__HAVE_BFLOAT__` | `bfloat, half, __metal_fmax/fmin/fmedian3.bf16` | Emit `.bf16` and `.f16` suffixed AIR arithmetic and conversion intrinsics |
| **Coherent Device Read-Write Textures** | `metal3.2` | `air64_v27-apple-macosx15.0.0` | `__HAVE_COHERENT__` | `coherent(device) texture2d<T, access::read_write>, atomic_max/min ulong4` | Emit device coherent memory fence flags and ulong4 texture atomic intrinsics |
| **Quad-Scoped SIMD Operations** | `metal2.2` | `air64_v22-apple-macosx10.15.0` | `__HAVE_QUAD_SIMD__` | `quad_shuffle, quad_broadcast, quad_ballot, quad_vote_all/any` | Emit `air.quad_shuffle.*` and `air.quad_vote.*` intrinsics |
| **Subgroup & SIMD Group Reduction** | `metal2.1` | `air64_v21-apple-macosx10.14.0` | `__HAVE_SIMD_GROUP_REDUCTION__` | `simd_sum, simd_product, simd_min, simd_max, simd_prefix_exclusive_sum` | Emit `air.simd_reduce.*` and `air.simd_prefix.*` operations |
| **Visible Function Table & Dynamic Dispatch** | `metal2.3` | `air64_v23-apple-macosx11.0.0` | `__HAVE_VISIBLE_FUNCTION_TABLE__` | `visible_function_table<T>, intersection_function_table<>, function_handle` | Emit `air.get_function_handle` and indirect function call tables |
| **Indirect Command Buffers (ICB)** | `metal2.1` | `air64_v21-apple-macosx10.14.0` | `__HAVE_INDIRECT_ARGUMENT_BUFFER__` | `command_buffer, render_command, compute_command, draw_primitives, dispatch_threadgroups` | Emit `air.render_command.*` and `air.compute_command.*` ICB builder calls |
| **Imageblock Memory & Subgroup Operations** | `metal2.0` | `air64_v20-apple-macosx10.13.0` | `__HAVE_IMAGEBLOCKS__` | `imageblock<T>, imageblock_layout, read_imageblock_slice, write_imageblock_slice` | Emit `air.read_imageblock.*` and `air.write_imageblock.*` address space 3/4 access |
| **Metal 4.1 Clean-Room Forward Compatibility** | `metal4.1` | `air64_v28-apple-macosx26.0.0+` | `__HAVE_METAL4_1__` | `!air.language_version = !{!"Metal", i32 4, i32 1, i32 0}` | Accept `-std=metal4.1` flag, emit `4.1.0` language version, define `__HAVE_METAL4_1__` macro |

## 2. 特定 OS/GPU ターゲット特有仕様対応表 (`target_specific`)

| ターゲット区分 (`feature_name`) | 最低標準 | ターゲットトリプル | 判定マクロ | 専用ランタイム Slice (`lib*rt`) | クリーンルーム Slice 選択仕様 |
|---|---|---|---|---|---|
| **macOS Desktop GPU ABI (OSX / MacABI)** | `metal1.0+` | `air64-apple-macosx10.11.0+` | `TARGET_OS_OSX;TARGET_OS_MACCATALYST` | `libair_rt_osx.rtlib, libair_rt_iosmac.rtlib, libtracepoint_rt_osx.metallib` | Select `osx` or `iosmac` slice from fat `.metallib` container (`cputype=0x01000017`) |
| **iOS Mobile GPU ABI (iPhone / iPad)** | `metal1.0+` | `air64-apple-ios8.0.0+` | `TARGET_OS_IPHONE;TARGET_OS_IOS` | `libair_rt_ios.rtlib, libtracepoint_rt_ios.metallib` | Select `ios` slice (`air64-apple-ios*`) from runtime container |
| **tvOS / watchOS Embedded ABI** | `metal1.0+` | `air64-apple-tvos12.0.0+` | `TARGET_OS_TV;TARGET_OS_WATCH` | `libair_rt_tvos.rtlib, libair_rt_watchos.rtlib` | Select `tvos` / `watchos` slice from runtime container |
| **visionOS / xrOS Spatial Computing ABI** | `metal3.1+` | `air64_v26-apple-xros1.0.0+` | `TARGET_OS_XROS;TARGET_OS_VISION` | `libair_rt_xros.rtlib, libtracepoint_rt_xros.metallib` | Select `xros` spatial slice (`air64_v26+`) from runtime container |
| **Apple Silicon AGX Hardware Matrix & Raytracing** | `metal2.3+` | `air64_v23-apple-macosx11.0.0+` | `__HAVE_APPLE_SILICON_AGX__;__HAVE_SIMDGROUP_MATRIX__` | `AGX Hardware Raytracing / Simdgroup Matrix Engines` | Direct hardware instructions via `libapplegpu*-nt.dylib` backend |
| **Simulator Host Paravirtualization ABI** | `metal2.0+` | `air64-apple-ios13.0.0-simulator+` | `TARGET_OS_SIMULATOR` | `libair_rt_iossim.rtlib, libair_rt_tvossim.rtlib, libair_rt_watchossim.rtlib` | Select `*sim` paravirtual slice from container (`apple-*-simulator` triple) |

## 3. クリーンルームコンパイラにおけるバージョン/ターゲット固有分岐の実装方式

- **フロントエンド (`SemaChecking`)**:
  `clang_frontend_impl_map.csv` の評価に基づき、現在のコンパイルターゲットが指定標準 (`-std=`) およびトリプル (`-target`) の最低条件を満たさない場合、対応するマクロ (`__HAVE_*`) を未定義化し、当該関数の呼出を適切なコンパイルエラーとして診断・棄却する。
- **コンテナリンカ (`write_metallib.py`)**:
  ターゲット OS プラットフォームが要求する専用の `.rtlib` / `.metallib` Slice (`libair_rt_osx.rtlib` や `libtracepoint_rt_ios.metallib` 等) を正確に選択してリンクする (`os_triple_map.csv` 準拠)。
