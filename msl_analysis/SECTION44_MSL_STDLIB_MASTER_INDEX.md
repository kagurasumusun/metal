# Section 44: MSL stdlib Master Headers and Dependencies Catalog

This section specifies the complete, hierarchical file index, include dependencies, namespaces, and target architectures of all header files inside `<metal_stdlib>`.

---

## 1. Table 61: MSL stdlib Master Headers and Dependencies Catalog

The table below catalogs every standard library header inside `reference/clang/32023.883/include/metal/`, mapping their include chains and target compilation requirements.

| Standard Header File | Root Namespace | Nested Includes / Dependencies | Minimum MSL Version | Target compilation Requirements |
|:---|:---|:---|:---:|:---|
| **`<metal_stdlib>`** | `metal` | Includes all core subheaders. | MSL 1.0 | Primary master header. Imports math, textures, atomics, etc. |
| **`metal_config`** | `metal` | None | MSL 1.0 | Defines compiler flags, attributes, and compiler macros. |
| **`metal_types`** | `metal` | `<metal_config>` | MSL 1.0 | Declares scalar, vector, and matrix types. |
| **`metal_common`** | `metal` | `<metal_types>` | MSL 1.0 | Core utilities, `memcpy`, `memset` builtins. |
| **`metal_integer`** | `metal` | `<metal_types>`, `<metal_config>` | MSL 1.0 | Integer math functions (addsat, clz, popcount, etc.). |
| **`metal_math`** | `metal` | `<metal_types>`, `<metal_config>` | MSL 1.0 | Floating-point transcendental math. |
| **`metal_geometric`**| `metal` | `<metal_types>` | MSL 1.0 | Geometric primitives (dot, cross, normalize, etc.). |
| **`metal_relational`**| `metal` | `<metal_types>` | MSL 1.0 | Vector relational templates (any, all, isnan, etc.). |
| **`metal_texture`** | `metal` | `<metal_types>`, nested `__bits/` | MSL 1.0 | Templated texture classes (texture2d, etc.). |
| **`metal_atomic`** | `metal` | `<metal_types>` | MSL 1.0 | Atomic templates across all memory qualifiers. |
| **`metal_simdgroup`**| `metal` | `<metal_types>` | MSL 2.0 | SIMDgroup collective shuffles and barriers. |
| **`metal_raytracing`**| `metal` | `<metal_types>` | MSL 2.3 | Acceleration structures and intersection traversers. |
| **`metal_mesh`** | `metal` | `<metal_types>` | MSL 2.4 | Object/Mesh shading grid and vertex write stages. |
| **`metal_logging`** | `metal` | `<metal_types>` | MSL 4.1 | Custom os_log dynamic formatting buffers. |
| **`metal_assert`** | `metal` | `<metal_types>` | MSL 4.1 | Shader-side assert trap handler configurations. |

---

## 2. Low-Level Translation Commentary

### 2.1 Complete Header Dependency Map (Include Tree)
```
     [ <metal_stdlib> ]
             │
             ├─► <metal_config>
             ├─► <metal_types> ──► <metal_config>
             ├─► <metal_common> ──► <metal_types>
             ├─► <metal_integer> ──► <metal_types>
             ├─► <metal_math> ──► <metal_types>
             ├─► <metal_geometric> ──► <metal_types>
             ├─► <metal_relational> ──► <metal_types>
             ├─► <metal_texture> ──► <metal_types> ──► __bits/* (impl)
             ├─► <metal_atomic> ──► <metal_types>
             ├─► <metal_simdgroup> ──► <metal_types>
             ├─► <metal_raytracing> ──► <metal_types>
             └─► <metal_mesh> ──► <metal_types>
```
- During compilation, Clang resolves this hierarchical include tree, building a complete, parsed AST mapping all template and inline functions inside standard libraries.
