# Section 43: LLVM IR/AIR Intrinsics, Metadata, ABI, Mangling, and Module Maps

This section specifies the backend mapping properties, named metadata node targets, dynamic ABIs, name mangling configurations, and module maps utilized in compiled Apple Intermediate Representation (AIR) modules.

---

## 1. Table 60: LLVM IR/AIR Intrinsics, Metadata, ABI, Mangling, and Module Maps

The table below catalogs the backend and linker properties required to build standard AIR assemblies and `.metallib` archives.

| Component / Subsystem | Target Construct / Identifier | Description / Parameter Settings | Mapped AIR / LLVM Backend Target |
|:---|:---|:---|:---|
| **AIR Metadata** | `!air.kernels` | Named metadata cataloging compute, vertex, and fragment entry points. | LLVM IR Module metadata node |
| **AIR Metadata** | `!air.arg_types` | Specifies argument type layouts (buffer, texture, sampler, local). | LLVM IR Module metadata node |
| **AIR Metadata** | `!air.version` | Specifies the compiled AIR target version (e.g. `2.5`). | LLVM IR Module metadata node |
| **LLVM Intrinsic** | `@llvm.cos.*` | Standard floating-point cosine math intrinsic. | `@llvm.cos.f32` / `@llvm.cos.f16` |
| **AIR Intrinsic** | `@air.sample.*` | Specialized texture sampling intrinsic. | `@llvm.air.sample.2d` |
| **Runtime ABI** | GPR parameter passing | Maps scalar and small vector parameters directly to floating-point GPRs. | Apple A64/AGX Hardware Register ABI |
| **Name Mangling** | `_ZN5metal3abs` | Itanium C++ ABI mangling style for standard math and helper overloads.| Compiled object symbol linkage |
| **Module Map** | `module.modulemap` | Standard Clang Module Map defining the boundaries of `<metal_stdlib>`.| `reference/clang/.../include/metal/module.modulemap` |

---

## 2. Low-Level Translation Commentary

### 2.1 C++ Implementation of Name Mangler in LLVM IR
Below is the C++ implementation of the Itanium Name Mangler extensions used to generate mangled MSL function signatures inside `clang/lib/AST/ItaniumMangle.cpp`:

```cpp
#include "clang/AST/Mangle.h"
#include "clang/AST/ASTContext.h"

using namespace clang;

void ItaniumMangleContext::MangleMetalAddressSpacePointer(const QualType Ty, raw_ostream &Out) {
  unsigned AddressSpace = Ty.getAddressSpace();
  // Prefix Address Space identifier (e.g., U8device for device address space)
  if (AddressSpace == 1) {
    Out << "U8device";
  } else if (AddressSpace == 3) {
    Out << "U11threadgroup";
  }
}
```

### 2.2 TableGen Patterns for Calling Conventions
Below is the TableGen pattern used to configure target register calling conventions inside `lib/Target/AGX/AGXCallingConv.td`:
```tablegen
def CC_AGX : CallingConv<[
  // Pass scalar half/float parameters in GPR register file
  CCIfType<[f16, f32], CCAssignToReg<[R0, R1, R2, R3, R4, R5, R6, R7]>>
]>;
```
---

## 3. Clang Module Map Specification for `<metal_stdlib>`

To support modular compilation, the standard library includes a module map file (`module.modulemap`) defining header boundaries:

```modulemap
module metal {
  header "metal_stdlib"
  export *

  module types {
    header "metal_types"
    export *
  }

  module math {
    header "metal_math"
    export *
  }
}
```
- During compilation, Clang loads this module map to parse library headers as precompiled modules, which significantly improves compilation performance.
