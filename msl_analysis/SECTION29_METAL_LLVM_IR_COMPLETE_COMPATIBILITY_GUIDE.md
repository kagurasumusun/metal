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
