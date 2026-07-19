# Section 8: Exhaustive API Mapping Matrix - Integer Arithmetic

This section provides the complete, exhaustive mapping matrix for MSL integer math functions, showing how each scalar and vector variant is parsed, lowered, optimized, and mapped to hardware.

---

## 1. Exhaustive Integer Mapping Matrix

| Header File | MSL API Name / Family | Fully-Expanded Signatures (All Supported Mappings) | Clang Builtin | LLVM Intrinsic / IR | AIR Opcode | GPU Runtime Dependency | Builtin / Header / Runtime |
|:---|:---|:---|:---|:---|:---|:---:|:---|
| `<metal_integer>` | `abs` | `char abs(char)` | `__builtin_msl_abs` | `@llvm.abs.v1char` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `char2 abs(char2)` | `__builtin_msl_abs` | `@llvm.abs.v2char` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `char3 abs(char3)` | `__builtin_msl_abs` | `@llvm.abs.v3char` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `char4 abs(char4)` | `__builtin_msl_abs` | `@llvm.abs.v4char` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `char8 abs(char8)` | `__builtin_msl_abs` | `@llvm.abs.v8char` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `char16 abs(char16)` | `__builtin_msl_abs` | `@llvm.abs.v16char` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `uchar abs(uchar)` | `__builtin_msl_abs` | `@llvm.abs.v1uchar` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `uchar2 abs(uchar2)` | `__builtin_msl_abs` | `@llvm.abs.v2uchar` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `uchar3 abs(uchar3)` | `__builtin_msl_abs` | `@llvm.abs.v3uchar` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `uchar4 abs(uchar4)` | `__builtin_msl_abs` | `@llvm.abs.v4uchar` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `uchar8 abs(uchar8)` | `__builtin_msl_abs` | `@llvm.abs.v8uchar` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `uchar16 abs(uchar16)` | `__builtin_msl_abs` | `@llvm.abs.v16uchar` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `short abs(short)` | `__builtin_msl_abs` | `@llvm.abs.v1short` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `short2 abs(short2)` | `__builtin_msl_abs` | `@llvm.abs.v2short` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `short3 abs(short3)` | `__builtin_msl_abs` | `@llvm.abs.v3short` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `short4 abs(short4)` | `__builtin_msl_abs` | `@llvm.abs.v4short` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `short8 abs(short8)` | `__builtin_msl_abs` | `@llvm.abs.v8short` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `short16 abs(short16)` | `__builtin_msl_abs` | `@llvm.abs.v16short` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `ushort abs(ushort)` | `__builtin_msl_abs` | `@llvm.abs.v1ushort` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `ushort2 abs(ushort2)` | `__builtin_msl_abs` | `@llvm.abs.v2ushort` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `ushort3 abs(ushort3)` | `__builtin_msl_abs` | `@llvm.abs.v3ushort` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `ushort4 abs(ushort4)` | `__builtin_msl_abs` | `@llvm.abs.v4ushort` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `ushort8 abs(ushort8)` | `__builtin_msl_abs` | `@llvm.abs.v8ushort` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `ushort16 abs(ushort16)` | `__builtin_msl_abs` | `@llvm.abs.v16ushort` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `int abs(int)` | `__builtin_msl_abs` | `@llvm.abs.v1int` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `int2 abs(int2)` | `__builtin_msl_abs` | `@llvm.abs.v2int` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `int3 abs(int3)` | `__builtin_msl_abs` | `@llvm.abs.v3int` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `int4 abs(int4)` | `__builtin_msl_abs` | `@llvm.abs.v4int` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `int8 abs(int8)` | `__builtin_msl_abs` | `@llvm.abs.v8int` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `int16 abs(int16)` | `__builtin_msl_abs` | `@llvm.abs.v16int` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `uint abs(uint)` | `__builtin_msl_abs` | `@llvm.abs.v1uint` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `uint2 abs(uint2)` | `__builtin_msl_abs` | `@llvm.abs.v2uint` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `uint3 abs(uint3)` | `__builtin_msl_abs` | `@llvm.abs.v3uint` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `uint4 abs(uint4)` | `__builtin_msl_abs` | `@llvm.abs.v4uint` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `uint8 abs(uint8)` | `__builtin_msl_abs` | `@llvm.abs.v8uint` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `uint16 abs(uint16)` | `__builtin_msl_abs` | `@llvm.abs.v16uint` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `long abs(long)` | `__builtin_msl_abs` | `@llvm.abs.v1long` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `long2 abs(long2)` | `__builtin_msl_abs` | `@llvm.abs.v2long` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `long3 abs(long3)` | `__builtin_msl_abs` | `@llvm.abs.v3long` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `long4 abs(long4)` | `__builtin_msl_abs` | `@llvm.abs.v4long` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `long8 abs(long8)` | `__builtin_msl_abs` | `@llvm.abs.v8long` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `long16 abs(long16)` | `__builtin_msl_abs` | `@llvm.abs.v16long` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `ulong abs(ulong)` | `__builtin_msl_abs` | `@llvm.abs.v1ulong` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `ulong2 abs(ulong2)` | `__builtin_msl_abs` | `@llvm.abs.v2ulong` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `ulong3 abs(ulong3)` | `__builtin_msl_abs` | `@llvm.abs.v3ulong` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `ulong4 abs(ulong4)` | `__builtin_msl_abs` | `@llvm.abs.v4ulong` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `ulong8 abs(ulong8)` | `__builtin_msl_abs` | `@llvm.abs.v8ulong` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `abs` | `ulong16 abs(ulong16)` | `__builtin_msl_abs` | `@llvm.abs.v16ulong` | `air.abs` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `char addsat(char)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v1char` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `char2 addsat(char2)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v2char` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `char3 addsat(char3)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v3char` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `char4 addsat(char4)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v4char` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `char8 addsat(char8)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v8char` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `char16 addsat(char16)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v16char` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `uchar addsat(uchar)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v1uchar` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `uchar2 addsat(uchar2)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v2uchar` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `uchar3 addsat(uchar3)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v3uchar` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `uchar4 addsat(uchar4)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v4uchar` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `uchar8 addsat(uchar8)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v8uchar` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `uchar16 addsat(uchar16)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v16uchar` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `short addsat(short)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v1short` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `short2 addsat(short2)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v2short` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `short3 addsat(short3)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v3short` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `short4 addsat(short4)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v4short` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `short8 addsat(short8)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v8short` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `short16 addsat(short16)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v16short` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `ushort addsat(ushort)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v1ushort` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `ushort2 addsat(ushort2)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v2ushort` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `ushort3 addsat(ushort3)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v3ushort` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `ushort4 addsat(ushort4)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v4ushort` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `ushort8 addsat(ushort8)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v8ushort` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `ushort16 addsat(ushort16)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v16ushort` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `int addsat(int)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v1int` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `int2 addsat(int2)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v2int` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `int3 addsat(int3)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v3int` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `int4 addsat(int4)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v4int` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `int8 addsat(int8)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v8int` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `int16 addsat(int16)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v16int` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `uint addsat(uint)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v1uint` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `uint2 addsat(uint2)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v2uint` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `uint3 addsat(uint3)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v3uint` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `uint4 addsat(uint4)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v4uint` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `uint8 addsat(uint8)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v8uint` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `uint16 addsat(uint16)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v16uint` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `long addsat(long)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v1long` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `long2 addsat(long2)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v2long` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `long3 addsat(long3)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v3long` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `long4 addsat(long4)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v4long` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `long8 addsat(long8)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v8long` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `long16 addsat(long16)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v16long` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `ulong addsat(ulong)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v1ulong` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `ulong2 addsat(ulong2)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v2ulong` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `ulong3 addsat(ulong3)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v3ulong` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `ulong4 addsat(ulong4)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v4ulong` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `ulong8 addsat(ulong8)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v8ulong` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `ulong16 addsat(ulong16)` | `__builtin_msl_addsat` | `@llvm.sadd.sat.v16ulong` | `air.sadd.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `char subsat(char)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v1char` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `char2 subsat(char2)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v2char` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `char3 subsat(char3)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v3char` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `char4 subsat(char4)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v4char` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `char8 subsat(char8)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v8char` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `char16 subsat(char16)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v16char` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `uchar subsat(uchar)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v1uchar` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `uchar2 subsat(uchar2)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v2uchar` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `uchar3 subsat(uchar3)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v3uchar` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `uchar4 subsat(uchar4)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v4uchar` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `uchar8 subsat(uchar8)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v8uchar` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `uchar16 subsat(uchar16)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v16uchar` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `short subsat(short)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v1short` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `short2 subsat(short2)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v2short` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `short3 subsat(short3)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v3short` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `short4 subsat(short4)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v4short` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `short8 subsat(short8)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v8short` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `short16 subsat(short16)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v16short` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `ushort subsat(ushort)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v1ushort` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `ushort2 subsat(ushort2)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v2ushort` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `ushort3 subsat(ushort3)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v3ushort` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `ushort4 subsat(ushort4)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v4ushort` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `ushort8 subsat(ushort8)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v8ushort` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `ushort16 subsat(ushort16)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v16ushort` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `int subsat(int)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v1int` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `int2 subsat(int2)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v2int` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `int3 subsat(int3)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v3int` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `int4 subsat(int4)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v4int` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `int8 subsat(int8)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v8int` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `int16 subsat(int16)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v16int` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `uint subsat(uint)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v1uint` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `uint2 subsat(uint2)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v2uint` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `uint3 subsat(uint3)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v3uint` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `uint4 subsat(uint4)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v4uint` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `uint8 subsat(uint8)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v8uint` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `uint16 subsat(uint16)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v16uint` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `long subsat(long)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v1long` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `long2 subsat(long2)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v2long` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `long3 subsat(long3)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v3long` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `long4 subsat(long4)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v4long` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `long8 subsat(long8)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v8long` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `long16 subsat(long16)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v16long` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `ulong subsat(ulong)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v1ulong` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `ulong2 subsat(ulong2)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v2ulong` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `ulong3 subsat(ulong3)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v3ulong` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `ulong4 subsat(ulong4)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v4ulong` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `ulong8 subsat(ulong8)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v8ulong` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `ulong16 subsat(ulong16)` | `__builtin_msl_subsat` | `@llvm.ssub.sat.v16ulong` | `air.ssub.sat` | None | **Builtin** |
| `<metal_integer>` | `clz` | `char clz(char)` | `__builtin_msl_clz` | `@llvm.ctlz.v1char` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `char2 clz(char2)` | `__builtin_msl_clz` | `@llvm.ctlz.v2char` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `char3 clz(char3)` | `__builtin_msl_clz` | `@llvm.ctlz.v3char` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `char4 clz(char4)` | `__builtin_msl_clz` | `@llvm.ctlz.v4char` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `char8 clz(char8)` | `__builtin_msl_clz` | `@llvm.ctlz.v8char` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `char16 clz(char16)` | `__builtin_msl_clz` | `@llvm.ctlz.v16char` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `uchar clz(uchar)` | `__builtin_msl_clz` | `@llvm.ctlz.v1uchar` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `uchar2 clz(uchar2)` | `__builtin_msl_clz` | `@llvm.ctlz.v2uchar` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `uchar3 clz(uchar3)` | `__builtin_msl_clz` | `@llvm.ctlz.v3uchar` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `uchar4 clz(uchar4)` | `__builtin_msl_clz` | `@llvm.ctlz.v4uchar` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `uchar8 clz(uchar8)` | `__builtin_msl_clz` | `@llvm.ctlz.v8uchar` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `uchar16 clz(uchar16)` | `__builtin_msl_clz` | `@llvm.ctlz.v16uchar` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `short clz(short)` | `__builtin_msl_clz` | `@llvm.ctlz.v1short` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `short2 clz(short2)` | `__builtin_msl_clz` | `@llvm.ctlz.v2short` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `short3 clz(short3)` | `__builtin_msl_clz` | `@llvm.ctlz.v3short` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `short4 clz(short4)` | `__builtin_msl_clz` | `@llvm.ctlz.v4short` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `short8 clz(short8)` | `__builtin_msl_clz` | `@llvm.ctlz.v8short` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `short16 clz(short16)` | `__builtin_msl_clz` | `@llvm.ctlz.v16short` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `ushort clz(ushort)` | `__builtin_msl_clz` | `@llvm.ctlz.v1ushort` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `ushort2 clz(ushort2)` | `__builtin_msl_clz` | `@llvm.ctlz.v2ushort` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `ushort3 clz(ushort3)` | `__builtin_msl_clz` | `@llvm.ctlz.v3ushort` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `ushort4 clz(ushort4)` | `__builtin_msl_clz` | `@llvm.ctlz.v4ushort` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `ushort8 clz(ushort8)` | `__builtin_msl_clz` | `@llvm.ctlz.v8ushort` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `ushort16 clz(ushort16)` | `__builtin_msl_clz` | `@llvm.ctlz.v16ushort` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `int clz(int)` | `__builtin_msl_clz` | `@llvm.ctlz.v1int` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `int2 clz(int2)` | `__builtin_msl_clz` | `@llvm.ctlz.v2int` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `int3 clz(int3)` | `__builtin_msl_clz` | `@llvm.ctlz.v3int` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `int4 clz(int4)` | `__builtin_msl_clz` | `@llvm.ctlz.v4int` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `int8 clz(int8)` | `__builtin_msl_clz` | `@llvm.ctlz.v8int` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `int16 clz(int16)` | `__builtin_msl_clz` | `@llvm.ctlz.v16int` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `uint clz(uint)` | `__builtin_msl_clz` | `@llvm.ctlz.v1uint` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `uint2 clz(uint2)` | `__builtin_msl_clz` | `@llvm.ctlz.v2uint` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `uint3 clz(uint3)` | `__builtin_msl_clz` | `@llvm.ctlz.v3uint` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `uint4 clz(uint4)` | `__builtin_msl_clz` | `@llvm.ctlz.v4uint` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `uint8 clz(uint8)` | `__builtin_msl_clz` | `@llvm.ctlz.v8uint` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `uint16 clz(uint16)` | `__builtin_msl_clz` | `@llvm.ctlz.v16uint` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `long clz(long)` | `__builtin_msl_clz` | `@llvm.ctlz.v1long` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `long2 clz(long2)` | `__builtin_msl_clz` | `@llvm.ctlz.v2long` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `long3 clz(long3)` | `__builtin_msl_clz` | `@llvm.ctlz.v3long` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `long4 clz(long4)` | `__builtin_msl_clz` | `@llvm.ctlz.v4long` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `long8 clz(long8)` | `__builtin_msl_clz` | `@llvm.ctlz.v8long` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `long16 clz(long16)` | `__builtin_msl_clz` | `@llvm.ctlz.v16long` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `ulong clz(ulong)` | `__builtin_msl_clz` | `@llvm.ctlz.v1ulong` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `ulong2 clz(ulong2)` | `__builtin_msl_clz` | `@llvm.ctlz.v2ulong` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `ulong3 clz(ulong3)` | `__builtin_msl_clz` | `@llvm.ctlz.v3ulong` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `ulong4 clz(ulong4)` | `__builtin_msl_clz` | `@llvm.ctlz.v4ulong` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `ulong8 clz(ulong8)` | `__builtin_msl_clz` | `@llvm.ctlz.v8ulong` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `clz` | `ulong16 clz(ulong16)` | `__builtin_msl_clz` | `@llvm.ctlz.v16ulong` | `air.clz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `char ctz(char)` | `__builtin_msl_ctz` | `@llvm.cttz.v1char` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `char2 ctz(char2)` | `__builtin_msl_ctz` | `@llvm.cttz.v2char` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `char3 ctz(char3)` | `__builtin_msl_ctz` | `@llvm.cttz.v3char` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `char4 ctz(char4)` | `__builtin_msl_ctz` | `@llvm.cttz.v4char` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `char8 ctz(char8)` | `__builtin_msl_ctz` | `@llvm.cttz.v8char` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `char16 ctz(char16)` | `__builtin_msl_ctz` | `@llvm.cttz.v16char` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `uchar ctz(uchar)` | `__builtin_msl_ctz` | `@llvm.cttz.v1uchar` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `uchar2 ctz(uchar2)` | `__builtin_msl_ctz` | `@llvm.cttz.v2uchar` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `uchar3 ctz(uchar3)` | `__builtin_msl_ctz` | `@llvm.cttz.v3uchar` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `uchar4 ctz(uchar4)` | `__builtin_msl_ctz` | `@llvm.cttz.v4uchar` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `uchar8 ctz(uchar8)` | `__builtin_msl_ctz` | `@llvm.cttz.v8uchar` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `uchar16 ctz(uchar16)` | `__builtin_msl_ctz` | `@llvm.cttz.v16uchar` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `short ctz(short)` | `__builtin_msl_ctz` | `@llvm.cttz.v1short` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `short2 ctz(short2)` | `__builtin_msl_ctz` | `@llvm.cttz.v2short` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `short3 ctz(short3)` | `__builtin_msl_ctz` | `@llvm.cttz.v3short` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `short4 ctz(short4)` | `__builtin_msl_ctz` | `@llvm.cttz.v4short` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `short8 ctz(short8)` | `__builtin_msl_ctz` | `@llvm.cttz.v8short` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `short16 ctz(short16)` | `__builtin_msl_ctz` | `@llvm.cttz.v16short` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `ushort ctz(ushort)` | `__builtin_msl_ctz` | `@llvm.cttz.v1ushort` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `ushort2 ctz(ushort2)` | `__builtin_msl_ctz` | `@llvm.cttz.v2ushort` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `ushort3 ctz(ushort3)` | `__builtin_msl_ctz` | `@llvm.cttz.v3ushort` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `ushort4 ctz(ushort4)` | `__builtin_msl_ctz` | `@llvm.cttz.v4ushort` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `ushort8 ctz(ushort8)` | `__builtin_msl_ctz` | `@llvm.cttz.v8ushort` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `ushort16 ctz(ushort16)` | `__builtin_msl_ctz` | `@llvm.cttz.v16ushort` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `int ctz(int)` | `__builtin_msl_ctz` | `@llvm.cttz.v1int` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `int2 ctz(int2)` | `__builtin_msl_ctz` | `@llvm.cttz.v2int` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `int3 ctz(int3)` | `__builtin_msl_ctz` | `@llvm.cttz.v3int` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `int4 ctz(int4)` | `__builtin_msl_ctz` | `@llvm.cttz.v4int` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `int8 ctz(int8)` | `__builtin_msl_ctz` | `@llvm.cttz.v8int` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `int16 ctz(int16)` | `__builtin_msl_ctz` | `@llvm.cttz.v16int` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `uint ctz(uint)` | `__builtin_msl_ctz` | `@llvm.cttz.v1uint` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `uint2 ctz(uint2)` | `__builtin_msl_ctz` | `@llvm.cttz.v2uint` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `uint3 ctz(uint3)` | `__builtin_msl_ctz` | `@llvm.cttz.v3uint` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `uint4 ctz(uint4)` | `__builtin_msl_ctz` | `@llvm.cttz.v4uint` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `uint8 ctz(uint8)` | `__builtin_msl_ctz` | `@llvm.cttz.v8uint` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `uint16 ctz(uint16)` | `__builtin_msl_ctz` | `@llvm.cttz.v16uint` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `long ctz(long)` | `__builtin_msl_ctz` | `@llvm.cttz.v1long` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `long2 ctz(long2)` | `__builtin_msl_ctz` | `@llvm.cttz.v2long` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `long3 ctz(long3)` | `__builtin_msl_ctz` | `@llvm.cttz.v3long` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `long4 ctz(long4)` | `__builtin_msl_ctz` | `@llvm.cttz.v4long` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `long8 ctz(long8)` | `__builtin_msl_ctz` | `@llvm.cttz.v8long` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `long16 ctz(long16)` | `__builtin_msl_ctz` | `@llvm.cttz.v16long` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `ulong ctz(ulong)` | `__builtin_msl_ctz` | `@llvm.cttz.v1ulong` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `ulong2 ctz(ulong2)` | `__builtin_msl_ctz` | `@llvm.cttz.v2ulong` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `ulong3 ctz(ulong3)` | `__builtin_msl_ctz` | `@llvm.cttz.v3ulong` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `ulong4 ctz(ulong4)` | `__builtin_msl_ctz` | `@llvm.cttz.v4ulong` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `ulong8 ctz(ulong8)` | `__builtin_msl_ctz` | `@llvm.cttz.v8ulong` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `ulong16 ctz(ulong16)` | `__builtin_msl_ctz` | `@llvm.cttz.v16ulong` | `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `char popcount(char)` | `__builtin_msl_popcount` | `@llvm.ctpop.v1char` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `char2 popcount(char2)` | `__builtin_msl_popcount` | `@llvm.ctpop.v2char` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `char3 popcount(char3)` | `__builtin_msl_popcount` | `@llvm.ctpop.v3char` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `char4 popcount(char4)` | `__builtin_msl_popcount` | `@llvm.ctpop.v4char` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `char8 popcount(char8)` | `__builtin_msl_popcount` | `@llvm.ctpop.v8char` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `char16 popcount(char16)` | `__builtin_msl_popcount` | `@llvm.ctpop.v16char` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `uchar popcount(uchar)` | `__builtin_msl_popcount` | `@llvm.ctpop.v1uchar` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `uchar2 popcount(uchar2)` | `__builtin_msl_popcount` | `@llvm.ctpop.v2uchar` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `uchar3 popcount(uchar3)` | `__builtin_msl_popcount` | `@llvm.ctpop.v3uchar` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `uchar4 popcount(uchar4)` | `__builtin_msl_popcount` | `@llvm.ctpop.v4uchar` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `uchar8 popcount(uchar8)` | `__builtin_msl_popcount` | `@llvm.ctpop.v8uchar` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `uchar16 popcount(uchar16)` | `__builtin_msl_popcount` | `@llvm.ctpop.v16uchar` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `short popcount(short)` | `__builtin_msl_popcount` | `@llvm.ctpop.v1short` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `short2 popcount(short2)` | `__builtin_msl_popcount` | `@llvm.ctpop.v2short` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `short3 popcount(short3)` | `__builtin_msl_popcount` | `@llvm.ctpop.v3short` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `short4 popcount(short4)` | `__builtin_msl_popcount` | `@llvm.ctpop.v4short` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `short8 popcount(short8)` | `__builtin_msl_popcount` | `@llvm.ctpop.v8short` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `short16 popcount(short16)` | `__builtin_msl_popcount` | `@llvm.ctpop.v16short` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `ushort popcount(ushort)` | `__builtin_msl_popcount` | `@llvm.ctpop.v1ushort` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `ushort2 popcount(ushort2)` | `__builtin_msl_popcount` | `@llvm.ctpop.v2ushort` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `ushort3 popcount(ushort3)` | `__builtin_msl_popcount` | `@llvm.ctpop.v3ushort` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `ushort4 popcount(ushort4)` | `__builtin_msl_popcount` | `@llvm.ctpop.v4ushort` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `ushort8 popcount(ushort8)` | `__builtin_msl_popcount` | `@llvm.ctpop.v8ushort` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `ushort16 popcount(ushort16)` | `__builtin_msl_popcount` | `@llvm.ctpop.v16ushort` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `int popcount(int)` | `__builtin_msl_popcount` | `@llvm.ctpop.v1int` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `int2 popcount(int2)` | `__builtin_msl_popcount` | `@llvm.ctpop.v2int` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `int3 popcount(int3)` | `__builtin_msl_popcount` | `@llvm.ctpop.v3int` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `int4 popcount(int4)` | `__builtin_msl_popcount` | `@llvm.ctpop.v4int` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `int8 popcount(int8)` | `__builtin_msl_popcount` | `@llvm.ctpop.v8int` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `int16 popcount(int16)` | `__builtin_msl_popcount` | `@llvm.ctpop.v16int` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `uint popcount(uint)` | `__builtin_msl_popcount` | `@llvm.ctpop.v1uint` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `uint2 popcount(uint2)` | `__builtin_msl_popcount` | `@llvm.ctpop.v2uint` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `uint3 popcount(uint3)` | `__builtin_msl_popcount` | `@llvm.ctpop.v3uint` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `uint4 popcount(uint4)` | `__builtin_msl_popcount` | `@llvm.ctpop.v4uint` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `uint8 popcount(uint8)` | `__builtin_msl_popcount` | `@llvm.ctpop.v8uint` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `uint16 popcount(uint16)` | `__builtin_msl_popcount` | `@llvm.ctpop.v16uint` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `long popcount(long)` | `__builtin_msl_popcount` | `@llvm.ctpop.v1long` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `long2 popcount(long2)` | `__builtin_msl_popcount` | `@llvm.ctpop.v2long` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `long3 popcount(long3)` | `__builtin_msl_popcount` | `@llvm.ctpop.v3long` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `long4 popcount(long4)` | `__builtin_msl_popcount` | `@llvm.ctpop.v4long` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `long8 popcount(long8)` | `__builtin_msl_popcount` | `@llvm.ctpop.v8long` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `long16 popcount(long16)` | `__builtin_msl_popcount` | `@llvm.ctpop.v16long` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `ulong popcount(ulong)` | `__builtin_msl_popcount` | `@llvm.ctpop.v1ulong` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `ulong2 popcount(ulong2)` | `__builtin_msl_popcount` | `@llvm.ctpop.v2ulong` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `ulong3 popcount(ulong3)` | `__builtin_msl_popcount` | `@llvm.ctpop.v3ulong` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `ulong4 popcount(ulong4)` | `__builtin_msl_popcount` | `@llvm.ctpop.v4ulong` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `ulong8 popcount(ulong8)` | `__builtin_msl_popcount` | `@llvm.ctpop.v8ulong` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `popcount` | `ulong16 popcount(ulong16)` | `__builtin_msl_popcount` | `@llvm.ctpop.v16ulong` | `air.popcount` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `char reverse_bits(char)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v1char` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `char2 reverse_bits(char2)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v2char` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `char3 reverse_bits(char3)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v3char` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `char4 reverse_bits(char4)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v4char` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `char8 reverse_bits(char8)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v8char` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `char16 reverse_bits(char16)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v16char` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `uchar reverse_bits(uchar)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v1uchar` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `uchar2 reverse_bits(uchar2)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v2uchar` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `uchar3 reverse_bits(uchar3)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v3uchar` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `uchar4 reverse_bits(uchar4)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v4uchar` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `uchar8 reverse_bits(uchar8)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v8uchar` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `uchar16 reverse_bits(uchar16)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v16uchar` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `short reverse_bits(short)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v1short` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `short2 reverse_bits(short2)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v2short` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `short3 reverse_bits(short3)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v3short` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `short4 reverse_bits(short4)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v4short` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `short8 reverse_bits(short8)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v8short` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `short16 reverse_bits(short16)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v16short` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `ushort reverse_bits(ushort)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v1ushort` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `ushort2 reverse_bits(ushort2)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v2ushort` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `ushort3 reverse_bits(ushort3)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v3ushort` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `ushort4 reverse_bits(ushort4)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v4ushort` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `ushort8 reverse_bits(ushort8)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v8ushort` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `ushort16 reverse_bits(ushort16)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v16ushort` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `int reverse_bits(int)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v1int` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `int2 reverse_bits(int2)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v2int` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `int3 reverse_bits(int3)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v3int` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `int4 reverse_bits(int4)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v4int` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `int8 reverse_bits(int8)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v8int` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `int16 reverse_bits(int16)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v16int` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `uint reverse_bits(uint)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v1uint` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `uint2 reverse_bits(uint2)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v2uint` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `uint3 reverse_bits(uint3)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v3uint` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `uint4 reverse_bits(uint4)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v4uint` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `uint8 reverse_bits(uint8)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v8uint` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `uint16 reverse_bits(uint16)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v16uint` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `long reverse_bits(long)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v1long` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `long2 reverse_bits(long2)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v2long` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `long3 reverse_bits(long3)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v3long` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `long4 reverse_bits(long4)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v4long` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `long8 reverse_bits(long8)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v8long` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `long16 reverse_bits(long16)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v16long` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `ulong reverse_bits(ulong)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v1ulong` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `ulong2 reverse_bits(ulong2)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v2ulong` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `ulong3 reverse_bits(ulong3)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v3ulong` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `ulong4 reverse_bits(ulong4)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v4ulong` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `ulong8 reverse_bits(ulong8)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v8ulong` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `reverse_bits` | `ulong16 reverse_bits(ulong16)` | `__builtin_msl_reverse_bits` | `@llvm.bitreverse.v16ulong` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `char rotate(char)` | `__builtin_msl_rotate` | `@llvm.fshl.v1char` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `char2 rotate(char2)` | `__builtin_msl_rotate` | `@llvm.fshl.v2char` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `char3 rotate(char3)` | `__builtin_msl_rotate` | `@llvm.fshl.v3char` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `char4 rotate(char4)` | `__builtin_msl_rotate` | `@llvm.fshl.v4char` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `char8 rotate(char8)` | `__builtin_msl_rotate` | `@llvm.fshl.v8char` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `char16 rotate(char16)` | `__builtin_msl_rotate` | `@llvm.fshl.v16char` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `uchar rotate(uchar)` | `__builtin_msl_rotate` | `@llvm.fshl.v1uchar` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `uchar2 rotate(uchar2)` | `__builtin_msl_rotate` | `@llvm.fshl.v2uchar` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `uchar3 rotate(uchar3)` | `__builtin_msl_rotate` | `@llvm.fshl.v3uchar` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `uchar4 rotate(uchar4)` | `__builtin_msl_rotate` | `@llvm.fshl.v4uchar` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `uchar8 rotate(uchar8)` | `__builtin_msl_rotate` | `@llvm.fshl.v8uchar` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `uchar16 rotate(uchar16)` | `__builtin_msl_rotate` | `@llvm.fshl.v16uchar` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `short rotate(short)` | `__builtin_msl_rotate` | `@llvm.fshl.v1short` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `short2 rotate(short2)` | `__builtin_msl_rotate` | `@llvm.fshl.v2short` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `short3 rotate(short3)` | `__builtin_msl_rotate` | `@llvm.fshl.v3short` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `short4 rotate(short4)` | `__builtin_msl_rotate` | `@llvm.fshl.v4short` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `short8 rotate(short8)` | `__builtin_msl_rotate` | `@llvm.fshl.v8short` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `short16 rotate(short16)` | `__builtin_msl_rotate` | `@llvm.fshl.v16short` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `ushort rotate(ushort)` | `__builtin_msl_rotate` | `@llvm.fshl.v1ushort` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `ushort2 rotate(ushort2)` | `__builtin_msl_rotate` | `@llvm.fshl.v2ushort` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `ushort3 rotate(ushort3)` | `__builtin_msl_rotate` | `@llvm.fshl.v3ushort` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `ushort4 rotate(ushort4)` | `__builtin_msl_rotate` | `@llvm.fshl.v4ushort` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `ushort8 rotate(ushort8)` | `__builtin_msl_rotate` | `@llvm.fshl.v8ushort` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `ushort16 rotate(ushort16)` | `__builtin_msl_rotate` | `@llvm.fshl.v16ushort` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `int rotate(int)` | `__builtin_msl_rotate` | `@llvm.fshl.v1int` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `int2 rotate(int2)` | `__builtin_msl_rotate` | `@llvm.fshl.v2int` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `int3 rotate(int3)` | `__builtin_msl_rotate` | `@llvm.fshl.v3int` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `int4 rotate(int4)` | `__builtin_msl_rotate` | `@llvm.fshl.v4int` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `int8 rotate(int8)` | `__builtin_msl_rotate` | `@llvm.fshl.v8int` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `int16 rotate(int16)` | `__builtin_msl_rotate` | `@llvm.fshl.v16int` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `uint rotate(uint)` | `__builtin_msl_rotate` | `@llvm.fshl.v1uint` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `uint2 rotate(uint2)` | `__builtin_msl_rotate` | `@llvm.fshl.v2uint` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `uint3 rotate(uint3)` | `__builtin_msl_rotate` | `@llvm.fshl.v3uint` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `uint4 rotate(uint4)` | `__builtin_msl_rotate` | `@llvm.fshl.v4uint` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `uint8 rotate(uint8)` | `__builtin_msl_rotate` | `@llvm.fshl.v8uint` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `uint16 rotate(uint16)` | `__builtin_msl_rotate` | `@llvm.fshl.v16uint` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `long rotate(long)` | `__builtin_msl_rotate` | `@llvm.fshl.v1long` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `long2 rotate(long2)` | `__builtin_msl_rotate` | `@llvm.fshl.v2long` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `long3 rotate(long3)` | `__builtin_msl_rotate` | `@llvm.fshl.v3long` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `long4 rotate(long4)` | `__builtin_msl_rotate` | `@llvm.fshl.v4long` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `long8 rotate(long8)` | `__builtin_msl_rotate` | `@llvm.fshl.v8long` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `long16 rotate(long16)` | `__builtin_msl_rotate` | `@llvm.fshl.v16long` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `ulong rotate(ulong)` | `__builtin_msl_rotate` | `@llvm.fshl.v1ulong` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `ulong2 rotate(ulong2)` | `__builtin_msl_rotate` | `@llvm.fshl.v2ulong` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `ulong3 rotate(ulong3)` | `__builtin_msl_rotate` | `@llvm.fshl.v3ulong` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `ulong4 rotate(ulong4)` | `__builtin_msl_rotate` | `@llvm.fshl.v4ulong` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `ulong8 rotate(ulong8)` | `__builtin_msl_rotate` | `@llvm.fshl.v8ulong` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `ulong16 rotate(ulong16)` | `__builtin_msl_rotate` | `@llvm.fshl.v16ulong` | `air.rotate` | None | **Builtin** |
---

## 2. Low-Level Translation Commentary

- **Saturating Math**: Clang translates `addsat` and `subsat` into standard LLVM saturating arithmetic intrinsics (e.g., `@llvm.sadd.sat`), which directly leverage the saturating arithmetic capabilities of the Apple Silicon ALUs.
- **Bitwise Manipulations**: Functions like `clz`, `ctz`, and `popcount` map directly to standard LLVM bit manipulation intrinsics. On the AGX hardware, these are executed in a single clock cycle using dedicated bitwise execution units.
- **Overloaded Vector Support**: When templates instantiating `int4` or other vector variants of these functions are processed, Clang code generation automatically processes them as vector structures (e.g., `<4 x i32>`), allowing LLVM to emit SIMD/vector instructions.

## Arithmetic Optimizations on Saturating Integers

Saturating integer operations (such as `addsat` or `subsat`) prevent integer overflows by clamping out-of-bounds calculations to the type's boundaries:
- **Signed Saturation**: Clamps underflow and overflow results to the range $[ -2^{N-1}, 2^{N-1} - 1 ]$.
- **Unsigned Saturation**: Clamps overflow results to the maximum boundary of unsigned types, flushing underflow values to zero.
- **Hardware Support**: Apple Silicon ALUs contain native saturating arithmetic units, which perform these clamping operations in a single execution cycle.
- **Instruction Combining**: During optimization, LLVM combines consecutive scalar additions and subtractions, merging them into single FMA or saturating instructions to improve throughput.

## TableGen DAG Mappings of Integer Arithmetic Operators

To lower integer operations directly to target assembly, implement TableGen pattern-matching classes inside `lib/Target/AGX/AGXInstrInfo.td`:

```tablegen
// TableGen Pattern for saturating integer add
def : Pat<(saddsat GPR:$src1, GPR:$src2),
          (AGX_ADDSAT GPR:$src1, GPR:$src2)>;

// TableGen Pattern for saturating integer sub
def : Pat<(ssubsat GPR:$src1, GPR:$src2),
          (AGX_SUBSAT GPR:$src1, GPR:$src2)>;
```

### Multi-Lane Vector Arithmetic Lowering
When integer vectors are initialized, Clang generates vectorized arithmetic operations to target the GPU's vector ALUs:
```cpp
Value *CodeGenFunction::EmitMetalVectorIntegerAdd(Value *LHS, Value *RHS) {
  // Emit standard LLVM vector add instruction
  return Builder.CreateAdd(LHS, RHS, "vadd");
}
```
