# Section 22: Raytracing Intersection Properties and Member Functions

This section specifies the properties, return types, and member functions of the `intersection` class in the Metal Shading Language (MSL) compiled for Raytracing workloads.

---

## 1. Table 39: Raytracing Intersection Properties and Member Functions

The table below catalogs the core properties, return types, and compiler mappings of the `intersection` class, which holds collision attributes returned by the raytracing engine.

| MSL Intersection Member | Return Data Type | Mapped BVH Node / Metadata Source | Clang AST Node | LLVM IR Intrinsic Lowering | AIR Opcode |
|:---|:---|:---|:---|:---|:---|
| `distance` | `float` | Intersection distance along ray direction | `MemberExpr` | `@llvm.air.ray_get_dist(...)` | `air.ray_get_dist` |
| `triangle_id` | `uint` | Flat index of collided triangle primitive | `MemberExpr` | `@llvm.air.ray_get_tri_id(...)`| `air.ray_get_tri_id` |
| `instance_id` | `uint` | User-defined ID of the hit instance | `MemberExpr` | `@llvm.air.ray_get_inst_id(...)`| `air.ray_get_inst_id`|
| `user_instance_id` | `uint` | Custom metadata associated with hit instance | `MemberExpr` | `@llvm.air.ray_get_user_id(...)`| `air.ray_get_user_id`|
| `geometry_id` | `uint` | Index of the target geometry in structure | `MemberExpr` | `@llvm.air.ray_get_geom_id(...)`| `air.ray_get_geom_id`|
| `triangle_barycentric_coords`| `float2` | Barycentric coordinates `(u, v)` of hit point | `MemberExpr` | `@llvm.air.ray_get_bary(...)` | `air.ray_get_bary` |
| `type` | `intersection_type`| Enum: `none`, `triangle`, `bounding_box` | `MemberExpr` | `@llvm.air.ray_get_type(...)` | `air.ray_get_type` |

---

## 2. Low-Level Translation Commentary

### 2.1 Intersection Query Lowering
When a shader queries properties from an `intersection` struct (such as `distance` or `barycentric_coords`):
- Rather than compiling the `intersection` struct as a standard memory-backed allocation, Clang treats the struct members as virtual.
- Queries are compiled directly to optimized LLVM intrinsics (e.g., `@llvm.air.ray_get_bary`), which load the requested metadata directly from hardware register slots populated by the Raytracing traversal engine.
- This compilation model avoids redundant register storage and memory transactions, maximizing execution efficiency.
- If a shader queries properties of an invalid intersection (where `type` is `none`), the query returns undefined data. To prevent this, developers should check the intersection `type` before querying other properties.
- As a result, these virtual properties ensure fast, direct access to hardware-generated raytracing metadata.



## Virtual Member Properties in Raytracing Intersections

The `intersection` class manages collision attributes returned by the raytracing engine:
- **Virtual Properties**: Struct members (such as `distance` or `barycentric_coords`) are compiled as virtual properties.
- **Hardware Register Fetch**: Loads requested metadata directly from specialized register slots populated by the Traversal Engine, avoiding memory transactions.
