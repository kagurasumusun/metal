# Section 27: Hardware AGX ISA Instructions Speculative Mappings

This section specifies the reconstructed, speculative mappings between Apple Intermediate Representation (AIR) opcodes and the physical AGX Instruction Set Architecture (ISA) executed by Apple Silicon GPU shader cores.

---

## 1. Table 44: Speculative AIR Opcode to AGX ISA Instruction Mappings

The table below catalogs the core AIR arithmetic, logical, and memory operations, mapping them to their speculative native AGX assembly instructions and target execution pipelines.

| AIR Opcode / Intrinsic | Speculative AGX Assembly Instruction | Native Operand Types | AGX Execution Pipeline / Core Unit | Hardware Execution Description |
|:---|:---|:---|:---|:---|
| `fadd` | `fadd` | `r0 = fadd r1, r2` | Floating-Point ALU (32-bit) | Performs single-cycle floating-point addition. |
| `fmul` | `fmul` | `r0 = fmul r1, r2` | Floating-Point ALU (32-bit) | Performs single-cycle floating-point multiplication. |
| `@air.fma` | `fma` | `r0 = fma r1, r2, r3` | Fused Multiply-Add Unit | Performs fused multiplication and addition with single rounding. |
| `add` | `add` | `r0 = add r1, r2` | Integer ALU (32-bit) | Performs single-cycle integer addition. |
| `sub` | `sub` | `r0 = sub r1, r2` | Integer ALU (32-bit) | Performs single-cycle integer subtraction. |
| `select` | `fsel` / `isel` | `r0 = fsel r1, r2, r3` | Conditional Execution Block | Branchless conditional selection based on comparison mask. |
| `@air.sin` | `fsin` | `r0 = fsin r1` | Transcendental Math Pipeline | Evaluates sine using hardware approximation lookup table. |
| `@air.cos` | `fcos` | `r0 = fcos r1` | Transcendental Math Pipeline | Evaluates cosine using hardware approximation lookup table. |
| `load` (global) | `ld_global` | `r0 = ld_global [r1]` | Load/Store Cache Bus | Fetches data from global device memory into GPRs via L1. |
| `store` (global) | `st_global` | `st_global [r1], r0` | Load/Store Cache Bus | Stores GPR data to global device memory via L1. |
| `load` (local) | `ld_local` | `r0 = ld_local [r1]` | Local SRAM Bus (LSM) | Fetches data from high-speed on-chip local SRAM. |
| `store` (local) | `st_local` | `st_local [r1], r0` | Local SRAM Bus (LSM) | Stores GPR data to high-speed on-chip local SRAM. |

---

## 2. Low-Level Translation Commentary

### 2.1 AGX ISA Execution Pipeline
Apple Silicon GPU cores utilize a unified shader core architecture designed to maximize instruction-level parallelism:
- **Unified Registers**: Integer and floating-point operations share a single, massive **General Purpose Register (GPR) file**. This design reduces register file-to-file copy operations and optimizes register allocation.
- **ALU Cores**: Each shader core contains independent integer, floating-point, and transcendental execution pipelines, allowing them to process multiple instruction classes concurrently.
- **Memory Cores**: Memory operations are handled by a dedicated Load/Store bus that manages data transfers to and from VRAM and local SRAM caches.
- This compilation and execution model ensures that lowered AGX assembly instructions run with optimal performance and minimum power overhead.



## AGX Instruction Pipeline and GPR Allocation

The compiled AIR bitcode is translated into speculative native AGX assembly instructions:
- **Unified Register Files**: Integer and floating-point operations share a single, massive GPR file, reducing register copy overhead.
- **Pipeline Optimization**: Optimizes instruction-level parallelism across independent, parallel arithmetic units.

## Speculative A64/AGX instruction Selection

Below is the speculative native AGX ISA instruction emitter implementation inside `lib/Target/AGX/AGXMCInstLower.cpp`:

```cpp
#include "llvm/MC/MCInst.h"

using namespace llvm;

void LowerAGXInstruction(const MachineInstr *MI, MCInst &OutMI) {
  OutMI.setOpcode(MI->getOpcode());
  for (unsigned i = 0, e = MI->getNumOperands(); i != e; ++i) {
    const MachineOperand &MO = MI->getOperand(i);
    // Lower MachineOperand to MCOperand
  }
}
```

### Register Class Configuration inside TableGen Registers
Below is the register target configuration specified inside `lib/Target/AGX/AGXRegisterInfo.td`:
```tablegen
class AGXReg<string n, bits<16> num> : Register<n> {
  let HWEncoding = num;
}

// Declare GPR Registers
foreach i = 0-127 in {
  def R#i : AGXReg<"r"#i, i>;
}

def GPR : RegisterClass<"AGX", [i32, f32], 32, (add (sequence "R%u", 0, 127))>;
```


## Section Implementer's Guide & Advanced Dynamic Linkage Specifications for SECTION27_AGX_ISA_OPCODES_RECONSTRUCTION

When building a production-grade clang/llvm compiler backend targeting SECTION27_AGX_ISA_OPCODES_RECONSTRUCTION:
1. **Target Triple Configuration**:
   - The compiler must configure the target machine structure (e.g., `Triple::agx`) inside `lib/Target/AGX/TargetInfo/AGXTargetInfo.cpp`.
   - Setup exact pointer and layout alignments in data layout strings: `e-m:o-p:64:64-i32:32-i64:64-f32:32-f64:64-v64:64-v128:128-a:0:64-n32:64-S128`.
   - Ensure the compiler respects hardware scheduling properties (latency, hazards, GPR read ports constraints).

2. **Advanced Semantic Analyzer Passes**:
   - Inside `clang/lib/Sema/SemaChecking.cpp`, implement validation passes that verify resource parameters, coordinate ranges, and boundary checks.
   - For example, when parsing texture coordinate vectors, check that dimensions match the target texture class (e.g., `float2` for `texture2d`).
   - If precise math is enabled, ensure that standard floating-point optimizations (such as folding `x + 0.0` or multiplying by reciprocals) are restricted to preserve IEEE-754 correctness.

3. **GPR Register Pressure & Spilling Optimization**:
   - Shaders compiled for Apple Silicon are highly register-constrained. The AGX core optimizes scheduling by allocating dynamic slots within a single GPR register file.
   - If register usage exceeds the core threshold (typically 128 registers for high occupancy, 256 for lower occupancy), LLVM must emit spill instructions to thread-local scratch space (VRAM). This results in severe memory latency.
   - To mitigate spilling, the compiler pass manager runs aggressive dead-code elimination (DCE), scalar replacement of aggregates (SROA), and live range splitting.
   - Design your custom compiler passes to run SROA early, decomposing structure allocations into registers before initiating loop optimizations.

4. **Indirect Call Branching & Dynamic Lookups**:
   - For advanced graphics operations (such as dynamic visible function dispatch or raytracing intersection functions), the compiler must support indirect branches.
   - These lookups are compiled as array indexes on Visible Function Tables (VFTs) and lowered in assembly to indirect register jumps (`jmp %reg`).
   - The JIT compiler inserts guard checks before indirect jumps to prevent out-of-bounds register loading and ensure security.

5. **L LSM Coherence and Cache Synchronization**:
   - On-chip Local Shared Memory (LSM) manages threadgroup memory allocations.
   - Maintain LSM coherence across lanes via hardware barrier instructions.
   - LLVM's instruction combiner optimizes barrier sequences, merging adjacent execution and memory barriers to minimize core stall states.
