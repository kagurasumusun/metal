# STDLIB / RUNTIME 自前構築 対応表 (機械生成)

生成: 2026-07-21 by build_stdlib_runtime_map.py
(内容は全て csv 正本 data/stdlib_runtime_impl_map.csv 等から機械生成。推測行なし)

## レイヤ構造

- **L1-headers** (43 rows): ユーザー向け MSL 標準ヘッダ (types/templates/builtin 宣言)
- **L2-metal-builtins** (1 rows): __metal_* target builtin 語彙 (clang 実装側が受ける口)
- **L3-air-impl** (3 rows): __air_impl_* ブリッジ (rtlib 内で AIR 化しない経路)
- **L4-rtlib** (1331 rows): airlib/rtlib module (bitcode archive、リンク時に引かれる)
- **L5-driver** (2 rows): metallib / GPUCompiler JIT まわり (実行系側必須要素)

## 棚卸サマリ

- ヘッダ棚卸: 43 個 (data/stdlib_header_inventory.csv)
- rtlib module 棚卸: 1257 modules (data/stdlib_runtime_module_inventory.csv)
- rtlib が直接呼ぶ AIR stem 語彙: 130 (直呼び分のみ)
- rtlib archive: MTLRaytracingRuntime.rtlib, MTLShaderLoggingRuntime.rtlib, libair_rt_ios.rtlib, libair_rt_iosmac.rtlib, libair_rt_iossim.rtlib, libair_rt_osx.rtlib, libair_rt_tvos.rtlib, libair_rt_tvossim.rtlib, libair_rt_watchos.rtlib, libair_rt_watchossim.rtlib, libair_rt_xros.rtlib, libair_rt_xrossim.rtlib, libmetal_rt_ios.a, libmetal_rt_iosmac.a, libmetal_rt_iossim.a, libmetal_rt_osx.a, libmetal_rt_tvos.a, libmetal_rt_tvossim.a, libmetal_rt_watchos.a, libmetal_rt_watchossim.a, libmetal_rt_xros.a, libmetal_rt_xrossim.a, libopencl_rt_osx.a, libopencl_rt_osx_fast-relaxed-math.a, libpost_mesh_dump_rt_ios.rtlib, libpost_mesh_dump_rt_iosmac.rtlib, libpost_mesh_dump_rt_iossim.rtlib, libpost_mesh_dump_rt_osx.rtlib, libpost_mesh_dump_rt_tvos.rtlib, libpost_mesh_dump_rt_tvossim.rtlib, libpost_mesh_dump_rt_watchos.rtlib, libpost_mesh_dump_rt_watchossim.rtlib, libpost_mesh_dump_rt_xros.rtlib, libpost_mesh_dump_rt_xrossim.rtlib, libresource_tracking_rt_ios.rtlib, libresource_tracking_rt_iosmac.rtlib, libresource_tracking_rt_iossim.rtlib, libresource_tracking_rt_osx.rtlib, libresource_tracking_rt_tvos.rtlib, libresource_tracking_rt_tvossim.rtlib, libresource_tracking_rt_watchos.rtlib, libresource_tracking_rt_watchossim.rtlib, libresource_tracking_rt_xros.rtlib, libresource_tracking_rt_xrossim.rtlib, libtracepoint_rt_ios.metallib, libtracepoint_rt_iosmac.metallib, libtracepoint_rt_iossim.metallib, libtracepoint_rt_osx.metallib, libtracepoint_rt_static_ios.a, libtracepoint_rt_static_iosmac.a, libtracepoint_rt_static_iossim.a, libtracepoint_rt_static_osx.a, libtracepoint_rt_static_tvos.a, libtracepoint_rt_static_tvossim.a, libtracepoint_rt_static_watchos.a, libtracepoint_rt_static_watchossim.a, libtracepoint_rt_static_xros.a, libtracepoint_rt_static_xrossim.a, libtracepoint_rt_tvos.metallib, libtracepoint_rt_tvossim.metallib, libtracepoint_rt_watchos.metallib, libtracepoint_rt_watchossim.metallib, libtracepoint_rt_workaround_ios.a, libtracepoint_rt_workaround_iosmac.a, libtracepoint_rt_workaround_iossim.a, libtracepoint_rt_workaround_osx.a, libtracepoint_rt_workaround_tvos.a, libtracepoint_rt_workaround_tvossim.a, libtracepoint_rt_workaround_watchos.a, libtracepoint_rt_workaround_watchossim.a, libtracepoint_rt_workaround_xros.a, libtracepoint_rt_workaround_xrossim.a, libtracepoint_rt_xros.metallib, libtracepoint_rt_xrossim.metallib

## ヘッダ棚卸 (stage1 宣言数 top20)

| header | decls | builtins | classes | pub types |
|---|---|---|---|---|
| metal_math | 3270 | 47 | 3 | 0 |
| metal_integer | 2160 | 24 | 1 | 0 |
| metal_matrix | 444 | 0 | 1 | 1 |
| metal_relational | 372 | 3 | 3 | 0 |
| __bits/metal_texture2d_array | 348 | 30 | 13 | 29 |
| __bits/metal_texturecube_array | 348 | 30 | 13 | 31 |
| __bits/metal_texture2d | 342 | 29 | 13 | 29 |
| __bits/metal_texturecube | 342 | 29 | 13 | 31 |
| __bits/metal_texture3d | 336 | 29 | 12 | 27 |
| __bits/metal_depth2d_array | 258 | 17 | 5 | 12 |
| __bits/metal_depthcube_array | 258 | 17 | 5 | 12 |
| __bits/metal_depth2d | 252 | 16 | 5 | 12 |
| __bits/metal_depthcube | 252 | 16 | 5 | 12 |
| __bits/metal_texture1d_array | 246 | 25 | 12 | 27 |
| __bits/metal_texture1d | 240 | 24 | 12 | 27 |
| metal_common | 228 | 4 | 2 | 0 |
| __bits/metal_texture_buffer | 198 | 21 | 11 | 24 |
| metal_geometric | 183 | 1 | 3 | 5 |
| metal_raytracing | 165 | 81 | 16 | 126 |
| metal_command_buffer | 74 | 37 | 5 | 8 |

## 参照 CSV

- 正本: `data/stdlib_runtime_impl_map.csv` (レイヤ x 項目 対応表)
- `data/stdlib_header_inventory.csv` / `data/stdlib_runtime_module_inventory.csv`
- builtin 側の完全表: `data/builtin_to_air_map.v2.csv` (386 行はそちら)
