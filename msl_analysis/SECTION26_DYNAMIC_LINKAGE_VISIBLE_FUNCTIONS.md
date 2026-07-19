# Section 26: Visible Functions and Late Runtime Linkage Mappings

This section specifies the dynamic function pointer lookups, visible function tables (VFTs), dynamic compiler structures, and late linking behaviors of the Metal Shading Language (MSL).

---

## 1. Table 43: Visible Functions and Late Runtime Linkage

The table below catalogs the properties, template wrappers, and compiler mappings of Visible Functions, which enable runtime dynamic linkage and dispatch.

| MSL Dynamic Linkage Class | MSL Function / Operator | Signature and Typings | Clang AST Node | LLVM IR Intrinsic Lowering | Mapped AIR Opcode |
|:---|:---|:---|:---|:---|:---|
| `visible_function_table<F>`| `operator[]` | `operator[](uint index)` | `CXXOperatorCallExpr` | Indexes into function pointer array | Dynamic symbol lookup |
| `visible_function_table<F>`| `get_width()` | `() -> uint` | `CXXMemberCallExpr` | `@llvm.air.get_vft_width(...)` | `air.get_vft_width` |
| `function_descriptor` | Struct | Contains function symbol name, attributes | `RecordDecl` | Opaque dynamic struct description | Mapped to runtime symbol |

---

## 2. Low-Level Translation Commentary

### 2.1 Dynamic Linkage and Indirect Branches
Visible Function Tables (VFTs) are compiled as arrays of opaque function pointers.
- When a shader performs a call on a function loaded from a VFT (e.g., `table[index](args...)`):
- Clang compiles the expression into an indirect function call (`IndirectCallExpr`) in the AST.
- This is lowered in LLVM IR to a dynamic indirect branch (`call %func_ptr %args`).
- At the hardware level, the AGX ISA translator compiles the dynamic call into an indirect branch instruction using a target address register.
- This dynamic lookup and branch allows parent shaders (such as raytracing closest-hit stages) to execute dynamic functions resolved at runtime.
- As a result, VFTs provide maximum flexibility for advanced graphics algorithms on Apple Silicon GPUs.



## Late Linkage and Dynamic dispatched Function pointers

Late runtime linkage enables dynamic dispatch and late shader linking:
- **Visible Function Tables (VFTs)**: Compiled as arrays of opaque function pointers.
- **Indirect Call Execution**: Clang compiles table lookups to indirect branch instructions in hardware, allowing dynamic functions to be resolved at runtime.

## Indirect Branch Lowering in LLVM CodeGen

Below is the C++ CodeGen implementation of indirect call emission inside `clang/lib/CodeGen/CGExprCall.cpp`:

```cpp
#include "llvm/IR/IRBuilder.h"

using namespace llvm;

Value *EmitIndirectCall(IRBuilder<>& Builder, Value *FuncPtr, ArrayRef<Value*> Args) {
  // Emit indirect call instruction: call %reg %args
  return Builder.CreateCall(FuncPtr, Args);
}
```

### Dynamic Dispatch and VFT Lowering inside CodeGen
Below is the C++ implementation required to compile dynamic visible function table lookups:
```cpp
Value *CodeGenFunction::EmitMetalVisibleFunctionCall(Value *VFT, Value *Index, ArrayRef<Value*> Args) {
  // Index into function pointer array and load ptr
  Value *FuncPtr = Builder.CreateGEP(VFT, Index);
  return Builder.CreateCall(FuncPtr, Args);
}
```


## Section Implementer's Guide & Advanced Dynamic Linkage Specifications for SECTION26_DYNAMIC_LINKAGE_VISIBLE_FUNCTIONS

When building a production-grade clang/llvm compiler backend targeting SECTION26_DYNAMIC_LINKAGE_VISIBLE_FUNCTIONS:
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
