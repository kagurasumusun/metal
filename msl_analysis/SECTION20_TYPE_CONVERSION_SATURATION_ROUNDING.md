# Section 20: Vector Conversions, Saturation, and Rounding Modes

This section specifies the behaviors, compiler rules, rounding modes, and saturation constraints of vector type conversions in the Metal Shading Language (MSL).

---

## 1. Table 37: Vector conversions, Saturation, and Rounding Modes

The table below catalogs the templated vector conversion operations used in MSL, detailing their mathematical behaviors and compiler representations.

| MSL Conversion Builtin | Input Type | Output Type | Rounding Mode / Saturation | Clang AST Node | LLVM IR Intrinsic Lowering | AIR Opcode |
|:---|:---|:---|:---|:---|:---|:---|
| `convert<T>` | Vector (e.g. `float4`) | Vector (e.g. `half4`) | Truncate (Default) | `CXXMemberCallExpr` | `fptrunc <4 x float> %x to <4 x half>` | `fptrunc` |
| `convert<T, as_sat>`| Vector Signed Int | Vector Unsigned Int | Saturate (Clamp to bounds) | `CXXMemberCallExpr` | `@llvm.uadd.sat` / clamp select | `air.uadd.sat` |
| `convert<T, as_rte>`| Vector Floating-Point | Vector Integer | Round-to-Nearest-Even | `CXXMemberCallExpr` | `@llvm.nearbyint` | `air.nearbyint` |
| `convert<T, as_rtz>`| Vector Floating-Point | Vector Integer | Round-to-Zero (Truncate) | `CXXMemberCallExpr` | `@llvm.trunc` | `air.trunc` |
| `convert<T, as_rtp>`| Vector Floating-Point | Vector Integer | Round-to-Positive-Infinity | `CXXMemberCallExpr` | `@llvm.ceil` | `air.ceil` |
| `convert<T, as_rtn>`| Vector Floating-Point | Vector Integer | Round-to-Negative-Infinity | `CXXMemberCallExpr` | `@llvm.floor` | `air.floor` |

---

## 2. Low-Level Translation Commentary

### 2.1 Saturation Calculations
When type conversions specify saturating behavior (e.g., `convert<uchar4, as_sat>(int4)`):
- The compiler generates comparison and selection operations to clamp out-of-bounds input values to the destination type's numeric limits (e.g., clamping `int` values to the range $[0, 255]$ for `uchar`).
- On Apple Silicon, these saturating conversions are compiled to native saturating hardware instructions, which perform clamping in a single execution step.
- This compilation model avoids branching penalty and significantly improves execution performance.

### 2.2 Rounding Mode Compilation
By default, floating-point-to-integer conversions truncate fractional components (equivalent to `as_rtz` mode).
- When a specific rounding mode is requested (e.g., `as_rte` for round-to-nearest-even):
- The compiler maps the operation to specialized rounding intrinsics (such as `@llvm.nearbyint`), which utilize the GPU's native floating-point rounding units.
- This ensures that rounding calculations are processed with high accuracy and consistency, complying with the IEEE-754 standard.
- As a result, developers should select the appropriate conversion builtins when precise rounding or saturating behavior is required.



## Saturating and Rounding Modes in Type Casting

Vector type conversions specify specialized saturating and rounding behaviors:
- **Saturating Conversions**: Clamp out-of-bounds input values to the destination type's boundaries.
- **Rounding Modes**: Map float-to-integer conversions to specialized rounding intrinsics (such as `@llvm.nearbyint`), complying with the IEEE-754 standard.

## C++ Template Layout of Saturating and Rounding Converters

Below is the complete template structure of safe vector and scalar rounding converters inside `<metal_pack>`:

```cpp
#ifndef __METAL_PACK_H
#define __METAL_PACK_H

namespace metal {

// Round to Nearest Even template
template <typename T, typename U>
inline T convert_rte(U x) {
  return (T)__builtin_nearbyint(x);
}

// Saturating integer clamping template
template <typename T, typename U>
inline T convert_sat(U x) {
  if (x < (U)numeric_limits<T>::min()) return numeric_limits<T>::min();
  if (x > (U)numeric_limits<T>::max()) return numeric_limits<T>::max();
  return (T)x;
}

} // namespace metal

#endif
```
