// scene P07F: free 関数 builtin wrapper (build_free_probes.py)
// 生成: 2026-07-21
#include <metal_stdlib>
using namespace metal;

// builtin=__metal_atomic_compare_exchange_weak_explicit
extern "C" bool probe_p07f_atomic_compare_exchange_weak_explicit_0(device atomic_int * at0) {
  int pv0 = 0;
  return metal::atomic_compare_exchange_weak_explicit(at0, &pv0, 0, memory_order_relaxed, memory_order_relaxed);
}

// builtin=__metal_atomic_exchange_explicit
extern "C" int probe_p07f_atomic_exchange_explicit_1(device atomic_int * at0) {
  return metal::atomic_exchange_explicit(at0, 0, memory_order_relaxed);
}

// builtin=__metal_atomic_fetch_add_explicit
extern "C" int probe_p07f_atomic_fetch_add_explicit_2(device atomic_int * at0) {
  return metal::atomic_fetch_add_explicit(at0, 0, memory_order_relaxed);
}

// builtin=__metal_atomic_fetch_and_explicit
extern "C" int probe_p07f_atomic_fetch_and_explicit_3(device atomic_int * at0) {
  return metal::atomic_fetch_and_explicit(at0, 0, memory_order_relaxed);
}

// builtin=__metal_atomic_fetch_max_explicit
extern "C" int probe_p07f_atomic_fetch_max_explicit_4(device atomic_int * at0) {
  return metal::atomic_fetch_max_explicit(at0, 0, memory_order_relaxed);
}

// builtin=__metal_atomic_fetch_min_explicit
extern "C" int probe_p07f_atomic_fetch_min_explicit_5(device atomic_int * at0) {
  return metal::atomic_fetch_min_explicit(at0, 0, memory_order_relaxed);
}

// builtin=__metal_atomic_fetch_or_explicit
extern "C" int probe_p07f_atomic_fetch_or_explicit_6(device atomic_int * at0) {
  return metal::atomic_fetch_or_explicit(at0, 0, memory_order_relaxed);
}

// builtin=__metal_atomic_fetch_sub_explicit
extern "C" int probe_p07f_atomic_fetch_sub_explicit_7(device atomic_int * at0) {
  return metal::atomic_fetch_sub_explicit(at0, 0, memory_order_relaxed);
}

// builtin=__metal_atomic_fetch_xor_explicit
extern "C" int probe_p07f_atomic_fetch_xor_explicit_8(device atomic_int * at0) {
  return metal::atomic_fetch_xor_explicit(at0, 0, memory_order_relaxed);
}

// builtin=__metal_atomic_load_explicit
extern "C" int probe_p07f_atomic_load_explicit_9(device atomic_int * at0) {
  return metal::atomic_load_explicit(at0, memory_order_relaxed);
}

#if defined(__HAVE_ATOMIC_ULONG_MIN_MAX__)
// builtin=__metal_atomic_max_explicit
extern "C" void probe_p07f_atomic_max_explicit_10(device atomic_int * at0) {
  metal::atomic_max_explicit(at0, 0, memory_order_relaxed);
}
#endif

#if defined(__HAVE_ATOMIC_ULONG_MIN_MAX__)
// builtin=__metal_atomic_min_explicit
extern "C" void probe_p07f_atomic_min_explicit_11(device atomic_int * at0) {
  metal::atomic_min_explicit(at0, 0, memory_order_relaxed);
}
#endif

// builtin=__metal_atomic_store_explicit
extern "C" void probe_p07f_atomic_store_explicit_12(device atomic_int * at0) {
  metal::atomic_store_explicit(at0, 0, memory_order_relaxed);
}

// builtin=__metal_frexp
extern "C" float probe_p07f_frexp_13() {
  int pv0 = 0;
  return metal::frexp(1.0f, pv0);
}

#if defined(__HAVE_VISIBLE_FUNCTION_TABLE__)
// builtin=__metal_get_function_pointer_visible_function_table
extern "C" bool probe_p07f_is_null_visible_function_table_14(visible_function_table<> vft) {
  return metal::is_null_visible_function_table(vft);
}
#endif

#if defined(__HAVE_VISIBLE_FUNCTION_TABLE__)
// builtin=__metal_get_null_visible_function_table
extern "C" bool probe_p07f_is_null_visible_function_table_15(visible_function_table<> vft) {
  return metal::is_null_visible_function_table(vft);
}
#endif

#if defined(__HAVE_VISIBLE_FUNCTION_TABLE__)
// builtin=__metal_get_size_visible_function_table
extern "C" bool probe_p07f_is_null_visible_function_table_16(visible_function_table<> vft) {
  return metal::is_null_visible_function_table(vft);
}
#endif

// builtin=__metal_ilogb
extern "C" int probe_p07f_ilogb_17() {
  return metal::ilogb(1.0f);
}

#if defined(__HAVE_RAYTRACING__)
// builtin=__metal_is_null_intersection_function_table
extern "C" bool probe_p07f_is_null_intersection_function_table_18(intersection_function_table<> vft) {
  return metal::is_null_intersection_function_table(vft);
}
#endif

#if defined(__HAVE_QUADGROUP__) || defined(__HAVE_QUADGROUP_REDUCTION__)
// builtin=__metal_quad_and
extern "C" float probe_p07f_quad_and_19() {
  return metal::quad_and(1.0f);
}
#endif

#if defined(__HAVE_QUADGROUP__) || defined(__HAVE_QUADGROUP_REDUCTION__)
// builtin=__metal_quad_or
extern "C" float probe_p07f_quad_or_20() {
  return metal::quad_or(1.0f);
}
#endif

#if defined(__HAVE_QUADGROUP__) || defined(__HAVE_QUADGROUP_REDUCTION__)
// builtin=__metal_quad_xor
extern "C" float probe_p07f_quad_xor_21() {
  return metal::quad_xor(1.0f);
}
#endif

// builtin=__metal_select
extern "C" float probe_p07f_fdim_22() {
  return metal::fdim(1.0f, 1.0f);
}

#if defined(__HAVE_SIMDGROUP__) || defined(__HAVE_SIMDGROUP_REDUCTION__)
// builtin=__metal_simd_and
extern "C" float probe_p07f_simd_and_23() {
  return metal::simd_and(1.0f);
}
#endif

#if defined(__HAVE_SIMDGROUP__) || defined(__HAVE_SIMDGROUP_REDUCTION__)
// builtin=__metal_simd_or
extern "C" float probe_p07f_simd_or_24() {
  return metal::simd_or(1.0f);
}
#endif

#if defined(__HAVE_SIMDGROUP__) || defined(__HAVE_SIMDGROUP_REDUCTION__)
// builtin=__metal_simd_xor
extern "C" float probe_p07f_simd_xor_25() {
  return metal::simd_xor(1.0f);
}
#endif

#if defined(__HAVE_VISIBLE_FUNCTION_TABLE__)
// builtin=__metal_visible_function_table_t
extern "C" bool probe_p07f_is_null_visible_function_table_26(visible_function_table<> vft) {
  return metal::is_null_visible_function_table(vft);
}
#endif
