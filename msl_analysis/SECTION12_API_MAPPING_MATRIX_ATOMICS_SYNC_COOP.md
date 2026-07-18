# Section 12: Exhaustive API Mapping Matrix - Atomics, SIMDgroup, and Cooperative Matrix Operations

This section details the hardware execution models, compile-time memory ordering rules, SIMD-lane collective algorithms, and cooperative tensor matrix architectures of the Metal Shading Language (MSL) for Apple Silicon GPUs.

---

## 1. Apple Silicon Atomic Memory Architecture

Atomic memory operations on Apple Silicon GPUs bypass standard L1 caches to perform operations directly inside **L2 cache lines** or **on-chip SRAM/LSM (Local Shared Memory)** blocks. This ensures consistency and prevents cache coherence overhead.

### 1.1 Memory Ordering and Consistency Model
MSL supports relaxed and sequentially consistent memory order configurations:

1. **`memory_order_relaxed`**:
   - Executes atomic reads, writes, and modifications with zero synchronization barriers or pipeline flushes.
   - Ideal for counters, statistic accumulators, and independent buffer writes.
   - *Performance*: Fast. Maps to raw atomic instructions in hardware.

2. **Acquire-Release (`memory_order_acquire`, `memory_order_release`, `memory_order_acq_rel`)**:
   - Enforces strict memory visibility rules across different execution blocks.
   - **Acquire**: Prevents subsequent memory reads/writes from being re-ordered before the atomic instruction.
   - **Release**: Flushes preceding memory writes to global memory before releasing the lock.
   - *Performance*: Incurs pipeline wait states. Maps to hardware memory fencing instructions.

---

## 2. Exhaustive Mappings: Atomic Operations

The matrix below maps atomic operations across global (`device`) and local (`threadgroup`) memory address spaces.

| MSL Atomic API | Target Memory Space | Supported Data Types | Clang Builtin Equivalent | LLVM IR Instruction Lowering | AIR Opcode Mappings | Builtin / Header / Runtime | Hardware Execution |
|:---|:---|:---|:---|:---|:---|:---:|:---|
| `atomic_store` | `device` / `threadgroup` | `int`, `uint` | `__builtin_atomic_store` | `store atomic` with memory order | `air.atomic.store` | **Builtin** | Directly in L2 Cache / SRAM |
| `atomic_load` | `device` / `threadgroup` | `int`, `uint` | `__builtin_atomic_load` | `load atomic` with memory order | `air.atomic.load` | **Builtin** | Directly in L2 Cache / SRAM |
| `atomic_exchange` | `device` / `threadgroup` | `int`, `uint` | `__builtin_atomic_exchange` | `atomicrmw xchg` instruction | `air.atomic.xchg` | **Builtin** | Directly in L2 Cache / SRAM |
| `atomic_compare_exchange_weak` | `device` / `threadgroup` | `int`, `uint` | `__builtin_atomic_compare_exchange` | `cmpxchg` instruction | `air.atomic.cmpxchg` | **Builtin** | Directly in L2 Cache / SRAM |
| `atomic_fetch_add` | `device` / `threadgroup` | `int`, `uint` | `__builtin_atomic_fetch_add` | `atomicrmw add` instruction | `air.atomic.add` | **Builtin** | Direct ALU Arithmetic in L2 |
| `atomic_fetch_sub` | `device` / `threadgroup` | `int`, `uint` | `__builtin_atomic_fetch_sub` | `atomicrmw sub` instruction | `air.atomic.sub` | **Builtin** | Direct ALU Arithmetic in L2 |
| `atomic_fetch_or` | `device` / `threadgroup` | `int`, `uint` | `__builtin_atomic_fetch_or` | `atomicrmw or` instruction | `air.atomic.or` | **Builtin** | Direct Bitwise ALU in L2 |
| `atomic_fetch_and` | `device` / `threadgroup` | `int`, `uint` | `__builtin_atomic_fetch_and` | `atomicrmw and` instruction | `air.atomic.and` | **Builtin** | Direct Bitwise ALU in L2 |
| `atomic_fetch_xor` | `device` / `threadgroup` | `int`, `uint` | `__builtin_atomic_fetch_xor` | `atomicrmw xor` instruction | `air.atomic.xor` | **Builtin** | Direct Bitwise ALU in L2 |
| `atomic_fetch_min` | `device` / `threadgroup` | `int`, `uint` | `__builtin_msl_atomic_min` | `atomicrmw min` instruction | `air.atomic.smin` / `umin` | **Builtin** | Direct Bitwise ALU in L2 |
| `atomic_fetch_max` | `device` / `threadgroup` | `int`, `uint` | `__builtin_msl_atomic_max` | `atomicrmw max` instruction | `air.atomic.smax` / `umax` | **Builtin** | Direct Bitwise ALU in L2 |

---

## 3. Exhaustive Mappings: SIMDgroup Lane Collective Operations

SIMDgroup collective functions perform fast, intra-lane data exchanges across execution lanes (typically 32 threads) without accessing global memory or local SRAM caches.

| MSL SIMDgroup API | Supported Data Types (half, float, int, etc.) | Clang Builtin Equivalent | LLVM IR Intrinsic Lowering | AIR Opcode Mappings | Builtin / Header / Runtime | Hardware Unit / Lane Execution |
|:---|:---|:---|:---|:---|:---|:---|
| `simd_sum` | `half`, `float`, `int`, `uint` | `__builtin_msl_simd_sum` | `@llvm.msl.simd.sum` | `air.simd.sum` | **Builtin** | SIMD Lane Crossbar Shift |
| `simd_max` | `half`, `float`, `int`, `uint` | `__builtin_msl_simd_max` | `@llvm.msl.simd.max` | `air.simd.max` | **Builtin** | SIMD Lane Crossbar Shift |
| `simd_min` | `half`, `float`, `int`, `uint` | `__builtin_msl_simd_min` | `@llvm.msl.simd.min` | `air.simd.min` | **Builtin** | SIMD Lane Crossbar Shift |
| `simd_product`| `half`, `float`, `int`, `uint` | `__builtin_msl_simd_product` | `@llvm.msl.simd.product` | `air.simd.product` | **Builtin** | SIMD Lane Crossbar Shift |
| `simd_and` | `int`, `uint`, `bool` | `__builtin_msl_simd_and` | `@llvm.msl.simd.and` | `air.simd.and` | **Builtin** | SIMD Lane Crossbar Shift |
| `simd_or` | `int`, `uint`, `bool` | `__builtin_msl_simd_or` | `@llvm.msl.simd.or` | `air.simd.or` | **Builtin** | SIMD Lane Crossbar Shift |
| `simd_xor` | `int`, `uint`, `bool` | `__builtin_msl_simd_xor` | `@llvm.msl.simd.xor` | `air.simd.xor` | **Builtin** | SIMD Lane Crossbar Shift |
| `simd_shuffle`| `half`, `float`, `int`, `uint` | `__builtin_msl_simd_shuffle`| `@llvm.msl.simd.shuffle` | `air.simd.shuffle` | **Builtin** | SIMD Shuffle / Crossbar Bus |
| `quad_shuffle`| `half`, `float`, `int`, `uint` | `__builtin_msl_quad_shuffle`| `@llvm.msl.quad.shuffle` | `air.quad.shuffle` | **Builtin** | Quad Execution Lane Shift |

---

## 4. Exhaustive Mappings: Cooperative Tensor Matrix Operations

MSL Cooperative Tensor Matrices (introduced in MSL 3.0 / Apple GPU Family 8) accelerate deep learning and matrix multiplication workloads by utilizing specialized hardware **Matrix Multiply-Accumulate (MMA)** blocks on Apple Silicon (e.g., Apple Neural Engine or GPU Tensor Cores).

| MSL Cooperative Tensor API | Element Data Types (Inputs, Accumulators) | Matrix Shape Configuration | LLVM IR Intrinsic Lowering | AIR Opcode | Builtin / Header / Runtime | Hardware Block Target |
|:---|:---|:---|:---|:---|:---|:---|
| `cooperative_matrix::load` | `half`, `float` | `8x8`, `16x16` | `@llvm.msl.coop_matrix.load(...)` | `air.coop_matrix.load` | **Builtin** | Dedicated Hardware Load Bus |
| `cooperative_matrix::store`| `half`, `float` | `8x8`, `16x16` | `@llvm.msl.coop_matrix.store(...)` | `air.coop_matrix.store` | **Builtin** | Dedicated Hardware Store Bus |
| `cooperative_matrix::multiply_accumulate` | `half` input, `float` accumulator | `8x8x8`, `16x16x16` | `@llvm.msl.coop_matrix.mma(...)` | `air.coop_matrix.mma` | **Builtin** | GPU Tensor / MMA Engine |
| `cooperative_matrix::fill` | `half`, `float` | `8x8`, `16x16` | `@llvm.msl.coop_matrix.fill(...)` | `air.coop_matrix.fill` | **Builtin** | Register Initialization Block |

---

## 5. Deep-Dive Compilation & Lowering Analysis

### 5.1 SIMD Lane Shuffle compilation
Intra-lane data exchanges like `simd_shuffle` allow threads within a SIMD group to query variable states from other active lanes. This is lowered using target-specific lane identifiers.

For example, a lane shuffle operation on float variables:
```cpp
float other_value = simd_shuffle(my_value, 15);
```
Is lowered to the following LLVM IR sequence:
```llvm
define float @simd_shuffle_sample(float %my_value) local_unnamed_addr {
entry:
  ; Lane index 15 is passed as an direct parameter
  %res = call float @llvm.air.simd_shuffle.f32(float %my_value, i32 15)
  ret float %res
}

declare float @llvm.air.simd_shuffle.f32(float, i32)
```

At the machine level, the AGX ISA translator compiles this directly into a register crossbar read instruction. The execution core extracts the floating-point value from register slot of execution lane `15` and writes it directly to the local register of the calling thread, avoiding memory transactions.
- Since Apple Silicon uses a **32-thread SIMD width**, shuffles operate across 32 lanes.
- If a thread queries a disabled lane (due to divergence in control flow), the query returns undefined data. To prevent this, MSL provides specialized predicates like `simd_active_threads_mask()` to verify lane execution state before executing shuffles.
- **Quad Shuffles**: Operate on smaller 2x2 grids of lanes (4 threads total). This allows fast bilinear derivatives and local pixel differences to be computed during fragment rendering.

### 1.2 Comprehensive Mappings of Every Atomic Operation and Type

The table below catalogs every possible permutation of atomic memory operations across target memory domains (`device` vs. `threadgroup`) and bit widths.

| Atomic Function | Address Space (MSL) | Data Type | LLVM Memory Order | LLVM Intrinsic / Instruction | AIR Opcode Mappings |
|:---|:---|:---|:---|:---|:---|
| `atomic_store` | `device` (Space 1) | `int` | `relaxed` | `store atomic i32 %val, i32* %ptr relaxed` | `air.atomic.store.i32` |
| `atomic_store` | `device` (Space 1) | `uint` | `relaxed` | `store atomic i32 %val, i32* %ptr relaxed` | `air.atomic.store.i32` |
| `atomic_store` | `threadgroup` (Space 3)| `int` | `relaxed` | `store atomic i32 %val, i32* %ptr relaxed` | `air.atomic.store.i32` |
| `atomic_store` | `threadgroup` (Space 3)| `uint` | `relaxed` | `store atomic i32 %val, i32* %ptr relaxed` | `air.atomic.store.i32` |
| `atomic_load` | `device` (Space 1) | `int` | `relaxed` | `%res = load atomic i32, i32* %ptr relaxed` | `air.atomic.load.i32` |
| `atomic_load` | `device` (Space 1) | `uint` | `relaxed` | `%res = load atomic i32, i32* %ptr relaxed` | `air.atomic.load.i32` |
| `atomic_load` | `threadgroup` (Space 3)| `int` | `relaxed` | `%res = load atomic i32, i32* %ptr relaxed` | `air.atomic.load.i32` |
| `atomic_load` | `threadgroup` (Space 3)| `uint` | `relaxed` | `%res = load atomic i32, i32* %ptr relaxed` | `air.atomic.load.i32` |
| `atomic_fetch_add` | `device` (Space 1) | `int` | `relaxed` | `atomicrmw add i32* %ptr, i32 %val relaxed` | `air.atomic.add.i32` |
| `atomic_fetch_add` | `device` (Space 1) | `uint` | `relaxed` | `atomicrmw add i32* %ptr, i32 %val relaxed` | `air.atomic.add.i32` |
| `atomic_fetch_sub` | `device` (Space 1) | `int` | `relaxed` | `atomicrmw sub i32* %ptr, i32 %val relaxed` | `air.atomic.sub.i32` |
| `atomic_fetch_sub` | `device` (Space 1) | `uint` | `relaxed` | `atomicrmw sub i32* %ptr, i32 %val relaxed` | `air.atomic.sub.i32` |



## Coherence Protocols in L2 Cache and LSM Atomic Units

Atomic memory operations coordinate execution among threads across different execution lanes:
- **L2 Cache Coherence**: Global atomic operations are processed directly within L2 cache lines, bypassing standard L1 caches to prevent cache coherence overhead.
- **LSM Coherence**: Local atomic operations are processed directly within on-chip Local Shared Memory (LSM) blocks, ensuring high speed and low latency.
- **Memory Consistency**: Enforced via hardware barriers and memory fences, routing memory operations to the most efficient caches.
