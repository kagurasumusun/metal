# Section 10: Exhaustive API Mapping Matrix - Geometric, Relational, and Logical Operations

This section provides a rigorous, exhaustive mapping specification of the geometric, relational, and logical primitives of the Metal Shading Language (MSL). It documents the mathematical definitions, compiler-assisted type conversions, vector expansions, AST nodes, and the lowered LLVM/AIR representations for every overload family.

---

## 1. Mathematical Definitions and Precision Rules

### 1.1 Geometric Functions
Geometric functions in MSL operate on float and half scalar and vector types up to 4 dimensions. They provide the core geometric operations required for graphics rasterization, raytracing calculations, and scientific physics dispatches.

1. **dot(x, y)**: Computes the dot product of two vectors $x$ and $y$.
   $$\text{dot}(x, y) = \sum_{i=0}^{N-1} x_i y_i$$
   For 3D and 4D vectors, the AGX ISA compiles this down to a series of FMA (Fused Multiply-Add) instructions or a native hardware dot-product instruction (if supported by the architecture slice).

2. **cross(x, y)**: Computes the 3D cross product of two vectors $x$ and $y$.
   $$\text{cross}(x, y) = \begin{pmatrix} x_1 y_2 - x_2 y_1 \\ x_2 y_0 - x_0 y_2 \\ x_0 y_1 - x_1 y_0 \end{pmatrix}$$
   This template is implemented in header files and expands into native float/half multiplications. No custom LLVM intrinsic exists; it is optimized directly by LLVM's instruction combiner.

3. **length(x)**: Computes the Euclidean length of the vector $x$.
   $$\text{length}(x) = \sqrt{\text{dot}(x, x)}$$
   Under fast math mode, this is optimized to use reciprocal square root approximations (`rsqrt`) where appropriate.

4. **distance(x, y)**: Computes the distance between two points $x$ and $y$.
   $$\text{distance}(x, y) = \text{length}(x - y)$$

5. **normalize(x)**: Computes a unit vector pointing in the same direction as $x$.
   $$\text{normalize}(x) = x \cdot \text{rsqrt}(\text{dot}(x, x))$$
   Lowered using high-performance reciprocal square roots.

6. **reflect(I, N)**: Computes the reflection vector of an incident vector $I$ against a normal $N$.
   $$\text{reflect}(I, N) = I - 2 \cdot \text{dot}(N, I) \cdot N$$

7. **refract(I, N, eta)**: Computes the refraction vector of an incident vector $I$ against a normal $N$ using refractive index ratio $eta$.
   $$k = 1 - \text{eta}^2 \cdot (1 - \text{dot}(N, I)^2)$$
   $$\text{refract}(I, N, eta) = \begin{cases} \text{eta} \cdot I - (\text{eta} \cdot \text{dot}(N, I) + \sqrt{k}) \cdot N & \text{if } k \geq 0 \\ 0 & \text{otherwise} \end{cases}$$

---

### 1.2 Relational and Logical Functions
Relational functions in MSL perform element-wise comparisons on vectors and return boolean vectors. They allow branching-free logic to be implemented using high-performance selection operations in hardware.

1. **any(x)**: Returns true if any component of boolean vector $x$ is true.
2. **all(x)**: Returns true if all components of boolean vector $x$ are true.
3. **select(x, y, cond)**: Performs component-wise selection. Returns $x$ if $cond$ is false/0, and $y$ if $cond$ is true/nonzero.
4. **isnan(x)**: Element-wise check for NaN (Not a Number) values.
5. **isinf(x)**: Element-wise check for Infinity.
6. **isfinite(x)**: Element-wise check for finite values (not NaN and not Infinity).
7. **step(edge, x)**: Element-wise step function: returns $0.0$ if $x < edge$, and $1.0$ otherwise.
8. **smoothstep(edge0, edge1, x)**: Performs smooth Hermite interpolation.
   $$t = \text{clamp}\left(\frac{x - edge0}{edge1 - edge0}, 0.0, 1.0\right)$$
   $$\text{smoothstep}(edge0, edge1, x) = t^2 \cdot (3 - 2t)$$

---

## 2. Exhaustive Mapping Matrix - Geometric Operations

| MSL API Family | Fully-Expanded Overload Signatures | Clang AST Node representation | LLVM IR Intrinsic / Conversion | AIR Opcode Mappings | Builtin / Header / Runtime | GPU Register Target |
|:---|:---|:---|:---|:---|:---|:---|
| `dot` | `half dot(half, half)`<br>`half dot(half2, half2)`<br>`half dot(half3, half3)`<br>`half dot(half4, half4)` | `CallExpr` calling custom compiler builtins | `@llvm.msl.dot.f16` / Vector multiplication-add sequence | `air.dot` | **Builtin** | Floating-Point GPR |
| `dot` | `float dot(float, float)`<br>`float dot(float2, float2)`<br>`float dot(float3, float3)`<br>`float dot(float4, float4)` | `CallExpr` calling custom compiler builtins | `@llvm.msl.dot.f32` / Vector multiplication-add sequence | `air.dot` | **Builtin** | Floating-Point GPR |
| `cross` | `half3 cross(half3, half3)` | `CXXMemberCallExpr` inlined templates | Vector cross-multiplication IR | Optimized to inline FMA | **Header** | Vector Float GPR |
| `cross` | `float3 cross(float3, float3)` | `CXXMemberCallExpr` inlined templates | Vector cross-multiplication IR | Optimized to inline FMA | **Header** | Vector Float GPR |
| `length` | `half length(half)`<br>`half length(half2)`<br>`half length(half3)`<br>`half length(half4)` | Inline math template calling `sqrt(dot)` | `@llvm.sqrt.f16` after dot product sequence | `air.sqrt` / `rsqrt` approximation | **Header** | Floating-Point GPR |
| `length` | `float length(float)`<br>`float length(float2)`<br>`float length(float3)`<br>`float length(float4)` | Inline math template calling `sqrt(dot)` | `@llvm.sqrt.f32` after dot product sequence | `air.sqrt` / `rsqrt` approximation | **Header** | Floating-Point GPR |
| `distance` | `half distance(half, half)`<br>`half distance(half2, half2)`<br>`half distance(half3, half3)`<br>`half distance(half4, half4)` | Inline math template calling `length(x-y)` | `@llvm.sqrt.f16` on vector differences | Optimized vector distance | **Header** | Floating-Point GPR |
| `distance` | `float distance(float, float)`<br>`float distance(float2, float2)`<br>`float distance(float3, float3)`<br>`float distance(float4, float4)` | Inline math template calling `length(x-y)` | `@llvm.sqrt.f32` on vector differences | Optimized vector distance | **Header** | Floating-Point GPR |
| `normalize`| `half normalize(half)`<br>`half2 normalize(half2)`<br>`half3 normalize(half3)`<br>`half4 normalize(half4)` | Inline math template calling `x * rsqrt(dot)` | Vector multiply by `@llvm.rsqrt.f16` | Multi-lane vector normalizer | **Header** | Vector Float GPR |
| `normalize`| `float normalize(float)`<br>`float2 normalize(float2)`<br>`float3 normalize(float3)`<br>`float4 normalize(float4)` | Inline math template calling `x * rsqrt(dot)` | Vector multiply by `@llvm.rsqrt.f32` | Multi-lane vector normalizer | **Header** | Vector Float GPR |
| `reflect` | `half reflect(half, half)`<br>`half2 reflect(half2, half2)`<br>`half3 reflect(half3, half3)`<br>`half4 reflect(half4, half4)` | Inline template `I - 2*dot*N` | Arithmetic vector instructions | Direct FMA compilation | **Header** | Vector Float GPR |
| `reflect` | `float reflect(float, float)`<br>`float2 reflect(float2, float2)`<br>`float3 reflect(float3, float3)`<br>`float4 reflect(float4, float4)` | Inline template `I - 2*dot*N` | Arithmetic vector instructions | Direct FMA compilation | **Header** | Vector Float GPR |
| `refract` | `half refract(half, half, half)`<br>`half2 refract(half2, half2, half)` | Complex check logic in templates | Nested comparison select and arithmetic IR | Multi-lane select & FMA | **Header** | Vector Float GPR |
| `refract` | `float refract(float, float, float)`<br>`float2 refract(float2, float2, float)` | Complex check logic in templates | Nested comparison select and arithmetic IR | Multi-lane select & FMA | **Header** | Vector Float GPR |

---

## 3. Exhaustive Mapping Matrix - Relational and Logical Operations

| MSL API Family | Fully-Expanded Overload Signatures | Clang AST Node representation | LLVM IR Intrinsic / Conversion | AIR Opcode Mappings | Builtin / Header / Runtime | GPU Register Target |
|:---|:---|:---|:---|:---|:---|:---|
| `any` | `bool any(bool)`<br>`bool any(bool2)`<br>`bool any(bool3)`<br>`bool any(bool4)` | `CallExpr` for standard Clang relational builtin | `@llvm.msl.any` / reduction comparisons | `air.any` | **Builtin** | Integer GPR (Flag) |
| `all` | `bool all(bool)`<br>`bool all(bool2)`<br>`bool all(bool3)`<br>`bool all(bool4)` | `CallExpr` for standard Clang relational builtin | `@llvm.msl.all` / reduction comparisons | `air.all` | **Builtin** | Integer GPR (Flag) |
| `select` | `char select(char x, char y, bool cond)`<br>`charN select(charN x, charN y, boolN cond)` | Clang AST maps to element-wise conditional | `select` LLVM instruction on vectors | `air.select` / hardware bitwise selection | **Builtin** | Vector Integer GPR |
| `select` | `int select(int x, int y, bool cond)`<br>`intN select(intN x, intN y, boolN cond)` | Clang AST maps to element-wise conditional | `select` LLVM instruction on vectors | `air.select` / hardware bitwise selection | **Builtin** | Vector Integer GPR |
| `select` | `float select(float x, float y, bool cond)`<br>`floatN select(floatN x, floatN y, boolN cond)` | Clang AST maps to element-wise conditional | `select` LLVM instruction on vectors | `air.select` / hardware bitwise selection | **Builtin** | Vector Float GPR |
| `isnan` | `bool isnan(half)`<br>`boolN isnan(halfN)`<br>`bool isnan(float)`<br>`boolN isnan(floatN)` | `CallExpr` calling `__builtin_isnan` | `fcmp uno` instruction (unordered check) | `air.isnan` / comparison flag | **Builtin** | Integer GPR |
| `isinf` | `bool isinf(half)`<br>`boolN isinf(halfN)`<br>`bool isinf(float)`<br>`boolN isinf(floatN)` | `CallExpr` calling `__builtin_isinf` | comparison against Inf values | `air.isinf` / comparison flag | **Builtin** | Integer GPR |
| `isfinite` | `bool isfinite(half)`<br>`boolN isfinite(halfN)`<br>`bool isfinite(float)` | Relational template check | Logical AND of isnan, isinf exclusions | Compiled comparison checks | **Header** | Integer GPR |
| `isnormal` | `bool isnormal(half)`<br>`boolN isnormal(halfN)`<br>`bool isnormal(float)` | Relational template check | Checks for subnormal boundaries | Compiled comparison checks | **Header** | Integer GPR |
| `step` | `half step(half edge, half x)`<br>`halfN step(halfN edge, halfN x)` | Template comparison returns 0 or 1 | `select` on comparison results | Hardware conditional write | **Header** | Vector Float GPR |
| `step` | `float step(float edge, float x)`<br>`floatN step(floatN edge, floatN x)` | Template comparison returns 0 or 1 | `select` on comparison results | Hardware conditional write | **Header** | Vector Float GPR |
| `smoothstep`| `half smoothstep(half e0, half e1, half x)` | Interpolation calculation templates | Fused multiply-add clamp calculations | Clamp, division, and Hermite GPR sequences | **Header** | Floating-Point GPR |
| `smoothstep`| `float smoothstep(float e0, float e1, float x)`| Interpolation calculation templates | Fused multiply-add clamp calculations | Clamp, division, and Hermite GPR sequences | **Header** | Floating-Point GPR |

---

## 4. Deep-Dive Compilation & Lowering Analysis

### 4.1 Vector Lowering in LLVM
When compilation targets vector types (such as `float4` or `half16`), LLVM IR structures represent them using native target vectors. For example, a vector dot product on `float4` (`float dot(float4 x, float4 y)`) generates the following optimized lowering:

```llvm
define float @vector_dot_product_4f(<4 x float> %x, <4 x float> %y) local_unnamed_addr {
entry:
  %mul = fmul <4 x float> %x, %y
  %shuffle1 = shufflevector <4 x float> %mul, <4 x float> poison, <2 x i32> <i32 0, i32 1>
  %shuffle2 = shufflevector <4 x float> %mul, <4 x float> poison, <2 x i32> <i32 2, i32 3>
  %add1 = fadd <2 x float> %shuffle1, %shuffle2
  %extract1 = extractelement <2 x float> %add1, i32 0
  %extract2 = extractelement <2 x float> %add1, i32 1
  %res = fadd float %extract1, %extract2
  ret float %res
}
```

This sequence is parsed by the AGX native compiler, which maps the entire reduction to dedicated multi-lane execution instructions on Apple Silicon GPUs, bypassing general-purpose register transfers.

### 4.2 Branchless Execution using Selection Operations
To maintain optimal execution thread alignment (preventing SIMD lane divergence), relational checks and conditional selections are lowered to target-independent selection instructions (`select` or specialized bitwise mask operators).

For example, `select(x, y, cond)` compiles to native hardware instructions that select between registers based on comparison masks in a single instruction, avoiding pipeline flushes or branch divergence.
- On Apple Silicon, the execution of `select` on floating-point vectors maps to the physical GPU instruction `FSEL`, which evaluates the sign or condition mask of a register and selects elements with zero branching penalty.
- The element-wise `step(edge, x)` compiles down to `FCMP` followed directly by `FSEL`, enabling extremely fast shader executions across thousands of threads in parallel.

---

## 5. Exhaustive Language Reference for Type Conversions and Re-interpretations

The Metal Shading Language enforces extremely strict C++-style type conversions, preventing unintentional performance bottlenecks caused by implicit scalar/vector widening.

### 5.1 Type Conversion Rules
1. **Implicit Conversions**:
   - Implicit scalar widening (e.g., `half` to `float`, `int` to `long`) is supported.
   - Vector conversions are **never** implicit. Converting an `int4` to a `float4` requires an explicit cast or the use of specific conversion functions.
2. **Explicit Conversions**:
   - Explicit constructors (e.g., `float4(v_int)`) execute standard C++ functional casts.
   - For saturating or rounding vector conversions, MSL provides specialized templated functions inside `<metal_pack>` and `<metal_unpack>`.

### 5.2 Re-interpreting Memory: `as_type<T>`
To re-interpret the bit-pattern of a variable as another type without changing its underlying value (comparable to `reinterpret_cast` or `std::bit_cast`), MSL provides the templated builtin `as_type<T>(value)`.

- **Implementation**: Mapped directly to the Clang AST node `AsTypeExpr` and lowered in LLVM IR to the `bitcast` instruction.
- **Constraints**:
  - The source and destination types must have the exact same bit width.
  - Attempting to use `as_type` between structures of mismatching sizes triggers a compile-time static assertion failure.

#### Example Lowering of `as_type<uint>` for a `float`:
- MSL Source:
  ```cpp
  float f_val = 12.5f;
  uint u_val = as_type<uint>(f_val);
  ```
- LLVM IR Representation:
  ```llvm
  %f_val = alloca float, align 4
  store float 1.250000e+01, float* %f_val, align 4
  %loaded = load float, float* %f_val, align 4
  %u_val = bitcast float %loaded to i32
  ```
- Hardware translation: The AGX JIT compiler maps the bitcast as a register re-interpretation, resulting in zero overhead at runtime.



## Branchless Execution via Sign and Condition Flags

Relational checks and conditional selections are compiled to branchless execution instructions to maintain optimal execution thread alignment (preventing SIMD lane divergence):
- **Sign Bit Extraction**: Relational templates like `signbit` extract the sign bit from floating-point values using mask operations, avoiding comparison penalties.
- **Selection Units**: The AGX GPU features direct support for conditional selection instructions (`FSEL`), which evaluate a register's condition mask and select elements with zero branching penalty.

## C++ Header for Geometric Dot and Cross Primitives

Below is the complete template layout and implementation required to build geometric dot and cross products inside `<metal_geometric>`:

```cpp
#ifndef __METAL_GEOMETRIC_H
#define __METAL_GEOMETRIC_H

#include <metal_types>

namespace metal {

// Dot product template
template <typename T, int N>
inline T dot(vector<T, N> x, vector<T, N> y) {
  T result = 0;
  for (int i = 0; i < N; ++i) {
    result += x.data[i] * y.data[i];
  }
  return result;
}

// Cross product template (3D vectors only)
template <typename T>
inline vector<T, 3> cross(vector<T, 3> x, vector<T, 3> y) {
  vector<T, 3> result;
  result.data[0] = x.data[1] * y.data[2] - x.data[2] * y.data[1];
  result.data[1] = x.data[2] * y.data[0] - x.data[0] * y.data[2];
  result.data[2] = x.data[0] * y.data[1] - x.data[1] * y.data[0];
  return result;
}

} // namespace metal

#endif
```

### Vector Reduction Optimization
During compilation, LLVM translates vector dot products into a series of multiply-add instructions, optimizing GPR register usage:
```cpp
Value *CodeGenFunction::EmitMetalVectorDotProduct(Value *LHS, Value *RHS) {
  Value *Mul = Builder.CreateFMul(LHS, RHS, "mul");
  // Extract and sum components
  Value *X = Builder.CreateExtractElement(Mul, (uint64_t)0, "x");
  Value *Y = Builder.CreateExtractElement(Mul, (uint64_t)1, "y");
  return Builder.CreateFAdd(X, Y, "sum");
}
```
