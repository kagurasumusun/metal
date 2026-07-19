# Section 29: Complete Compatibility Guide on How to Extend Clang and LLVM IR to Fully Support Metal

This section provides a highly detailed, step-by-step engineering guide on how to extend standard Clang and LLVM IR to fully support the Metal Shading Language (MSL) and compilation to Apple Intermediate Representation (AIR).

---

## 1. Clang Frontend Extension Guide

To compile MSL source code, the Clang frontend must be extended to parse MSL-specific syntax, support custom attributes, and map address space qualifiers.

### 1.1 Step 1: Target Triple Integration
Clang identifies target systems using Target Triples. To support compilation to AIR, integrate the following target triples into the Clang target register:
- `air64-apple-ios`
- `air64-apple-macosx`
- `air32-apple-watchos`

Modify `clang/lib/Basic/Targets.cpp` to register these target environments, mapping their pointers, alignments, and bit widths to match the standard Apple Silicon 64-bit/32-bit execution models.

### 1.2 Step 2: Language Dialect Configuration
Enable a custom language dialect for MSL (e.g., `LangOptions::MSL`) when parsing with the `-x metal` compiler flag.
- Enable standard C++ language options (C++14, C++17, or C++20 depending on the compilation mode).
- Prohibit unsupported C++ features (such as run-time type information `RTTI`, exception handling, virtual functions, and dynamic allocations `new`/`delete`) by throwing compilation errors inside `clang/lib/Sema/Sema.cpp`.

### 1.3 Step 3: MSL Attribute Integration
Extend the Clang Parser to recognize MSL-specific attributes (`[[kernel]]`, `[[vertex]]`, `[[fragment]]`, `[[buffer(n)]]`, etc.).
- Update `clang/include/clang/Basic/Attr.td` to declare these custom attributes.
- Example attribute declaration:
  ```tablegen
  def MetalKernel : InheritableAttr {
    let Spellings = [CXX11<"metal", "kernel">];
    let Subjects = SubjectList<[Function]>;
    let Documentation = [Undocumented];
  }
  ```
- Modify `clang/lib/Sema/SemaDeclAttr.cpp` to parse, validate, and attach these attributes to AST node declarations (`FunctionDecl`, `ParmVarDecl`, etc.).

### 1.4 Step 4: Target Address Space Mappings
Map MSL-specific address spaces (`device`, `constant`, `threadgroup`, `thread`) to LLVM IR address spaces.
- Define a custom address space mapping block in `clang/lib/Basic/Targets/AArch64.cpp` (or a dedicated target-mapping class):
  - `device` mapped to target Address Space `1`
  - `constant` mapped to target Address Space `2`
  - `threadgroup` mapped to target Address Space `3`
  - `thread` mapped to target Address Space `0` (Default / Private registers)

---

## 2. LLVM Backend & Code Generation Extension Guide

Once the AST is parsed, the LLVM code generator and optimization passes must be extended to support lowering to AIR bitcode.

### 2.1 Step 1: CodeGen Address Space Propagation
Update `clang/lib/CodeGen/CGDecl.cpp` and `clang/lib/CodeGen/CGExpr.cpp` to propagate address space attributes.
- Ensure that pointer variables are instantiated in their target Address Spaces when emitting LLVM IR.
- Prevent Clang's code generator from optimizing out address-space-specific pointers, ensuring they are compiled with correct memory scopes.

### 2.2 Step 2: Intrinsic Lowering Integration
Map Clang-prefixed builtins (such as `__builtin_msl_barrier`) to their corresponding LLVM/AIR intrinsic functions.
- Update `clang/lib/CodeGen/CGBuiltin.cpp` to intercept MSL builtins and emit custom intrinsic calls:
  ```cpp
  case Builtin::BI__builtin_msl_barrier_tg:
    return Builder.CreateCall(CGM.getIntrinsic(Intrinsic::air_barrier_threadgroup));
  ```

### 2.3 Step 3: Optimization Passes Integration
Add target-specific optimization passes to the LLVM Pass Manager (`llvm/lib/Transforms/Scalar/`):
- **SROA (Scalar Replacement of Aggregates)**: Ensure structures containing resource pointers are broken down into individual scalar variables, allowing them to be allocated directly to registers.
- **Address Space Promotion**: Optimize memory loads/stores targeting the same cache line, converting redundant pointer fetches to shared GPR registers.
- **Vector Instruction Combining**: Combine adjacent scalar instructions targeting vector indices into single, high-performance vector instructions.

### 2.4 Step 4: Metadata Serialization
Ensure that named metadata nodes required by the GPU JIT compiler (such as `!air.kernels`, `!air.arg_types`, and `!air.version`) are serialized into the compiled bitcode.
- Modify `clang/lib/CodeGen/BackendUtil.cpp` to write these named metadata nodes based on AST attribute declarations.
- This ensures the compiled bitcode can be parsed correctly by the GPU driver and host APIs.



## Custom Pass Pipelines for Target Selection in LLVM

When extending LLVM to output compiled AIR modules:
- **Target Selection**: Register a dedicated `AIRTargetMachine` class within LLVM's target backend database.
- **Pass Pipeline**: Hook custom memory-routing and metadata-generation passes into the LLVM Pass Builder, ensuring AIR compatibility at scale.

## LLVM Backend configurations for AGX Architecture

Below is the target backend machine registry declaration inside `lib/Target/AGX/TargetInfo/AGXTargetInfo.cpp`:

```cpp
#include "llvm/MC/TargetRegistry.h"

using namespace llvm;

Target &getTheAGXTarget() {
  static Target TheAGXTarget;
  return TheAGXTarget;
}

extern "C" LLVM_EXTERNAL_VISIBILITY void LLVMInitializeAGXTargetInfo() {
  RegisterTarget<Triple::agx> X(getTheAGXTarget(), "agx", "Apple Silicon AGX Architecture", "AGX");
}
```

### Backend Pass Pipeline Registries inside PassBuilder
Below is the target pass pipeline initialization declaration inside `llvm/lib/Passes/PassBuilder.cpp`:
```cpp
void PassBuilder::RegisterAGXPasses() {
  registerPipelineParsingCallback(
    [](StringRef Name, FunctionPassManager &FPM, ArrayRef<PipelineElement>) {
      if (Name == "agx-sroa") {
        FPM.addPass(AGXSROAPass());
        return true;
      }
      return false;
    });
}
```


## Section Implementer's Guide & Advanced Dynamic Linkage Specifications for SECTION29_METAL_LLVM_IR_COMPLETE_COMPATIBILITY_GUIDE

When building a production-grade clang/llvm compiler backend targeting SECTION29_METAL_LLVM_IR_COMPLETE_COMPATIBILITY_GUIDE:
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
