// scene P07F: free 関数 builtin wrapper (build_free_probes.py)
// 生成: 2026-07-21
#include <metal_stdlib>
using namespace metal;

// builtin=__metal_atomic_compare_exchange_weak_explicit
// DISABLED_BY_LOOP extern "C" bool probe_p07f_atomic_compare_exchange_weak_explicit_0() {
// DISABLED_LINE   threadgroup atomic_int atm0;
// DISABLED_LINE   int pv1 = 0;
// DISABLED_LINE   return metal::atomic_compare_exchange_weak_explicit(&atm0, &pv1, 0, memory_order_relaxed, memory_order_relaxed);
// DISABLED_LINE }

// builtin=__metal_atomic_exchange_explicit
// DISABLED_BY_LOOP extern "C" int probe_p07f_atomic_exchange_explicit_1() {
// DISABLED_LINE   threadgroup atomic_int atm0;
// DISABLED_LINE   return metal::atomic_exchange_explicit(&atm0, 0, memory_order_relaxed);
// DISABLED_LINE }

// builtin=__metal_atomic_fetch_add_explicit
// DISABLED_BY_LOOP extern "C" int probe_p07f_atomic_fetch_add_explicit_2() {
// DISABLED_LINE   threadgroup atomic_int atm0;
// DISABLED_LINE   return metal::atomic_fetch_add_explicit(&atm0, 0, memory_order_relaxed);
// DISABLED_LINE }

// builtin=__metal_atomic_fetch_and_explicit
// DISABLED_BY_LOOP extern "C" int probe_p07f_atomic_fetch_and_explicit_3() {
// DISABLED_LINE   threadgroup atomic_int atm0;
// DISABLED_LINE   return metal::atomic_fetch_and_explicit(&atm0, 0, memory_order_relaxed);
// DISABLED_LINE }

// builtin=__metal_atomic_fetch_max_explicit
// DISABLED_BY_LOOP extern "C" int probe_p07f_atomic_fetch_max_explicit_4() {
// DISABLED_LINE   threadgroup atomic_int atm0;
// DISABLED_LINE   return metal::atomic_fetch_max_explicit(&atm0, 0, memory_order_relaxed);
// DISABLED_LINE }

// builtin=__metal_atomic_fetch_min_explicit
// DISABLED_BY_LOOP extern "C" int probe_p07f_atomic_fetch_min_explicit_5() {
// DISABLED_LINE   threadgroup atomic_int atm0;
// DISABLED_LINE   return metal::atomic_fetch_min_explicit(&atm0, 0, memory_order_relaxed);
// DISABLED_LINE }

// builtin=__metal_atomic_fetch_or_explicit
// DISABLED_BY_LOOP extern "C" int probe_p07f_atomic_fetch_or_explicit_6() {
// DISABLED_LINE   threadgroup atomic_int atm0;
// DISABLED_LINE   return metal::atomic_fetch_or_explicit(&atm0, 0, memory_order_relaxed);
// DISABLED_LINE }

// builtin=__metal_atomic_fetch_sub_explicit
// DISABLED_BY_LOOP extern "C" int probe_p07f_atomic_fetch_sub_explicit_7() {
// DISABLED_LINE   threadgroup atomic_int atm0;
// DISABLED_LINE   return metal::atomic_fetch_sub_explicit(&atm0, 0, memory_order_relaxed);
// DISABLED_LINE }

// builtin=__metal_atomic_fetch_xor_explicit
// DISABLED_BY_LOOP extern "C" int probe_p07f_atomic_fetch_xor_explicit_8() {
// DISABLED_LINE   threadgroup atomic_int atm0;
// DISABLED_LINE   return metal::atomic_fetch_xor_explicit(&atm0, 0, memory_order_relaxed);
// DISABLED_LINE }

// builtin=__metal_atomic_load_explicit
// DISABLED_BY_LOOP extern "C" int probe_p07f_atomic_load_explicit_9() {
// DISABLED_LINE   threadgroup atomic_int atm0;
// DISABLED_LINE   return metal::atomic_load_explicit(&atm0, memory_order_relaxed);
// DISABLED_LINE }

#if defined(__HAVE_ATOMIC_ULONG_MIN_MAX__)
// builtin=__metal_atomic_max_explicit
// DISABLED_BY_LOOP extern "C" void probe_p07f_atomic_max_explicit_10() {
// DISABLED_LINE   threadgroup atomic_int atm0;
// DISABLED_LINE   metal::atomic_max_explicit(&atm0, 0, memory_order_relaxed);
// DISABLED_LINE }
#endif

#if defined(__HAVE_ATOMIC_ULONG_MIN_MAX__)
// builtin=__metal_atomic_min_explicit
// DISABLED_BY_LOOP extern "C" void probe_p07f_atomic_min_explicit_11() {
// DISABLED_LINE   threadgroup atomic_int atm0;
// DISABLED_LINE   metal::atomic_min_explicit(&atm0, 0, memory_order_relaxed);
// DISABLED_LINE }
#endif

// builtin=__metal_atomic_store_explicit
// DISABLED_BY_LOOP extern "C" void probe_p07f_atomic_store_explicit_12() {
// DISABLED_LINE   threadgroup atomic_int atm0;
// DISABLED_LINE   metal::atomic_store_explicit(&atm0, 0, memory_order_relaxed);
// DISABLED_LINE }

// builtin=__metal_frexp
// DISABLED_BY_LOOP extern "C" float probe_p07f_frexp_13() {
// DISABLED_LINE   return metal::frexp(1.0f, 0);
// DISABLED_LINE }

#if defined(__HAVE_VISIBLE_FUNCTION_TABLE__)
// builtin=__metal_get_function_pointer_visible_function_table
// DISABLED_BY_LOOP extern "C" bool probe_p07f_is_null_visible_function_table_14(visible_function_table<> vft) {
// DISABLED_LINE   return metal::is_null_visible_function_table(vft);
// DISABLED_LINE }
#endif

#if defined(__HAVE_VISIBLE_FUNCTION_TABLE__)
// builtin=__metal_get_null_visible_function_table
// DISABLED_BY_LOOP extern "C" bool probe_p07f_is_null_visible_function_table_15(visible_function_table<> vft) {
// DISABLED_LINE   return metal::is_null_visible_function_table(vft);
// DISABLED_LINE }
#endif

#if defined(__HAVE_VISIBLE_FUNCTION_TABLE__)
// builtin=__metal_get_size_visible_function_table
// DISABLED_BY_LOOP extern "C" bool probe_p07f_is_null_visible_function_table_16(visible_function_table<> vft) {
// DISABLED_LINE   return metal::is_null_visible_function_table(vft);
// DISABLED_LINE }
#endif

// builtin=__metal_ilogb
extern "C" int probe_p07f_ilogb_17() {
  return metal::ilogb(1.0f);
}

#if defined(__HAVE_RAYTRACING__)
// builtin=__metal_is_null_intersection_function_table
// DISABLED_BY_LOOP extern "C" bool probe_p07f_is_null_intersection_function_table_18(intersection_function_table<> vft) {
// DISABLED_LINE   return metal::is_null_intersection_function_table(vft);
// DISABLED_LINE }
#endif

#if defined(__HAVE_QUADGROUP__) || defined(__HAVE_QUADGROUP_REDUCTION__)
// builtin=__metal_quad_and
// DISABLED_BY_LOOP extern "C" float probe_p07f_quad_and_19() {
// DISABLED_LINE   return metal::quad_and(1.0f);
// DISABLED_LINE }
#endif

#if defined(__HAVE_QUADGROUP__) || defined(__HAVE_QUADGROUP_REDUCTION__)
// builtin=__metal_quad_or
// DISABLED_BY_LOOP extern "C" float probe_p07f_quad_or_20() {
// DISABLED_LINE   return metal::quad_or(1.0f);
// DISABLED_LINE }
#endif

#if defined(__HAVE_QUADGROUP__) || defined(__HAVE_QUADGROUP_REDUCTION__)
// builtin=__metal_quad_xor
// DISABLED_BY_LOOP extern "C" float probe_p07f_quad_xor_21() {
// DISABLED_LINE   return metal::quad_xor(1.0f);
// DISABLED_LINE }
#endif

// builtin=__metal_select
extern "C" float probe_p07f_fdim_22() {
  return metal::fdim(1.0f, 1.0f);
}

#if defined(__HAVE_SIMDGROUP__) || defined(__HAVE_SIMDGROUP_REDUCTION__)
// builtin=__metal_simd_and
// DISABLED_BY_LOOP extern "C" float probe_p07f_simd_and_23() {
// DISABLED_LINE   return metal::simd_and(1.0f);
// DISABLED_LINE }
#endif

#if defined(__HAVE_SIMDGROUP__) || defined(__HAVE_SIMDGROUP_REDUCTION__)
// builtin=__metal_simd_or
// DISABLED_BY_LOOP extern "C" float probe_p07f_simd_or_24() {
// DISABLED_LINE   return metal::simd_or(1.0f);
// DISABLED_LINE }
#endif

#if defined(__HAVE_SIMDGROUP__) || defined(__HAVE_SIMDGROUP_REDUCTION__)
// builtin=__metal_simd_xor
// DISABLED_BY_LOOP extern "C" float probe_p07f_simd_xor_25() {
// DISABLED_LINE   return metal::simd_xor(1.0f);
// DISABLED_LINE }
#endif

#if defined(__HAVE_VISIBLE_FUNCTION_TABLE__)
// builtin=__metal_visible_function_table_t
// DISABLED_BY_LOOP extern "C" bool probe_p07f_is_null_visible_function_table_26(visible_function_table<> vft) {
// DISABLED_LINE   return metal::is_null_visible_function_table(vft);
// DISABLED_LINE }
#endif
