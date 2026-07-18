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
