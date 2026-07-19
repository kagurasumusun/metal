# Section 40: Compiler Frontend Parser Rules, Keywords, and Attribute Arguments

This section specifies the parser configurations, reserved keywords, preprocessor macros, builtin macros, reserved identifiers, and attribute arguments utilized by the compiler frontend to parse the Metal Shading Language (MSL).

---

## 1. Table 57: Compiler Frontend Parser Rules, Keywords, and Attribute Arguments

The table below catalogs the reserved keywords, preprocessor/builtin macros, reserved identifiers, and compiler attribute configurations utilized in the MSL frontend.

| Category | Identifier / Keyword / Argument | Syntax Classification | Minimum MSL Version | Purpose / Compiler AST Node |
|:---|:---|:---|:---:|:---|
| **Reserved Keywords** | `kernel` | Function Type Qualifier | MSL 1.0 | Declares a compute shader. AST: `FunctionDecl` |
| **Reserved Keywords** | `vertex` | Function Type Qualifier | MSL 1.0 | Declares a vertex shader. AST: `FunctionDecl` |
| **Reserved Keywords** | `fragment` | Function Type Qualifier | MSL 1.0 | Declares a fragment/pixel shader. AST: `FunctionDecl` |
| **Reserved Keywords** | `device` | Address Space Qualifier | MSL 1.0 | Global read-write memory. AST: `QualType` |
| **Reserved Keywords** | `threadgroup` | Address Space Qualifier | MSL 1.0 | Threadgroup shared local SRAM. AST: `QualType` |
| **Reserved Keywords** | `thread` | Address Space Qualifier | MSL 1.0 | Private registers. AST: `QualType` |
| **Reserved Keywords** | `constant` | Address Space Qualifier | MSL 1.0 | Read-only global memory. AST: `QualType` |
| **Reserved Keywords** | `threadgroup_imageblock` | Address Space Qualifier | MSL 1.2 | Local on-chip render tile memory. AST: `QualType` |
| **Preprocessor Macros** | `__METAL_VERSION__` | Language Version | MSL 1.0 | Returns the compiled MSL version (e.g., `310` for 3.1). |
| **Preprocessor Macros** | `__METAL_MACOS__` | Target Platform | MSL 1.0 | Predefined if compiling for macOS. |
| **Preprocessor Macros** | `__METAL_IOS__` | Target Platform | MSL 1.0 | Predefined if compiling for iOS. |
| **Builtin Macros** | `__has_attribute` | Attribute Query | MSL 1.0 | Preprocessor check for attribute support (e.g. `__has_attribute(metal::kernel)`). |
| **Builtin Macros** | `__has_builtin` | Builtin Query | MSL 1.0 | Preprocessor check for compiler builtin support. |
| **Reserved Identifiers** | `__metal_` prefix | Namespace Protection | MSL 1.0 | Reserved for compiler-internal builtins and runtime symbols. |
| **Reserved Identifiers** | `__air_` prefix | Namespace Protection | MSL 1.0 | Reserved for target-specific intermediate representations. |
| **Attribute Arguments** | `buffer(n)` | Parameter Binding | MSL 1.0 | Binds pointer parameters to buffer index `n`. AST: `ArgumentBufferAttr(n)` |
| **Attribute Arguments** | `texture(n)` | Parameter Binding | MSL 1.0 | Binds texture parameters to texture index `n`. AST: `ArgumentTextureAttr(n)` |
| **Attribute Arguments** | `sampler(n)` | Parameter Binding | MSL 1.0 | Binds sampler parameters to sampler index `n`. AST: `ArgumentSamplerAttr(n)` |
| **Attribute Arguments** | `threadgroup(n)` | Parameter Binding | MSL 1.0 | Allocates `n` bytes of local SRAM. AST: `ArgumentLocalAttr(n)` |
| **Attribute Arguments** | `id(n)` | Struct Field Binding | MSL 2.0 | Binds field inside an Argument Buffer to index `n`. AST: `IdAttr(n)` |

---

## 2. Low-Level Translation Commentary

### 2.1 C++ Implementation of Keyword Parser and Attribute Registration
Below is the C++ implementation required to register MSL keywords inside Clang's identifier table (`clang/lib/Basic/IdentifierTable.cpp`):

```cpp
#include "clang/Basic/IdentifierTable.h"
#include "clang/Basic/TokenKinds.h"

using namespace clang;

void IdentifierTable::RegisterMetalKeywords(const LangOptions &LangOpts) {
  if (LangOpts.Metal) {
    // Register Address Space Qualifiers
    get("device").setKeywordStatusShared(tok::kw_device);
    get("threadgroup").setKeywordStatusShared(tok::kw_threadgroup);
    get("thread").setKeywordStatusShared(tok::kw_thread);
    get("constant").setKeywordStatusShared(tok::kw_constant);

    // Register Entry Point Qualifiers
    get("kernel").setKeywordStatusShared(tok::kw_kernel);
    get("vertex").setKeywordStatusShared(tok::kw_vertex);
    get("fragment").setKeywordStatusShared(tok::kw_fragment);
  }
}
```

### 2.2 TableGen Definitions of Custom MSL Attributes inside `Attr.td`
```tablegen
// Custom MSL Parameter Binding Attribute TableGen Specification
class MetalBindingAttr<string name> : InheritableAttr {
  let Spellings = [CXX11<"metal", name>];
  let Subjects = SubjectList<[ParmVar]>;
  let Args = [UnsignedArgument<"Slot">];
  let Documentation = [Undocumented];
}

def MetalBufferAttr  : MetalBindingAttr<"buffer">;
def MetalTextureAttr : MetalBindingAttr<"texture">;
def MetalSamplerAttr : MetalBindingAttr<"sampler">;
```
