# Section 3: MSL Type System, Memory Layout, and Alignment Specification

This section provides a rigorous specification of the Metal Shading Language (MSL) type system. It includes memory layouts, strides, alignment constraints, and compiler representation for scalar, vector, and matrix structures, as well as pixel mappings.

---

## 1. Scalar Type Representation & Mappings

The table below maps the standard scalar types in MSL to their respective sizes, alignments, and representations in Clang, LLVM IR, and AIR.

| MSL Scalar Type | Bit Width | Alignment (Bytes) | Clang Internal Type representation | LLVM IR Type | AIR Type representation | GPU Register Class |
|:---|:---:|:---:|:---|:---|:---|:---|
| `bool` | 8 | 1 | `bool` | `i1` / `i8` | `i1` (or `i8` unpacked) | Integer GPR |
| `char` / `int8_t` | 8 | 1 | `char` | `i8` | `i8` | Integer GPR |
| `uchar` / `uint8_t` | 8 | 1 | `unsigned char` | `i8` | `i8` | Integer GPR |
| `short` / `int16_t` | 16 | 2 | `short` | `i16` | `i16` | Integer GPR (Half-word) |
| `ushort` / `uint16_t`| 16 | 2 | `unsigned short` | `i16` | `i16` | Integer GPR (Half-word) |
| `int` / `int32_t` | 32 | 4 | `int` | `i32` | `i32` | Integer GPR (32-bit Word) |
| `uint` / `uint32_t` | 32 | 4 | `unsigned int` | `i32` | `i32` | Integer GPR (32-bit Word) |
| `long` / `int64_t` | 64 | 8 | `long long` | `i64` | `i64` | Integer GPR (64-bit Double Word) |
| `ulong` / `uint64_t` | 64 | 8 | `unsigned long long` | `i64` | `i64` | Integer GPR (64-bit Double Word) |
| `half` | 16 | 2 | `__fp16` / `half` | `half` | `half` | Floating-point GPR (Half-precision) |
| `bfloat` / `bfloat16`| 16 | 2 | `__bfloat16` | `bfloat` | `bfloat` | Floating-point GPR (Half-precision) |
| `float` | 32 | 4 | `float` | `float` | `float` | Floating-point GPR (Single-precision) |
| `double` | 64 | 8 | `double` | `double` | `double` | Floating-point GPR (Double-precision) |

---

## 2. Vector Type Representation & Memory Layout

Vectors in MSL are declared with the syntax `T_N` (where `T` is a scalar type and `N` is `2`, `3`, `4`, `8`, or `16`).

### Alignment & Padding Rules
- **Power-of-Two Vectors (2, 4, 8, 16 elements)**: The size and alignment are equal to `sizeof(scalar) * N`.
- **Three-Element Vectors (3 elements)**: To preserve performance and cache line alignments, 3-element vectors (e.g., `float3`, `int3`) are padded to match 4-element vectors. Thus, their size and alignment are equal to `sizeof(scalar) * 4`.

| MSL Vector Type | Total Elements | Memory Size (Bytes) | Alignment (Bytes) | Padding Element | Clang Vector Representation | LLVM IR Type representation |
|:---|:---:|:---:|:---:|:---:|:---|:---|
| `half2` | 2 | 4 | 4 | None | `half __attribute__((ext_vector_type(2)))` | `<2 x half>` |
| `half3` | 3 | 8 | 8 | 1 element padding | `half __attribute__((ext_vector_type(3)))` | `<3 x half>` (padded to `<4 x half>`) |
| `half4` | 4 | 8 | 8 | None | `half __attribute__((ext_vector_type(4)))` | `<4 x half>` |
| `half8` | 8 | 16 | 16 | None | `half __attribute__((ext_vector_type(8)))` | `<8 x half>` |
| `half16` | 16 | 32 | 32 | None | `half __attribute__((ext_vector_type(16)))` | `<16 x half>` |
| `float2` | 2 | 8 | 8 | None | `float __attribute__((ext_vector_type(2)))` | `<2 x float>` |
| `float3` | 3 | 16 | 16 | 1 element padding | `float __attribute__((ext_vector_type(3)))` | `<3 x float>` (padded to `<4 x float>`) |
| `float4` | 4 | 16 | 16 | None | `float __attribute__((ext_vector_type(4)))` | `<4 x float>` |
| `float8` | 8 | 32 | 32 | None | `float __attribute__((ext_vector_type(8)))` | `<8 x float>` |
| `float16` | 16 | 64 | 64 | None | `float __attribute__((ext_vector_type(16)))` | `<16 x float>` |
| `int2` | 2 | 8 | 8 | None | `int __attribute__((ext_vector_type(2)))` | `<2 x i32>` |
| `int3` | 3 | 16 | 16 | 1 element padding | `int __attribute__((ext_vector_type(3)))` | `<3 x i32>` (padded to `<4 x i32>`) |
| `int4` | 4 | 16 | 16 | None | `int __attribute__((ext_vector_type(4)))` | `<4 x i32>` |
| `int8` | 8 | 32 | 32 | None | `int __attribute__((ext_vector_type(8)))` | `<8 x i32>` |
| `int16` | 16 | 64 | 64 | None | `int __attribute__((ext_vector_type(16)))` | `<16 x i32>` |

---

## 3. Matrix Memory Layout & Strides

MSL matrices are stored in **column-major** order. This means that a matrix of shape `Columns x Rows` (declared as `halfCxR` or `floatCxR`) is represented in memory as an array of `C` column vectors, each containing `R` elements.

### Strides and Vector Layouts
Since each column is represented as a vector, the padding rules of 3-element vectors apply to matrices:
- A `float4x3` matrix contains 4 columns of `float3` vectors. Since each `float3` vector is padded to 16 bytes (the size of `float4`), the total size of the matrix in memory is `4 columns * 16 bytes/column = 64 bytes`, rather than `48 bytes`.

| MSL Matrix Type | Columns | Rows | Total Size (Bytes) | Alignment (Bytes) | Column Vector Type | Memory Layout (Column vectors in memory) | Clang Representation |
|:---|:---:|:---:|:---:|:---:|:---|:---|:---|
| `half2x2` | 2 | 2 | 8 | 4 | `half2` | `[col0.xy, col1.xy]` | `half __attribute__((matrix_type(2, 2)))` |
| `half3x3` | 3 | 3 | 24 | 8 | `half3` (padded to 4) | `[col0.xyz+, col1.xyz+, col2.xyz+]` | `half __attribute__((matrix_type(3, 3)))` |
| `half4x4` | 4 | 4 | 32 | 8 | `half4` | `[col0, col1, col2, col3]` | `half __attribute__((matrix_type(4, 4)))` |
| `float2x2` | 2 | 2 | 16 | 8 | `float2` | `[col0.xy, col1.xy]` | `float __attribute__((matrix_type(2, 2)))` |
| `float3x3` | 3 | 3 | 48 | 16 | `float3` (padded to 4) | `[col0.xyz+, col1.xyz+, col2.xyz+]` | `float __attribute__((matrix_type(3, 3)))` |
| `float4x3` | 4 | 3 | 64 | 16 | `float3` (padded to 4) | `[col0.xyz+, col1.xyz+, col2.xyz+, col3.xyz+]` | `float __attribute__((matrix_type(4, 3)))` |
| `float4x4` | 4 | 4 | 64 | 16 | `float4` | `[col0, col1, col2, col3]` | `float __attribute__((matrix_type(4, 4)))` |

---

## 4. Pixel Format / Texture Format Mappings

Textures in MSL are represented by templated classes with type parameters representing their pixel data types: `pixel<T, access>`. The table below maps MSL pixel types to actual hardware structures and their internal compiler representations.

| MSL Pixel Class | Texture Component Format | Data Packing Type | LLVM / AIR Texture Representation | Hardware Sampler Behavior |
|:---|:---|:---|:---|:---|
| `pixel<half, access::read>` | R16_Float / RGBA16_Float | Unpacked / Pack | `%opencl.image2d_t` / `addrspace(4)` | Returns half-precision vector |
| `pixel<float, access::read>` | R32_Float / RGBA32_Float | Unpacked | `%opencl.image2d_t` / `addrspace(4)` | Returns single-precision vector |
| `pixel<int, access::read>` | R32_Int / RGBA32_Int | Sign-Extended | `%opencl.image2d_t` / `addrspace(4)` | Returns signed 32-bit integer vector |
| `pixel<uint, access::read>` | R32_UInt / RGBA32_UInt | Zero-Extended | `%opencl.image2d_t` / `addrspace(4)` | Returns unsigned 32-bit integer vector |
| `pixel<uchar, access::write>`| RGBA8_UNorm / RGBA8_UInt | Packed / Clamped | `%opencl.image2d_write_t` / `addrspace(4)`| Unpacks and converts to normalized float or integer |



## Padding and Strides in Struct Alignments

The Metal Shading Language enforces strict structural alignment rules to ensure optimal memory coalescing on GPU cache lines:
- **Struct Alignment**: The total alignment of a struct is equal to the largest alignment of its members.
- **Padding**: The compiler automatically inserts padding bytes between struct members to align them to their natural boundaries. For example, if a `float` member (4-byte alignment) follows a `short` member (2-byte alignment), the compiler inserts 2 padding bytes.
- **Array Stride**: The distance between adjacent elements in an array (stride) is padded to match the element's natural alignment.

### Structure Packing Directives
To bypass automatic padding and minimize memory footprint, MSL supports packing attributes:
```cpp
struct PackedData {
  packed_float3 position;
  packed_half2 texcoords;
} __attribute__((packed));
```
When Clang processes a packed structure:
- It disables natural alignments, reducing member alignments to 1 byte.
- Lowered LLVM IR loads and stores use unaligned memory fetch instructions, which can incur a performance penalty on older hardware but minimize memory usage in complex pipelines.

## Complete C++ Header for MSL Standard Vector and Matrix Types

Below is the complete, natural-alignment C++ header declaration required to build standard scalar, vector, and matrix types in `<metal_types>`:

```cpp
#ifndef __METAL_TYPES_H
#define __METAL_TYPES_H

namespace metal {

// Scalar types
typedef unsigned char uchar;
typedef unsigned short ushort;
typedef unsigned int uint;
typedef unsigned long long ulong;

// Vector template layout
template <typename T, int N>
struct alignas(sizeof(T) * (N == 3 ? 4 : N)) vector {
  T data[N];
};

typedef vector<float, 2> float2;
typedef vector<float, 3> float3; // Padded to alignas(16)
typedef vector<float, 4> float4;

// Matrix Column-Major Layout
template <typename T, int C, int R>
struct matrix {
  vector<T, R> columns[C];
};

typedef matrix<float, 4, 4> float4x4;

} // namespace metal

#endif
```

### Memory Copy Alignment Verification
When generating memory accesses for vectors, Clang ensures load and store operations are aligned to their natural boundaries, preventing unaligned memory exceptions in hardware:
```cpp
llvm::Align CodeGenFunction::GetMetalTypeAlignment(QualType Ty) {
  if (const auto *VT = Ty->getAs<VectorType>()) {
    unsigned NumElements = VT->getNumElements();
    QualType EltTy = VT->getElementType();
    unsigned EltSize = Context.getTypeSize(EltTy) / 8;
    return llvm::Align(EltSize * (NumElements == 3 ? 4 : NumElements));
  }
  return Context.getTypeAlignInChars(Ty);
}
```


## Section Implementer's Guide & Advanced Dynamic Linkage Specifications for SECTION03_TYPE_SYSTEM_AND_REPRESENTATION

When building a production-grade clang/llvm compiler backend targeting SECTION03_TYPE_SYSTEM_AND_REPRESENTATION:
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
