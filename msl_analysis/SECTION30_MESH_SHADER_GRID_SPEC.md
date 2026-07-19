# Section 30: Mesh Shader Grid and Allocation Specifications

This section specifies the grid dimensions, primitive counts, threadgroup tile allocations, and compiler structures of the Mesh/Object shader pipeline in the Metal Shading Language (MSL).

---

## 1. Table 46: Mesh and Object Shader Grid Mappings

The table below catalogs how mesh and object grid properties are mapped to Clang AST nodes, LLVM IR, and AIR intrinsics.

| MSL Mesh/Object Property | Target Data Type | Mapped Clang AST Node | LLVM IR Intrinsic Lowering | AIR Opcode Mappings |
|:---|:---|:---|:---|:---|
| `set_mesh_grid_size` | `(uint3 grid_size)` | `CXXMemberCallExpr` | `call void @llvm.air.mesh_grid_size(...)` | `air.mesh_grid_size` |
| `set_primitive_count` | `(uint count)` | `CXXMemberCallExpr` | `call void @llvm.air.set_prim_count(...)` | `air.set_primitive_count` |
| `set_vertex` | `(uint index, V data)`| `CXXMemberCallExpr` | Store operations to `@llvm.air.mesh_v` | `air.mesh_write_v` |
| `set_primitive` | `(uint index, P data)`| `CXXMemberCallExpr` | Store operations to `@llvm.air.mesh_p` | `air.mesh_write_p` |
| `set_index` | `(uint index, uint val)`| `CXXMemberCallExpr` | Store operations to `@llvm.air.mesh_i` | `air.mesh_write_i` |

---

## 2. Low-Level Translation Commentary

### 2.1 C++ Implementation of Mesh Shader Tile Allocator in LLVM IR
Below is the C++ implementation required to compile and lower mesh shader tile allocations inside `lib/Target/AGX/AGXMeshLowering.cpp`:

```cpp
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Instructions.h"

using namespace llvm;

Value *EmitMeshTileAllocation(IRBuilder<>& Builder, Value *VertexCount, Value *PrimitiveCount) {
  // Allocate specialized Tile Storage SRAM for vertices and primitives
  Function *F_alloc = Intrinsic::getDeclaration(Builder.GetInsertBlock()->getModule(), Intrinsic::air_mesh_alloc);
  return Builder.CreateCall(F_alloc, {VertexCount, PrimitiveCount});
}
```

### 2.2 TableGen Patterns for Mesh Writes
Below is the TableGen pattern used to select native AGX instructions for writing vertices and primitives:
```tablegen
def : Pat<(air_mesh_write_v GPR:$idx, GPR:$data),
          (AGX_MESH_WRITE_V GPR:$idx, GPR:$data)>;

def : Pat<(air_mesh_write_p GPR:$idx, GPR:$data),
          (AGX_MESH_WRITE_P GPR:$idx, GPR:$data)>;
```


## Section Implementer's Guide & Advanced Dynamic Linkage Specifications for SECTION30_MESH_SHADER_GRID_SPEC

When building a production-grade clang/llvm compiler backend targeting SECTION30_MESH_SHADER_GRID_SPEC:
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
