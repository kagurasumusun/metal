# Section 15: LLVM IR and Intrinsic to AIR Opcode Mapping Specification

This section details the transformation rules, optimization passes, and instructions mappings used by the MSL compiler to lower standard LLVM IR instructions and intrinsics into optimized Apple Intermediate Representation (AIR) opcodes and intrinsic functions.

---

## 1. LLVM IR Core Instruction lowering to AIR

The table below maps standard LLVM IR math, memory, and control flow instructions to their respective AIR representations and GPU register classes.

| LLVM IR Instruction | Operation Type | Argument Typings | Mapped AIR Instruction / Opcode | Optimization / Instruction Combining Behavior |
|:---|:---|:---|:---|:---|
| `fadd` | Floating-point Add | `half`, `float`, vectors | `fadd` | Fused with subsequent multiplications into single FMA instructions. |
| `fsub` | Floating-point Subtract | `half`, `float`, vectors | `fsub` | Fused with subsequent multiplications into single FMA instructions. |
| `fmul` | Floating-point Multiply | `half`, `float`, vectors | `fmul` | Fused with subsequent additions into single FMA instructions. |
| `fdiv` | Floating-point Divide | `half`, `float`, vectors | `fdiv` / reciprocal sequence | Transformed to reciprocal multiplications under fast math. |
| `frem` | Floating-point Remainder | `half`, `float` | `air.fmod` | Lowered to custom hardware-accelerated mod calculations. |
| `add` | Integer Add | `i8`, `i16`, `i32`, `i64` | `add` | Lowered to saturating hardware additions under specific flags. |
| `sub` | Integer Subtract | `i8`, `i16`, `i32`, `i64` | `sub` | Lowered to saturating hardware subtractions under specific flags. |
| `mul` | Integer Multiply | `i8`, `i16`, `i32`, `i64` | `mul` | Lowered to 32-bit integer multiplication instructions. |
| `sdiv` / `udiv` | Signed / Unsigned Integer Divide| `i32`, `i64` | `sdiv` / `udiv` | Optimized to shift operations for power-of-two denominators. |
| `shl` / `lshr` / `ashr`| Bitwise Shifts | `i8`, `i16`, `i32`, `i64` | `shl` / `lshr` / `ashr` | Direct ALU hardware shifts. |
| `and` / `or` / `xor` | Bitwise Logical Operations | `i8`, `i16`, `i32`, `i64` | `and` / `or` / `xor` | Direct ALU bitwise logic. |
| `load` | Memory Load | Pointers | `load` | Lowered with address space qualifiers to target specific caches. |
| `store` | Memory Store | Pointers | `store` | Lowered with address space qualifiers to target specific caches. |
| `select` | Conditional Selection | Condition, Values | `select` | Compiles to branchless conditional write instructions in hardware. |

---

## 2. LLVM Intrinsic to AIR Intrinsic Mapping Matrix

The table below provides the complete mapping between standard LLVM math, bitwise, and atomic intrinsics and their respective AIR-specific intrinsics.

| LLVM Intrinsic Name | MSL Source Equivalent | LLVM Type Signature | AIR Intrinsic Name | Hardware Block / Execution Target |
|:---|:---|:---|:---|:---|
| `@llvm.sin.f32` | `sin` | `(float)` | `@air.sin.f32` | Dedicated Hardware Transcendental Unit |
| `@llvm.cos.f32` | `cos` | `(float)` | `@air.cos.f32` | Dedicated Hardware Transcendental Unit |
| `@llvm.tan.f32` | `tan` | `(float)` | `@air.tan.f32` | Dedicated Hardware Transcendental Unit |
| `@llvm.exp.f32` | `exp` | `(float)` | `@air.exp.f32` | Dedicated Hardware Transcendental Unit |
| `@llvm.log.f32` | `log` | `(float)` | `@air.log.f32` | Dedicated Hardware Transcendental Unit |
| `@llvm.pow.f32` | `pow` | `(float, float)` | `@air.pow.f32` | Dedicated Hardware Transcendental Unit |
| `@llvm.sqrt.f32` | `sqrt` | `(float)` | `@air.sqrt.f32` | Dedicated Hardware Transcendental Unit |
| `@llvm.rsqrt.f32` | `rsqrt` | `(float)` | `@air.rsqrt.f32` | Dedicated Hardware Transcendental Unit |
| `@llvm.floor.f32` | `floor` | `(float)` | `@air.floor.f32` | Floating-Point ALU |
| `@llvm.ceil.f32` | `ceil` | `(float)` | `@air.ceil.f32` | Floating-Point ALU |
| `@llvm.round.f32` | `round` | `(float)` | `@air.round.f32` | Floating-Point ALU |
| `@llvm.trunc.f32` | `trunc` | `(float)` | `@air.trunc.f32` | Floating-Point ALU |
| `@llvm.fma.f32` | `fma` | `(float, float, float)`| `@air.fma.f32` | Native Hardware Fused Multiply-Add Unit |
| `@llvm.copysign.f32` | `copysign` | `(float, float)` | `@air.copysign.f32` | Floating-Point ALU |
| `@llvm.fabs.f32` | `abs` | `(float)` | `@air.fabs.f32` | Floating-Point ALU |
| `@llvm.fmin.f32` | `min` | `(float, float)` | `@air.fmin.f32` | Floating-Point ALU |
| `@llvm.fmax.f32` | `max` | `(float, float)` | `@air.fmax.f32` | Floating-Point ALU |
| `@llvm.ctlz.i32` | `clz` | `(i32, i1)` | `@air.ctlz.i32` | Bitwise ALU |
| `@llvm.cttz.i32` | `ctz` | `(i32, i1)` | `@air.cttz.i32` | Bitwise ALU |
| `@llvm.ctpop.i32` | `popcount` | `(i32)` | `@air.ctpop.i32` | Bitwise ALU |
| `@llvm.bitreverse.i32`| `reverse_bits` | `(i32)` | `@air.bitreverse.i32`| Bitwise ALU |

---

## 3. Deep-Dive Compilation & Lowering Analysis

### 3.1 LLVM Optimizations and Vector Instruction Combining
The Clang-LLVM compiler backend optimized for Apple Silicon applies several specialized optimization passes before lowering the intermediate representation to AIR:

1. **SROA (Scalar Replacement of Aggregates)**:
   - Breaks down structures, arrays, and vector arguments into individual scalar variables.
   - This allows them to be allocated directly to registers, bypassing expensive memory allocations and stack spills.

2. **Vector Instruction Combining**:
   - Compiles scalar operations targeting adjacent indices (such as vector elements `.x` and `.y`) into single vector instructions (e.g., `<2 x float>`, `<4 x float>`).
   - This enables the JIT compiler to target the GPU's native SIMD execution pipelines, which significantly improves instruction throughput and execution efficiency.

3. **Loop Vectorization**:
   - Identifies loops with independent iterations and vectorizes them, allowing multiple iterations to be executed in parallel on the GPU's vector ALUs.

### 3.2 Lowering to Address-Space Specific Load/Store Opcodes
When pointers are loaded or stored, the compiler checks their LLVM Address Space qualifiers and selects specialized AIR memory instructions:
- Pointers qualified with `device` (Address Space `1`) are lowered to `load global` or `store global` instructions. These instructions target the GPU's L1 read-write cache and global memory pipelines.
- Pointers qualified with `threadgroup` (Address Space `3`) are lowered to local memory access instructions. These instructions target the GPU's high-speed, on-chip Local Shared Memory (LSM) blocks, bypassing global memory transactions and improving bandwidth.
- Pointers qualified with `constant` (Address Space `2`) are lowered to read-only constant fetch instructions. These instructions target the GPU's specialized Constant Cache, which optimizes read operations and reduces memory latency.
- By checking address space qualifiers during compilation, the compiler ensures that memory operations are routed to the most efficient hardware memory caches.



## Instruction Combining Passes in LLVM Backend

The LLVM backend applies aggressive scalar replacement of aggregates (SROA) to optimize register allocation:
- **SROA Pass**: Deconstructs structures and arrays into individual scalar variables, allocating them directly to GPR registers.
- **Register Spilling**: Forces variables to thread-local scratch space (VRAM) if live registers exceed the physical file size, which the compiler minimizes by optimizing structure nesting.
- **Instruction Combine**: Collapses consecutive arithmetic operations into single FMA instructions.
