# METAL_TARGETINFO_IMPL_MAP — Metal 固有 TargetInfo (ターゲットアーキテクチャ・アドレス空間) 完全詳細対応表

> **2026-07-21 実機 IR 解析確定**: Apple Clang (`air64_v28-apple-macosx26.0.0`) の DataLayout およびアドレス空間マッピングを全定量化。

## 1. TargetInfo プロパティ詳細表 (`data/metal_targetinfo_impl_map.csv`)

| 側面 (`target_aspect`) | プロパティ名 | Apple `air64` 値 | LLVM DataLayout / IR 表現 | クリーンルーム実装ノート |
|---|---|---|---|---|---|
| `target_triple` | **`Target Architecture Prefix`** | `air64 / air64_v20 .. air64_v28` | `air64_v28-apple-macosx26.0.0 / air64_v25-apple-ios16.0.0` | Determined by target OS SDK version; `vNN` corresponds to `!air.version` (`v28` -> `2.8.0`) |
| `data_layout` | **`Pointer Width & Alignment (`p0`..`p9`)`** | `64-bit pointers across all address spaces` | ``e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-...-n8:16:32`` | Exact LLVM DataLayout string verified from all 54 golden probe `.ll` files |
| `address_space_mapping` | **`Address Space 0 (`as0`)`** | `Generic / Default / Thread Local memory` | `ptr / ptr addrspace(0)` | Default pointer address space; used for `thread` local stack/register allocations and generic pointers (`__HAVE_GENERIC_ADDRESS_SPACE__`) |
| `address_space_mapping` | **`Address Space 1 (`as1`)`** | `Device memory (`[[buffer(N)]]`, `[[texture(N)]]`)` | `ptr addrspace(1) / `%struct._texture_2d_t addrspace(1)*`` | Global VRAM / unified device memory. All buffer arrays and texture handles reside in `addrspace(1)` |
| `address_space_mapping` | **`Address Space 2 (`as2`)`** | `Constant memory (`constant T*`, `__tracepoint_data`)` | `ptr addrspace(2)` | Read-only constant memory; optimized cache hierarchy for uniform broadcast buffers and global read-only structs |
| `address_space_mapping` | **`Address Space 3 (`as3`)`** | `Threadgroup memory (`threadgroup T*`)` | `ptr addrspace(3)` | On-chip local shared memory (`LDS` / `Shared Memory` across 32/64 threads inside a SIMD group / threadgroup) |
| `address_space_mapping` | **`Address Space 4 (`as4` / `as9`)`** | `Raytracing Data / Object Data (`ray_data`, `object_data`)` | `ptr addrspace(9) / `%struct._intersection_result_t addrspace(9)*`` | Specialized address spaces for BVH ray traversal payloads and object shader payload distribution |
| `resource_limits` | **`Maximum Device Buffers (`max_device_buffers`)`** | `31 (`!3 = !{i32 7, !"air.max_device_buffers", i32 31}`)` | `Integer limit 31` | Enforced by `SemaDeclAttr::CheckMSLResourceIndexBounds` during `[[buffer(N)]]` validation |
| `resource_limits` | **`Maximum Textures (`max_textures`)`** | `128 (`!6 = !{i32 7, !"air.max_textures", i32 128}`)` | `Integer limit 128` | Maximum texture binding slot `[[texture(127)]]` |
| `resource_limits` | **`Maximum Samplers (`max_samplers`)`** | `16 (`!8 = !{i32 7, !"air.max_samplers", i32 16}`)` | `Integer limit 16` | Maximum sampler binding slot `[[sampler(15)]]` |
| `target_defines` | **`Builtin Feature Macros (`__HAVE_*`)`** | ``__HAVE_TEXTURE_CUBE_ARRAY__`, `__HAVE_TEXTURE_BUFFER__`, `__HAVE_RAYTRACING__`, `__HAVE_MESH__`, `__HAVE_COHERENT__`` | `Defined during `TargetInfo::getTargetDefines()`` | Automatically injected by preprocessor based on language standard (`-std=`) and target triple (`os_triple_map.csv`) |
