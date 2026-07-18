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
