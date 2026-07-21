// scene P07F: free 関数 builtin wrapper (build_free_probes.py)
// 生成: 2026-07-21
#include <metal_stdlib>
using namespace metal;

#if defined(__HAVE_VISIBLE_FUNCTION_TABLE__)
// builtin=__metal_get_function_pointer_visible_function_table
extern "C" bool probe_p07f_is_null_visible_function_table_0(visible_function_table<void(uint)> vft) {
  return metal::is_null_visible_function_table(vft);
}
#endif

#if defined(__HAVE_VISIBLE_FUNCTION_TABLE__)
// builtin=__metal_get_null_visible_function_table
extern "C" bool probe_p07f_is_null_visible_function_table_1(visible_function_table<void(uint)> vft) {
  return metal::is_null_visible_function_table(vft);
}
#endif

#if defined(__HAVE_VISIBLE_FUNCTION_TABLE__)
// builtin=__metal_get_size_visible_function_table
extern "C" bool probe_p07f_is_null_visible_function_table_2(visible_function_table<void(uint)> vft) {
  return metal::is_null_visible_function_table(vft);
}
#endif

#if defined(__HAVE_RAYTRACING__)
// builtin=__metal_is_null_intersection_function_table
extern "C" bool probe_p07f_is_null_intersection_function_table_3(metal::raytracing::intersection_function_table<metal::raytracing::instancing, metal::raytracing::triangle_data> ift) {
  return metal::raytracing::is_null_intersection_function_table(ift);
}
#endif

// builtin=__metal_select
extern "C" float probe_p07f_fdim_4() {
  return metal::fdim(1.0f, 1.0f);
}

#if defined(__HAVE_VISIBLE_FUNCTION_TABLE__)
// builtin=__metal_visible_function_table_t
extern "C" bool probe_p07f_is_null_visible_function_table_5(visible_function_table<void(uint)> vft) {
  return metal::is_null_visible_function_table(vft);
}
#endif
