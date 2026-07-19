# Section 41: Compiler Semantic Validation, Conversion, and Resolution Rules

This section specifies the semantic analysis, type conversions, name resolution, template deduction, and overload resolution rules enforced by the compiler frontend in the Metal Shading Language (MSL).

---

## 1. Table 58: Compiler Semantic Validation, Conversion, and Resolution Rules

The table below catalogs the semantic and validation rules executed by Clang during type analysis, syntax checks, and overload resolutions.

| Category / Phase | Target Operations | Semantic Validation Rules Enforced | Clang Sema Component | LLVM CodeGen / lowering impact |
|:---|:---|:---|:---|:---|
| **Type Traits** | `metal::is_same<A, B>` | Evaluates template type equivalency at compile time. | `SemaChecking.cpp` | Lowered to constant boolean `i1` |
| **Implicit Conversion** | Scalar to Scalar | Implicit widening (e.g. `half` to `float`) is allowed. | `SemaChecking.cpp` | Generates standard `fpext` / `sext` instructions |
| **Implicit Conversion** | Vector to Vector | **Strictly Forbidden**. Converting vectors requires explicit casts. | `SemaChecking.cpp` | Compilation failure if implicit cast attempted |
| **Explicit Conversion** | `float4(int4)` | Executes functional casts on components. | `SemaCast.cpp` | Generates conversion intrinsics (`fptosi`, etc.) |
| **Explicit Conversion** | `as_type<T>(value)`| Bitwise re-interpretation. Bit widths must match. | `SemaCast.cpp` | Lowers directly to LLVM `bitcast` instruction |
| **Address Space Cast** | `device` to `thread` | **Forbidden**. Cannot cast across address spaces. | `SemaCast.cpp` | Compilation failure if address spaces mismatch |
| **Operator Overload** | Vector `+`, `-`, `*` | Element-wise vector operators are parsed as C++ overloads. | `SemaOverload.cpp` | Generates vectorized arithmetic instructions |
| **Template Deduction** | `<metal_texture>` types| Deduces pixel types and access qualifiers. | `SemaTemplate.cpp`| Generates target image descriptors in IR |
| **Name Lookup** | Namespace lookup | Resolves identifiers within `metal::` namespace first. | `SemaLookup.cpp` | Resolves symbols in target LLVM modules |
| **Overload Resolution**| Math / Integer overloads| Selects matching scalar or vector signature. | `SemaOverload.cpp` | Emits target-specific math intrinsics |

---

## 2. Low-Level Translation Commentary

### 2.1 C++ Implementation of Implicit Conversion Check in Sema
Below is the C++ implementation of a dedicated Sema validator that checks for implicit vector conversions inside `lib/Sema/SemaExprMetal.cpp`:

```cpp
#include "clang/Sema/Sema.h"
#include "clang/AST/Type.h"

using namespace clang;

bool Sema::CheckMetalVectorImplicitConversion(QualType SrcTy, QualType DestTy, SourceLocation Loc) {
  if (SrcTy->isVectorType() && DestTy->isVectorType()) {
    if (SrcTy != DestTy) {
      // Vector conversions must be explicit. Throw compile-time error
      Diag(Loc, diag::err_implicit_vector_conversion_forbidden) << SrcTy << DestTy;
      return false;
    }
  }
  return true;
}
```

### 2.2 TableGen Patterns for Vector Operations
Below is the TableGen pattern used to map vector arithmetic overloads directly to native vector instructions:
```tablegen
def : Pat<(fadd (v4f32 GPR:$src1), (v4f32 GPR:$src2)),
          (AGX_FADD_V4F32 GPR:$src1, GPR:$src2)>;
```
---

## 3. Detailed Name Lookup and Overload Resolution Specification

When the compiler parses a function call (such as `cos(x)`), it executes name lookup and overload resolution to determine the appropriate signature:

1. **Name Lookup**:
   - Searches the local block scope and class namespaces.
   - Searches the `metal` namespace (via implicit `using namespace metal` inside compilation units).
   - If multiple candidates are found, they are gathered as an overload set.

2. **Overload Resolution**:
   - Compares the argument types against the parameter types of each candidate in the overload set.
   - Evaluates conversion sequences (e.g., exact matches, promotions, or standard conversions).
   - If an exact match exists (e.g., passing a `float4` to `cos(float4)`), that candidate is selected.
   - If multiple candidates are viable via conversion, the compiler selects the best match using C++ overload resolution rules.
   - If no candidates are viable, or if the best match is ambiguous, a compile-time diagnostic error is thrown.
   - Once resolved, the selected function is lowered to its corresponding LLVM/AIR intrinsic.
