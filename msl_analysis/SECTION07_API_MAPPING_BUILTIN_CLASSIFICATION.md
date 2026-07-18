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
