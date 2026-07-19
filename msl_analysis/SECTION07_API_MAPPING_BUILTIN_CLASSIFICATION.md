# Section 7: API Compilation Classification - Builtin vs. Header-only vs. Runtime

This section specifies how MSL functions are classified during compilation. It outlines the differences in implementation strategies, compile-time characteristics, and dynamic resolution models.

---

## 1. Classification Definitions

Every API family in the Metal Shading Language Standard Library is processed using one of three primary implementation paths:

1. **Compiler Builtin (`Builtin`)**:
   - The function is recognized directly by the Clang front-end or LLVM code generator.
   - It is mapped immediately to a compiler builtin function or standard LLVM IR instruction/intrinsic.
   - *Example*: `metal::cos` maps directly to `__metal_cos` -> `@llvm.cos`.
   - *Performance*: Maximum. Generates inline hardware-specific instructions.

2. **Header-Only Template (`Header`)**:
   - The function is written entirely in C++ templates inside the `<metal_stdlib>` headers.
   - The compiler parses and instantiates the template inline.
   - It does not map directly to a single intrinsic, but is instead lowered to standard scalar and vector instructions (e.g., adds, multiplies, select operations).
   - *Example*: `metal::cross(x, y)` is implemented as inline vector cross multiplication elements.
   - *Performance*: Highly optimized, inline-expanded.

3. **GPU Runtime-Backed (`Runtime`)**:
   - The function is declared in the headers, but its implementation is too complex to inline or map directly to single hardware instructions.
   - The compiler emits a call to an external library function symbol.
   - During JIT compilation, this symbol is linked against a precompiled GPU runtime library archive (e.g., `libair_rt_*.rtlib` or `libmetal_rt_*.a`).
   - *Example*: `metal::nextafter(x, y)` calls `__air_impl_nextafter_f16`, which is resolved from `libair_rt_osx.rtlib`.
   - *Performance*: Medium. Involves branching/subroutine execution in shader cores.

---

## 2. API Classification Matrix

The table below maps MSL API categories to their compilation and linking behaviors.

| API Category | Representative Functions | Implementation Strategy | Compiler / Linker Behavior | GPU Runtime Library Dependency |
|:---|:---|:---:|:---|:---|
| **Scalar Math (Basic)** | `cos`, `sin`, `exp`, `log`, `sqrt`, `floor`, `ceil`, `fma` | **Builtin** | Lowers directly to `@llvm.*` or `@air.*` intrinsics. | None (Inline instructions) |
| **Scalar Math (Complex)**| `nextafter`, `ldexp`, `frexp`, `ilogb` | **Runtime** | Lowered to a call to a compiler-runtime symbol. | `libair_rt_*.rtlib` or `libmetal_rt_*.a` |
| **Vector Algebra** | `dot`, `cross`, `length`, `normalize`, `distance`, `reflect` | **Header** | Inlined template. Lowered to raw multiply-add vector operations. | None |
| **Integer Math** | `clz`, `ctz`, `popcount`, `reverse_bits` | **Builtin** | Lowers directly to `@llvm.ctlz`, `@llvm.cttz`, `@llvm.ctpop`. | None (Direct ALU instructions) |
| **Saturating Integer** | `addsat`, `subsat`, `madsat` | **Builtin** / **Header** | Lowers to `@llvm.sadd.sat` or template clamps. | None |
| **Atomic Operations** | `atomic_store`, `atomic_fetch_add`, etc. | **Builtin** | Emits atomic LLVM IR operations with memory ordering properties. | None (Hardware memory controller atomic instructions) |
| **Texture Sampling** | `sample`, `sample_compare`, `gather` | **Builtin** | Lowered to `@air.sample` intrinsics targeting image blocks. | None (Hardware texture sampling unit) |
| **Dynamic Raytracing** | `intersector::intersect`, `commit` | **Runtime** | Lowered to calls into prebuilt raytracing binary bitcode. | `MTLRaytracingRuntime.rtlib` |
| **Shader Logging** | `os_log` | **Runtime** | Lowered to custom logging buffer routines. | `MTLShaderLoggingRuntime.rtlib` / `libmetal_rt_*.a` |
| **Memory Utilities** | `memcpy`, `memset`, `memmove` | **Runtime** | Lowered to target copy-loop bitcode blocks. | `libmetal_rt_*.a` (`_target_memcpy`) |
| **Mesh / Tessellation**| `set_vertex`, `set_primitive`, etc. | **Builtin** | Emits custom mesh hardware allocations. | None |
| **SIMDgroup Collective**| `simd_sum`, `simd_max`, `simd_shuffle` | **Builtin** | Lowered to SIMD execution lane instructions. | None (Hardware SIMD execution bus) |
| **Trace Points** | `[[tracepoint(n)]]` | **Runtime** | Emits trace point identifiers and profiling hooks. | `libtracepoint_rt_*.metallib` / `libtracepoint_rt_static_*.a` |




## Compilation Resolution Pipeline for Header-only Templates

To resolve whether a function is generated as inline template instructions or external runtime library symbols, the compiler uses template specialization rules. Below is the C++ template design used inside `<metal_integer>`:

```cpp
namespace metal {

// Base template maps to header-only implementation
template <typename T>
inline T abs(T x) {
  return x < 0 ? -x : x;
}

// Specialization for char maps to compiler builtin
template <>
inline char abs<char>(char x) {
  return __builtin_abs(x);
}

} // namespace metal
```

### Compiler Intrinsics and Late Linking Passes
During code generation, calls to unresolved template functions are compiled as external function references in the LLVM Module, allowing them to be resolved by the dynamic linker at JIT compile time:
```cpp
bool CodeGenModule::IsRuntimeLinkedFunction(const FunctionDecl *FD) {
  // Check if function name matches any precompiled symbol inside libmetal_rt
  StringRef Name = FD->getName();
  return Name.starts_with("___metal_") || Name.starts_with("__air_impl_");
}
```


## Section Implementer's Guide & Advanced Dynamic Linkage Specifications for SECTION07_API_MAPPING_BUILTIN_CLASSIFICATION

When building a production-grade clang/llvm compiler backend targeting SECTION07_API_MAPPING_BUILTIN_CLASSIFICATION:
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
