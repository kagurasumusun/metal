# Section 35: SIMDgroup Matrix Operations and Register Layouts

This section specifies the register mappings, load, store, multiply-accumulate, and thread register sharing of SIMDgroup Matrices inside `<metal_simdgroup_matrix>`.

---

## 1. Table 51: SIMDgroup Matrix Operations Mappings

The table below catalogs how SIMDgroup matrix operations are mapped to Clang builtins, LLVM IR, and AIR intrinsics.

| MSL SIMD Matrix API | Operation Type | Clang AST Node | LLVM IR Intrinsic Lowering | AIR Opcode |
|:---|:---|:---|:---|:---|
| `simdgroup_matrix::load` | Coordinated Load | `CXXMemberCallExpr` | `call void @llvm.air.simd_matrix_load(...)` | `air.simd_matrix_load` |
| `simdgroup_matrix::store`| Coordinated Store | `CXXMemberCallExpr` | `call void @llvm.air.simd_matrix_store(...)`| `air.simd_matrix_store`|
| `simdgroup_matrix::multiply_accumulate`| Matrix multiply-add | `CXXMemberCallExpr` | `call void @llvm.air.simd_matrix_mma(...)` | `air.simd_matrix_mma` |

---

## 2. Low-Level Translation Commentary

### 2.1 C++ Header for SIMDgroup Matrix inside `<metal_simdgroup_matrix>`
Below is the C++ header layout required to declare SIMDgroup matrices inside `<metal_simdgroup_matrix>`:

```cpp
#ifndef __METAL_SIMDGROUP_MATRIX_H
#define __METAL_SIMDGROUP_MATRIX_H

namespace metal {

template <typename T, int C, int R>
class simdgroup_matrix {
private:
  T registers[(C * R) / 32];

public:
  void load(device const T* ptr, uint stride) {
    __builtin_msl_simd_matrix_load(registers, ptr, stride);
  }

  void store(device T* ptr, uint stride) const {
    __builtin_msl_simd_matrix_store(registers, ptr, stride);
  }
};

} // namespace metal

#endif
```

### 2.2 LLVM IR Lowering of MMA Operations
Below is the LLVM IR assembly generated to perform a coordinated $8 	imes 8 	imes 8$ matrix multiply-accumulate operation:
```llvm
define void @simd_mma_sample(float* %a_regs, float* %b_regs, float* %c_regs) {
  call void @llvm.air.simd_matrix_mma(float* %a_regs, float* %b_regs, float* %c_regs)
  ret void
}

declare void @llvm.air.simd_matrix_mma(float*, float*, float*)
```


## Section Implementer's Guide & Advanced Dynamic Linkage Specifications for SECTION35_SIMDGROUP_MATRIX_LAYOUTS

When building a production-grade clang/llvm compiler backend targeting SECTION35_SIMDGROUP_MATRIX_LAYOUTS:
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
