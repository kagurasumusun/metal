# Section 6: MSL Standard Library Headers, Enums, and Template Declarations

This section lists the entire standard library header layout of the Metal Shading Language (MSL) inside `reference/clang/32023.883/include/metal/`, along with the core enumerations, namespaces, and templated classes.

---

## 1. Standard Header Manifest

The standard headers included in the Metal Shading Language runtime library are detailed below, mapping their source-level namespace and functional targets.

| Header File | Root Namespace | Functional Description & Compiler Target | Mapped Subheaders / Internal Dependencies |
|:---|:---|:---|:---|
| `<metal_stdlib>` | `metal` | The primary entry header of the Metal Standard Library. Automatically imports math, integer, textures, and atomics. | All headers below are conditionally imported by this file. |
| `metal_common` | `metal` | Core preprocessor variables, macros (`METAL_FUNC`, `METAL_PURE`), and platform verification tags. | `<metal_config>` |
| `metal_types` | `metal` | Scalar type declarations (`half`, `float`), vector types, and core standard types (`size_t`, `ptrdiff_t`). | `<metal_config>` |
| `metal_integer` | `metal` | Standard integer math functions (abs, clz, popcount, rotates, saturating math). | `<metal_types>` |
| `metal_math` | `metal` | High-performance and precise transcendental floating-point math functions (sin, cos, exp, logs, sincos). | `<metal_types>`, `<metal_config>` |
| `metal_geometric` | `metal` | Vector algebra and geometric primitives (dot, cross, lengths, distances, normalizations). | `<metal_types>` |
| `metal_relational` | `metal` | Element-wise relational checks (any, all, isnan, isinf, select, bitselects). | `<metal_types>` |
| `metal_texture` | `metal` | Declarations of templated texture classes (`texture1d`, `texture2d`, `texture3d`, `texturecube`, etc.). | `<metal_types>`, `__bits/metal_texture1d`, etc. |
| `metal_atomic` | `metal` | Atomic memory operations and synchronizations (`atomic<T>`, memory order configurations). | `<metal_types>`, `<metal_config>` |
| `metal_simdgroup` | `metal` | Cooperative SIMD-lane execution algorithms and collective barriers. | `<metal_types>` |
| `metal_simdgroup_matrix`| `metal` | Early Simdgroup Matrix structures for GEMM operations. | `<metal_types>` |
| `metal_cooperative_tensor`| `metal` | Cooperative Tensor structures and hardware-accelerated Matrix Multiply-Accumulate (MMA) operations. | `<metal_types>`, `<metal_config>` |
| `metal_raytracing` | `metal` | Raytracing structures (`ray`, `intersection`), acceleration structures, and intersection querying. | `<metal_types>`, `<metal_config>` |
| `metal_mesh` | `metal` | Mesh/Object pipeline primitives, vertex grids, output grids, and payload sharing buffers. | `<metal_types>` |
| `metal_curves` | `metal` | Raytracing curves intersections (bezier, subdivision surfaces, linear segments support). | `<metal_types>` |
| `metal_pixel` | `metal` | Component mappings and packed pixel operations. | `<metal_types>` |
| `metal_limits` | `metal` | Numeric limits for integers and floating-point types (min, max, infinity, huge values). | `<metal_types>` |
| `metal_logging` | `metal` | Custom shader-side logging frameworks (`os_log`, custom printf structures). | `<metal_types>`, `<metal_config>` |
| `metal_command_buffer` | `metal` | Indirect Command Buffers (ICB) for executing GPU commands from shaders. | `<metal_types>` |
| `metal_tessellation` | `metal` | Fixed-function tessellation configurations and patch descriptions. | `<metal_types>` |
| `metal_array` | `metal` | `metal::array<T, N>` standard array structures (safer wrappers around raw arrays). | `<metal_types>` |

---

## 2. Standard Enum Declarations

Core standard enumerations in MSL configure resource execution, sampler behavior, and memory access order.

| Enum Name | Namespace | Enumerator Members / Underlying Values | Hardware / Compilation Role |
|:---|:---|:---|:---|
| `access` | `metal` | `read` (0), `write` (1), `sample` (2), `read_write` (3) | Defines compile-time permissions on texture and buffer descriptors. |
| `memory_order` | `metal` | `memory_order_relaxed` (0), `memory_order_acquire` (1), `memory_order_release` (2), `memory_order_acq_rel` (3), `memory_order_seq_cst` (4) | Sets CPU/GPU memory consistency rules for atomic instructions. |
| `gradient_type`| `metal` | `gradient2d` (0), `gradient3d` (1), `gradientcube` (2) | Configures anisotropic filtering derivatives in texture sampling. |
| `matrix_layout`| `metal` | `column_major` (0), `row_major` (1) | Determines row/column layout in SIMDgroup matrix structures. |
| `ray_flags` | `metal` | `none` (0), `opaque` (1), `accept_first_intersection` (2), `skip_closest_hit_shader` (4), `skip_triangles` (8) | Configures ray-tracing acceleration structure traversal logic. |
| `intersection_type`| `metal`| `none` (0), `triangle` (1), `bounding_box` (2) | Returns ray-primitive collision class during traversal. |

---

## 3. Standard Template Class / Struct Definitions

Templated wrapper classes define resource objects and specialized matrix blocks.

| Template Class / Struct | Key Template Parameters | Primary Member Functions | Compiler / Pipeline Role |
|:---|:---|:---|:---|
| `texture1d<T, access>` | `typename T` (Pixel type), `access A` | `read()`, `write()`, `get_width()`, `get_num_mip_levels()` | Maps 1D textures. Lowered to `%opencl.image1d_t`. |
| `texture2d<T, access>` | `typename T` (Pixel type), `access A` | `sample()`, `read()`, `write()`, `gather()`, `get_width()`, `get_height()` | Maps 2D textures. Lowered to `%opencl.image2d_t`. |
| `texture3d<T, access>` | `typename T` (Pixel type), `access A` | `sample()`, `read()`, `write()`, `get_width()`, `get_height()`, `get_depth()` | Maps 3D textures. Lowered to `%opencl.image3d_t`. |
| `atomic<T>` | `typename T` (int, uint) | `store()`, `load()`, `exchange()`, `compare_exchange_weak()`, `fetch_add()` | Multi-thread atomic variables. Lowered to standard LLVM atomic instructions. |
| `simdgroup_matrix<T, C, R, L>`| `typename T` (Float/Half), `uint C`, `uint R`, `matrix_layout L` | `load()`, `store()`, `multiply()`, `add()` | Simdgroup-cooperative matrix multipliers. Maps to hardware MMA pipelines. |
| `ray` | None | None (Plain Data Struct) | Holds `origin`, `direction`, `min_distance`, `max_distance` for Raytracing. |
| `intersection<T>` | `typename T` (Attributes) | None (Plain Data Struct) | Holds collision attributes returned by the raytracing engine. |
| `array<T, N>` | `typename T`, `size_t N` | `operator[]`, `size()`, `front()`, `back()`, `data()` | Safe static array container. |
| `mesh<V, P, NV, NP, Topology>`| `typename V`, `typename P`, `uint NV`, `uint NP`, `mesh_topology T`| `set_vertex()`, `set_primitive()`, `set_index()`, `set_primitive_count()`| Allocates on-chip mesh primitives and vertex parameters. |



## Namespace Isolation and Template Declarations in `<metal_stdlib>`

To prevent naming collisions with standard C++ libraries, MSL isolates all standard declarations inside the `metal` namespace.
- **Template Classes**: Header definitions use robust template wrappers to declare resource objects (such as `texture2d` or `atomic`).
- **Conditional Compilation**: Header blocks use preprocessor checks (e.g., `#if defined(__HAVE_RAYTRACING__)`) to conditionally declare advanced features, preventing compilation errors on unsupported hardware.
- **Type Traits**: The `<metal_type_traits>` header provides standard C++ type traits (such as `is_same` or `enable_if`) to enable robust template metaprogramming within shaders.

## Structural Header Layout of the `<metal_stdlib>` Master Entry

Below is the complete header layout required to orchestrate nested imports and target capability checks inside `<metal_stdlib>`:

```cpp
#ifndef __METAL_STDLIB
#define __METAL_STDLIB

#include <metal_config>
#include <metal_types>
#include <metal_integer>
#include <metal_math>
#include <metal_geometric>
#include <metal_relational>
#include <metal_texture>
#include <metal_atomic>

#if defined(__HAVE_RAYTRACING__)
#include <metal_raytracing>
#endif

#if defined(__HAVE_MESH_SHADERS__)
#include <metal_mesh>
#endif

#endif // __METAL_STDLIB
```

### Preprocessor Conditional Checks
To prevent header parsing overhead, `<metal_config>` defines core compiler switches and flags:
```cpp
#ifndef __METAL_CONFIG_H
#define __METAL_CONFIG_H

#if !defined(__METAL_VERSION__)
#error "MSL standard headers require __METAL_VERSION__ configuration"
#endif

#define METAL_FUNC inline __attribute__((__always_inline__))
#define METAL_PURE __attribute__((pure))

#endif
```
