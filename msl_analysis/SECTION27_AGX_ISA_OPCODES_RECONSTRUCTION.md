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
