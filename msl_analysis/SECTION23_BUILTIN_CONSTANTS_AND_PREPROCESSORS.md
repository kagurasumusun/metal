# Section 23: Builtin Math Constants and Capability Macros

This section specifies the preprocessor definitions, mathematical constants, and capability query macros predefined by the compiler in the Metal Shading Language (MSL).

---

## 1. Table 40: Predefined Constants and Capability Macros

The table below catalogs the predefined constants, mathematical constants, and preprocessor capability query macros supported in MSL.

| MSL Preprocessor / Macro | Data Type | Default Constant Value | Minimum MSL Version | Purpose / Hardware Target |
|:---|:---:|:---:|:---:|:---|
| `M_PI_F` | `float` | `3.14159265f` | MSL 1.0 | Single-precision Pi constant. |
| `M_E_F` | `float` | `2.71828182f` | MSL 1.0 | Single-precision Euler's constant. |
| `M_LOG2E_F` | `float` | `1.44269504f` | MSL 1.0 | Single-precision $\log_2(e)$ constant. |
| `M_SQRT2_F` | `float` | `1.41421356f` | MSL 1.0 | Single-precision $\sqrt{2}$ constant. |
| `__METAL_VERSION__` | `int` | `310` (e.g. for MSL 3.1) | MSL 1.0 | Identifies target compiled MSL language version. |
| `__HAVE_RAYTRACING__` | Macro | Predefined if supported | MSL 2.3 | Preprocessor query for hardware raytracing support. |
| `__HAVE_MESH_SHADERS__` | Macro | Predefined if supported | MSL 2.4 | Preprocessor query for mesh and object shader pipelines. |
| `__HAVE_COOPERATIVE_TENSORS__`| Macro | Predefined if supported | MSL 3.0 | Preprocessor query for hardware tensor matrix engines. |
| `__METAL_FAST_MATH__` | Macro | Predefined if enabled | MSL 1.0 | Set when `-ffast-math` is active. |

---

## 2. Low-Level Translation Commentary

### 2.1 Dynamic Capability Queries
MSL uses predefined macros to enable conditional compilation:
- This allows developers to write single, cross-compatible source files that scale dynamically from early iOS devices (e.g., Apple GPU Family 4) to modern Apple Silicon Macs (e.g., Apple GPU Family 10).
- For example, if `__HAVE_RAYTRACING__` is defined, the shader can compile hardware-accelerated intersection queries; otherwise, it can fall back to manual BVH traversal or software approximations.
- During parsing, Clang evaluates these preprocessor macros before starting semantic analysis.
- This compilation model prevents unsupported instructions from being lowered, ensuring robust compilation across diverse hardware targets.



## Compiler Query Macros and Target Flags

Predefined preprocessor definitions enable conditional compilation:
- **Target OS Identifiers**: Evaluate target platforms before starting semantic analysis.
- **Capability Query Macros**: Predefine macros (such as `__HAVE_RAYTRACING__`) to scale shader compilation dynamically across different GPU families.

## Structural Layout of predefined Compiler constants

Below is the predefined preprocessor target constants set by the compiler:

```cpp
#ifndef __METAL_PREDEFINES_H
#define __METAL_PREDEFINES_H

#define __METAL_VERSION__ 310
#define __HAVE_RAYTRACING__ 1
#define __HAVE_MESH_SHADERS__ 1
#define __HAVE_COOPERATIVE_TENSORS__ 1

#endif
```

### Compiler Features Queries and Target flags
Preprocessor macros and features checks are initialized dynamically during parsing:
```cpp
void CompilerInstance::InitializeMetalFeatures(MacroBuilder &Builder) {
  Builder.defineMacro("__METAL_VERSION__", "310");
  // Additional features configuration
}
```


## Section Implementer's Guide & Advanced Dynamic Linkage Specifications for SECTION23_BUILTIN_CONSTANTS_AND_PREPROCESSORS

When building a production-grade clang/llvm compiler backend targeting SECTION23_BUILTIN_CONSTANTS_AND_PREPROCESSORS:
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
