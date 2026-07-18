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
