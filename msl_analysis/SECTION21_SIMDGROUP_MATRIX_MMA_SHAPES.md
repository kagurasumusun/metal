# Section 21: SIMDgroup / Cooperative Matrix MMA Shapes and Layouts

This section specifies the matrix multiplication-accumulation (MMA) dimensions, element precisions, memory layouts, and hardware compiler structures of SIMDgroup and Cooperative Matrices in the Metal Shading Language (MSL).

---

## 1. Table 38: SIMDgroup and Cooperative Matrix MMA Configurations

The table below catalogs the supported matrix shapes, precisions, layouts, and compilation targets for SIMDgroup and Cooperative Matrix operations.

| Matrix Class | Matrix Dimensions (Columns x Rows) | Element Precision (Input, Accumulator) | Matrix Layout Constraints | LLVM IR Representation | AIR Opcode Mappings | Hardware Accelerator Target |
|:---|:---:|:---|:---|:---|:---|:---|
| `simdgroup_matrix` | `8x8` | `half` / `half` | Column-Major / Row-Major | `<64 x half>` structured load | `air.simdgroup_matrix.load` | Native GPU MMA Engine |
| `simdgroup_matrix` | `8x8` | `float` / `float` | Column-Major / Row-Major | `<64 x float>` structured load| `air.simdgroup_matrix.load` | Native GPU MMA Engine |
| `simdgroup_matrix` | `16x16` | `half` input, `float` accum | Column-Major / Row-Major | `<256 x half>` structured load| `air.simdgroup_matrix.load` | Native GPU MMA Engine |
| `cooperative_matrix`| `8x8` | `half` / `half` | Row-Major / Column-Major | `%air.coop_matrix` handle | `air.coop_matrix.load` | Dedicated MMA Engine / Neural Engine |
| `cooperative_matrix`| `16x16` | `half` input, `float` accum | Row-Major / Column-Major | `%air.coop_matrix` handle | `air.coop_matrix.load` | Dedicated MMA Engine / Neural Engine |

---

## 2. Low-Level Translation Commentary

### 2.1 SIMDgroup Matrix Layout and Register Allocations
In MSL, a `simdgroup_matrix` distributes matrix components across the threads of a SIMD group:
- For an `8x8` matrix, each of the 32 threads in a SIMD group is allocated a subset of the matrix elements (typically 2 elements per thread).
- These elements are stored in the thread's local general-purpose registers (GPRs).
- When matrix multiplication is executed (`multiply_accumulate`), the GPU uses specialized lane-swizzling hardware to perform dot-product calculations across threads in a single execution step.
- This dynamic register distribution enables high-throughput matrix multiplications, reducing memory access overhead.

### 2.2 Cooperative Matrix Hardware Traversal
Unlike SIMDgroup matrices, `cooperative_matrix` structures are optimized for large-scale neural network and tensor calculations.
- They utilize dedicated matrix multiplication-accumulation hardware blocks (MMA) integrated directly into the SoC (such as the Apple Neural Engine or GPU Tensor Cores).
- The compiler lowers cooperative matrix load, store, and multiply operations to specialized AIR intrinsics (e.g., `@air.coop_matrix.mma`), which map directly to these hardware blocks.
- This compilation model offloads heavy tensor arithmetic from the main GPU execution pipeline, significantly improving power efficiency and performance.



## Hardware Matrix Multiply Accumulate (MMA) Cores

Cooperative Matrix Multiply-Accumulate (MMA) operations accelerate deep learning workloads:
- **SIMDgroup Matrix Distribution**: Distributes matrix components across the threads of a SIMD group, utilizing lane-swizzling hardware for single-cycle dot products.
- **Cooperative Matrix Hardware**: Utilizes dedicated tensor core processors integrated into modern SoC designs, offloading heavy tensor arithmetic from the main graphics core.

## Register Allocations for SIMDgroup Matrix MMA shape

Below is the C++ interface class representing SIMDgroup matrix MMA shape:

```cpp
#ifndef __METAL_SIMDGROUP_MATRIX_H
#define __METAL_SIMDGROUP_MATRIX_H

namespace metal {

template <typename T, int C, int R>
class simdgroup_matrix {
private:
  T registers[(C * R) / 32]; // Shared register array across 32 threads

public:
  void load(device const T* ptr, uint stride) {
    // Coordinated load from memory targeting registers
  }
};

} // namespace metal

#endif
```

### LLVM Backend lowering of Cooperative MMA Matrix Load
Below is the C++ implementation required to lower cooperative matrix load operations to air-specific intrinsics:
```cpp
Value *CodeGenFunction::EmitMetalCooperativeMatrixLoad(Value *Ptr, Value *Stride) {
  Function *F = CGM.getIntrinsic(Intrinsic::air_coop_matrix_load);
  return Builder.CreateCall(F, {Ptr, Stride});
}
```
