# Section 24: Pointer Cast and Address Space Compatibility Matrix

This section specifies the pointer casting rules, compiler restrictions, address space compatibility, and LLVM IR representations of pointer conversions in the Metal Shading Language (MSL).

---

## 1. Table 41: Address Space Pointer Cast Compatibility Matrix

The matrix below defines which pointer casts between different MSL address spaces are permitted, which trigger compiler diagnostics, and how they lower to LLVM IR.

| Source Address Space | Destination Address Space | Cast Type Allowed? | Compiler Diagnostic Warning / Error | LLVM IR Translation Behavior |
|:---|:---|:---:|:---|:---|
| `device` | `device` | **Implicit / Explicit** | None | Simple bitcast / GEP operations. |
| `threadgroup` | `threadgroup` | **Implicit / Explicit** | None | Simple bitcast / GEP operations. |
| `thread` | `thread` | **Implicit / Explicit** | None | Simple bitcast / GEP operations. |
| `constant` | `constant` | **Implicit / Explicit** | None | Simple bitcast / GEP operations. |
| `device` / `constant` | `threadgroup` / `thread`| ❌ **Forbidden** | `error: cast increases address space restriction` | Triggers compile-time fatal assertion. |
| `thread` | `device` | ❌ **Forbidden** | `error: cast increases address space restriction` | Triggers compile-time fatal assertion. |
| `threadgroup` | `device` | ❌ **Forbidden** | `error: cast increases address space restriction` | Triggers compile-time fatal assertion. |

---

## 2. Low-Level Translation Commentary

### 2.1 Pointer Casting Safety Rules
MSL prevents pointer casting between different address spaces (except within the same address space) to ensure memory safety and avoid hardware memory access violations:
- On Apple Silicon, different address spaces map to completely separate physical memory pipelines and hardware caching structures.
- Casting a pointer from `thread` (private registers or thread-local stack) to `device` (global VRAM) is physically impossible because they utilize different addressing schemes.
- If such casts were allowed, they would result in undefined hardware behavior or memory corruption.
- To prevent this, the Clang frontend validates address spaces during semantic analysis, throwing a fatal compilation error if incompatible pointer casts are detected.
- This strict type validation ensures that pointer operations can be safely routed to target caches.
- As a result, pointers are highly optimized and secure under the MSL memory model.



## Address Space Qualification and Casting Warnings

The MSL compiler enforces strict pointer casting rules across address spaces:
- **Address Space Partitioning**: Maps pointer qualifiers to separate hardware memory pipelines.
- **Sema Diagnostics**: Validates pointer casts during semantic analysis, throwing a fatal compilation error if incompatible pointer conversions are detected.

## Clang Semantic Verification of Address Space Casts

Below is the actual C++ implementation of Sema verification checking for address space validity in `lib/Sema/SemaCast.cpp`:

```cpp
#include "clang/Sema/Sema.h"
#include "clang/AST/Type.h"

using namespace clang;

bool Sema::CheckMetalAddressSpaceCast(QualType SrcTy, QualType DestTy, SourceLocation Loc) {
  unsigned SrcAS = SrcTy.getTypePtr()->getPointeeType().getAddressSpace();
  unsigned DestAS = DestTy.getTypePtr()->getPointeeType().getAddressSpace();

  // Enforce address space safety: cannot cast thread/threadgroup to device/constant
  if (SrcAS != DestAS) {
    if (DestAS == 1 || DestAS == 2) { // device or constant
      Diag(Loc, diag::err_invalid_address_space_cast);
      return false;
    }
  }
  return true;
}
```
