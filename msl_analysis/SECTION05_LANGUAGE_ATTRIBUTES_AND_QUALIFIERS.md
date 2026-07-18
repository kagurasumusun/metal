# Section 5: MSL Language Attributes, Qualifiers, and Identifiers

This section details the attributes and qualifiers used in Metal Shading Language (MSL) to define compiler behaviors, resource bindings, hardware entry configurations, and thread coordinate systems.

---

## 1. Function Type / Entry Point Attributes

Entry points in MSL are functions decorated with specific attributes. These attributes instruct Clang to output the functions with specific calling conventions and create entry blocks in `.air` metadata.

| MSL Attribute | Clang Internal representation | Target Shader Stage | Description / Hardware Setup |
|:---|:---|:---|:---|
| `[[kernel]]` | `__attribute__((pcs("spir_kernel")))` | Compute (Kernel) | Defines a parallel compute shader. Sets up hardware grids, dispatch configurations, and local memory sizing. |
| `[[vertex]]` | `__attribute__((pcs("spir_vertex")))` | Vertex | Defines the vertex shader stage. Fetches vertex buffers and executes transformations per vertex index. |
| `[[fragment]]` | `__attribute__((pcs("spir_fragment")))` | Fragment (Pixel) | Defines the rasterized pixel/fragment shader. Processes depth, stencil, and outputs pixel colors to render targets. |
| `[[mesh]]` | `__attribute__((pcs("spir_mesh")))` | Mesh | Modern pipeline stage. Programmatically creates primitive grids and vertex outputs directly on-chip. |
| `[[object]]` | `__attribute__((pcs("spir_object")))` | Object (Task) | Executed before the mesh shader. Sets up dynamic workgroups, payload allocations, and mesh dispatch parameters. |
| `[[intersection]]`| `__attribute__((pcs("spir_intersection")))` | Intersection | Custom intersection shader in Raytracing. Executes ray-bounding box or ray-triangle checks. |

---

## 2. Input/Output Semantics & Variable Qualifiers

These attributes represent system-value semantics. They bind inputs and outputs to fixed-function hardware units or specialized system-managed hardware registers.

| MSL Attribute | Target Stage | Clang AST Attribute | Data Type | Hardware / Driver Interface Role |
|:---|:---|:---|:---|:---|
| `[[position]]` | Vertex/Fragment | `__attribute__((position))` | `float4` | Output: Transformed clip-space position (`xyzw`). Input: Rasterized viewport coordinates. |
| `[[color(n)]]` | Fragment | `__attribute__((color(n)))` | `half4` / `float4` | Maps a fragment shader output vector to render target attachment index `n`. |
| `[[stage_in]]` | Vertex/Fragment | `__attribute__((stage_in))` | Struct | Instructs the GPU to fetch inputs automatically from vertex buffers (using attributes) or fragment raster outputs. |
| `[[point_size]]`| Vertex | `__attribute__((point_size))` | `float` | Sets point-primitive raster size in pixels. |
| `[[flat]]` | Fragment Input | `__attribute__((flat))` | Scalar / Vector | Disables perspective-correct interpolation. Provoking vertex value is used for the primitive. |
| `[[centroid]]` | Fragment Input | `__attribute__((centroid))` | Vector | Restricts pixel coordinate sampling to inside the primitive polygon boundary. |
| `[[sample_no]]` | Fragment Input | `__attribute__((sample_no))` | `uint` | Returns current multisampling pattern index (MSAA index). |

---

## 3. Binding & Resource Layout Attributes

These qualifiers associate MSL parameters with resource slots configured in the Host API (`MTLRenderCommandEncoder`, `MTLComputeCommandEncoder`).

| MSL Attribute | Associated Parameter Class | Clang AST Node | Argument Mapping Section in AIR | Role & Resource Tier |
|:---|:---|:---|:---|:---|
| `[[buffer(n)]]` | Device/Constant Pointer, Ref | `__attribute__((buffer(n)))` | `!air.arg_types` (buffer) | Binds a raw pointer (global/constant address space) to buffer index `n`. |
| `[[texture(n)]]`| `texture1d`, `texture2d`, etc. | `__attribute__((texture(n)))`| `!air.arg_types` (texture) | Binds an image descriptor or texture object to texture index `n`. |
| `[[sampler(n)]]`| `sampler` | `__attribute__((sampler(n)))`| `!air.arg_types` (sampler) | Binds a sampler hardware state configuration to sampler index `n`. |
| `[[threadgroup(n)]]`| `threadgroup` Pointer | `__attribute__((threadgroup(n)))`| `!air.arg_types` (local) | Allocates `n` bytes of high-speed local on-chip SRAM memory for threadgroup sharing. |
| `[[id(n)]]` | Member inside Struct | `__attribute__((id(n)))` | `!air.arg_types` (argument_buffer) | Binds a specific field inside an Argument Buffer to sub-index `n`. |

---

## 4. Workgroup & Thread Identifiers Mapping Matrix

These attributes generate implicit system coordinates and sizes populated by the hardware's Workgroup Dispatcher (Thread Launching Unit).

| MSL Attribute Semantics | Associated Variable Type | Clang Builtin equivalent | AIR Intrinsic Name | Hardware Register Target / Role |
|:---|:---|:---|:---|:---|
| `[[thread_position_in_grid]]` | `uint3` / `uint2` / `uint` | `__builtin_msl_grid_pos` | `@air.thread_position_in_grid` | Global coordinate of the executing thread in the full grid dispatch. |
| `[[thread_position_in_threadgroup]]` | `uint3` / `uint2` / `uint` | `__builtin_msl_tg_pos` | `@air.thread_position_in_threadgroup` | Local coordinate of the executing thread within its current threadgroup. |
| `[[thread_index_in_threadgroup]]` | `uint` | `__builtin_msl_tg_idx` | `@air.thread_index_in_threadgroup` | Flat 1D index of the thread within its current threadgroup. |
| `[[thread_index_in_simdgroup]]` | `uint` | `__builtin_msl_simd_idx` | `@air.thread_index_in_simdgroup` | Flat lane index of the thread within its SIMD unit (0 to 31). |
| `[[simdgroup_position_in_threadgroup]]` | `uint` | `__builtin_msl_simd_tg_pos`| `@air.simdgroup_position_in_threadgroup`| Coordinate representing which SIMD group within the threadgroup the lane belongs to. |
| `[[threadgroups_per_grid]]` | `uint3` | `__builtin_msl_tgs_per_grid`| `@air.threadgroups_per_grid` | Total number of threadgroups dispatched in this grid. |
| `[[threads_per_grid]]` | `uint3` | `__builtin_msl_threads_per_grid`| `@air.threads_per_grid` | Total number of threads dispatched in this grid. |
| `[[threads_per_threadgroup]]` | `uint3` | `__builtin_msl_threads_per_tg`| `@air.threads_per_threadgroup` | Dimensions/size of the local threadgroup structure. |
| `[[simdgroups_per_threadgroup]]` | `uint` | `__builtin_msl_simds_per_tg`| `@air.simdgroups_per_threadgroup` | Total number of SIMD groups grouped inside the threadgroup. |
| `[[threads_per_simdgroup]]` | `uint` | `__builtin_msl_threads_per_simd`| `@air.threads_per_simdgroup` | Number of active execution lanes within a simdgroup (typically 32). |
| `[[grid_origin]]` | `uint3` | `__builtin_msl_grid_origin`| `@air.grid_origin` | Offset representing grid offset (e.g. for sub-rect execution). |
