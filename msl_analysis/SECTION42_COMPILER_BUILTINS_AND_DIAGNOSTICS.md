# Section 42: Builtins.def, Attr.td, and Compiler Diagnostics Catalog

This section specifies the builtins configuration (`Builtins.def`), custom attributes (`Attr.td`), and diagnostics warnings/errors catalog of the Clang compiler frontend expanded for the Metal Shading Language (MSL).

---

## 1. Table 59: Builtins.def, Attr.td, and Compiler Diagnostics Catalog

The table below catalogs the target-specific builtins, attributes table, and warning diagnostics required to support compiler front-end development for Metal.

| Component | Identifier / Configuration | Type | Purpose / Trigger Condition | Clang Source Mapped Target |
|:---|:---|:---|:---|:---|
| **`Builtins.def`** | `BUILTIN(__builtin_msl_cos, "ff", "nc")` | Compiler Builtin | Mapped to `metal::cos(float)`. | `clang/Basic/Builtins.def` |
| **`Builtins.def`** | `BUILTIN(__builtin_msl_sin, "ff", "nc")` | Compiler Builtin | Mapped to `metal::sin(float)`. | `clang/Basic/Builtins.def` |
| **`Builtins.def`** | `BUILTIN(__builtin_msl_barrier, "vI", "n")` | Compiler Builtin | Mapped to `threadgroup_barrier`. | `clang/Basic/Builtins.def` |
| **`Attr.td`** | `def MetalKernel : Attr { ... }` | Attribute definition| Compiles `[[kernel]]` statement. | `clang/include/clang/Basic/Attr.td` |
| **`Attr.td`** | `def MetalBuffer : Attr { let Args = [Int]; }` | Attribute definition| Compiles `[[buffer(n)]]` binding. | `clang/include/clang/Basic/Attr.td` |
| **`Diagnostics`** | `err_implicit_vector_conversion_forbidden` | Fatal Error | Implicit vector conversions are forbidden.| `clang/include/clang/Basic/DiagnosticSemaKinds.td` |
| **`Diagnostics`** | `err_invalid_address_space_cast` | Fatal Error | Invalid address space pointer cast. | `clang/include/clang/Basic/DiagnosticSemaKinds.td` |
| **`Diagnostics`** | `warn_metal_compiler_options_mismatch` | Warning | Incompatible compilation flags. | `clang/include/clang/Basic/DiagnosticSemaKinds.td` |

---

## 2. Low-Level Translation Commentary

### 2.1 C++ Implementation of Custom Diagnostic Registration
Below is the C++ implementation of the diagnostic message registration inside `DiagnosticSemaKinds.td` and its mapping inside Clang's diagnostics subsystem:

```cpp
#include "clang/Basic/Diagnostic.h"
#include "clang/Basic/DiagnosticIDs.h"

using namespace clang;

void DiagnosticsEngine::ReportMetalError(SourceLocation Loc, unsigned DiagID) {
  // Report MSL compilation error at source location
  Report(Loc, DiagID);
}
```

### 2.2 TableGen Declaration of custom Diagnostics
```tablegen
def err_implicit_vector_conversion_forbidden : Error<
  "implicit conversion between vector types %0 and %1 is forbidden in MSL; use explicit cast instead">;

def err_invalid_address_space_cast : Error<
  "address space pointer cast between incompatible address spaces is forbidden in MSL">;
```
---

## 3. Detailed Diagnostics and Warning System Specification

Clang's diagnostics system is TableGen-driven. Custom diagnostics for MSL must be declared in `DiagnosticSemaKinds.td` and validated in `Sema`:

1. **Fatal Errors**:
   - `err_implicit_vector_conversion_forbidden`: Triggers when an developer assigns a `float4` to a `half4` without an explicit cast.
   - `err_invalid_address_space_cast`: Triggers when casting pointers across incompatible address spaces (e.g., casting `device` to `threadgroup`).
   - `err_metal_unsupported_type`: Triggers when unsupported C++ types (e.g., standard C++ double-precision types on older targets, or references/pointers of references) are declared.

2. **Warnings**:
   - `warn_metal_compiler_options_mismatch`: Warns when compilation flags (e.g., combining `-fno-fast-math` and `-ffast-math`) are conflicting.
   - `warn_unused_local_variable`: Highlights unused declarations, allowing register optimization.
