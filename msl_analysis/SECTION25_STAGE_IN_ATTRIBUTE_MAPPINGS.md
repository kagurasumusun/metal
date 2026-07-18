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
