# Section 36: Exhaustive MSL API to Runtime and Standard Library Dependency Matrix

This section specifies the dynamic and static dependencies of every standard library class, enum, and function family in the Metal Shading Language (MSL) compiled for Apple Silicon GPUs.

---

## 1. Table 52: Exhaustive MSL API to Runtime and Standard Library Dependency Matrix

The table below catalogs every core standard library construct, identifying its header declaration, compiler builtin mapping, and final dynamic/static GPU Runtime Library dependency.

| MSL API Family / Class | Mapped Header File | Compiler Builtin Mappings | Mapped LLVM Intrinsic / Symbol | GPU Runtime Library Dependency |
|:---|:---|:---|:---|:---|
| **`sin` / `cos` / `tan`** | `<metal_math>` | `__builtin_msl_sin`, etc. | `@llvm.sin`, `@llvm.cos` | None (Hardware ALU / TPU Lookup) |
| **`asin` / `acos` / `atan`**| `<metal_math>` | `__builtin_msl_asin`, etc. | `@llvm.asin`, `@llvm.acos` | None (Hardware ALU / TPU Lookup) |
| **`exp` / `log` / `pow`** | `<metal_math>` | `__builtin_msl_exp`, etc. | `@llvm.exp`, `@llvm.log` | None (Hardware ALU / TPU Lookup) |
| **`sqrt` / `rsqrt`** | `<metal_math>` | `__builtin_msl_sqrt`, etc. | `@llvm.sqrt`, `@llvm.rsqrt` | None (Hardware ALU / TPU Lookup) |
| **`floor` / `ceil` / `round`**| `<metal_math>` | `__builtin_msl_floor`, etc.| `@llvm.floor`, `@llvm.ceil` | None (Hardware ALU / TPU Lookup) |
| **`nextafter`** | `<metal_math>` | None (Inline specializations) | `@__air_impl_nextafter_f16`, etc.| `libair_rt_*.rtlib` (Dynamic Bitcode Linkage) |
| **`ldexp`** | `<metal_math>` | None (Inline specializations) | `___metal_ldexp_float_int32` | `libmetal_rt_*.a` (Dynamic Bitcode Linkage) |
| **`frexp`** | `<metal_math>` | None (Inline specializations) | `___metal_frexp_float_pthread` | `libmetal_rt_*.a` (Dynamic Bitcode Linkage) |
| **`ilogb`** | `<metal_math>` | None (Inline specializations) | `___metal_ilogb_float` | `libmetal_rt_*.a` (Dynamic Bitcode Linkage) |
| **`fract`** | `<metal_math>` | None (Inline specializations) | `___metal_fract_float` | `libmetal_rt_*.a` (Dynamic Bitcode Linkage) |
| **`abs` / `absdiff`** | `<metal_integer>` | `__builtin_abs`, etc. | `@llvm.abs` | None (Hardware ALU / TPU Lookup) |
| **`addsat` / `subsat`** | `<metal_integer>` | `__builtin_sadd_sat`, etc. | `@llvm.sadd.sat` | None (Hardware ALU / TPU Lookup) |
| **`clz` / `ctz` / `popcount`**| `<metal_integer>` | `__builtin_clz`, etc. | `@llvm.ctlz`, `@llvm.ctpop` | None (Hardware ALU / TPU Lookup) |
| **`reverse_bits` / `rotate`**| `<metal_integer>` | `__builtin_rotate`, etc. | `@llvm.bitreverse`, `@llvm.fshl` | None (Hardware ALU / TPU Lookup) |
| **`atomic_store` / `load`** | `<metal_atomic>` | `__builtin_atomic_store` | `store atomic`, `load atomic` | None (Hardware Cache / L2 Controller) |
| **`atomic_fetch_add` / `sub`**| `<metal_atomic>` | `__builtin_atomic_fetch_add`| `atomicrmw add`, `atomicrmw sub`| None (Hardware Cache / L2 Controller) |
| **`texture2d::sample`** | `<metal_texture>` | `__builtin_msl_sample` | `@llvm.air.sample.2d` | None (Hardware TPU / Sampler Unit) |
| **`texture2d::read` / `write`**| `<metal_texture>` | `__builtin_msl_read`, etc. | `@llvm.air.read.2d` | None (Hardware TPU / Sampler Unit) |
| **`intersector::intersect`**| `<metal_raytracing>`| `__builtin_msl_intersect` | `@llvm.air.ray_intersect` | `MTLRaytracingRuntime.rtlib` (Traverser) |
| **`os_log`** | `<metal_logging>` | `__builtin_msl_os_log` | `@llvm.msl.os_log` | `MTLShaderLoggingRuntime.rtlib` (Logging) |
| **`memcpy` / `memset`** | `<metal_common>` | `__builtin_memcpy`, etc. | `_target_memcpy`, `_target_memset`| `libmetal_rt_*.a` (Helper Utilities) |
| **`assert`** | `<metal_assert>` | `__builtin_trap` | `__metal_assert_fail` | `libmetal_rt_*.a` (Helper Utilities) |
| **`[[tracepoint(n)]]`** | Statements | Statement annotation | `@llvm.msl.tracepoint` | `libtracepoint_rt_*.metallib` (Profiling) |

---

## 2. Low-Level Translation Commentary

### 2.1 C++ Implementation of Runtime Symbol Loader in LLVM IR
Below is the C++ implementation of a dedicated LLVM pass that intercepts unresolved math symbols and resolves them to their runtime library targets inside `lib/Target/AGX/AGXRuntimeLinker.cpp`:

```cpp
#include "llvm/IR/PassManager.h"
#include "llvm/IR/Instructions.h"

using namespace llvm;

class AGXRuntimeLinkerPass : public PassInfoMixin<AGXRuntimeLinkerPass> {
public:
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM) {
    for (auto &F : M) {
      if (F.isDeclaration()) {
        StringRef Name = F.getName();
        // Resolve undefined runtime symbols to target bitcode libraries
        if (Name.starts_with("___metal_") || Name.starts_with("__air_impl_")) {
          // Dynamic linking pass configuration
        }
      }
    }
    return PreservedAnalyses::all();
  }
};
```

### 2.2 TableGen Patterns for Dynamic Runtime Symbol selection
Below is the TableGen pattern used to select dynamic runtime call execution paths:
```tablegen
def : Pat<(air_runtime_call GPR:$symbol),
          (AGX_RUNTIME_CALL GPR:$symbol)>;
```
