# Section 11: Exhaustive API Mapping Matrix - Texture Sampling, Reading, and Writing

This section details the texture engine, resource descriptor bindings, coordinates layouts, sampling behaviors, and compiler mappings of the Metal Shading Language (MSL) compiled for Apple Silicon GPUs.

---

## 1. Technical Architecture of Apple Silicon Texture Engine

On Apple Silicon GPUs, texture operations are accelerated by highly optimized, dedicated hardware blocks called **Texture Processing Units (TPUs)**. These blocks are integrated directly into each GPU core and handle coordinate normalization, anisotropic filtering, mipmap selections, and texel data unpacking.

### 1.1 Coordinates and Sampling Conventions
MSL textures support both normalized and unnormalized coordinates, which dictate how sampling coordinates map to texel coordinates:

1. **Normalized Coordinates (`coordinates::normalized`)**:
   - Texture coordinates range from $0.0$ to $1.0$ across the texture face.
   - Ideal for general texture wrapping, scaling, and mipmap filtering.
   - Out-of-bounds coordinates are handled by hardware wrapping modes: `clamp_to_edge`, `repeat`, `mirror_repeat`, `clamp_to_zero`.

2. **Unnormalized Coordinates (`coordinates::pixel`)**:
   - Texture coordinates map directly to raw integer pixel coordinates (ranging from $0$ to $\text{width}-1$, $\text{height}-1$).
   - Ideal for post-processing filters, computing buffers, and precise pixel fetches.
   - Wrap modes are ignored; coordinates are clamped to the texture boundaries.

---

## 2. Exhaustive Mappings: Texture Sampling, Reading, and Writing

The matrix below maps the primary texture access functions to Clang AST nodes, LLVM IR, and AIR intrinsics.

| Texture Class | MSL Function Family | Argument Configurations (Coordinates, lod, bias, etc.) | Clang AST Representation | LLVM IR Intrinsic Lowering | AIR Opcode | Builtin / Header / Runtime | Hardware Unit Targeted |
|:---|:---|:---|:---|:---|:---|:---:|:---|
| `texture1d<T, access>` | `sample` | `(sampler s, float coord)` | `CXXMemberCallExpr` calling compiler builtin | `call <4 x float> @llvm.air.sample.1d(...)` | `air.sample.1d` | **Builtin** | TPU / Texture Sampler Unit |
| `texture1d<T, access>` | `read` | `(uint coord, uint lod = 0)` | `CXXMemberCallExpr` calling compiler builtin | `call <4 x float> @llvm.air.read.1d(...)` | `air.read.1d` | **Builtin** | TPU / Texel Fetch Unit |
| `texture1d<T, access>` | `write` | `(T color, uint coord, uint lod = 0)` | `CXXMemberCallExpr` calling compiler builtin | `call void @llvm.air.write.1d(...)` | `air.write.1d` | **Builtin** | TPU / Render Store Unit |
| `texture2d<T, access>` | `sample` | `(sampler s, float2 coord, lod_options...)` | `CXXMemberCallExpr` calling compiler builtin | `call <4 x float> @llvm.air.sample.2d(...)` | `air.sample.2d` | **Builtin** | TPU / Texture Sampler Unit |
| `texture2d<T, access>` | `sample_compare` | `(sampler s, float2 coord, float compare_value)` | `CXXMemberCallExpr` calling compiler builtin | `call float @llvm.air.sample_compare.2d(...)` | `air.sample_compare` | **Builtin** | TPU / Shadow Sampler Block |
| `texture2d<T, access>` | `read` | `(uint2 coord, uint lod = 0)` | `CXXMemberCallExpr` calling compiler builtin | `call <4 x float> @llvm.air.read.2d(...)` | `air.read.2d` | **Builtin** | TPU / Texel Fetch Unit |
| `texture2d<T, access>` | `write` | `(T color, uint2 coord, uint lod = 0)` | `CXXMemberCallExpr` calling compiler builtin | `call void @llvm.air.write.2d(...)` | `air.write.2d` | **Builtin** | TPU / Render Store Unit |
| `texture2d_ms<T, access>`| `read` | `(uint2 coord, uint sample_index)` | `CXXMemberCallExpr` calling compiler builtin | `call <4 x float> @llvm.air.read.2d_ms(...)` | `air.read.2d_ms` | **Builtin** | TPU / Multisample Texel Fetch |
| `texture3d<T, access>` | `sample` | `(sampler s, float3 coord)` | `CXXMemberCallExpr` calling compiler builtin | `call <4 x float> @llvm.air.sample.3d(...)` | `air.sample.3d` | **Builtin** | TPU / 3D Texture Sampler |
| `texture3d<T, access>` | `read` | `(uint3 coord, uint lod = 0)` | `CXXMemberCallExpr` calling compiler builtin | `call <4 x float> @llvm.air.read.3d(...)` | `air.read.3d` | **Builtin** | TPU / Texel Fetch Unit |
| `texture3d<T, access>` | `write` | `(T color, uint3 coord, uint lod = 0)` | `CXXMemberCallExpr` calling compiler builtin | `call void @llvm.air.write.3d(...)` | `air.write.3d` | **Builtin** | TPU / Render Store Unit |
| `texturecube<T, access>`| `sample` | `(sampler s, float3 coord)` | `CXXMemberCallExpr` calling compiler builtin | `call <4 x float> @llvm.air.sample.cube(...)` | `air.sample.cube` | **Builtin** | TPU / Cubemap Addressing Block |
| `texturecube<T, access>`| `read` | `(uint2 coord, uint face_index, uint lod = 0)` | `CXXMemberCallExpr` calling compiler builtin | `call <4 x float> @llvm.air.read.cube(...)` | `air.read.cube` | **Builtin** | TPU / Cubemap Fetch Block |
| `texture2d_array<T, acc>`| `sample` | `(sampler s, float2 coord, uint array_idx)` | `CXXMemberCallExpr` calling compiler builtin | `call <4 x float> @llvm.air.sample.2d_array(...)` | `air.sample.2d_array`| **Builtin** | TPU / Array Address Block |
| `texture2d_array<T, acc>`| `gather` | `(sampler s, float2 coord, uint array_idx)` | `CXXMemberCallExpr` calling compiler builtin | `call <4 x float> @llvm.air.gather.2d_array(...)` | `air.gather.2d_array`| **Builtin** | TPU / Texture Gather Unit |

---

## 3. Exhaustive Mappings: Texture Properties & Queries

These query functions read metadata stored in the texture descriptor, allowing shaders to dynamically adapt to resource dimension changes.

| MSL Query Function | Return Type | Clang AST Node | LLVM IR Intrinsic Lowering | AIR Opcode | Builtin / Header / Runtime |
|:---|:---|:---|:---|:---|:---|
| `get_width()` | `uint` / `ushort` | `CXXMemberCallExpr` | `call i32 @llvm.air.get_width(...)` | `air.get_width` | **Builtin** |
| `get_height()` | `uint` / `ushort` | `CXXMemberCallExpr` | `call i32 @llvm.air.get_height(...)` | `air.get_height` | **Builtin** |
| `get_depth()` | `uint` / `ushort` | `CXXMemberCallExpr` | `call i32 @llvm.air.get_depth(...)` | `air.get_depth` | **Builtin** |
| `get_num_mip_levels()` | `uint` | `CXXMemberCallExpr` | `call i32 @llvm.air.get_num_mip_levels(...)` | `air.get_num_mip_levels` | **Builtin** |
| `get_num_samples()` | `uint` | `CXXMemberCallExpr` | `call i32 @llvm.air.get_num_samples(...)` | `air.get_num_samples` | **Builtin** |
| `get_num_layers()` | `uint` | `CXXMemberCallExpr` | `call i32 @llvm.air.get_num_layers(...)` | `air.get_num_layers` | **Builtin** |

---

## 4. Deep-Dive Compilation & Lowering Analysis

### 4.1 Sampler Conversions and State Resolution
Samplers configure texture filtering, coordinate normalization, and address wrapping modes. In MSL, a sampler can be configured either programmatically on the host CPU (`id<MTLSamplerState>`) or directly in the shader source code using the constexpr initializer:

```cpp
constexpr sampler s(filter::linear, mip_filter::linear, address::clamp_to_edge);
```

When Clang parses a `constexpr sampler` initializer:
1. It analyzes the template constructor arguments and evaluates them at compile time.
2. The evaluated configuration parameters are encoded as a single 32-bit integer bitfield (Sampler State Bitfield).
3. Clang emits a global Constant variable holding this bitfield. When texture sampling calls are lowered to LLVM IR, this constant value is passed directly as a state argument to the sampling intrinsic.

#### Sampler Bitfield Layout Configuration (32-bit Word)
- **Bits [0:1]**: Coordinate mode (`0` = pixel, `1` = normalized).
- **Bits [2:4]**: Address wrap mode S (`0` = clamp_to_zero, `1` = clamp_to_edge, `2` = repeat, `3` = mirror_repeat).
- **Bits [5:7]**: Address wrap mode T.
- **Bits [8:10]**: Address wrap mode R.
- **Bits [11:12]**: Minification Filter (`0` = nearest, `1` = linear).
- **Bits [13:14]**: Magnification Filter (`0` = nearest, `1` = linear).
- **Bits [15:16]**: Mipmap Filter (`0` = none, `1` = nearest, `2` = linear).
- **Bits [17:21]**: Anisotropic Filtering Max Clamping (Value mapped from 1 to 16).

---

### 4.2 LLVM IR Representation of Texture Access
At the LLVM IR level, texture and sampler handles are passed as specialized pointer types or opaque structure pointers target-mapped inside Address Space `4` (Texture Space) or Address Space `2` (Constant space for samplers).

#### Example: 2D Texture Sampling Lowering
An MSL call to sample a 2D float texture:
```cpp
float4 color = tex.sample(s, float2(0.5f, 0.5f));
```
Is lowered to the following LLVM IR sequence:
```llvm
%opencl.image2d_t = type opaque
%opencl.sampler_t = type opaque

define <4 x float> @texture_sample_op(%opencl.image2d_t addrspace(4)* %tex, %opencl.sampler_t addrspace(2)* %sampler) local_unnamed_addr {
entry:
  %coords = fadd <2 x float> <float 5.000000e-01, float 5.000000e-01>, zeroinitializer
  ; Calling the AIR intrinsic for 2D sampling
  %res = call <4 x float> @_Z11sample_2d_fPvS_Dv2_f(%opencl.image2d_t addrspace(4)* %tex, %opencl.sampler_t addrspace(2)* %sampler, <2 x float> %coords)
  ret <4 x float> %res
}

declare <4 x float> @_Z11sample_2d_fPvS_Dv2_f(%opencl.image2d_t addrspace(4)*, %opencl.sampler_t addrspace(2)*, <2 x float>)
```

This bitcode is compiled by the JIT translator into an AGX instruction targeting the GPU's hardware sampling units:
1. The hardware loads the texture state descriptor (pixel layout, pitch, dimensions).
2. The hardware loads the sampler state descriptor (linear filter, clamp to edge).
3. The TPU calculates the four nearest pixels, interpolates them in hardware, and writes the resulting vector back to a destination floating-point GPR in a single execution step.

### 1.2 Comprehensive Mappings of Every Texture Permutation

The table below catalogs texture read, write, and sampling permutations across all coordinates (normalized vs. unnormalized) and dimensions.

| Texture Class | Permutation Operation | Coordinates Parameter Type | Mapped Clang AST Expression | LLVM IR Intrinsic Lowering | AIR Opcode Mappings |
|:---|:---|:---|:---|:---|:---|
| `texture1d<T, access>` | `sample` | `(sampler, float)` | `CXXMemberCallExpr` | `@llvm.air.sample.1d` | `air.sample.1d` |
| `texture1d_array<T, acc>`| `sample` | `(sampler, float, uint)` | `CXXMemberCallExpr` | `@llvm.air.sample.1d_array` | `air.sample.1d_array` |
| `texture2d<T, access>` | `sample` | `(sampler, float2)` | `CXXMemberCallExpr` | `@llvm.air.sample.2d` | `air.sample.2d` |
| `texture2d_array<T, acc>`| `sample` | `(sampler, float2, uint)` | `CXXMemberCallExpr` | `@llvm.air.sample.2d_array` | `air.sample.2d_array` |
| `texture3d<T, access>` | `sample` | `(sampler, float3)` | `CXXMemberCallExpr` | `@llvm.air.sample.3d` | `air.sample.3d` |
| `texturecube<T, access>`| `sample` | `(sampler, float3)` | `CXXMemberCallExpr` | `@llvm.air.sample.cube` | `air.sample.cube` |
| `texturecube_array<T, a>`| `sample` | `(sampler, float3, uint)` | `CXXMemberCallExpr` | `@llvm.air.sample.cube_array` | `air.sample.cube_array` |
| `texture1d<T, access>` | `read` | `(uint, uint lod = 0)`| `CXXMemberCallExpr` | `@llvm.air.read.1d` | `air.read.1d` |
| `texture2d<T, access>` | `read` | `(uint2, uint lod = 0)`| `CXXMemberCallExpr` | `@llvm.air.read.2d` | `air.read.2d` |
| `texture3d<T, access>` | `read` | `(uint3, uint lod = 0)`| `CXXMemberCallExpr` | `@llvm.air.read.3d` | `air.read.3d` |



## Anisotropic Filtering and Texel Fetch Units

Texture sampling in MSL is processed by dedicated Texture Processing Units (TPUs) integrated into each GPU core:
- **Bilinear Filtering**: The TPU fetches the four nearest pixels, interpolates them in hardware, and writes the resulting vector back to a destination register.
- **Anisotropic Filtering**: Performs multiple bilinear fetches along the direction of texture coordinates projection, providing sharp filtering for surfaces at steep angles.
- **MIP Mapping**: Calculates level-of-detail (LOD) and selects the appropriate mipmap level, interpolating between two adjacent mip levels in trilinear mode.

## C++ Class Layout of Standard 2D Texture Objects

Below is the complete C++ class structure required to represent a standard 2D texture object inside `<metal_texture>`:

```cpp
#ifndef __METAL_TEXTURE_H
#define __METAL_TEXTURE_H

namespace metal {

enum class access { read, write, sample };

template <typename T, access A>
class texture2d {
private:
  void* handle; // Opaque hardware descriptor pointer

public:
  // Compiler builtin texture fetch
  T read(uint2 coord, uint lod = 0) const {
    return __builtin_msl_texture_read_2d<T>(handle, coord, lod);
  }

  // Compiler builtin texture write
  void write(T color, uint2 coord, uint lod = 0) {
    return __builtin_msl_texture_write_2d<T>(handle, color, coord, lod);
  }
};

} // namespace metal

#endif
```

### TPU Load and Fetch Instructions inside LLVM
During code generation, texture sampling and fetching operations are lowered to target-specific TPU instructions:
```cpp
Value *CodeGenFunction::EmitMetalTextureSample(Value *Tex, Value *Sampler, Value *Coords) {
  Function *F = CGM.getIntrinsic(Intrinsic::air_sample_2d);
  return Builder.CreateCall(F, {Tex, Sampler, Coords});
}
```


## Section Implementer's Guide & Advanced Dynamic Linkage Specifications for SECTION11_API_MAPPING_MATRIX_GRAPHICS_TEXTURES

When building a production-grade clang/llvm compiler backend targeting SECTION11_API_MAPPING_MATRIX_GRAPHICS_TEXTURES:
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
