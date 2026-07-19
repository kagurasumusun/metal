# Section 34: Pixel Formats Packing and Components Layout

This section specifies the hardware packing, unpacking, format clamping, and color conversions inside `<metal_pack>` and `<metal_unpack>`.

---

## 1. Table 50: Color Packing and Unpacking Mappings

The table below catalogs how color packing and unpacking functions are mapped to Clang builtins, LLVM IR, and AIR intrinsics.

| MSL Packing API | Mapped Color Format | Clang AST Node | LLVM IR Intrinsic Lowering | AIR Opcode |
|:---|:---|:---|:---|:---|
| `pack_unorm2x16` | RG16_UNorm (half2 to uint) | `CallExpr` | `call i32 @llvm.air.pack_unorm2x16(...)` | `air.pack_unorm2x16`|
| `unpack_unorm2x16`| RG16_UNorm (uint to half2) | `CallExpr` | `call <2 x half> @llvm.air.unpack_unorm2x16(...)`| `air.unpack_unorm2x16`|
| `pack_snorm2x16` | RG16_SNorm (half2 to uint) | `CallExpr` | `call i32 @llvm.air.pack_snorm2x16(...)` | `air.pack_snorm2x16`|
| `unpack_snorm2x16`| RG16_SNorm (uint to half2) | `CallExpr` | `call <2 x half> @llvm.air.unpack_snorm2x16(...)`| `air.unpack_snorm2x16`|
| `pack_unorm4x8` | RGBA8_UNorm (float4 to uint) | `CallExpr` | `call i32 @llvm.air.pack_unorm4x8(...)` | `air.pack_unorm4x8`|
| `unpack_unorm4x8` | RGBA8_UNorm (uint to float4) | `CallExpr` | `call <4 x float> @llvm.air.unpack_unorm4x8(...)`| `air.unpack_unorm4x8`|

---

## 2. Low-Level Translation Commentary

### 2.1 C++ Header for Packing builtins inside `<metal_pack>`
Below is the C++ header layout required to declare packing functions inside `<metal_pack>`:

```cpp
#ifndef __METAL_PACK_H
#define __METAL_PACK_H

namespace metal {

inline uint pack_unorm2x16(half2 color) {
  return __builtin_msl_pack_unorm2x16(color);
}

inline half2 unpack_unorm2x16(uint packed) {
  return __builtin_msl_unpack_unorm2x16(packed);
}

} // namespace metal

#endif
```

### 2.2 TableGen Patterns for Hardware Packing
Below is the TableGen pattern used to map packing intrinsics directly to single-cycle hardware instructions:
```tablegen
def : Pat<(air_pack_unorm4x8 GPR:$src),
          (AGX_PACK_UNORM4X8 GPR:$src)>;

def : Pat<(air_unpack_unorm4x8 GPR:$src),
          (AGX_UNPACK_UNORM4X8 GPR:$src)>;
```


## Section Implementer's Guide & Advanced Dynamic Linkage Specifications for SECTION34_PIXEL_FORMATS_PACKING_SPECS

When building a production-grade clang/llvm compiler backend targeting SECTION34_PIXEL_FORMATS_PACKING_SPECS:
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
