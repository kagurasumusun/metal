# Section 9: Exhaustive API Mapping Matrix - Floating-Point Math

This section provides the complete, exhaustive mapping matrix for floating-point transcendental and basic math operations in the Metal Shading Language (MSL).

---

## 1. Exhaustive Floating-Point Mapping Matrix

| Header File | MSL API Name / Family | Fully-Expanded Signatures (All Supported Mappings) | Clang Builtin | LLVM Intrinsic / IR | AIR Opcode | GPU Runtime Dependency | Builtin / Header / Runtime |
|:---|:---|:---|:---|:---|:---|:---:|:---|
| `<metal_math>` | `sin` | `half sin(half)` | `__builtin_msl_sin` | `@llvm.sin.v1half` | `air.sin` | None | **Builtin** |
| `<metal_math>` | `sin` | `half2 sin(half2)` | `__builtin_msl_sin` | `@llvm.sin.v2half` | `air.sin` | None | **Builtin** |
| `<metal_math>` | `sin` | `half3 sin(half3)` | `__builtin_msl_sin` | `@llvm.sin.v3half` | `air.sin` | None | **Builtin** |
| `<metal_math>` | `sin` | `half4 sin(half4)` | `__builtin_msl_sin` | `@llvm.sin.v4half` | `air.sin` | None | **Builtin** |
| `<metal_math>` | `sin` | `half8 sin(half8)` | `__builtin_msl_sin` | `@llvm.sin.v8half` | `air.sin` | None | **Builtin** |
| `<metal_math>` | `sin` | `half16 sin(half16)` | `__builtin_msl_sin` | `@llvm.sin.v16half` | `air.sin` | None | **Builtin** |
| `<metal_math>` | `sin` | `float sin(float)` | `__builtin_msl_sin` | `@llvm.sin.v1float` | `air.sin` | None | **Builtin** |
| `<metal_math>` | `sin` | `float2 sin(float2)` | `__builtin_msl_sin` | `@llvm.sin.v2float` | `air.sin` | None | **Builtin** |
| `<metal_math>` | `sin` | `float3 sin(float3)` | `__builtin_msl_sin` | `@llvm.sin.v3float` | `air.sin` | None | **Builtin** |
| `<metal_math>` | `sin` | `float4 sin(float4)` | `__builtin_msl_sin` | `@llvm.sin.v4float` | `air.sin` | None | **Builtin** |
| `<metal_math>` | `sin` | `float8 sin(float8)` | `__builtin_msl_sin` | `@llvm.sin.v8float` | `air.sin` | None | **Builtin** |
| `<metal_math>` | `sin` | `float16 sin(float16)` | `__builtin_msl_sin` | `@llvm.sin.v16float` | `air.sin` | None | **Builtin** |
| `<metal_math>` | `sin` | `double sin(double)` | `__builtin_msl_sin` | `@llvm.sin.v1double` | `air.sin` | None | **Builtin** |
| `<metal_math>` | `sin` | `double2 sin(double2)` | `__builtin_msl_sin` | `@llvm.sin.v2double` | `air.sin` | None | **Builtin** |
| `<metal_math>` | `sin` | `double3 sin(double3)` | `__builtin_msl_sin` | `@llvm.sin.v3double` | `air.sin` | None | **Builtin** |
| `<metal_math>` | `sin` | `double4 sin(double4)` | `__builtin_msl_sin` | `@llvm.sin.v4double` | `air.sin` | None | **Builtin** |
| `<metal_math>` | `sin` | `double8 sin(double8)` | `__builtin_msl_sin` | `@llvm.sin.v8double` | `air.sin` | None | **Builtin** |
| `<metal_math>` | `sin` | `double16 sin(double16)` | `__builtin_msl_sin` | `@llvm.sin.v16double` | `air.sin` | None | **Builtin** |
| `<metal_math>` | `cos` | `half cos(half)` | `__builtin_msl_cos` | `@llvm.cos.v1half` | `air.cos` | None | **Builtin** |
| `<metal_math>` | `cos` | `half2 cos(half2)` | `__builtin_msl_cos` | `@llvm.cos.v2half` | `air.cos` | None | **Builtin** |
| `<metal_math>` | `cos` | `half3 cos(half3)` | `__builtin_msl_cos` | `@llvm.cos.v3half` | `air.cos` | None | **Builtin** |
| `<metal_math>` | `cos` | `half4 cos(half4)` | `__builtin_msl_cos` | `@llvm.cos.v4half` | `air.cos` | None | **Builtin** |
| `<metal_math>` | `cos` | `half8 cos(half8)` | `__builtin_msl_cos` | `@llvm.cos.v8half` | `air.cos` | None | **Builtin** |
| `<metal_math>` | `cos` | `half16 cos(half16)` | `__builtin_msl_cos` | `@llvm.cos.v16half` | `air.cos` | None | **Builtin** |
| `<metal_math>` | `cos` | `float cos(float)` | `__builtin_msl_cos` | `@llvm.cos.v1float` | `air.cos` | None | **Builtin** |
| `<metal_math>` | `cos` | `float2 cos(float2)` | `__builtin_msl_cos` | `@llvm.cos.v2float` | `air.cos` | None | **Builtin** |
| `<metal_math>` | `cos` | `float3 cos(float3)` | `__builtin_msl_cos` | `@llvm.cos.v3float` | `air.cos` | None | **Builtin** |
| `<metal_math>` | `cos` | `float4 cos(float4)` | `__builtin_msl_cos` | `@llvm.cos.v4float` | `air.cos` | None | **Builtin** |
| `<metal_math>` | `cos` | `float8 cos(float8)` | `__builtin_msl_cos` | `@llvm.cos.v8float` | `air.cos` | None | **Builtin** |
| `<metal_math>` | `cos` | `float16 cos(float16)` | `__builtin_msl_cos` | `@llvm.cos.v16float` | `air.cos` | None | **Builtin** |
| `<metal_math>` | `cos` | `double cos(double)` | `__builtin_msl_cos` | `@llvm.cos.v1double` | `air.cos` | None | **Builtin** |
| `<metal_math>` | `cos` | `double2 cos(double2)` | `__builtin_msl_cos` | `@llvm.cos.v2double` | `air.cos` | None | **Builtin** |
| `<metal_math>` | `cos` | `double3 cos(double3)` | `__builtin_msl_cos` | `@llvm.cos.v3double` | `air.cos` | None | **Builtin** |
| `<metal_math>` | `cos` | `double4 cos(double4)` | `__builtin_msl_cos` | `@llvm.cos.v4double` | `air.cos` | None | **Builtin** |
| `<metal_math>` | `cos` | `double8 cos(double8)` | `__builtin_msl_cos` | `@llvm.cos.v8double` | `air.cos` | None | **Builtin** |
| `<metal_math>` | `cos` | `double16 cos(double16)` | `__builtin_msl_cos` | `@llvm.cos.v16double` | `air.cos` | None | **Builtin** |
| `<metal_math>` | `tan` | `half tan(half)` | `__builtin_msl_tan` | `@llvm.tan.v1half` | `air.tan` | None | **Builtin** |
| `<metal_math>` | `tan` | `half2 tan(half2)` | `__builtin_msl_tan` | `@llvm.tan.v2half` | `air.tan` | None | **Builtin** |
| `<metal_math>` | `tan` | `half3 tan(half3)` | `__builtin_msl_tan` | `@llvm.tan.v3half` | `air.tan` | None | **Builtin** |
| `<metal_math>` | `tan` | `half4 tan(half4)` | `__builtin_msl_tan` | `@llvm.tan.v4half` | `air.tan` | None | **Builtin** |
| `<metal_math>` | `tan` | `half8 tan(half8)` | `__builtin_msl_tan` | `@llvm.tan.v8half` | `air.tan` | None | **Builtin** |
| `<metal_math>` | `tan` | `half16 tan(half16)` | `__builtin_msl_tan` | `@llvm.tan.v16half` | `air.tan` | None | **Builtin** |
| `<metal_math>` | `tan` | `float tan(float)` | `__builtin_msl_tan` | `@llvm.tan.v1float` | `air.tan` | None | **Builtin** |
| `<metal_math>` | `tan` | `float2 tan(float2)` | `__builtin_msl_tan` | `@llvm.tan.v2float` | `air.tan` | None | **Builtin** |
| `<metal_math>` | `tan` | `float3 tan(float3)` | `__builtin_msl_tan` | `@llvm.tan.v3float` | `air.tan` | None | **Builtin** |
| `<metal_math>` | `tan` | `float4 tan(float4)` | `__builtin_msl_tan` | `@llvm.tan.v4float` | `air.tan` | None | **Builtin** |
| `<metal_math>` | `tan` | `float8 tan(float8)` | `__builtin_msl_tan` | `@llvm.tan.v8float` | `air.tan` | None | **Builtin** |
| `<metal_math>` | `tan` | `float16 tan(float16)` | `__builtin_msl_tan` | `@llvm.tan.v16float` | `air.tan` | None | **Builtin** |
| `<metal_math>` | `tan` | `double tan(double)` | `__builtin_msl_tan` | `@llvm.tan.v1double` | `air.tan` | None | **Builtin** |
| `<metal_math>` | `tan` | `double2 tan(double2)` | `__builtin_msl_tan` | `@llvm.tan.v2double` | `air.tan` | None | **Builtin** |
| `<metal_math>` | `tan` | `double3 tan(double3)` | `__builtin_msl_tan` | `@llvm.tan.v3double` | `air.tan` | None | **Builtin** |
| `<metal_math>` | `tan` | `double4 tan(double4)` | `__builtin_msl_tan` | `@llvm.tan.v4double` | `air.tan` | None | **Builtin** |
| `<metal_math>` | `tan` | `double8 tan(double8)` | `__builtin_msl_tan` | `@llvm.tan.v8double` | `air.tan` | None | **Builtin** |
| `<metal_math>` | `tan` | `double16 tan(double16)` | `__builtin_msl_tan` | `@llvm.tan.v16double` | `air.tan` | None | **Builtin** |
| `<metal_math>` | `asin` | `half asin(half)` | `__builtin_msl_asin` | `@llvm.asin.v1half` | `air.asin` | None | **Builtin** |
| `<metal_math>` | `asin` | `half2 asin(half2)` | `__builtin_msl_asin` | `@llvm.asin.v2half` | `air.asin` | None | **Builtin** |
| `<metal_math>` | `asin` | `half3 asin(half3)` | `__builtin_msl_asin` | `@llvm.asin.v3half` | `air.asin` | None | **Builtin** |
| `<metal_math>` | `asin` | `half4 asin(half4)` | `__builtin_msl_asin` | `@llvm.asin.v4half` | `air.asin` | None | **Builtin** |
| `<metal_math>` | `asin` | `half8 asin(half8)` | `__builtin_msl_asin` | `@llvm.asin.v8half` | `air.asin` | None | **Builtin** |
| `<metal_math>` | `asin` | `half16 asin(half16)` | `__builtin_msl_asin` | `@llvm.asin.v16half` | `air.asin` | None | **Builtin** |
| `<metal_math>` | `asin` | `float asin(float)` | `__builtin_msl_asin` | `@llvm.asin.v1float` | `air.asin` | None | **Builtin** |
| `<metal_math>` | `asin` | `float2 asin(float2)` | `__builtin_msl_asin` | `@llvm.asin.v2float` | `air.asin` | None | **Builtin** |
| `<metal_math>` | `asin` | `float3 asin(float3)` | `__builtin_msl_asin` | `@llvm.asin.v3float` | `air.asin` | None | **Builtin** |
| `<metal_math>` | `asin` | `float4 asin(float4)` | `__builtin_msl_asin` | `@llvm.asin.v4float` | `air.asin` | None | **Builtin** |
| `<metal_math>` | `asin` | `float8 asin(float8)` | `__builtin_msl_asin` | `@llvm.asin.v8float` | `air.asin` | None | **Builtin** |
| `<metal_math>` | `asin` | `float16 asin(float16)` | `__builtin_msl_asin` | `@llvm.asin.v16float` | `air.asin` | None | **Builtin** |
| `<metal_math>` | `asin` | `double asin(double)` | `__builtin_msl_asin` | `@llvm.asin.v1double` | `air.asin` | None | **Builtin** |
| `<metal_math>` | `asin` | `double2 asin(double2)` | `__builtin_msl_asin` | `@llvm.asin.v2double` | `air.asin` | None | **Builtin** |
| `<metal_math>` | `asin` | `double3 asin(double3)` | `__builtin_msl_asin` | `@llvm.asin.v3double` | `air.asin` | None | **Builtin** |
| `<metal_math>` | `asin` | `double4 asin(double4)` | `__builtin_msl_asin` | `@llvm.asin.v4double` | `air.asin` | None | **Builtin** |
| `<metal_math>` | `asin` | `double8 asin(double8)` | `__builtin_msl_asin` | `@llvm.asin.v8double` | `air.asin` | None | **Builtin** |
| `<metal_math>` | `asin` | `double16 asin(double16)` | `__builtin_msl_asin` | `@llvm.asin.v16double` | `air.asin` | None | **Builtin** |
| `<metal_math>` | `acos` | `half acos(half)` | `__builtin_msl_acos` | `@llvm.acos.v1half` | `air.acos` | None | **Builtin** |
| `<metal_math>` | `acos` | `half2 acos(half2)` | `__builtin_msl_acos` | `@llvm.acos.v2half` | `air.acos` | None | **Builtin** |
| `<metal_math>` | `acos` | `half3 acos(half3)` | `__builtin_msl_acos` | `@llvm.acos.v3half` | `air.acos` | None | **Builtin** |
| `<metal_math>` | `acos` | `half4 acos(half4)` | `__builtin_msl_acos` | `@llvm.acos.v4half` | `air.acos` | None | **Builtin** |
| `<metal_math>` | `acos` | `half8 acos(half8)` | `__builtin_msl_acos` | `@llvm.acos.v8half` | `air.acos` | None | **Builtin** |
| `<metal_math>` | `acos` | `half16 acos(half16)` | `__builtin_msl_acos` | `@llvm.acos.v16half` | `air.acos` | None | **Builtin** |
| `<metal_math>` | `acos` | `float acos(float)` | `__builtin_msl_acos` | `@llvm.acos.v1float` | `air.acos` | None | **Builtin** |
| `<metal_math>` | `acos` | `float2 acos(float2)` | `__builtin_msl_acos` | `@llvm.acos.v2float` | `air.acos` | None | **Builtin** |
| `<metal_math>` | `acos` | `float3 acos(float3)` | `__builtin_msl_acos` | `@llvm.acos.v3float` | `air.acos` | None | **Builtin** |
| `<metal_math>` | `acos` | `float4 acos(float4)` | `__builtin_msl_acos` | `@llvm.acos.v4float` | `air.acos` | None | **Builtin** |
| `<metal_math>` | `acos` | `float8 acos(float8)` | `__builtin_msl_acos` | `@llvm.acos.v8float` | `air.acos` | None | **Builtin** |
| `<metal_math>` | `acos` | `float16 acos(float16)` | `__builtin_msl_acos` | `@llvm.acos.v16float` | `air.acos` | None | **Builtin** |
| `<metal_math>` | `acos` | `double acos(double)` | `__builtin_msl_acos` | `@llvm.acos.v1double` | `air.acos` | None | **Builtin** |
| `<metal_math>` | `acos` | `double2 acos(double2)` | `__builtin_msl_acos` | `@llvm.acos.v2double` | `air.acos` | None | **Builtin** |
| `<metal_math>` | `acos` | `double3 acos(double3)` | `__builtin_msl_acos` | `@llvm.acos.v3double` | `air.acos` | None | **Builtin** |
| `<metal_math>` | `acos` | `double4 acos(double4)` | `__builtin_msl_acos` | `@llvm.acos.v4double` | `air.acos` | None | **Builtin** |
| `<metal_math>` | `acos` | `double8 acos(double8)` | `__builtin_msl_acos` | `@llvm.acos.v8double` | `air.acos` | None | **Builtin** |
| `<metal_math>` | `acos` | `double16 acos(double16)` | `__builtin_msl_acos` | `@llvm.acos.v16double` | `air.acos` | None | **Builtin** |
| `<metal_math>` | `atan` | `half atan(half)` | `__builtin_msl_atan` | `@llvm.atan.v1half` | `air.atan` | None | **Builtin** |
| `<metal_math>` | `atan` | `half2 atan(half2)` | `__builtin_msl_atan` | `@llvm.atan.v2half` | `air.atan` | None | **Builtin** |
| `<metal_math>` | `atan` | `half3 atan(half3)` | `__builtin_msl_atan` | `@llvm.atan.v3half` | `air.atan` | None | **Builtin** |
| `<metal_math>` | `atan` | `half4 atan(half4)` | `__builtin_msl_atan` | `@llvm.atan.v4half` | `air.atan` | None | **Builtin** |
| `<metal_math>` | `atan` | `half8 atan(half8)` | `__builtin_msl_atan` | `@llvm.atan.v8half` | `air.atan` | None | **Builtin** |
| `<metal_math>` | `atan` | `half16 atan(half16)` | `__builtin_msl_atan` | `@llvm.atan.v16half` | `air.atan` | None | **Builtin** |
| `<metal_math>` | `atan` | `float atan(float)` | `__builtin_msl_atan` | `@llvm.atan.v1float` | `air.atan` | None | **Builtin** |
| `<metal_math>` | `atan` | `float2 atan(float2)` | `__builtin_msl_atan` | `@llvm.atan.v2float` | `air.atan` | None | **Builtin** |
| `<metal_math>` | `atan` | `float3 atan(float3)` | `__builtin_msl_atan` | `@llvm.atan.v3float` | `air.atan` | None | **Builtin** |
| `<metal_math>` | `atan` | `float4 atan(float4)` | `__builtin_msl_atan` | `@llvm.atan.v4float` | `air.atan` | None | **Builtin** |
| `<metal_math>` | `atan` | `float8 atan(float8)` | `__builtin_msl_atan` | `@llvm.atan.v8float` | `air.atan` | None | **Builtin** |
| `<metal_math>` | `atan` | `float16 atan(float16)` | `__builtin_msl_atan` | `@llvm.atan.v16float` | `air.atan` | None | **Builtin** |
| `<metal_math>` | `atan` | `double atan(double)` | `__builtin_msl_atan` | `@llvm.atan.v1double` | `air.atan` | None | **Builtin** |
| `<metal_math>` | `atan` | `double2 atan(double2)` | `__builtin_msl_atan` | `@llvm.atan.v2double` | `air.atan` | None | **Builtin** |
| `<metal_math>` | `atan` | `double3 atan(double3)` | `__builtin_msl_atan` | `@llvm.atan.v3double` | `air.atan` | None | **Builtin** |
| `<metal_math>` | `atan` | `double4 atan(double4)` | `__builtin_msl_atan` | `@llvm.atan.v4double` | `air.atan` | None | **Builtin** |
| `<metal_math>` | `atan` | `double8 atan(double8)` | `__builtin_msl_atan` | `@llvm.atan.v8double` | `air.atan` | None | **Builtin** |
| `<metal_math>` | `atan` | `double16 atan(double16)` | `__builtin_msl_atan` | `@llvm.atan.v16double` | `air.atan` | None | **Builtin** |
| `<metal_math>` | `exp` | `half exp(half)` | `__builtin_msl_exp` | `@llvm.exp.v1half` | `air.exp` | None | **Builtin** |
| `<metal_math>` | `exp` | `half2 exp(half2)` | `__builtin_msl_exp` | `@llvm.exp.v2half` | `air.exp` | None | **Builtin** |
| `<metal_math>` | `exp` | `half3 exp(half3)` | `__builtin_msl_exp` | `@llvm.exp.v3half` | `air.exp` | None | **Builtin** |
| `<metal_math>` | `exp` | `half4 exp(half4)` | `__builtin_msl_exp` | `@llvm.exp.v4half` | `air.exp` | None | **Builtin** |
| `<metal_math>` | `exp` | `half8 exp(half8)` | `__builtin_msl_exp` | `@llvm.exp.v8half` | `air.exp` | None | **Builtin** |
| `<metal_math>` | `exp` | `half16 exp(half16)` | `__builtin_msl_exp` | `@llvm.exp.v16half` | `air.exp` | None | **Builtin** |
| `<metal_math>` | `exp` | `float exp(float)` | `__builtin_msl_exp` | `@llvm.exp.v1float` | `air.exp` | None | **Builtin** |
| `<metal_math>` | `exp` | `float2 exp(float2)` | `__builtin_msl_exp` | `@llvm.exp.v2float` | `air.exp` | None | **Builtin** |
| `<metal_math>` | `exp` | `float3 exp(float3)` | `__builtin_msl_exp` | `@llvm.exp.v3float` | `air.exp` | None | **Builtin** |
| `<metal_math>` | `exp` | `float4 exp(float4)` | `__builtin_msl_exp` | `@llvm.exp.v4float` | `air.exp` | None | **Builtin** |
| `<metal_math>` | `exp` | `float8 exp(float8)` | `__builtin_msl_exp` | `@llvm.exp.v8float` | `air.exp` | None | **Builtin** |
| `<metal_math>` | `exp` | `float16 exp(float16)` | `__builtin_msl_exp` | `@llvm.exp.v16float` | `air.exp` | None | **Builtin** |
| `<metal_math>` | `exp` | `double exp(double)` | `__builtin_msl_exp` | `@llvm.exp.v1double` | `air.exp` | None | **Builtin** |
| `<metal_math>` | `exp` | `double2 exp(double2)` | `__builtin_msl_exp` | `@llvm.exp.v2double` | `air.exp` | None | **Builtin** |
| `<metal_math>` | `exp` | `double3 exp(double3)` | `__builtin_msl_exp` | `@llvm.exp.v3double` | `air.exp` | None | **Builtin** |
| `<metal_math>` | `exp` | `double4 exp(double4)` | `__builtin_msl_exp` | `@llvm.exp.v4double` | `air.exp` | None | **Builtin** |
| `<metal_math>` | `exp` | `double8 exp(double8)` | `__builtin_msl_exp` | `@llvm.exp.v8double` | `air.exp` | None | **Builtin** |
| `<metal_math>` | `exp` | `double16 exp(double16)` | `__builtin_msl_exp` | `@llvm.exp.v16double` | `air.exp` | None | **Builtin** |
| `<metal_math>` | `log` | `half log(half)` | `__builtin_msl_log` | `@llvm.log.v1half` | `air.log` | None | **Builtin** |
| `<metal_math>` | `log` | `half2 log(half2)` | `__builtin_msl_log` | `@llvm.log.v2half` | `air.log` | None | **Builtin** |
| `<metal_math>` | `log` | `half3 log(half3)` | `__builtin_msl_log` | `@llvm.log.v3half` | `air.log` | None | **Builtin** |
| `<metal_math>` | `log` | `half4 log(half4)` | `__builtin_msl_log` | `@llvm.log.v4half` | `air.log` | None | **Builtin** |
| `<metal_math>` | `log` | `half8 log(half8)` | `__builtin_msl_log` | `@llvm.log.v8half` | `air.log` | None | **Builtin** |
| `<metal_math>` | `log` | `half16 log(half16)` | `__builtin_msl_log` | `@llvm.log.v16half` | `air.log` | None | **Builtin** |
| `<metal_math>` | `log` | `float log(float)` | `__builtin_msl_log` | `@llvm.log.v1float` | `air.log` | None | **Builtin** |
| `<metal_math>` | `log` | `float2 log(float2)` | `__builtin_msl_log` | `@llvm.log.v2float` | `air.log` | None | **Builtin** |
| `<metal_math>` | `log` | `float3 log(float3)` | `__builtin_msl_log` | `@llvm.log.v3float` | `air.log` | None | **Builtin** |
| `<metal_math>` | `log` | `float4 log(float4)` | `__builtin_msl_log` | `@llvm.log.v4float` | `air.log` | None | **Builtin** |
| `<metal_math>` | `log` | `float8 log(float8)` | `__builtin_msl_log` | `@llvm.log.v8float` | `air.log` | None | **Builtin** |
| `<metal_math>` | `log` | `float16 log(float16)` | `__builtin_msl_log` | `@llvm.log.v16float` | `air.log` | None | **Builtin** |
| `<metal_math>` | `log` | `double log(double)` | `__builtin_msl_log` | `@llvm.log.v1double` | `air.log` | None | **Builtin** |
| `<metal_math>` | `log` | `double2 log(double2)` | `__builtin_msl_log` | `@llvm.log.v2double` | `air.log` | None | **Builtin** |
| `<metal_math>` | `log` | `double3 log(double3)` | `__builtin_msl_log` | `@llvm.log.v3double` | `air.log` | None | **Builtin** |
| `<metal_math>` | `log` | `double4 log(double4)` | `__builtin_msl_log` | `@llvm.log.v4double` | `air.log` | None | **Builtin** |
| `<metal_math>` | `log` | `double8 log(double8)` | `__builtin_msl_log` | `@llvm.log.v8double` | `air.log` | None | **Builtin** |
| `<metal_math>` | `log` | `double16 log(double16)` | `__builtin_msl_log` | `@llvm.log.v16double` | `air.log` | None | **Builtin** |
| `<metal_math>` | `sqrt` | `half sqrt(half)` | `__builtin_msl_sqrt` | `@llvm.sqrt.v1half` | `air.sqrt` | None | **Builtin** |
| `<metal_math>` | `sqrt` | `half2 sqrt(half2)` | `__builtin_msl_sqrt` | `@llvm.sqrt.v2half` | `air.sqrt` | None | **Builtin** |
| `<metal_math>` | `sqrt` | `half3 sqrt(half3)` | `__builtin_msl_sqrt` | `@llvm.sqrt.v3half` | `air.sqrt` | None | **Builtin** |
| `<metal_math>` | `sqrt` | `half4 sqrt(half4)` | `__builtin_msl_sqrt` | `@llvm.sqrt.v4half` | `air.sqrt` | None | **Builtin** |
| `<metal_math>` | `sqrt` | `half8 sqrt(half8)` | `__builtin_msl_sqrt` | `@llvm.sqrt.v8half` | `air.sqrt` | None | **Builtin** |
| `<metal_math>` | `sqrt` | `half16 sqrt(half16)` | `__builtin_msl_sqrt` | `@llvm.sqrt.v16half` | `air.sqrt` | None | **Builtin** |
| `<metal_math>` | `sqrt` | `float sqrt(float)` | `__builtin_msl_sqrt` | `@llvm.sqrt.v1float` | `air.sqrt` | None | **Builtin** |
| `<metal_math>` | `sqrt` | `float2 sqrt(float2)` | `__builtin_msl_sqrt` | `@llvm.sqrt.v2float` | `air.sqrt` | None | **Builtin** |
| `<metal_math>` | `sqrt` | `float3 sqrt(float3)` | `__builtin_msl_sqrt` | `@llvm.sqrt.v3float` | `air.sqrt` | None | **Builtin** |
| `<metal_math>` | `sqrt` | `float4 sqrt(float4)` | `__builtin_msl_sqrt` | `@llvm.sqrt.v4float` | `air.sqrt` | None | **Builtin** |
| `<metal_math>` | `sqrt` | `float8 sqrt(float8)` | `__builtin_msl_sqrt` | `@llvm.sqrt.v8float` | `air.sqrt` | None | **Builtin** |
| `<metal_math>` | `sqrt` | `float16 sqrt(float16)` | `__builtin_msl_sqrt` | `@llvm.sqrt.v16float` | `air.sqrt` | None | **Builtin** |
| `<metal_math>` | `sqrt` | `double sqrt(double)` | `__builtin_msl_sqrt` | `@llvm.sqrt.v1double` | `air.sqrt` | None | **Builtin** |
| `<metal_math>` | `sqrt` | `double2 sqrt(double2)` | `__builtin_msl_sqrt` | `@llvm.sqrt.v2double` | `air.sqrt` | None | **Builtin** |
| `<metal_math>` | `sqrt` | `double3 sqrt(double3)` | `__builtin_msl_sqrt` | `@llvm.sqrt.v3double` | `air.sqrt` | None | **Builtin** |
| `<metal_math>` | `sqrt` | `double4 sqrt(double4)` | `__builtin_msl_sqrt` | `@llvm.sqrt.v4double` | `air.sqrt` | None | **Builtin** |
| `<metal_math>` | `sqrt` | `double8 sqrt(double8)` | `__builtin_msl_sqrt` | `@llvm.sqrt.v8double` | `air.sqrt` | None | **Builtin** |
| `<metal_math>` | `sqrt` | `double16 sqrt(double16)` | `__builtin_msl_sqrt` | `@llvm.sqrt.v16double` | `air.sqrt` | None | **Builtin** |
| `<metal_math>` | `rsqrt` | `half rsqrt(half)` | `__builtin_msl_rsqrt` | `@llvm.rsqrt.v1half` | `air.rsqrt` | None | **Builtin** |
| `<metal_math>` | `rsqrt` | `half2 rsqrt(half2)` | `__builtin_msl_rsqrt` | `@llvm.rsqrt.v2half` | `air.rsqrt` | None | **Builtin** |
| `<metal_math>` | `rsqrt` | `half3 rsqrt(half3)` | `__builtin_msl_rsqrt` | `@llvm.rsqrt.v3half` | `air.rsqrt` | None | **Builtin** |
| `<metal_math>` | `rsqrt` | `half4 rsqrt(half4)` | `__builtin_msl_rsqrt` | `@llvm.rsqrt.v4half` | `air.rsqrt` | None | **Builtin** |
| `<metal_math>` | `rsqrt` | `half8 rsqrt(half8)` | `__builtin_msl_rsqrt` | `@llvm.rsqrt.v8half` | `air.rsqrt` | None | **Builtin** |
| `<metal_math>` | `rsqrt` | `half16 rsqrt(half16)` | `__builtin_msl_rsqrt` | `@llvm.rsqrt.v16half` | `air.rsqrt` | None | **Builtin** |
| `<metal_math>` | `rsqrt` | `float rsqrt(float)` | `__builtin_msl_rsqrt` | `@llvm.rsqrt.v1float` | `air.rsqrt` | None | **Builtin** |
| `<metal_math>` | `rsqrt` | `float2 rsqrt(float2)` | `__builtin_msl_rsqrt` | `@llvm.rsqrt.v2float` | `air.rsqrt` | None | **Builtin** |
| `<metal_math>` | `rsqrt` | `float3 rsqrt(float3)` | `__builtin_msl_rsqrt` | `@llvm.rsqrt.v3float` | `air.rsqrt` | None | **Builtin** |
| `<metal_math>` | `rsqrt` | `float4 rsqrt(float4)` | `__builtin_msl_rsqrt` | `@llvm.rsqrt.v4float` | `air.rsqrt` | None | **Builtin** |
| `<metal_math>` | `rsqrt` | `float8 rsqrt(float8)` | `__builtin_msl_rsqrt` | `@llvm.rsqrt.v8float` | `air.rsqrt` | None | **Builtin** |
| `<metal_math>` | `rsqrt` | `float16 rsqrt(float16)` | `__builtin_msl_rsqrt` | `@llvm.rsqrt.v16float` | `air.rsqrt` | None | **Builtin** |
| `<metal_math>` | `rsqrt` | `double rsqrt(double)` | `__builtin_msl_rsqrt` | `@llvm.rsqrt.v1double` | `air.rsqrt` | None | **Builtin** |
| `<metal_math>` | `rsqrt` | `double2 rsqrt(double2)` | `__builtin_msl_rsqrt` | `@llvm.rsqrt.v2double` | `air.rsqrt` | None | **Builtin** |
| `<metal_math>` | `rsqrt` | `double3 rsqrt(double3)` | `__builtin_msl_rsqrt` | `@llvm.rsqrt.v3double` | `air.rsqrt` | None | **Builtin** |
| `<metal_math>` | `rsqrt` | `double4 rsqrt(double4)` | `__builtin_msl_rsqrt` | `@llvm.rsqrt.v4double` | `air.rsqrt` | None | **Builtin** |
| `<metal_math>` | `rsqrt` | `double8 rsqrt(double8)` | `__builtin_msl_rsqrt` | `@llvm.rsqrt.v8double` | `air.rsqrt` | None | **Builtin** |
| `<metal_math>` | `rsqrt` | `double16 rsqrt(double16)` | `__builtin_msl_rsqrt` | `@llvm.rsqrt.v16double` | `air.rsqrt` | None | **Builtin** |
| `<metal_math>` | `floor` | `half floor(half)` | `__builtin_msl_floor` | `@llvm.floor.v1half` | `air.floor` | None | **Builtin** |
| `<metal_math>` | `floor` | `half2 floor(half2)` | `__builtin_msl_floor` | `@llvm.floor.v2half` | `air.floor` | None | **Builtin** |
| `<metal_math>` | `floor` | `half3 floor(half3)` | `__builtin_msl_floor` | `@llvm.floor.v3half` | `air.floor` | None | **Builtin** |
| `<metal_math>` | `floor` | `half4 floor(half4)` | `__builtin_msl_floor` | `@llvm.floor.v4half` | `air.floor` | None | **Builtin** |
| `<metal_math>` | `floor` | `half8 floor(half8)` | `__builtin_msl_floor` | `@llvm.floor.v8half` | `air.floor` | None | **Builtin** |
| `<metal_math>` | `floor` | `half16 floor(half16)` | `__builtin_msl_floor` | `@llvm.floor.v16half` | `air.floor` | None | **Builtin** |
| `<metal_math>` | `floor` | `float floor(float)` | `__builtin_msl_floor` | `@llvm.floor.v1float` | `air.floor` | None | **Builtin** |
| `<metal_math>` | `floor` | `float2 floor(float2)` | `__builtin_msl_floor` | `@llvm.floor.v2float` | `air.floor` | None | **Builtin** |
| `<metal_math>` | `floor` | `float3 floor(float3)` | `__builtin_msl_floor` | `@llvm.floor.v3float` | `air.floor` | None | **Builtin** |
| `<metal_math>` | `floor` | `float4 floor(float4)` | `__builtin_msl_floor` | `@llvm.floor.v4float` | `air.floor` | None | **Builtin** |
| `<metal_math>` | `floor` | `float8 floor(float8)` | `__builtin_msl_floor` | `@llvm.floor.v8float` | `air.floor` | None | **Builtin** |
| `<metal_math>` | `floor` | `float16 floor(float16)` | `__builtin_msl_floor` | `@llvm.floor.v16float` | `air.floor` | None | **Builtin** |
| `<metal_math>` | `floor` | `double floor(double)` | `__builtin_msl_floor` | `@llvm.floor.v1double` | `air.floor` | None | **Builtin** |
| `<metal_math>` | `floor` | `double2 floor(double2)` | `__builtin_msl_floor` | `@llvm.floor.v2double` | `air.floor` | None | **Builtin** |
| `<metal_math>` | `floor` | `double3 floor(double3)` | `__builtin_msl_floor` | `@llvm.floor.v3double` | `air.floor` | None | **Builtin** |
| `<metal_math>` | `floor` | `double4 floor(double4)` | `__builtin_msl_floor` | `@llvm.floor.v4double` | `air.floor` | None | **Builtin** |
| `<metal_math>` | `floor` | `double8 floor(double8)` | `__builtin_msl_floor` | `@llvm.floor.v8double` | `air.floor` | None | **Builtin** |
| `<metal_math>` | `floor` | `double16 floor(double16)` | `__builtin_msl_floor` | `@llvm.floor.v16double` | `air.floor` | None | **Builtin** |
| `<metal_math>` | `ceil` | `half ceil(half)` | `__builtin_msl_ceil` | `@llvm.ceil.v1half` | `air.ceil` | None | **Builtin** |
| `<metal_math>` | `ceil` | `half2 ceil(half2)` | `__builtin_msl_ceil` | `@llvm.ceil.v2half` | `air.ceil` | None | **Builtin** |
| `<metal_math>` | `ceil` | `half3 ceil(half3)` | `__builtin_msl_ceil` | `@llvm.ceil.v3half` | `air.ceil` | None | **Builtin** |
| `<metal_math>` | `ceil` | `half4 ceil(half4)` | `__builtin_msl_ceil` | `@llvm.ceil.v4half` | `air.ceil` | None | **Builtin** |
| `<metal_math>` | `ceil` | `half8 ceil(half8)` | `__builtin_msl_ceil` | `@llvm.ceil.v8half` | `air.ceil` | None | **Builtin** |
| `<metal_math>` | `ceil` | `half16 ceil(half16)` | `__builtin_msl_ceil` | `@llvm.ceil.v16half` | `air.ceil` | None | **Builtin** |
| `<metal_math>` | `ceil` | `float ceil(float)` | `__builtin_msl_ceil` | `@llvm.ceil.v1float` | `air.ceil` | None | **Builtin** |
| `<metal_math>` | `ceil` | `float2 ceil(float2)` | `__builtin_msl_ceil` | `@llvm.ceil.v2float` | `air.ceil` | None | **Builtin** |
| `<metal_math>` | `ceil` | `float3 ceil(float3)` | `__builtin_msl_ceil` | `@llvm.ceil.v3float` | `air.ceil` | None | **Builtin** |
| `<metal_math>` | `ceil` | `float4 ceil(float4)` | `__builtin_msl_ceil` | `@llvm.ceil.v4float` | `air.ceil` | None | **Builtin** |
| `<metal_math>` | `ceil` | `float8 ceil(float8)` | `__builtin_msl_ceil` | `@llvm.ceil.v8float` | `air.ceil` | None | **Builtin** |
| `<metal_math>` | `ceil` | `float16 ceil(float16)` | `__builtin_msl_ceil` | `@llvm.ceil.v16float` | `air.ceil` | None | **Builtin** |
| `<metal_math>` | `ceil` | `double ceil(double)` | `__builtin_msl_ceil` | `@llvm.ceil.v1double` | `air.ceil` | None | **Builtin** |
| `<metal_math>` | `ceil` | `double2 ceil(double2)` | `__builtin_msl_ceil` | `@llvm.ceil.v2double` | `air.ceil` | None | **Builtin** |
| `<metal_math>` | `ceil` | `double3 ceil(double3)` | `__builtin_msl_ceil` | `@llvm.ceil.v3double` | `air.ceil` | None | **Builtin** |
| `<metal_math>` | `ceil` | `double4 ceil(double4)` | `__builtin_msl_ceil` | `@llvm.ceil.v4double` | `air.ceil` | None | **Builtin** |
| `<metal_math>` | `ceil` | `double8 ceil(double8)` | `__builtin_msl_ceil` | `@llvm.ceil.v8double` | `air.ceil` | None | **Builtin** |
| `<metal_math>` | `ceil` | `double16 ceil(double16)` | `__builtin_msl_ceil` | `@llvm.ceil.v16double` | `air.ceil` | None | **Builtin** |
---

## 2. Fast Math vs. Precise Math Mappings

Metal provides compile options that dictate the precision level of transcendental math functions:

1. **Fast Math Mode (`__METAL_FAST_MATH__` defined)**:
   - Floating-point divisions and square roots are lowered to fast reciprocal/reciprocal-sqrt approximations in hardware.
   - Triggers compiler options to ignore NaNs and Infinities, generating fast, low-latency, approximate ALU instructions (e.g., AGX hardware math pipeline).

2. **Precise Math Mode (`__METAL_PRECISE_MATH__` defined)**:
   - The compiler enforces IEEE-754 standards.
   - Translates to strict high-precision division, accurate range reductions, and handles Edge Cases (Infinities, subnormals, NaNs) properly.
   - For example, `cos` calls in Precise Math generate specialized code paths or target high-precision runtime sequences rather than raw hardware approximate lookup tables.



## Range Reduction and Transcendental Math Approximations

Transcendental mathematical functions (such as `sin`, `cos`, or `exp`) require robust range reduction before execution:
- **Range Reduction**: Reduces the input argument $x$ to a standard reference interval (e.g., reducing $x$ to $[ -\pi, \pi ]$ for trigonometric functions).
- **Fast Math Lookup**: Under fast math, range reduction and calculation are performed by a dedicated hardware lookup table, which executes in a fraction of the clock cycles required for full division.
- **Precise Math Pipeline**: Under precise math, range reduction is performed with strict IEEE-754 compliance using high-precision polynomial expansions.

## LLVM IR Mappings of Transcendental Trigonometric Functions

Below is the exact LLVM IR assembly generated for scalar and vector `cos` and `sin` calls:

```llvm
; Scalar float cos call
define float @scalar_cos(float %x) {
  %res = call float @llvm.cos.f32(float %x)
  ret float %res
}

; Vector float4 sin call
define <4 x float> @vector_sin(<4 x float> %x) {
  %res = call <4 x float> @llvm.sin.v4f32(<4 x float> %x)
  ret <4 x float> %res
}

declare float @llvm.cos.f32(float)
declare <4 x float> @llvm.sin.v4f32(<4 x float>)
```

### Fast-Math Approximations inside TableGen Instructions
When fast math is enabled, trigonometric functions are mapped to direct hardware lookup instructions inside `lib/Target/AGX/AGXInstrInfo.td`:
```tablegen
def : Pat<(fsin GPR:$src), (AGX_FSIN GPR:$src)>;
def : Pat<(fcos GPR:$src), (AGX_FCOS GPR:$src)>;
```
