// scene P01: 最小 kernel — エントリ metadata 全構造の確定用
// 設計一次ソース: docs/PROBING_PLAN.md §2 P1 (実機未検証。コンパイル可否は probe 時確認)
#include <metal_stdlib>
using namespace metal;

struct Params { float4 scale; uint mode; };

kernel void probe_p01_kernel(device float* b            [[buffer(0)]],
                             constant Params& p         [[buffer(1)]],
                             texture2d<float> t         [[texture(0)]],
                             sampler s                  [[sampler(0)]],
                             threadgroup float* shm     [[threadgroup(0)]],
                             uint i                     [[thread_position_in_grid]]) {
    uint idx = i % 1024;
    shm[idx] = b[i] * p.scale.x + t.sample(s, float2(0.5f)).x;
    threadgroup_barrier(mem_flags::mem_threadgroup);
    if (idx == 0) b[i] = shm[1023];
}
