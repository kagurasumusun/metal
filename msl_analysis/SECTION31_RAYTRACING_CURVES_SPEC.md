# Section 31: Raytracing Curves and Intersection Pipelines

This section specifies the raytracing curves (linear, bezier, B-spline), geometric primitives, and hardware intersection pipelines inside `<metal_curves>`.

---

## 1. Table 47: Raytracing Curves Geometric Mappings

The table below catalogs how curve geometric properties are mapped to compiler builtins, LLVM IR, and AIR intrinsics.

| MSL Curve Primitive | Representation | Clang AST Node | LLVM IR Intrinsic Lowering | AIR Opcode |
|:---|:---|:---|:---|:---|
| `curves` descriptor | Struct holding control points | `RecordDecl` | `%air.curves_desc` handle | Target metadata block |
| `curve_intersection` | Intersection results (u, v, t) | `RecordDecl` | `%air.curve_intersect` | Target register slots |
| `intersect_curve` | Travis checks on curves | `CXXMemberCallExpr` | `call @llvm.air.intersect_curve(...)` | `air.intersect_curve` |

---

## 2. Low-Level Translation Commentary

### 2.1 C++ Layout of Curve Intersection Struct
Below is the C++ struct layout required to represent a curve intersection inside `<metal_curves>`:

```cpp
#ifndef __METAL_CURVES_H
#define __METAL_CURVES_H

namespace metal {

enum class curve_type { linear, bezier, bspline };

struct alignas(16) curve_intersection {
  float distance;
  uint segment_id;
  float2 uv;
  curve_type type;
};

} // namespace metal

#endif
```

### 2.2 LLVM IR Lowering of Curve Traversal
Below is the LLVM IR assembly generated to perform curve traversal and intersection:
```llvm
define void @intersect_curve_sample(i8 addrspace(4)* %curves_desc, <4 x float> %ray_origin, <4 x float> %ray_dir) {
  %res = call <4 x float> @llvm.air.intersect_curve(i8 addrspace(4)* %curves_desc, <4 x float> %ray_origin, <4 x float> %ray_dir)
  ret void
}

declare <4 x float> @llvm.air.intersect_curve(i8 addrspace(4)*, <4 x float>, <4 x float>)
```


## Section Implementer's Guide & Advanced Dynamic Linkage Specifications for SECTION31_RAYTRACING_CURVES_SPEC

When building a production-grade clang/llvm compiler backend targeting SECTION31_RAYTRACING_CURVES_SPEC:
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
