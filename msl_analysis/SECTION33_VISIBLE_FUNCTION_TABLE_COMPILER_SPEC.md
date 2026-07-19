# Section 33: Visible Function Tables and Function Groups

This section specifies the compilation of visible functions, visible function tables (VFTs), function groups, and dynamic linkage models on Apple Silicon GPUs.

---

## 1. Table 49: Visible Function Tables (VFT) Mappings

The table below catalogs how visible function tables and descriptors are mapped to Clang AST nodes, LLVM IR, and AIR intrinsics.

| MSL VFT Component | Mapped Description | Clang AST Node | LLVM IR Intrinsic Lowering | AIR Opcode |
|:---|:---|:---|:---|:---|
| `visible_function_table<F>`| Opaque function pointer array | `ClassTemplateSpecializationDecl` | Pointer array addressing | Dynamic symbol load |
| `get_width()` | Returns total table entries | `CXXMemberCallExpr` | `call i32 @llvm.air.get_vft_width(...)` | `air.get_vft_width` |
| `function_descriptor` | Dynamically loads symbol | `RecordDecl` | Opaque struct pointer | Target metadata |

---

## 2. Low-Level Translation Commentary

### 2.1 C++ Header for visible_function_table inside `<metal_visible_function_table>`
Below is the C++ header layout required to declare Visible Function Tables inside `<metal_visible_function_table>`:

```cpp
#ifndef __METAL_VISIBLE_FUNCTION_TABLE_H
#define __METAL_VISIBLE_FUNCTION_TABLE_H

namespace metal {

template <typename F>
class visible_function_table {
private:
  void* handle;

public:
  uint get_width() const {
    return __builtin_msl_get_vft_width(handle);
  }

  F operator[](uint index) const {
    return (F)__builtin_msl_load_vft_entry(handle, index);
  }
};

} // namespace metal

#endif
```

### 2.2 Indirect Branch Compilation inside AGX backend
The backend handles the compilation of indirect dynamic branches targeting visible functions. Below is the C++ implementation required to emit indirect branch selection DAG nodes:
```cpp
#include "llvm/MC/MCInst.h"

using namespace llvm;

void EmitIndirectBranch(MCInst &OutMI, unsigned TargetReg) {
  OutMI.setOpcode(1234); // Speculative AGX register jump
  OutMI.addOperand(MCOperand::createReg(TargetReg));
}
```


## Section Implementer's Guide & Advanced Dynamic Linkage Specifications for SECTION33_VISIBLE_FUNCTION_TABLE_COMPILER_SPEC

When building a production-grade clang/llvm compiler backend targeting SECTION33_VISIBLE_FUNCTION_TABLE_COMPILER_SPEC:
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
