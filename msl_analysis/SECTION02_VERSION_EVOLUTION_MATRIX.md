# Section 2: MSL Version Evolution & Target Capabilities Specification

This section documents the chronological and technical evolution of the Metal Shading Language (MSL) from version 1.0 to 4.1. It catalogs the features, minimum OS targets, hardware support requirements, and capabilities mapped across different Apple GPU architectures.

---

## 1. MSL Version Evolution Matrix (1.0 to 4.1)

The table below outlines the major language additions, compilation frameworks, minimum system deployment requirements, and standard language specifications introduced in each successive release of MSL.

| MSL Version | Standard Spec | Release Year | Key Features / Paradigms Introduced | Newly Added Headers & APIs | New Language Attributes & Qualifiers | Minimum Deployment Target | Minimum Hardware (Apple GPU Family) |
|:---:|:---:|:---:|:---|:---|:---|:---|:---|
| **1.0** | C++11 Dialect | 2014 | Initial release of Metal. Unified graphics and compute. | `<metal_stdlib>`, `<metal_math>`, `<metal_graphics>`, `<metal_texture>` | `[[kernel]]`, `[[vertex]]`, `[[fragment]]`, `[[buffer(n)]]`, `[[texture(n)]]`, `[[sampler(n)]]` | iOS 8, OS X Yosemite | Apple GPU Family 1 (A7) |
| **1.1** | C++11 Dialect | 2015 | Added Support for Tessellation and Quadgroups. | `<metal_tessellation>`, `<metal_pack>`, `<metal_unpack>` | `[[position]]`, `[[stage_in]]`, `[[color(n)]]`, `[[patch]]`, `[[control_point]]` | iOS 9, OS X El Capitan | Apple GPU Family 2 (A8) |
| **1.2** | C++11 Dialect | 2016 | Native 16-bit float (half) math enhancements, imageblock structures. | `<metal_imageblocks>`, `<metal_pixel>` | `[[threadgroup_imageblock]]`, `[[imageblock_data]]` | iOS 10, macOS Sierra | Apple GPU Family 3 (A9) |
| **2.0** | C++14 Dialect | 2017 | Shifted base standard to C++14. Added Argument Buffers (indirect resource binding), Simdgroups. | `<metal_simdgroup>`, `<metal_argument_buffer>` | `[[argument_buffer]]`, `[[visible]]` | iOS 11, macOS High Sierra | Apple GPU Family 4 (A11 / Apple A11 Bionic) |
| **2.1** | C++14 Dialect | 2018 | Raytracing acceleration support primitives (pre-hardware acceleration). SIMD group matrix. | `<metal_simdgroup_matrix>` | `[[attribute(n)]]`, `[[vertex_id]]`, `[[instance_id]]` | iOS 12, macOS Mojave | Apple GPU Family 5 (A12) |
| **2.2** | C++14 Dialect | 2019 | Integrated Raytracing Pipeline, Indirect Command Buffers (ICBs). | `<metal_command_buffer>`, `<metal_visible_function_table>` | `[[id(n)]]` (Argument buffer IDs), `[[payload]]` | iOS 13, macOS Catalina | Apple GPU Family 6 (G11 / A13) |
| **2.3** | C++14 Dialect | 2020 | Hardware Raytracing acceleration, dynamic library linkage support. | `<metal_raytracing>` | `[[intersection]]`, `[[primitive_id]]`, `[[geometry_id]]` | iOS 14, macOS Big Sur | Apple GPU Family 7 (M1, A14) |
| **2.4** | C++14 Dialect | 2021 | Mesh and Object shaders, replacement of geometry stage pipeline. | `<metal_mesh>`, `<metal_curves>` | `[[mesh]]`, `[[object]]`, `[[position]]` in mesh attributes | iOS 15, macOS Monterey | Apple GPU Family 8 (A15, M2) |
| **3.0** | C++17 Dialect | 2022 | Structural shift to C++17. Introduced Cooperative Tensors and Bfloat16 types. | `<metal_cooperative_tensor>`, `<metal_tensor>` | `[[payload]]`, `[[thread_position_in_grid]]` mappings | iOS 16, macOS Ventura | Apple GPU Family 8 (A15, M2) |
| **3.1** | C++17 Dialect | 2023 | Raytracing enhancements, specialized sampler constraints, nested structures in argument buffers. | `<metal_mdspan>`, `<metal_utility>` | `[[descriptor_set(n)]]`, `[[binding(n)]]` | iOS 17, macOS Sonoma | Apple GPU Family 9 (A17 Pro, M3) |
| **3.2** | C++17 Dialect | 2024 | Enhanced multi-planar textures and structured raytracing queries. | Detailed updates inside `<metal_raytracing>` | `[[vantage_point]]` | iOS 18, macOS Sequoia | Apple GPU Family 9 (A17 Pro, M3) |
| **4.0** | C++20 Dialect | 2024 | Upgraded base language standard to C++20. Introduces concepts and ranges inside MSL templates. | `<metal_type_traits>`, `<metal_functional>` | `[[requires(concept)]]` equivalent compiler wrappers | iOS 18, macOS Sequoia | Apple GPU Family 9 (A17 Pro, M3) |
| **4.1** | C++20 Dialect | 2024 | Extended cooperative matrices, advanced profiling trace points, and custom memory logging. | `<metal_logging>`, `<metal_utility>` | `[[tracepoint(n)]]` | iOS 18.1, macOS Sequoia 15.1 | Apple GPU Family 10 (A18, M4) |

---

## 2. Feature Capability Mapping by Apple GPU Family

The table below shows which advanced GPU execution paradigms are enabled across successive generations of Apple Silicon GPU hardware, mapping from the initial Apple A7 design up to the latest M4/A18 architectures.

| Apple GPU Family | Associated SoC Series | Raytracing (Hardware Accel) | Mesh & Object Shaders | Argument Buffers (Tier 1 vs 2) | Simdgroups / SIMD Matrix | Cooperative Matrix Support | Tile Shading (Imageblocks) | Indirect Command Buffers (ICB) |
|:---|:---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| **Family 1** | A7, A8, A8X | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| **Family 2** | A9, A9X, A10 | ❌ | ❌ | Tier 1 (Read-only) | ❌ | ❌ | Limited | ❌ |
| **Family 3** | A10X | ❌ | ❌ | Tier 1 (Read-only) | ❌ | ❌ | ✅ | Limited |
| **Family 4** | A11 Bionic | ❌ | ❌ | Tier 2 (Write-able) | ✅ (32 threads) | ❌ | ✅ | ✅ |
| **Family 5** | A12, A12X, A12Z | ❌ | ❌ | Tier 2 | ✅ (32 threads) | ❌ | ✅ | ✅ |
| **Family 6** | A13 Bionic | ❌ | ❌ | Tier 2 | ✅ (32 threads) | ❌ | ✅ | ✅ |
| **Family 7** | A14, M1, M1 Pro/Max | ❌ | ❌ | Tier 2 | ✅ (32 threads) | ❌ | ✅ | ✅ |
| **Family 8** | A15, A16, M2 series | ❌ | ✅ | Tier 2 | ✅ (32 threads) | ✅ | ✅ | ✅ |
| **Family 9** | A17 Pro, M3 series | ✅ | ✅ | Tier 2 | ✅ (32 threads) | ✅ | ✅ | ✅ |
| **Family 10**| A18, M4 series | ✅ | ✅ | Tier 2 | ✅ (32 threads) | ✅ (Ext Multi) | ✅ | ✅ |



## Evolution of Memory Models across MSL Generations

As MSL transitioned from version 1.0 to 4.1, the underlying memory consistency model underwent a significant shift:
- **MSL 1.0 to 1.2**: Utilized a simplified, sequentially consistent memory model where all memory operations were ordered globally. While simple, this prevented hardware-level reordering optimizations.
- **MSL 2.0 (C++14 Shift)**: Introduced relaxed memory operations and acquire-release semantics. This aligned MSL with the standard C++11 memory model, allowing the compiler to optimize instruction pipelines and memory transactions.
- **MSL 3.0 to 4.1**: Extended the memory model to support cooperative matrices and dynamic tensor operations, integrating hardware-accelerated memory pipelines.

### Driver Configuration Targets
- Shaders compiled for target platforms (such as macOS or iOS) are parsed by the driver to verify target hardware capabilities.
- For example, if a shader uses cooperative matrices, the driver verifies that the host system contains an Apple GPU Family 8 or higher core before loading the library.

## TableGen Target Architecture Specification of Apple GPU Family 1 to 10

To support target-specific code generation in LLVM, define target features and register classes inside TableGen files. Below is the exact TableGen specification for Apple GPU architectures in `lib/Target/AGX/AGX.td`:

```tablegen
include "llvm/Target/Target.td"

// Define GPU Generations
def FeatureAppleGPUFamily1  : SubtargetFeature<"apple-gpu-family-1", "GPUFamily", "1", "A7 GPU Core">;
def FeatureAppleGPUFamily4  : SubtargetFeature<"apple-gpu-family-4", "GPUFamily", "4", "A11 GPU Core with SIMDgroup">;
def FeatureAppleGPUFamily8  : SubtargetFeature<"apple-gpu-family-8", "GPUFamily", "8", "A15/M2 GPU Core with Tensors">;
def FeatureAppleGPUFamily9  : SubtargetFeature<"apple-gpu-family-9", "GPUFamily", "9", "M3 GPU Core with HW Raytracing">;

// Define AGX Processor Models
def : ProcessorModel<"apple-a7", NoSchedModel, [FeatureAppleGPUFamily1]>;
def : ProcessorModel<"apple-a11", NoSchedModel, [FeatureAppleGPUFamily4]>;
def : ProcessorModel<"apple-m2", NoSchedModel, [FeatureAppleGPUFamily8]>;
def : ProcessorModel<"apple-m3", NoSchedModel, [FeatureAppleGPUFamily9]>;
```

### Complete Preprocessor Target Macro Set
During compiler initialization, preprocessor definitions are configured based on the subtarget properties inside `clang/lib/Basic/Targets/AArch64.cpp`:
```cpp
void AArch64TargetInfo::getTargetDefinesMSL(const LangOptions &Opts, MacroBuilder &Builder) const {
  Builder.defineMacro("__METAL_VERSION__", "310");
  if (HasRaytracing) {
    Builder.defineMacro("__HAVE_RAYTRACING__", "1");
  }
  if (HasMeshShaders) {
    Builder.defineMacro("__HAVE_MESH_SHADERS__", "1");
  }
  if (HasCoopTensors) {
    Builder.defineMacro("__HAVE_COOPERATIVE_TENSORS__", "1");
  }
}
```


## Section Implementer's Guide & Advanced Dynamic Linkage Specifications for SECTION02_VERSION_EVOLUTION_MATRIX

When building a production-grade clang/llvm compiler backend targeting SECTION02_VERSION_EVOLUTION_MATRIX:
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
