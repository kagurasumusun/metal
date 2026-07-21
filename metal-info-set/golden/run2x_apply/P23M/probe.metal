// scene P23M: buffer atomic max/min (ulong のみ一次事実) + simdgroup_matrix 8x8 + uniform is_uniform
// 一次情報: metal_atomic L647 (_valid_max_type = device ulong* のみ)
//           metal_simdgroup_matrix (8x8 専用 builtin 族)
//           metal_uniform (uniform<U> 変換で __builtin_assume(__metal_is_uniform(v)))
#include <metal_stdlib>
#include <metal_atomic>
#include <metal_simdgroup_matrix>
#include <metal_uniform>
using namespace metal;

// builtin=__metal_atomic_max_explicit
extern "C" void probe_p23m_amax(volatile device metal::atomic_ulong *__p) {
    metal::atomic_max_explicit(__p, ulong(0), metal::memory_order_relaxed);
}

// builtin=__metal_atomic_min_explicit
extern "C" void probe_p23m_amin(volatile device metal::atomic_ulong *__p) {
    metal::atomic_min_explicit(__p, ulong(0), metal::memory_order_relaxed);
}

// builtin=__metal_simdgroup_matrix_8x8_init_diag
extern "C" void probe_p23m_mdiag(device float4 *__out) {
    auto __m = metal::simdgroup_float8x8(1.0f);
    (void)__m; __out[0] = float4(0);
}

// builtin=__metal_simdgroup_matrix_8x8_init_filled
extern "C" void probe_p23m_mfill(device float4 *__out) {
    auto __m = metal::make_filled_simdgroup_matrix<float, 8, 8>(1.0f);
    (void)__m; __out[0] = float4(0);
}

// builtin=__metal_simdgroup_matrix_8x8_load
extern "C" void probe_p23m_mload(const device float *__src, device float4 *__out) {
    metal::simdgroup_float8x8 __m;
    metal::simdgroup_load(__m, __src);
    (void)__m; __out[0] = float4(0);
}

// builtin=__metal_simdgroup_matrix_8x8_store
extern "C" void probe_p23m_mstore(const device float *__src, device float *__dst) {
    metal::simdgroup_float8x8 __m;
    metal::simdgroup_load(__m, __src);
    metal::simdgroup_store(__m, __dst);
}

// builtin=__metal_simdgroup_matrix_8x8_multiply_accumulate
extern "C" void probe_p23m_mmac(const device float *__src, device float *__dst) {
    metal::simdgroup_float8x8 __a, __b, __c, __d;
    metal::simdgroup_load(__a, __src);
    metal::simdgroup_load(__b, __src);
    metal::simdgroup_load(__c, __src);
    metal::simdgroup_multiply_accumulate(__d, __a, __b, __c);
    metal::simdgroup_store(__d, __dst);
}

// builtin=__metal_is_uniform
// DISABLED_BY_LOOP extern "C" int probe_p23m_unif(int __x) {
// DISABLED_LINE     metal::uniform<int> __u(__x);
// DISABLED_LINE     return int(__u);
// DISABLED_LINE }
