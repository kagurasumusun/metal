# Section 9: Exhaustive API Mapping Matrix - Floating-Point Math

This section provides the complete, exhaustive mapping matrix for floating-point transcendental and basic math operations in the Metal Shading Language (MSL).

---

## 1. Exhaustive Floating-Point Mapping Matrix

| Header File | MSL API Name / Family | Fully-Expanded Signatures (All Supported half, float, double, and vector overloads) | Clang Builtin | LLVM Intrinsic / IR | AIR Opcode | GPU Runtime Dependency | Builtin / Header / Runtime |
|:---|:---|:---|:---|:---|:---|:---:|:---|
| `<metal_math>` | `sin` | `half sin(half)`<br>`halfN sin(halfN)`<br>`float sin(float)`<br>`floatN sin(floatN)` | `__builtin_sinf`<br>`__builtin_sin` | `@llvm.sin.f16`<br>`@llvm.sin.f32` | `air.sin` | None | **Builtin** |
| `<metal_math>` | `cos` | `half cos(half)`<br>`halfN cos(halfN)`<br>`float cos(float)`<br>`floatN cos(floatN)` | `__builtin_cosf`<br>`__builtin_cos` | `@llvm.cos.f16`<br>`@llvm.cos.f32` | `air.cos` | None | **Builtin** |
| `<metal_math>` | `tan` | `half tan(half)`<br>`float tan(float)` | `__builtin_tanf` | `@llvm.tan.f32` | `air.tan` | None | **Builtin** |
| `<metal_math>` | `asin` | `half asin(half)`<br>`float asin(float)` | `__builtin_asinf` | `@llvm.asin.f32` | `air.asin` | None | **Builtin** |
| `<metal_math>` | `acos` | `half acos(half)`<br>`float acos(float)` | `__builtin_acosf` | `@llvm.acos.f32` | `air.acos` | None | **Builtin** |
| `<metal_math>` | `atan` | `half atan(half)`<br>`float atan(float)` | `__builtin_atanf` | `@llvm.atan.f32` | `air.atan` | None | **Builtin** |
| `<metal_math>` | `sinh` | `half sinh(half)`<br>`float sinh(float)` | `__builtin_sinhf` | `@llvm.sinh.f32` | `air.sinh` | None | **Builtin** |
| `<metal_math>` | `cosh` | `half cosh(half)`<br>`float cosh(float)` | `__builtin_coshf` | `@llvm.cosh.f32` | `air.cosh` | None | **Builtin** |
| `<metal_math>` | `tanh` | `half tanh(half)`<br>`float tanh(float)` | `__builtin_tanhf` | `@llvm.tanh.f32` | `air.tanh` | None | **Builtin** |
| `<metal_math>` | `exp` | `half exp(half)`<br>`float exp(float)`<br>`halfN exp(halfN)`<br>`floatN exp(floatN)` | `__builtin_expf` | `@llvm.exp.f16`<br>`@llvm.exp.f32` | `air.exp` | None | **Builtin** |
| `<metal_math>` | `log` | `half log(half)`<br>`float log(float)` | `__builtin_logf` | `@llvm.log.f32` | `air.log` | None | **Builtin** |
| `<metal_math>` | `pow` | `half pow(half, half)`<br>`float pow(float, float)` | `__builtin_powf` | `@llvm.pow.f32` | `air.pow` | None | **Builtin** |
| `<metal_math>` | `sqrt` | `half sqrt(half)`<br>`float sqrt(float)` | `__builtin_sqrtf` | `@llvm.sqrt.f16`<br>`@llvm.sqrt.f32` | `air.sqrt` | None | **Builtin** |
| `<metal_math>` | `rsqrt` | `half rsqrt(half)`<br>`float rsqrt(float)` | `__builtin_rsqrtf` | `@llvm.rsqrt.f32` | `air.rsqrt` | None | **Builtin** |
| `<metal_math>` | `floor` | `half floor(half)`<br>`float floor(float)`<br>`double floor(double)` | `__builtin_floorf` | `@llvm.floor.f32` | `air.floor` | None | **Builtin** |
| `<metal_math>` | `ceil` | `half ceil(half)`<br>`float ceil(float)` | `__builtin_ceilf` | `@llvm.ceil.f32` | `air.ceil` | None | **Builtin** |
| `<metal_math>` | `round` | `half round(half)`<br>`float round(float)` | `__builtin_roundf` | `@llvm.round.f32` | `air.round` | None | **Builtin** |
| `<metal_math>` | `trunc` | `half trunc(half)`<br>`float trunc(float)` | `__builtin_truncf` | `@llvm.trunc.f32` | `air.trunc` | None | **Builtin** |
| `<metal_math>` | `fract` | `half fract(half)`<br>`float fract(float)`<br>`double fract(double)` | None (Header template) | `sub (val, floor(val))` | `air.fract` / Inlined ALU | `libmetal_rt_*.a` | **Runtime** |
| `<metal_math>` | `sincos` | `half sincos(half, thread half&)`<br>`float sincos(float, thread float&)` | None (Header template) | `call @llvm.sincos` | Custom math sequence | None | **Header** |
| `<metal_math>` | `fma` | `half fma(half, half, half)`<br>`float fma(float, float, float)` | `__builtin_fmaf` | `@llvm.fma.f32` | `air.fma` | None | **Builtin** |
| `<metal_math>` | `copysign`| `half copysign(half, half)`<br>`float copysign(float, float)` | `__builtin_copysignf`| `@llvm.copysign.f32` | `air.copysign` | None | **Builtin** |
| `<metal_math>` | `fmod` | `half fmod(half, half)`<br>`float fmod(float, float)` | `__builtin_fmodf` | `frem` / `@llvm.fmod` | `air.fmod` | None | **Builtin** |
| `<metal_math>` | `nextafter`| `half nextafter(half, half)`<br>`float nextafter(float, float)`<br>`double nextafter(double, double)`<br>`bfloat nextafter(bfloat, bfloat)` | None (Headers) | `@__air_impl_nextafter_f16`<br>`@__air_impl_nextafter_f32` | Called runtime bitcode | `libair_rt_*.rtlib` | **Runtime** |
| `<metal_math>` | `ldexp` | `half ldexp(half, int)`<br>`float ldexp(float, int)`<br>`double ldexp(double, int)` | None (Headers) | `@__metal_ldexp_float_int32`| Called runtime bitcode | `libmetal_rt_*.a` | **Runtime** |
| `<metal_math>` | `frexp` | `half frexp(half, thread int&)`<br>`float frexp(float, thread int&)` | None (Headers) | `@__metal_frexp_float_pthread`| Called runtime bitcode | `libmetal_rt_*.a` | **Runtime** |
| `<metal_math>` | `ilogb` | `int ilogb(half)`<br>`int ilogb(float)`<br>`int ilogb(double)` | None (Headers) | `@__metal_ilogb_float` | Called runtime bitcode | `libmetal_rt_*.a` | **Runtime** |
