# Section 25: Stage-In Structural Layouts and Host Vertex Descriptors

This section specifies the structural layout generation, compiler properties, and host-side descriptors used to map `[[stage_in]]` variables to physical vertex buffers in the Metal Shading Language (MSL).

---

## 1. Table 42: Stage-In Mappings and Host Vertex Descriptors

The table below catalogs how different MSL attribute layout qualifiers decorated inside structures are mapped to host-side `MTLVertexDescriptor` or `MTLPipelineDescriptor` APIs.

| MSL Attribute Layout Qualifier | Target Data Type | Clang AST Node representation | Mapped LLVM / AIR Metadata | Host-Side API Descriptor Mappings | Hardware Vertex Fetch Behavior |
|:---|:---|:---|:---|:---|:---|
| `[[attribute(n)]]` | `floatN`, `halfN`, etc. | `FieldDecl` with AST attribute | `!air.vertex_inputs` (attribute slot `n`) | `MTLVertexDescriptor.attributes[n]` | Automated fixed-function vertex fetching. |
| `[[user(name)]]` | Struct / Vector | `FieldDecl` with AST attribute | `!air.user_attributes` (name tag) | Custom shader reflection bindings | Bypasses vertex fetch; mapped programmatically. |
| `[[position]]` | `float4` | `FieldDecl` with AST attribute | `!air.vertex_outputs` (position slot) | Viewport clipper and rasterizer inputs | Used directly by rasterizer for viewport clipping. |

---

## 2. Low-Level Translation Commentary

### 2.1 Stage-In Layout Generation
In MSL, the `[[stage_in]]` attribute is decorated on a structure parameter passed to a vertex or fragment shader:

```cpp
struct VertexInput {
  float4 position [[attribute(0)]];
  float2 texcoords [[attribute(1)]];
};

vertex VertexOutput my_vertex(VertexInput in [[stage_in]]) { ... }
```

When Clang parses the `VertexInput` structure:
1. It validates that all members inside the stage-in structure are decorated with unique attributes (such as `[[attribute(n)]]`).
2. It generates metadata nodes in LLVM IR (e.g., `!air.vertex_inputs`), which map the attributes to slot indices.
3. This metadata is serialized into the `.air` bitcode and compiled into the `.metallib` reflection section (`REF`).
4. At runtime, the GPU's fixed-function **Vertex Fetch Unit (VFU)** reads the `MTLVertexDescriptor` configured on the CPU, fetches texels from vertex buffers, converts their formats, and writes the resulting vectors directly to the thread's input registers.
5. This compilation model offloads vertex fetching from the ALUs, maximizing geometric processing efficiency.



## Automated Vertex Fetching and Attribute Layouts

The `[[stage_in]]` attribute maps vertex input structure parameters to vertex buffers:
- **Metadata Serialization**: Serializes attribute bindings to `.air` bitcode metadata.
- **Automated Vertex Fetching**: The GPU's fixed-function Vertex Fetch Unit automatically fetches vertex parameters, converts formats, and writes them to registers.

## Clang AST Layout representation of Stage-In parameters

Below is the actual C++ AST declaration modeling vertex attributes inside `clang/include/clang/AST/Decl.h`:

```cpp
#include "clang/AST/Decl.h"

namespace clang {

class StageInDecl : public VarDecl {
private:
  unsigned AttributeSlot;

public:
  StageInDecl(DeclContext *DC, SourceLocation L, IdentifierInfo *Id, QualType T, unsigned Slot)
    : VarDecl(Var, DC, L, L, Id, T, nullptr, SC_None), AttributeSlot(Slot) {}

  unsigned getAttributeSlot() const { return AttributeSlot; }
};

}
```

### Vertex Input Metadata Generation inside CodeGen
Below is the C++ implementation required to register stage-in fields to AIR vertex input metadata:
```cpp
void CodeGenModule::EmitMetalVertexInputMetadata(const VarDecl *VD) {
  if (const auto *StageIn = dyn_cast<StageInDecl>(VD)) {
    unsigned Slot = StageIn->getAttributeSlot();
    // Emit metadata mappings for Slot
  }
}
```


## Section Implementer's Guide & Advanced Dynamic Linkage Specifications for SECTION25_STAGE_IN_ATTRIBUTE_MAPPINGS

When building a production-grade clang/llvm compiler backend targeting SECTION25_STAGE_IN_ATTRIBUTE_MAPPINGS:
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
