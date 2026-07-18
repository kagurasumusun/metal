# Section 17: Diagnostics, Debugging, Logging, and Profiling Specification

This section specifies the compiler diagnostics, warning suppression flags, shader-side logging engines, assertions trapping, resource tracking frameworks, and profiling trace points of the Metal Shading Language (MSL).

---

## 1. Compiler Diagnostics and Warning Control Flags

The MSL compiler (based on Clang) supports a comprehensive set of diagnostics to help developers find and resolve issues. It supports standard C++ compilation warnings alongside specific MSL validation checks.

### 1.1 MSL-Specific Warning Controls
- **`-Wmetal-compiler-options`**: Validates whether target compiler options are compatible with the specified MSL language version.
- **`-Wunused-variable` / `-Wunused-function`**: Standard C++ checks. Highlights unused declarations that can be removed to optimize register allocation.
- **`-Waddress-space`**: Validates pointer casts between mismatching address spaces (e.g., casting a `device` pointer to a `thread` pointer), which can cause memory access violations.

---

## 2. Exhaustive Mappings: Logging and Assertion APIs

The matrix below maps shader-side debugging and logging APIs to compiler builtins, LLVM IR, and AIR intrinsics.

| MSL Debugging API | Argument Typings and Formats | Clang AST Node | LLVM IR Intrinsic Lowering | AIR Opcode | GPU Runtime Dependency |
|:---|:---|:---|:---|:---|:---|
| `assert` | `(bool condition)` | `ConditionalOperator` / check branch | `@llvm.trap` / `@__metal_assert_fail` | `trap` / custom write | `libmetal_rt_*.a` |
| `os_log` | `(os_log_t log, const char* format, ...)` | `CallExpr` calling log builtin | `@llvm.msl.os_log` / dynamic buffering | `air.os_log` | `MTLShaderLoggingRuntime.rtlib` |
| `METAL_VALIST_SIZE` | Macro resolving to size of argument pack | `CallExpr` calling `__builtin_valist_size()` | Compiled to constant integer | Constant loading | None |

---

## 3. Exhaustive Mappings: Resource Tracking and Mesh Dumping

Resource tracking and post-mesh dumping runtime libraries (found in `reference/clang/.../lib/darwin/`) trace GPU resource access, detect hazards, and output geometric data for debugging.

| MSL Debugging Library | Precompiled Symbol Name | Mapped Debugging Operation | LLVM IR Intrinsic | AIR Opcode |
|:---|:---|:---|:---|:---|
| `libresource_tracking_rt_*.rtlib`| `_rt_track_buffer_read` | Records buffer read operations. | `@llvm.rt.track_buffer_read` | `air.track_read` |
| `libresource_tracking_rt_*.rtlib`| `_rt_track_buffer_write` | Records buffer write operations. | `@llvm.rt.track_buffer_write`| `air.track_write`|
| `libresource_tracking_rt_*.rtlib`| `_rt_track_texture_read` | Records texture read operations. | `@llvm.rt.track_texture_read`| `air.track_read` |
| `libresource_tracking_rt_*.rtlib`| `_rt_track_texture_write`| Records texture write operations.| `@llvm.rt.track_texture_write`| `air.track_write`|
| `libpost_mesh_dump_rt_*.rtlib` | `_pmd_dump_vertex` | Dumps post-transform vertex buffer data. | `@llvm.pmd.dump_vertex` | `air.pmd_write` |
| `libpost_mesh_dump_rt_*.rtlib` | `_pmd_dump_primitive` | Dumps post-transform primitive indices. | `@llvm.pmd.dump_primitive` | `air.pmd_write` |

---

## 4. Exhaustive Mappings: Profiling Trace Points

Profiling trace points allow developers to record execution events and performance metrics within running shaders. These events are captured by Xcode Instruments for profiling and optimization.

| Profiling Attribute | Argument Typings | Clang AST Node | LLVM IR Intrinsic Lowering | AIR Opcode | GPU Runtime Dependency |
|:---|:---|:---|:---|:---|:---|
| `[[tracepoint(n)]]` | `uint n` (Trace point index identifier) | Attribute annotated on statements | `@llvm.msl.tracepoint(i32 n)` | `air.tracepoint` | `libtracepoint_rt_*.metallib` / `libtracepoint_rt_static_*.a` |

---

## 5. Deep-Dive Debugging & Profiling Analysis

### 5.1 Compilation Warning Suppression and Diagnostics
Suppressing compilation warnings in MSL is achieved using standard `#pragma clang diagnostic` preprocessor blocks:

```cpp
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"
int unused_val = 10;
#pragma clang diagnostic pop
```

During parsing, the Clang frontend parses these pragma blocks, suppressing diagnostics for the enclosed statements without affecting warning outputs for the rest of the compilation unit.

### 5.2 Thread Profiling and Trace Point Compilation
When a shader is compiled with statement-level trace points enabled (e.g., `[[tracepoint(4)]]`):
1. The compiler maps the annotated statement to a trace point index (e.g., `4`).
2. Clang inserts a call to `@llvm.msl.tracepoint(i32 4)` immediately before the compiled statement block.
3. This call is lowered to the `air.tracepoint` opcode, passing the index value as an argument.
4. During execution, the GPU write trace point event records (containing the thread index, workgroup coordinates, and trace point identifier) to a specialized system-managed profiling buffer in VRAM.
5. These event records are read by Xcode Instruments at runtime, allowing developers to analyze execution timing, detect memory bottlenecks, and profile shader performance with minimal overhead.
- This profiling architecture allows developers to trace execution paths across thousands of parallel threads, making it a critical tool for debugging and optimizing complex shaders on Apple Silicon GPUs.



## Assert Trapping and Debugging Ring Buffers

Diagnostics and assertion validation are critical for debugging shader code:
- **Assert Trapping**: Conditional branches check assertion conditions and trigger an assertion handler if the condition is false.
- **Logging Buffers**: Calls to `os_log` write binary argument logs directly into a specialized ring buffer in VRAM, which is processed asynchronously by the host CPU driver.
- **Statement Trace Points**: Statement-level trace attributes compile down to profiling hooks, capturing performance metrics using Xcode Instruments.

## C++ Implementation of Shader Assertion Trap Handler

Below is the C++ implementation of the shader assertion failure trap handler resolved inside `libmetal_rt_osx.a`:

```cpp
extern "C" {

struct AssertBufferHeader {
  volatile uint32_t triggered;
  uint32_t line;
  char file_name[256];
};

// Pointer targeting assert output buffer in VRAM (Address Space 1)
device AssertBufferHeader* __air_assert_buffer [[buffer(30)]];

void __metal_assert_fail(const char* file, int line) {
  // Atomic CAS to acquire trigger slot
  if (__builtin_atomic_compare_exchange_n(&__air_assert_buffer->triggered, 0, 1, false, 0, 0)) {
    __air_assert_buffer->line = line;
    // Copy file name characters
    for (int i = 0; i < 255 && file[i]; ++i) {
      __air_assert_buffer->file_name[i] = file[i];
    }
  }
  // Force execution block halt
  __builtin_trap();
}

}
```
