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
