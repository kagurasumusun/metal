# Metal Shading Language (MSL) Comprehensive API Lowering and Translation Specification Suite

This directory contains the ultimate, academic-grade specification and mapping matrix suite for the Metal Shading Language (MSL). It is designed to serve as an exhaustive, complete reference for adapting, optimizing, or implementing full Clang, LLVM, and AIR support for Metal.

The suite is divided into 17 highly detailed sections, organized as follows:

- **[Section 1: MSL to AIR/Metallib Compiler Pipeline and Architecture Specification](SECTION01_PIPELINE_AND_COMPILER_SPEC.md)**: Deep dive into the MSL translation pipeline, `.air` LLVM dialect, and Universal/Mach-O `.metallib` container binary format specs.
- **[Section 2: MSL Version Evolution & Target Capabilities Specification](SECTION02_VERSION_EVOLUTION_MATRIX.md)**: Historical evolution from MSL 1.0 to 4.1 paired with target capabilities matrices for Apple GPU Families (1 to 10).
- **[Section 3: MSL Type System, Memory Layout, and Alignment Specification](SECTION03_TYPE_SYSTEM_AND_REPRESENTATION.md)**: Detailed memory layout, byte alignment, and packing rules for scalar, vector, matrix, and texture pixel layouts.
- **[Section 4: Memory Address Spaces, Caching, and Synchronization](SECTION04_MEMORY_SPACES_AND_BARRIERS.md)**: Maps address spaces (`device`, `threadgroup`, `thread`, `constant`) to LLVM IR, caching tiers, and execution fence synchronization semantics.
- **[Section 5: MSL Language Attributes, Qualifiers, and Identifiers](SECTION05_LANGUAGE_ATTRIBUTES_AND_QUALIFIERS.md)**: Details entry stage attributes, vertex/fragment semantic attributes, binding layouts, and workgroup coordinate indicators.
- **[Section 6: MSL Standard Library Headers, Enums, and Template Declarations](SECTION06_HEADERS_AND_DECLARATIONS_MANIFEST.md)**: Comprehensive manifest of all headers, core enumerations, and template structures inside `<metal_stdlib>`.
- **[Section 7: API Compilation Classification - Builtin vs. Header-only vs. Runtime](SECTION07_API_MAPPING_BUILTIN_CLASSIFICATION.md)**: Specifies the compilation classification and linker strategy (Compiler Builtin, Header template, or Dynamic GPU Runtime linking).
- **[Section 8: Exhaustive API Mapping Matrix - Integer Arithmetic](SECTION08_API_MAPPING_MATRIX_INTEGER.md)**: Complete mapping matrix of all MSL integer functions across all scalar/vector types.
- **[Section 9: Exhaustive API Mapping Matrix - Floating-Point Math](SECTION09_API_MAPPING_MATRIX_MATH_SCALAR_VEC.md)**: Complete mapping matrix of all MSL math functions with precision mode constraints.
- **[Section 10: Exhaustive API Mapping Matrix - Geometric, Relational, and Logical Operations](SECTION10_API_MAPPING_MATRIX_GEOMETRIC_RELATIONAL.md)**: Covers vector reductions, step/smoothstep interpolation, branchless FSEL selection, and explicit type conversion mechanics (`as_type`).
- **[Section 11: Exhaustive API Mapping Matrix - Texture Sampling, Reading, and Writing](SECTION11_API_MAPPING_MATRIX_GRAPHICS_TEXTURES.md)**: Details normalized/pixel coordinate mapping, constexpr sampler state bitfield compilation (32-bit word), and LLVM texture intrinsic lowering.
- **[Section 12: Exhaustive API Mapping Matrix - Atomics, SIMDgroup, and Cooperative Matrix Operations](SECTION12_API_MAPPING_MATRIX_ATOMICS_SYNC_COOP.md)**: Outlines L2/SRAM hardware atomic execution, intra-lane shuffles, and cooperative tensor matrix multiplication architectures (MMA).
- **[Section 13: Exhaustive API Mapping Matrix - Raytracing, Mesh, Tessellation, and Visible Functions](SECTION13_API_MAPPING_MATRIX_ADVANCED_FEATURES.md)**: Covers dynamic raytracing BVH traversal, mesh/object threadgroup allocation, dynamic late-linking with Visible Function Tables, and patch tessellation.
- **[Section 14: Mathematical Precision, Error Bounds, and Precision Modes](SECTION14_MATHEMATICAL_PRECISION_ERR_BOUNDS.md)**: Details IEEE-754 compatibility, compiler optimization options, and ULP (Unit in the Last Place) error bounds.
- **[Section 15: LLVM IR and Intrinsic to AIR Opcode Mapping Specification](SECTION15_LLVM_IR_TO_AIR_OPCODES.md)**: Full instruction lowering and optimization paths from standard LLVM IR to AIR-specific opcodes.
- **[Section 16: GPU Runtime, RT Libraries, and Bitcode Symbol Analysis Specification](SECTION16_GPU_RUNTIME_AND_RT_LIBRARIES.md)**: Extensive analysis of precompiled runtime archives (`libmetal_rt`, `libair_rt`, `MTLRaytracingRuntime`) with direct symbol mappings.
- **[Section 17: Diagnostics, Debugging, Logging, and Profiling Specification](SECTION17_DIAGNOSTICS_DEBUGGING_LOGGING.md)**: Specifications for diagnostic warnings control, assert trapping, resource tracking, post-transform mesh dumping, and Statement-Level Trace Points.

---
Created with rigorous attention to detail for engineers developing systems targeting Metal compilation, LLVM backends, or GPU runtime frameworks.
