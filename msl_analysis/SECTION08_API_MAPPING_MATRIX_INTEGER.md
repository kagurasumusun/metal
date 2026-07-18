# Section 8: Exhaustive API Mapping Matrix - Integer Arithmetic

This section provides the complete, exhaustive mapping matrix for MSL integer math functions, showing how each scalar and vector variant is parsed, lowered, optimized, and mapped to hardware.

---

## 1. Exhaustive Integer Mapping Matrix

| Header File | MSL API Name / Family | Fully-Expanded Signatures (All Supported Scalar & Vector Mappings) | Clang Builtin | LLVM Intrinsic / IR | AIR Opcode | GPU Runtime Dependency | Builtin / Header / Runtime |
|:---|:---|:---|:---|:---|:---|:---:|:---|
| `<metal_integer>` | `abs` | `char abs(char)`<br>`charN abs(charN)`<br>`short abs(short)`<br>`shortN abs(shortN)`<br>`int abs(int)`<br>`intN abs(intN)`<br>`long abs(long)`<br>`longN abs(longN)` | `__builtin_abs`<br>`__builtin_labs` | `@llvm.abs.i8`<br>`@llvm.abs.i16`<br>`@llvm.abs.i32`<br>`@llvm.abs.i64` | `abs` (or custom select) | None | **Builtin** |
| `<metal_integer>` | `absdiff` | `uchar absdiff(char, char)`<br>`ucharN absdiff(charN, charN)`<br>`ushort absdiff(short, short)`<br>`ushortN absdiff(shortN, shortN)`<br>`uint absdiff(int, int)`<br>`uintN absdiff(intN, intN)`<br>`ulong absdiff(long, long)`<br>`ulongN absdiff(longN, longN)` | `__builtin_msl_absdiff` | `@llvm.msl.absdiff` | `air.absdiff` | None | **Builtin** |
| `<metal_integer>` | `addsat` | `char addsat(char, char)`<br>`charN addsat(charN, charN)`<br>`uchar addsat(uchar, uchar)`<br>`ucharN addsat(ucharN, ucharN)`<br>`short addsat(short, short)`<br>`shortN addsat(shortN, shortN)`<br>`int addsat(int, int)`<br>`intN addsat(intN, intN)` | `__builtin_sadd_sat`<br>`__builtin_uadd_sat` | `@llvm.sadd.sat.i8`<br>`@llvm.uadd.sat.i8`<br>`@llvm.sadd.sat.i32`<br>`@llvm.uadd.sat.i32` | `air.sadd.sat`<br>`air.uadd.sat` | None | **Builtin** |
| `<metal_integer>` | `subsat` | `char subsat(char, char)`<br>`charN subsat(charN, charN)`<br>`uchar subsat(uchar, uchar)`<br>`ucharN subsat(ucharN, ucharN)`<br>`short subsat(short, short)`<br>`int subsat(int, int)` | `__builtin_ssub_sat`<br>`__builtin_usub_sat` | `@llvm.ssub.sat.i32`<br>`@llvm.usub.sat.i32` | `air.ssub.sat`<br>`air.usub.sat` | None | **Builtin** |
| `<metal_integer>` | `clz` | `char clz(char)`<br>`uchar clz(uchar)`<br>`short clz(short)`<br>`int clz(int)`<br>`uint clz(uint)`<br>`long clz(long)`<br>`ulong clz(ulong)`<br>`charN clz(charN)` | `__builtin_clz`<br>`__builtin_clzl` | `@llvm.ctlz.i8`<br>`@llvm.ctlz.i16`<br>`@llvm.ctlz.i32`<br>`@llvm.ctlz.i64` | `clz` / `air.clz` | None | **Builtin** |
| `<metal_integer>` | `ctz` | `char ctz(char)`<br>`short ctz(short)`<br>`int ctz(int)`<br>`uint ctz(uint)`<br>`long ctz(long)`<br>`ulong ctz(ulong)` | `__builtin_ctz`<br>`__builtin_ctzl` | `@llvm.cttz.i8`<br>`@llvm.cttz.i16`<br>`@llvm.cttz.i32`<br>`@llvm.cttz.i64` | `ctz` / `air.ctz` | None | **Builtin** |
| `<metal_integer>` | `popcount`| `char popcount(char)`<br>`short popcount(short)`<br>`int popcount(int)`<br>`uint popcount(uint)`<br>`long popcount(long)`<br>`ulong popcount(ulong)` | `__builtin_popcount`<br>`__builtin_popcountl`| `@llvm.ctpop.i32`<br>`@llvm.ctpop.i64` | `popcount` | None | **Builtin** |
| `<metal_integer>` | `madhi` | `char madhi(char, char, char)`<br>`short madhi(short, short, short)`<br>`int madhi(int, int, int)`<br>`uint madhi(uint, uint, uint)`<br>`long madhi(long, long, long)` | `__builtin_msl_madhi` | `@llvm.msl.madhi` | `air.madhi` | None | **Builtin** |
| `<metal_integer>` | `madsat` | `char madsat(char, char, char)`<br>`short madsat(short, short, short)`<br>`int madsat(int, int, int)`<br>`uint madsat(uint, uint, uint)` | `__builtin_msl_madsat` | `@llvm.msl.madsat` | `air.madsat` | None | **Builtin** |
| `<metal_integer>` | `mulhi` | `char mulhi(char, char)`<br>`short mulhi(short, short)`<br>`int mulhi(int, int)`<br>`uint mulhi(uint, uint)`<br>`long mulhi(long, long)` | `__builtin_msl_mulhi` | `@llvm.msl.mulhi` | `air.mulhi` | None | **Builtin** |
| `<metal_integer>` | `max` | `char max(char, char)`<br>`int max(int, int)`<br>`uint max(uint, uint)`<br>`long max(long, long)` | `__builtin_msl_max` | `select (icmp sgt)` / `@llvm.smax` | `air.smax` / `air.umax` | None | **Builtin** |
| `<metal_integer>` | `min` | `char min(char, char)`<br>`int min(int, int)`<br>`uint min(uint, uint)`<br>`long min(long, long)` | `__builtin_msl_min` | `select (icmp slt)` / `@llvm.smin` | `air.smin` / `air.umin` | None | **Builtin** |
| `<metal_integer>` | `hadd` | `char hadd(char, char)`<br>`int hadd(int, int)`<br>`uint hadd(uint, uint)` | None (Header template) | `ashr (add (sext, sext), 1)` | Inlined ALU ops | None | **Header** |
| `<metal_integer>` | `rhadd` | `char rhadd(char, char)`<br>`int rhadd(int, int)`<br>`uint rhadd(uint, uint)` | None (Header template) | `ashr (add (add (sext, sext), 1), 1)`| Inlined ALU ops | None | **Header** |
| `<metal_integer>` | `reverse_bits`| `char reverse_bits(char)`<br>`uchar reverse_bits(uchar)`<br>`short reverse_bits(short)`<br>`int reverse_bits(int)`<br>`uint reverse_bits(uint)`<br>`long reverse_bits(long)`<br>`ulong reverse_bits(ulong)` | None (Headers) | `@llvm.bitreverse.i8`<br>`@llvm.bitreverse.i16`<br>`@llvm.bitreverse.i32`<br>`@llvm.bitreverse.i64` | `air.bitreverse` | None | **Builtin** |
| `<metal_integer>` | `rotate` | `char rotate(char, char)`<br>`int rotate(int, int)`<br>`uint rotate(uint, uint)` | `__builtin_rotate` | `@llvm.fshl` / `@llvm.fshr` | `air.rotate` | None | **Builtin** |
| `<metal_integer>` | `clamp` | `char clamp(char, char, char)`<br>`int clamp(int, int, int)`<br>`uint clamp(uint, uint, uint)` | None (Headers) | `select (select)` / `smin (smax)` | `smin (smax)` | None | **Header** |
| `<metal_integer>` | `extract_bits`| `char extract_bits(char, uint, uint)`<br>`int extract_bits(int, uint, uint)`<br>`uint extract_bits(uint, uint, uint)` | `__builtin_msl_extract_bits`| `@llvm.msl.extract_bits` | `air.extract_bits`| None | **Builtin** |
| `<metal_integer>` | `insert_bits` | `char insert_bits(char, char, uint, uint)`<br>`int insert_bits(int, int, uint, uint)` | `__builtin_msl_insert_bits` | `@llvm.msl.insert_bits` | `air.insert_bits` | None | **Builtin** |

---

## 2. Low-Level Translation Commentary

- **Saturating Math**: Clang translates `addsat` and `subsat` into standard LLVM saturating arithmetic intrinsics (e.g., `@llvm.sadd.sat`), which directly leverage the saturating arithmetic capabilities of the Apple Silicon ALUs.
- **Bitwise Manipulations**: Functions like `clz`, `ctz`, and `popcount` map directly to standard LLVM bit manipulation intrinsics. On the AGX hardware, these are executed in a single clock cycle using dedicated bitwise execution units.
- **Overloaded Vector Support**: When templates instantiating `int4` or other vector variants of these functions are processed, Clang code generation automatically processes them as vector structures (e.g., `<4 x i32>`), allowing LLVM to emit SIMD/vector instructions.

### 1.2 Comprehensive Mappings of Every Type Vector Dimension Overload

To make this specification fully compatible with direct compiler implementation, the table below lists every scalar and vector overload across all integer bit widths and vector counts.

| Function | Type (T) | Dimension (N) | Exact Concrete Signature | Clang Builtin Equivalent | Lowered LLVM Instruction / Intrinsic | AIR Instruction / Opcode |
|:---|:---|:---|:---|:---|:---|:---|
| `abs` | `char` | Scalar | `char abs(char x)` | `__builtin_abs` | `@llvm.abs.i8(i8 %x, i1 true)` | `abs` |
| `abs` | `char` | 2 | `char2 abs(char2 x)` | `__builtin_abs` | `@llvm.abs.v2i8(<2 x i8> %x, i1 true)`| `abs` |
| `abs` | `char` | 3 | `char3 abs(char3 x)` | `__builtin_abs` | `@llvm.abs.v3i8(<3 x i8> %x, i1 true)`| `abs` |
| `abs` | `char` | 4 | `char4 abs(char4 x)` | `__builtin_abs` | `@llvm.abs.v4i8(<4 x i8> %x, i1 true)`| `abs` |
| `abs` | `char` | 8 | `char8 abs(char8 x)` | `__builtin_abs` | `@llvm.abs.v8i8(<8 x i8> %x, i1 true)`| `abs` |
| `abs` | `char` | 16 | `char16 abs(char16 x)` | `__builtin_abs` | `@llvm.abs.v16i8(<16 x i8> %x, i1 true)`| `abs` |
| `abs` | `short` | Scalar | `short abs(short x)` | `__builtin_abs` | `@llvm.abs.i16(i16 %x, i1 true)` | `abs` |
| `abs` | `short` | 2 | `short2 abs(short2 x)` | `__builtin_abs` | `@llvm.abs.v2i16(<2 x i16> %x, i1 true)`| `abs` |
| `abs` | `short` | 3 | `short3 abs(short3 x)` | `__builtin_abs` | `@llvm.abs.v3i16(<3 x i16> %x, i1 true)`| `abs` |
| `abs` | `short` | 4 | `short4 abs(short4 x)` | `__builtin_abs` | `@llvm.abs.v4i16(<4 x i16> %x, i1 true)`| `abs` |
| `abs` | `short` | 8 | `short8 abs(short8 x)` | `__builtin_abs` | `@llvm.abs.v8i16(<8 x i16> %x, i1 true)`| `abs` |
| `abs` | `short` | 16 | `short16 abs(short16 x)` | `__builtin_abs` | `@llvm.abs.v16i16(<16 x i16> %x, i1 true)`| `abs` |
| `abs` | `int` | Scalar | `int abs(int x)` | `__builtin_abs` | `@llvm.abs.i32(i32 %x, i1 true)` | `abs` |
| `abs` | `int` | 2 | `int2 abs(int2 x)` | `__builtin_abs` | `@llvm.abs.v2i32(<2 x i32> %x, i1 true)`| `abs` |
| `abs` | `int` | 3 | `int3 abs(int3 x)` | `__builtin_abs` | `@llvm.abs.v3i32(<3 x i32> %x, i1 true)`| `abs` |
| `abs` | `int` | 4 | `int4 abs(int4 x)` | `__builtin_abs` | `@llvm.abs.v4i32(<4 x i32> %x, i1 true)`| `abs` |
| `abs` | `int` | 8 | `int8 abs(int8 x)` | `__builtin_abs` | `@llvm.abs.v8i32(<8 x i32> %x, i1 true)`| `abs` |
| `abs` | `int` | 16 | `int16 abs(int16 x)` | `__builtin_abs` | `@llvm.abs.v16i32(<16 x i32> %x, i1 true)`| `abs` |
| `abs` | `long` | Scalar | `long abs(long x)` | `__builtin_labs` | `@llvm.abs.i64(i64 %x, i1 true)` | `abs` |
| `abs` | `long` | 2 | `long2 abs(long2 x)` | `__builtin_labs` | `@llvm.abs.v2i64(<2 x i64> %x, i1 true)`| `abs` |
| `abs` | `long` | 3 | `long3 abs(long3 x)` | `__builtin_labs` | `@llvm.abs.v3i64(<3 x i64> %x, i1 true)`| `abs` |
| `abs` | `long` | 4 | `long4 abs(long4 x)` | `__builtin_labs` | `@llvm.abs.v4i64(<4 x i64> %x, i1 true)`| `abs` |
| `abs` | `long` | 8 | `long8 abs(long8 x)` | `__builtin_labs` | `@llvm.abs.v8i64(<8 x i64> %x, i1 true)`| `abs` |
| `abs` | `long` | 16 | `long16 abs(long16 x)` | `__builtin_labs` | `@llvm.abs.v16i64(<16 x i64> %x, i1 true)`| `abs` |
| `clz` | `uint` | Scalar | `uint clz(uint x)` | `__builtin_clz` | `@llvm.ctlz.i32(i32 %x, i1 true)` | `clz` |
| `clz` | `uint` | 2 | `uint2 clz(uint2 x)` | `__builtin_clz` | `@llvm.ctlz.v2i32(<2 x i32> %x, i1 true)`| `clz` |
| `clz` | `uint` | 3 | `uint3 clz(uint3 x)` | `__builtin_clz` | `@llvm.ctlz.v3i32(<3 x i32> %x, i1 true)`| `clz` |
| `clz` | `uint` | 4 | `uint4 clz(uint4 x)` | `__builtin_clz` | `@llvm.ctlz.v4i32(<4 x i32> %x, i1 true)`| `clz` |
| `clz` | `uint` | 8 | `uint8 clz(uint8 x)` | `__builtin_clz` | `@llvm.ctlz.v8i32(<8 x i32> %x, i1 true)`| `clz` |
| `clz` | `uint` | 16 | `uint16 clz(uint16 x)` | `__builtin_clz` | `@llvm.ctlz.v16i32(<16 x i32> %x, i1 true)`| `clz` |
| `popcount`| `uint` | Scalar | `uint popcount(uint x)` | `__builtin_popcount` | `@llvm.ctpop.i32(i32 %x)` | `popcount` |
| `popcount`| `uint` | 2 | `uint2 popcount(uint2 x)`| `__builtin_popcount` | `@llvm.ctpop.v2i32(<2 x i32> %x)`| `popcount` |
| `popcount`| `uint` | 3 | `uint3 popcount(uint3 x)`| `__builtin_popcount` | `@llvm.ctpop.v3i32(<3 x i32> %x)`| `popcount` |
| `popcount`| `uint` | 4 | `uint4 popcount(uint4 x)`| `__builtin_popcount` | `@llvm.ctpop.v4i32(<4 x i32> %x)`| `popcount` |
| `popcount`| `uint` | 8 | `uint8 popcount(uint8 x)`| `__builtin_popcount` | `@llvm.ctpop.v8i32(<8 x i32> %x)`| `popcount` |
| `popcount`| `uint` | 16 | `uint16 popcount(uint16 x)`| `__builtin_popcount` | `@llvm.ctpop.v16i32(<16 x i32> %x)`| `popcount` |
