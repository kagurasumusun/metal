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
