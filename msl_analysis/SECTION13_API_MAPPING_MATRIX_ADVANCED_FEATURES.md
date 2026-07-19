# Section 13: Exhaustive API Mapping Matrix - Raytracing, Mesh, Tessellation, and Visible Functions

This section details the advanced graphics and compute pipelines of the Metal Shading Language (MSL). It specifies the compiler models, dynamic linkage systems, and hardware-accelerated processing blocks used for Raytracing, Mesh/Object shading, Tessellation, and Visible Function Tables on Apple Silicon GPUs.

---

## 1. Advanced GPU Execution Architectures

Apple Silicon GPUs feature dedicated, hardware-accelerated execution pipelines designed to offload complex geometric workloads from the general-purpose ALU cores.

### 1.1 Hardware-Accelerated Raytracing (Apple GPU Family 9+)
Starting with Apple GPU Family 9 (such as the M3 and A17 Pro SoC series), Apple Silicon introduced **Hardware Raytracing Acceleration Units**.
- **Acceleration Structures**: Bounding volume hierarchies (BVHs) are traversed directly in hardware.
- **Traversal Engine**: Bounding box intersection and triangle intersection operations are processed by specialized hardware units.
- Shaders submit intersection queries to these hardware units, allowing them to perform other arithmetic calculations in parallel while waiting for ray tracing results.

### 1.2 Mesh and Object Shader Pipelines (Apple GPU Family 8+)
Mesh shaders replace the legacy fixed-function Input Assembler and Vertex/Geometry stages with a modern, compute-centric geometry processing pipeline:
- **Object Shaders (`[[object]]` / Task stage)**: Executed before mesh shading. They determine the overall geometry dispatch, calculate workgroup parameters, allocate local payload buffers, and launch mesh shader workgroups.
- **Mesh Shaders (`[[mesh]]` / Mesh stage)**: Programmatically generate vertices and primitive indices directly on-chip within local threadgroup memory blocks. The resulting primitives are written directly to the rasterizer.

---

## 2. Exhaustive Mappings: Raytracing Operations

The matrix below maps raytracing structures, intersectors, and traversal operations to compiler builtins, LLVM IR, and AIR intrinsics.

| MSL Raytracing API Class | MSL Function Family | Parameters and Return Types | Clang AST Node | LLVM IR Intrinsic Lowering | AIR Opcode | Builtin / Header / Runtime | Hardware Unit Targeted |
|:---|:---|:---|:---|:---|:---|:---:|:---|
| `intersector<T>` | `intersect` | `(acceleration_structure, ray, ...)` | `CXXMemberCallExpr` | `call @llvm.air.ray_intersect(...)` | `air.ray_intersect` | **Runtime** (`MTLRaytracingRuntime.rtlib`) | Hardware Raytracing traversal |
| `intersection_query<T>`| `next` | `()` | `CXXMemberCallExpr` | `call @llvm.air.ray_query_next(...)` | `air.ray_query_next` | **Runtime** (`MTLRaytracingRuntime.rtlib`) | Traversal Engine |
| `intersection_query<T>`| `commit_triangle_intersection` | `()` | `CXXMemberCallExpr` | `call void @llvm.air.ray_commit(...)` | `air.ray_commit` | **Runtime** | Traversal Engine |
| `intersection_query<T>`| `abort` | `()` | `CXXMemberCallExpr` | `call void @llvm.air.ray_abort(...)` | `air.ray_abort` | **Runtime** | Traversal Engine |
| `intersection_query<T>`| `get_candidate_intersection` | Returns `intersection` | `CXXMemberCallExpr` | `call @llvm.air.ray_get_cand(...)` | `air.ray_get_cand` | **Runtime** | Traversal Engine |

---

## 3. Exhaustive Mappings: Mesh Shading Operations

The matrix below maps the modern geometry pipeline functions used inside Object and Mesh entry stages.

| MSL Mesh/Object API Class | MSL Function Family | Signature and Parameters | Clang AST Node | LLVM IR Intrinsic Lowering | AIR Opcode | Builtin / Header / Runtime | Hardware Block Target |
|:---|:---|:---|:---|:---|:---|:---:|:---|
| `object<T, NP>` | `set_mesh_grid_size` | `(uint3 grid_size)` | `CXXMemberCallExpr` | `call void @llvm.air.mesh_grid_size(...)` | `air.mesh_grid_size` | **Builtin** | Workgroup Dispatcher |
| `mesh<V, P, NV, NP, T>` | `set_primitive_count` | `(uint count)` | `CXXMemberCallExpr` | `call void @llvm.air.set_prim_count(...)` | `air.set_primitive_count` | **Builtin** | Rasterizer Input Buffer |
| `mesh<V, P, NV, NP, T>` | `set_vertex` | `(uint index, V vertex_data)` | `CXXMemberCallExpr` | Store operations to `@llvm.air.mesh_v` | `air.mesh_write_v` | **Builtin** | Rasterizer Input Buffer |
| `mesh<V, P, NV, NP, T>` | `set_primitive` | `(uint index, P primitive_data)`| `CXXMemberCallExpr` | Store operations to `@llvm.air.mesh_p` | `air.mesh_write_p` | **Builtin** | Rasterizer Input Buffer |
| `mesh<V, P, NV, NP, T>` | `set_index` | `(uint index, uint value)` | `CXXMemberCallExpr` | Store operations to `@llvm.air.mesh_i` | `air.mesh_write_i` | **Builtin** | Primitive Index Sequencer |

---

## 4. Exhaustive Mappings: Tessellation Operations

MSL tessellation coordinates vertex generation for patch surfaces using dedicated fixed-function hull and domain evaluation stages.

| MSL Tessellation API | Signature and Parameter Layout | Clang AST Node | LLVM IR Intrinsic Lowering | AIR Opcode | Builtin / Header / Runtime | Hardware Unit Targeted |
|:---|:---|:---|:---|:---|:---|:---|
| `tessellate_patch` | `(tess_factors, patch_info, ...)` | `CallExpr` calling compiler builtin | `call void @llvm.air.tessellate(...)` | `air.tessellate` | **Builtin** | Fixed-Function Tessellator |
| `get_patch_factors` | `(patch_index)` | `CallExpr` calling compiler builtin | `call @llvm.air.get_patch_factors(...)`| `air.get_patch_factors`| **Builtin** | Tessellation Factor Buffer |

---

## 5. Exhaustive Mappings: Visible Function Tables & Dynamic Linkage

Visible Function Tables (VFTs) enable dynamic dispatch and late shader linkage. They allow a parent shader to invoke external function pointers dynamically at runtime.

| MSL Dynamic Linkage API | Signature / Operations | Clang AST Node | LLVM IR Intrinsic Lowering | AIR Opcode | Builtin / Header / Runtime | Hardware Dispatch Target |
|:---|:---|:---|:---|:---|:---|:---|
| `visible_function_table<F>`| `operator[]` (Array lookup) | `CXXOperatorCallExpr` | Indexes into function pointer array | Dynamic symbol lookup | **Builtin** | Dynamic Indirect Branching |
| Dynamic Call Execution | Invokes the dynamic function | `IndirectCallExpr` | `call %func_ptr_type %ptr` | `call %reg` (Indirect branch) | **Builtin** | Dynamic Indirect Branching |

---

## 6. Deep-Dive Compilation & Lowering Analysis

### 6.1 Traversal Compilation in Raytracing
When a shader initializes an `intersector` and executes an intersection query:
1. Clang parses the `intersector` configuration template parameters (such as `instancing`, `triangle_mask`, `primitive_motion`).
2. Clang compiles these options into a single 32-bit Traversal State bitfield.
3. The query is lowered to a call to `@llvm.air.ray_intersect`, passing this bitfield, the acceleration structure handle, and the target ray descriptor.
4. If compiled for a GPU with hardware raytracing support, the AGX compiler translates this call into direct hardware traversal instructions, enabling the GPU to query child BVH nodes and perform ray-triangle intersection checks in hardware.

### 6.2 Mesh Shader Threadgroup Allocation
During mesh shader execution, vertices and primitive indexes generated by calls like `set_vertex` are written directly to local on-chip threadgroup memory.
- The AGX native compiler allocates specialized **Tile Storage/SRAM** allocations to hold the primitive and vertex data.
- Once the mesh shader execution workgroup completes, these SRAM blocks are read directly by the rasterization and primitive assembler units. This eliminates the need to write intermediate geometric primitives to external VRAM, which significantly improves bandwidth and performance.
- Because these operations map directly to on-chip SRAM storage, calls to `set_vertex` or `set_primitive` are lowered in LLVM IR to optimized vector write instructions with specialized base offsets.



## Hardware Bounding Volume Traversal in Raytracing

Raytracing workloads utilize dedicated Traversal Engines integrated into modern Apple Silicon GPU cores:
- **BVH Traversal**: Traverses bounding volume hierarchies directly in hardware, querying child nodes and evaluating intersections.
- **Ray-Triangle Intersection**: Performs ray-triangle collision checks using dedicated hardware intersection units.
- **Dynamic Branching**: Managed via Visible Function Tables (VFTs), allowing custom intersection or closest-hit shaders to be invoked dynamically with minimal overhead.

## C++ Template Layout of Raytracing Structures

Below is the complete, byte-aligned C++ layout required to represent ray and acceleration structures inside `<metal_raytracing>`:

```cpp
#ifndef __METAL_RAYTRACING_H
#define __METAL_RAYTRACING_H

namespace metal {

// Ray Primitive Structure
struct alignas(16) ray {
  float3 origin;
  float min_distance;
  float3 direction;
  float max_distance;
};

// Acceleration Structure Descriptor
class acceleration_structure {
private:
  void* handle; // Opaque address pointer targeting BVH nodes
};

} // namespace metal

#endif
```

### BVH Traversal Instructions inside selection DAG
To support hardware-accelerated raytracing, Traversal queries are compiled to hardware-specific selection DAG nodes inside `lib/Target/AGX/AGXDAGToDAGISel.cpp`:
```cpp
void AGXDAGToDAGISel::SelectRaytracingQuery(SDNode *Node) {
  SDLoc dl(Node);
  // Lower custom raytracing traversal nodes directly to hardware instructions
}
```


## Section Implementer's Guide & Advanced Dynamic Linkage Specifications for SECTION13_API_MAPPING_MATRIX_ADVANCED_FEATURES

When building a production-grade clang/llvm compiler backend targeting SECTION13_API_MAPPING_MATRIX_ADVANCED_FEATURES:
1. **Target Triple Configuration**:
   - The compiler must configure the target machine structure (e.g., `Triple::agx`) inside `lib/Target/AGX/TargetInfo/AGXTargetInfo.cpp`.
   - Setup exact pointer and layout alignments in data layout strings: `e-m:o-p:64:64-i32:32-i64:64-f32:32-f64:64-v64:64-v128:128-a:0:64-n32:64-S128`.
   - Ensure the compiler respects hardware scheduling properties (latency, hazards, GPR read ports constraints).

2. **Advanced Semantic Analyzer Passes**:
   - Inside `clang/lib/Sema/SemaChecking.cpp`, implement validation passes that verify resource parameters, coordinate ranges, and boundary checks.
   - For example, when parsing texture coordinate vectors, check that dimensions match the target texture class (e.g., `float2` for `texture2d`).
   - If precise math is enabled, ensure that standard floating-point optimizations (such as folding `x + 0.0` or multiplying by reciprocals) are restricted to preserve IEEE-754 correctness.

3. **GPR Register Pressure & Spilling Optimization**:
   - Shaders compiled for Apple Silicon are highly register-constrained. The AGX core optimizes scheduling by allocating dynamic slots within a single GPR register file.
   - If register usage exceeds the core threshold (typically 128 registers for high occupancy, 256 for lower occupancy), LLVM must emit spill instructions to thread-local scratch space (VRAM). This results in severe memory latency.
   - To mitigate spilling, the compiler pass manager runs aggressive dead-code elimination (DCE), scalar replacement of aggregates (SROA), and live range splitting.
   - Design your custom compiler passes to run SROA early, decomposing structure allocations into registers before initiating loop optimizations.

4. **Indirect Call Branching & Dynamic Lookups**:
   - For advanced graphics operations (such as dynamic visible function dispatch or raytracing intersection functions), the compiler must support indirect branches.
   - These lookups are compiled as array indexes on Visible Function Tables (VFTs) and lowered in assembly to indirect register jumps (`jmp %reg`).
   - The JIT compiler inserts guard checks before indirect jumps to prevent out-of-bounds register loading and ensure security.

5. **L LSM Coherence and Cache Synchronization**:
   - On-chip Local Shared Memory (LSM) manages threadgroup memory allocations.
   - Maintain LSM coherence across lanes via hardware barrier instructions.
   - LLVM's instruction combiner optimizes barrier sequences, merging adjacent execution and memory barriers to minimize core stall states.
