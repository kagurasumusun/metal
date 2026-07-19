# Section 4: Memory Address Spaces, Caching, and Synchronization

This section specifies the memory hierarchy, address space models, caching structures, barrier execution layers, and memory fence semantics of the Metal Shading Language (MSL) compiled for Apple Silicon GPUs.

---

## 1. Memory Space & Scope Lifetime Correspondence Matrix

The table below maps the high-level MSL memory address space qualifiers down to compiler representations, hardware cache behaviors, and lifecycle attributes.

| MSL Qualifier | Clang Attribute | LLVM IR Address Space | AIR Memory Semantics | Hardware Cache Level Targeting | Lifetime Scope & Hardware Storage |
|:---|:---|:---:|:---|:---|:---|
| `device` | `__attribute__((address_space(1)))` | `addrspace(1)` | `global` | L1 Read/Write cache, backed by GPU L2 and physical Unified Memory. | Kernel/shader execution lifetime. Global Device VRAM. |
| `threadgroup`| `__attribute__((address_space(3)))` | `addrspace(3)` | `local` | Direct on-chip high-speed Local SRAM (SRAM block per Unified Shader Core). Bypass L2. | Lifetime of the executing threadgroup. Erased upon completion of threadgroup work. |
| `thread` | `__attribute__((address_space(0)))` | `addrspace(0)` | `private` | On-chip Register File (GPRs). Local thread stack frame in VRAM if registers spill. | Single thread lifetime. Thread-local registers. |
| `constant` | `__attribute__((address_space(2)))` | `addrspace(2)` | `constant` | Read-only constant cache (Uniform Cache). L1 Const Cache. | Kernel/shader execution lifetime. Global Device VRAM with read-only optimization. |
| `threadgroup_imageblock` | `__attribute__((address_space(8)))` | `addrspace(8)` | `tile` | Directly mapped to on-chip Tile Memory SRAM (within Rasterizer/Render Pipeline). | Lifetime of the render tile pipeline. Directly on-chip. |

---

## 2. Synchronization & Barrier APIs Mapping Matrix

Metal supports rigorous synchronization builtins to coordinate execution among threads within a simdgroup or threadgroup. The table below outlines how these synchronization barriers map to compilers, intermediate representations, and native execution fences.

| MSL API | API Arguments (`mem_flags`) | Clang Builtin | LLVM Intrinsic / Instruction | AIR Opcode | Hardware Execution Fence Level |
|:---|:---|:---|:---|:---|:---|
| `threadgroup_barrier` | `mem_flags::mem_none` | `__builtin_msl_barrier` | `call void @llvm.membar.none()` | `air.barrier.none` | Synchronizes execution only (Execution barrier). No memory flush. |
| `threadgroup_barrier` | `mem_flags::mem_device` | `__builtin_msl_barrier_dev`| `call void @llvm.membar.device()`| `air.barrier.device` | Flushes dirty L1 device writes to L2. Ensures device writes are visible to subsequent threads. |
| `threadgroup_barrier` | `mem_flags::mem_threadgroup` | `__builtin_msl_barrier_tg` | `call void @llvm.membar.tg()` | `air.barrier.threadgroup`| Synchronizes memory access within Local SRAM (On-chip memory fence). |
| `threadgroup_barrier` | `mem_flags::mem_threadgroup_imageblock` | `__builtin_msl_barrier_ib` | `call void @llvm.membar.ib()` | `air.barrier.imageblock` | Flushes on-chip tile memory imageblocks for subsequent subpass reads. |
| `simdgroup_barrier` | `mem_flags::mem_none` | `__builtin_msl_simd_barrier_none`| `call void @llvm.simdbar.none()`| `air.simdgroup_barrier.none`| Execution barrier across a single SIMD Lane (32 threads). Registers synced. |
| `simdgroup_barrier` | `mem_flags::mem_threadgroup` | `__builtin_msl_simd_barrier_tg`| `call void @llvm.simdbar.tg()`| `air.simdgroup_barrier.threadgroup`| Simdgroup execution fence with local threadgroup memory visibility. |
| `simdgroup_barrier` | `mem_flags::mem_device` | `__builtin_msl_simd_barrier_dev`| `call void @llvm.simdbar.device()`| `air.simdgroup_barrier.device`| Simdgroup execution fence with global device memory visibility. |



## Cache Line Synchronization and LSM Coherency

Apple Silicon GPUs utilize on-chip Local Shared Memory (LSM) to back the high-speed `threadgroup` address space. Coherency across execution lanes is maintained via hardware barriers and memory fences:
- **L1 Read/Write Caches**: Private to each GPU core. Thread-local variables and active GPR registers bypass L2 to target L1 directly.
- **LSM Blocks**: High-speed, low-latency SRAM shared among execution lanes in a threadgroup.
- **Memory Fences**: Prevent the compiler and hardware from reordering memory operations across the fence boundary, ensuring consistent memory states before threads resume execution.

### Barrier Optimization Passes
During optimization, LLVM combines consecutive barrier operations targeting the same scope (e.g., combining two `threadgroup_barrier` calls) to minimize pipeline stall states and maximize execution throughput.

## LLVM IR Code Generation for Synchronization Barriers and LSM

Below is the C++ source code required to lower MSL `threadgroup_barrier` calls to LLVM IR inside Clang's CodeGen:

```cpp
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Intrinsics.h"

using namespace llvm;

Value *CodeGenFunction::EmitMetalBarrier(unsigned MemFlags) {
  // Map mem_flags to target scopes
  Intrinsic::ID IntrinID;
  if (MemFlags == 1) { // mem_device
    IntrinID = Intrinsic::air_barrier_device;
  } else if (MemFlags == 2) { // mem_threadgroup
    IntrinID = Intrinsic::air_barrier_threadgroup;
  } else {
    IntrinID = Intrinsic::air_barrier_none;
  }

  Function *F = CGM.getIntrinsic(IntrinID);
  return Builder.CreateCall(F);
}
```

### TableGen Instruction Selection and Memory Fences
During backend instruction selection, memory fences are lowered to hardware execution barriers inside `lib/Target/AGX/AGXISelLowering.cpp`:
```cpp
SDValue AGXTargetLowering::LowerMemFence(SDValue Op, SelectionDAG &DAG) const {
  SDLoc dl(Op);
  // Emit native memory fence instruction on AGX
  return DAG.getNode(AGXISD::MEM_FENCE, dl, MVT::Other, Op.getOperand(0));
}
```
