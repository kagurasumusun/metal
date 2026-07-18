# Section 23: Builtin Math Constants and Capability Macros

This section specifies the preprocessor definitions, mathematical constants, and capability query macros predefined by the compiler in the Metal Shading Language (MSL).

---

## 1. Table 40: Predefined Constants and Capability Macros

The table below catalogs the predefined constants, mathematical constants, and preprocessor capability query macros supported in MSL.

| MSL Preprocessor / Macro | Data Type | Default Constant Value | Minimum MSL Version | Purpose / Hardware Target |
|:---|:---:|:---:|:---:|:---|
| `M_PI_F` | `float` | `3.14159265f` | MSL 1.0 | Single-precision Pi constant. |
| `M_E_F` | `float` | `2.71828182f` | MSL 1.0 | Single-precision Euler's constant. |
| `M_LOG2E_F` | `float` | `1.44269504f` | MSL 1.0 | Single-precision $\log_2(e)$ constant. |
| `M_SQRT2_F` | `float` | `1.41421356f` | MSL 1.0 | Single-precision $\sqrt{2}$ constant. |
| `__METAL_VERSION__` | `int` | `310` (e.g. for MSL 3.1) | MSL 1.0 | Identifies target compiled MSL language version. |
| `__HAVE_RAYTRACING__` | Macro | Predefined if supported | MSL 2.3 | Preprocessor query for hardware raytracing support. |
| `__HAVE_MESH_SHADERS__` | Macro | Predefined if supported | MSL 2.4 | Preprocessor query for mesh and object shader pipelines. |
| `__HAVE_COOPERATIVE_TENSORS__`| Macro | Predefined if supported | MSL 3.0 | Preprocessor query for hardware tensor matrix engines. |
| `__METAL_FAST_MATH__` | Macro | Predefined if enabled | MSL 1.0 | Set when `-ffast-math` is active. |

---

## 2. Low-Level Translation Commentary

### 2.1 Dynamic Capability Queries
MSL uses predefined macros to enable conditional compilation:
- This allows developers to write single, cross-compatible source files that scale dynamically from early iOS devices (e.g., Apple GPU Family 4) to modern Apple Silicon Macs (e.g., Apple GPU Family 10).
- For example, if `__HAVE_RAYTRACING__` is defined, the shader can compile hardware-accelerated intersection queries; otherwise, it can fall back to manual BVH traversal or software approximations.
- During parsing, Clang evaluates these preprocessor macros before starting semantic analysis.
- This compilation model prevents unsupported instructions from being lowered, ensuring robust compilation across diverse hardware targets.
