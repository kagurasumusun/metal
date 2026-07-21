// scene P07F: free 関数 builtin wrapper (build_free_probes.py)
// 生成: 2026-07-21
#include <metal_stdlib>
using namespace metal;

#if defined(__HAVE_VISIBLE_FUNCTION_TABLE__)
// builtin=__metal_get_function_pointer_visible_function_table
// DISABLED_BY_LOOP extern "C" bool probe_p07f_is_null_visible_function_table_0(visible_function_table<> vft) {
// DISABLED_LINE   return metal::is_null_visible_function_table(vft);
// DISABLED_LINE }
#endif

#if defined(__HAVE_VISIBLE_FUNCTION_TABLE__)
// builtin=__metal_get_null_visible_function_table
// DISABLED_BY_LOOP extern "C" bool probe_p07f_is_null_visible_function_table_1(visible_function_table<> vft) {
// DISABLED_LINE   return metal::is_null_visible_function_table(vft);
// DISABLED_LINE }
#endif

// builtin=__metal_get_sample_position
extern "C" float2 probe_p07f_get_sample_position_2() {
  return metal::get_sample_position(0u);
}

#if defined(__HAVE_SIMDGROUP__) || defined(__HAVE_SIMDGROUP_SHUFFLE_AND_FILL__)
// builtin=__metal_get_simdgroup_size
extern "C" float probe_p07f_simd_shuffle_and_fill_up_3() {
  return metal::simd_shuffle_and_fill_up(1.0f, 1.0f, 0);
}
#endif

#if defined(__HAVE_VISIBLE_FUNCTION_TABLE__)
// builtin=__metal_get_size_visible_function_table
// DISABLED_BY_LOOP extern "C" bool probe_p07f_is_null_visible_function_table_4(visible_function_table<> vft) {
// DISABLED_LINE   return metal::is_null_visible_function_table(vft);
// DISABLED_LINE }
#endif

// builtin=__metal_ilogb
extern "C" int probe_p07f_ilogb_5() {
  return metal::ilogb(1.0f);
}

#if defined(__HAVE_NULL_TEXTURE__) || defined(__HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__)
// builtin=__metal_is_null_depth_2d_array_t
extern "C" bool probe_p07f_is_null_texture_6(depth2d_array<float> t0) {
  return metal::is_null_texture(t0);
}
#endif

#if defined(__HAVE_NULL_TEXTURE__) || defined(__HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__)
// builtin=__metal_is_null_depth_2d_ms_array_t
extern "C" bool probe_p07f_is_null_texture_7(depth2d_ms_array<float> t0) {
  return metal::is_null_texture(t0);
}
#endif

#if defined(__HAVE_NULL_TEXTURE__) || defined(__HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__)
// builtin=__metal_is_null_depth_2d_ms_t
extern "C" bool probe_p07f_is_null_texture_8(depth2d_ms<float> t0) {
  return metal::is_null_texture(t0);
}
#endif

#if defined(__HAVE_NULL_TEXTURE__) || defined(__HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__)
// builtin=__metal_is_null_depth_2d_t
extern "C" bool probe_p07f_is_null_texture_9(depth2d<float> t0) {
  return metal::is_null_texture(t0);
}
#endif

#if defined(__HAVE_NULL_TEXTURE__) || defined(__HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__)
// builtin=__metal_is_null_depth_cube_array_t
extern "C" bool probe_p07f_is_null_texture_10(depthcube_array<float> t0) {
  return metal::is_null_texture(t0);
}
#endif

#if defined(__HAVE_NULL_TEXTURE__) || defined(__HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__)
// builtin=__metal_is_null_depth_cube_t
extern "C" bool probe_p07f_is_null_texture_11(depthcube<float> t0) {
  return metal::is_null_texture(t0);
}
#endif

#if defined(__HAVE_VISIBLE_FUNCTION_TABLE__) || defined(__HAVE_FUNCTION_HANDLES__)
// builtin=__metal_is_null_function_handle
extern "C" bool probe_p07f_is_null_function_handle_12(function_handle fn) {
  return metal::is_null_function_handle(fn);
}
#endif

#if defined(__HAVE_RAYTRACING__)
// builtin=__metal_is_null_intersection_function_table
// DISABLED_BY_LOOP extern "C" bool probe_p07f_is_null_intersection_function_table_13(intersection_function_table<> vft) {
// DISABLED_LINE   return metal::is_null_intersection_function_table(vft);
// DISABLED_LINE }
#endif

#if defined(__HAVE_NULL_TEXTURE__) || defined(__HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__)
// builtin=__metal_is_null_texture_1d_array_t
extern "C" bool probe_p07f_is_null_texture_14(texture1d_array<float> t0) {
  return metal::is_null_texture(t0);
}
#endif

#if defined(__HAVE_NULL_TEXTURE__) || defined(__HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__)
// builtin=__metal_is_null_texture_1d_t
extern "C" bool probe_p07f_is_null_texture_15(texture1d<float> t0) {
  return metal::is_null_texture(t0);
}
#endif

#if defined(__HAVE_NULL_TEXTURE__) || defined(__HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__)
// builtin=__metal_is_null_texture_2d_array_t
extern "C" bool probe_p07f_is_null_texture_16(texture2d_array<float> t0) {
  return metal::is_null_texture(t0);
}
#endif

#if defined(__HAVE_NULL_TEXTURE__) || defined(__HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__)
// builtin=__metal_is_null_texture_2d_ms_array_t
extern "C" bool probe_p07f_is_null_texture_17(texture2d_ms_array<float> t0) {
  return metal::is_null_texture(t0);
}
#endif

#if defined(__HAVE_NULL_TEXTURE__) || defined(__HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__)
// builtin=__metal_is_null_texture_2d_ms_t
extern "C" bool probe_p07f_is_null_texture_18(texture2d_ms<float> t0) {
  return metal::is_null_texture(t0);
}
#endif

#if defined(__HAVE_NULL_TEXTURE__) || defined(__HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__)
// builtin=__metal_is_null_texture_2d_t
extern "C" bool probe_p07f_is_null_texture_19(texture2d<float> t0) {
  return metal::is_null_texture(t0);
}
#endif

#if defined(__HAVE_NULL_TEXTURE__) || defined(__HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__)
// builtin=__metal_is_null_texture_3d_t
extern "C" bool probe_p07f_is_null_texture_20(texture3d<float> t0) {
  return metal::is_null_texture(t0);
}
#endif

#if defined(__HAVE_NULL_TEXTURE__) || defined(__HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__)
// builtin=__metal_is_null_texture_buffer_1d_t
extern "C" bool probe_p07f_is_null_texture_21(texture_buffer<float> t0) {
  return metal::is_null_texture(t0);
}
#endif

#if defined(__HAVE_NULL_TEXTURE__) || defined(__HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__)
// builtin=__metal_is_null_texture_cube_t
extern "C" bool probe_p07f_is_null_texture_22(texturecube<float> t0) {
  return metal::is_null_texture(t0);
}
#endif

#if defined(__HAVE_PACK_UNPACK_RGB10A2_SNORM_FUNCTIONS__)
// builtin=__metal_pack_snorm_rgb10a2
extern "C" uint probe_p07f_pack_half_to_snorm10a2_23() {
  return metal::pack_half_to_snorm10a2(half4(1.0h));
}
#endif

#if defined(__HAVE_QUADGROUP__) || defined(__HAVE_QUADGROUP_BALLOT__)
// builtin=__metal_quad_active_threads_mask
extern "C" quad_vote probe_p07f_quad_active_threads_mask_24() {
  return metal::quad_active_threads_mask();
}
#endif

#if defined(__HAVE_QUADGROUP__) || defined(__HAVE_QUADGROUP_BALLOT__)
// builtin=__metal_quad_all
extern "C" bool probe_p07f_quad_all_25() {
  return metal::quad_all(true);
}
#endif

#if defined(__HAVE_QUADGROUP__) || defined(__HAVE_QUADGROUP_REDUCTION__)
// builtin=__metal_quad_and
// DISABLED_BY_LOOP extern "C" float probe_p07f_quad_and_26() {
// DISABLED_LINE   return metal::quad_and(1.0f);
// DISABLED_LINE }
#endif

#if defined(__HAVE_QUADGROUP__) || defined(__HAVE_QUADGROUP_BALLOT__)
// builtin=__metal_quad_any
extern "C" bool probe_p07f_quad_any_27() {
  return metal::quad_any(true);
}
#endif

#if defined(__HAVE_QUADGROUP__) || defined(__HAVE_QUADGROUP_BALLOT__)
// builtin=__metal_quad_ballot
extern "C" quad_vote probe_p07f_quad_ballot_28() {
  return metal::quad_ballot(true);
}
#endif

#if defined(__HAVE_QUADGROUP__) || defined(__HAVE_QUADGROUP_BROADCAST_FIRST__)
// builtin=__metal_quad_broadcast_first
extern "C" float probe_p07f_quad_broadcast_first_29() {
  return metal::quad_broadcast_first(1.0f);
}
#endif

#if defined(__HAVE_QUADGROUP__) || defined(__HAVE_QUADGROUP_IS_FIRST__)
// builtin=__metal_quad_is_first
extern "C" bool probe_p07f_quad_is_first_30() {
  return metal::quad_is_first();
}
#endif

#if defined(__HAVE_QUADGROUP__) || defined(__HAVE_QUADGROUP_REDUCTION__)
// builtin=__metal_quad_is_helper_thread
extern "C" bool probe_p07f_quad_is_helper_thread_31() {
  return metal::quad_is_helper_thread();
}
#endif

#if defined(__HAVE_QUADGROUP__) || defined(__HAVE_QUADGROUP_REDUCTION__)
// builtin=__metal_quad_max
extern "C" float probe_p07f_quad_max_32() {
  return metal::quad_max(1.0f);
}
#endif

#if defined(__HAVE_QUADGROUP__) || defined(__HAVE_QUADGROUP_REDUCTION__)
// builtin=__metal_quad_min
extern "C" float probe_p07f_quad_min_33() {
  return metal::quad_min(1.0f);
}
#endif

#if defined(__HAVE_QUADGROUP__) || defined(__HAVE_QUADGROUP_REDUCTION__)
// builtin=__metal_quad_or
// DISABLED_BY_LOOP extern "C" float probe_p07f_quad_or_34() {
// DISABLED_LINE   return metal::quad_or(1.0f);
// DISABLED_LINE }
#endif

#if defined(__HAVE_QUADGROUP__) || defined(__HAVE_QUADGROUP_REDUCTION__)
// builtin=__metal_quad_prefix_exclusive_product
extern "C" float probe_p07f_quad_prefix_exclusive_product_35() {
  return metal::quad_prefix_exclusive_product(1.0f);
}
#endif

#if defined(__HAVE_QUADGROUP__) || defined(__HAVE_QUADGROUP_REDUCTION__)
// builtin=__metal_quad_prefix_exclusive_sum
extern "C" float probe_p07f_quad_prefix_exclusive_sum_36() {
  return metal::quad_prefix_exclusive_sum(1.0f);
}
#endif

#if defined(__HAVE_QUADGROUP__) || defined(__HAVE_QUADGROUP_REDUCTION__)
// builtin=__metal_quad_prefix_inclusive_product
extern "C" float probe_p07f_quad_prefix_inclusive_product_37() {
  return metal::quad_prefix_inclusive_product(1.0f);
}
#endif

#if defined(__HAVE_QUADGROUP__) || defined(__HAVE_QUADGROUP_REDUCTION__)
// builtin=__metal_quad_prefix_inclusive_sum
extern "C" float probe_p07f_quad_prefix_inclusive_sum_38() {
  return metal::quad_prefix_inclusive_sum(1.0f);
}
#endif

#if defined(__HAVE_QUADGROUP__) || defined(__HAVE_QUADGROUP_REDUCTION__)
// builtin=__metal_quad_product
extern "C" float probe_p07f_quad_product_39() {
  return metal::quad_product(1.0f);
}
#endif

#if defined(__HAVE_QUADGROUP__) || defined(__HAVE_QUADGROUP_SHUFFLE_AND_FILL__)
// builtin=__metal_quad_shuffle_and_fill_down
extern "C" float probe_p07f_quad_shuffle_and_fill_down_40() {
  return metal::quad_shuffle_and_fill_down(1.0f, 1.0f, 0);
}
#endif

#if defined(__HAVE_QUADGROUP__) || defined(__HAVE_QUADGROUP_SHUFFLE_AND_FILL__)
// builtin=__metal_quad_shuffle_and_fill_up
extern "C" float probe_p07f_quad_shuffle_and_fill_up_41() {
  return metal::quad_shuffle_and_fill_up(1.0f, 1.0f, 0);
}
#endif

#if defined(__HAVE_QUADGROUP__) || defined(__HAVE_QUADGROUP_SHUFFLE_ROTATE_DOWN__)
// builtin=__metal_quad_shuffle_rotate_down
extern "C" float probe_p07f_quad_shuffle_rotate_down_42() {
  return metal::quad_shuffle_rotate_down(1.0f, 0);
}
#endif

#if defined(__HAVE_QUADGROUP__) || defined(__HAVE_QUADGROUP_SHUFFLE_ROTATE_UP__)
// builtin=__metal_quad_shuffle_rotate_up
extern "C" float probe_p07f_quad_shuffle_rotate_up_43() {
  return metal::quad_shuffle_rotate_up(1.0f, 0);
}
#endif

#if defined(__HAVE_QUADGROUP__) || defined(__HAVE_QUADGROUP_REDUCTION__)
// builtin=__metal_quad_sum
extern "C" float probe_p07f_quad_sum_44() {
  return metal::quad_sum(1.0f);
}
#endif

#if defined(__HAVE_QUADGROUP__) || defined(__HAVE_QUADGROUP_REDUCTION__)
// builtin=__metal_quad_xor
// DISABLED_BY_LOOP extern "C" float probe_p07f_quad_xor_45() {
// DISABLED_LINE   return metal::quad_xor(1.0f);
// DISABLED_LINE }
#endif

// builtin=__metal_select
extern "C" float probe_p07f_fdim_46() {
  return metal::fdim(1.0f, 1.0f);
}

#if defined(__HAVE_SIMDGROUP__) || defined(__HAVE_SIMDGROUP_BALLOT__)
// builtin=__metal_simd_active_threads_mask
extern "C" simd_vote probe_p07f_simd_active_threads_mask_47() {
  return metal::simd_active_threads_mask();
}
#endif

#if defined(__HAVE_SIMDGROUP__) || defined(__HAVE_SIMDGROUP_BALLOT__)
// builtin=__metal_simd_all
extern "C" bool probe_p07f_simd_all_48() {
  return metal::simd_all(true);
}
#endif

#if defined(__HAVE_SIMDGROUP__) || defined(__HAVE_SIMDGROUP_REDUCTION__)
// builtin=__metal_simd_and
// DISABLED_BY_LOOP extern "C" float probe_p07f_simd_and_49() {
// DISABLED_LINE   return metal::simd_and(1.0f);
// DISABLED_LINE }
#endif

#if defined(__HAVE_SIMDGROUP__) || defined(__HAVE_SIMDGROUP_BALLOT__)
// builtin=__metal_simd_any
extern "C" bool probe_p07f_simd_any_50() {
  return metal::simd_any(true);
}
#endif

#if defined(__HAVE_SIMDGROUP__) || defined(__HAVE_SIMDGROUP_BALLOT__)
// builtin=__metal_simd_ballot
extern "C" simd_vote probe_p07f_simd_ballot_51() {
  return metal::simd_ballot(true);
}
#endif

#if defined(__HAVE_SIMDGROUP__) || defined(__HAVE_SIMDGROUP_BROADCAST_FIRST__)
// builtin=__metal_simd_broadcast_first
extern "C" float probe_p07f_simd_broadcast_first_52() {
  return metal::simd_broadcast_first(1.0f);
}
#endif

#if defined(__HAVE_SIMDGROUP__) || defined(__HAVE_SIMDGROUP_IS_FIRST__)
// builtin=__metal_simd_is_first
extern "C" bool probe_p07f_simd_is_first_53() {
  return metal::simd_is_first();
}
#endif

#if defined(__HAVE_SIMDGROUP__) || defined(__HAVE_SIMDGROUP_REDUCTION__)
// builtin=__metal_simd_is_helper_thread
extern "C" bool probe_p07f_simd_is_helper_thread_54() {
  return metal::simd_is_helper_thread();
}
#endif

#if defined(__HAVE_SIMDGROUP__) || defined(__HAVE_SIMDGROUP_REDUCTION__)
// builtin=__metal_simd_max
extern "C" float probe_p07f_simd_max_55() {
  return metal::simd_max(1.0f);
}
#endif

#if defined(__HAVE_SIMDGROUP__) || defined(__HAVE_SIMDGROUP_REDUCTION__)
// builtin=__metal_simd_min
extern "C" float probe_p07f_simd_min_56() {
  return metal::simd_min(1.0f);
}
#endif

#if defined(__HAVE_SIMDGROUP__) || defined(__HAVE_SIMDGROUP_REDUCTION__)
// builtin=__metal_simd_or
// DISABLED_BY_LOOP extern "C" float probe_p07f_simd_or_57() {
// DISABLED_LINE   return metal::simd_or(1.0f);
// DISABLED_LINE }
#endif

#if defined(__HAVE_SIMDGROUP__) || defined(__HAVE_SIMDGROUP_REDUCTION__)
// builtin=__metal_simd_prefix_exclusive_product
extern "C" float probe_p07f_simd_prefix_exclusive_product_58() {
  return metal::simd_prefix_exclusive_product(1.0f);
}
#endif

#if defined(__HAVE_SIMDGROUP__) || defined(__HAVE_SIMDGROUP_REDUCTION__)
// builtin=__metal_simd_prefix_exclusive_sum
extern "C" float probe_p07f_simd_prefix_exclusive_sum_59() {
  return metal::simd_prefix_exclusive_sum(1.0f);
}
#endif

#if defined(__HAVE_SIMDGROUP__) || defined(__HAVE_SIMDGROUP_REDUCTION__)
// builtin=__metal_simd_prefix_inclusive_product
extern "C" float probe_p07f_simd_prefix_inclusive_product_60() {
  return metal::simd_prefix_inclusive_product(1.0f);
}
#endif

#if defined(__HAVE_SIMDGROUP__) || defined(__HAVE_SIMDGROUP_REDUCTION__)
// builtin=__metal_simd_prefix_inclusive_sum
extern "C" float probe_p07f_simd_prefix_inclusive_sum_61() {
  return metal::simd_prefix_inclusive_sum(1.0f);
}
#endif

#if defined(__HAVE_SIMDGROUP__) || defined(__HAVE_SIMDGROUP_REDUCTION__)
// builtin=__metal_simd_product
extern "C" float probe_p07f_simd_product_62() {
  return metal::simd_product(1.0f);
}
#endif

#if defined(__HAVE_SIMDGROUP__) || defined(__HAVE_SIMDGROUP_SHUFFLE_AND_FILL__)
// builtin=__metal_simd_shuffle_and_fill_down
extern "C" float probe_p07f_simd_shuffle_and_fill_down_63() {
  return metal::simd_shuffle_and_fill_down(1.0f, 1.0f, 0);
}
#endif

#if defined(__HAVE_SIMDGROUP__) || defined(__HAVE_SIMDGROUP_SHUFFLE_AND_FILL__)
// builtin=__metal_simd_shuffle_and_fill_up
extern "C" float probe_p07f_simd_shuffle_and_fill_up_64() {
  return metal::simd_shuffle_and_fill_up(1.0f, 1.0f, 0);
}
#endif

#if defined(__HAVE_SIMDGROUP__) || defined(__HAVE_SIMDGROUP_SHUFFLE_ROTATE_DOWN__)
// builtin=__metal_simd_shuffle_rotate_down
extern "C" float probe_p07f_simd_shuffle_rotate_down_65() {
  return metal::simd_shuffle_rotate_down(1.0f, 0);
}
#endif

#if defined(__HAVE_SIMDGROUP__) || defined(__HAVE_SIMDGROUP_SHUFFLE_ROTATE_UP__)
// builtin=__metal_simd_shuffle_rotate_up
extern "C" float probe_p07f_simd_shuffle_rotate_up_66() {
  return metal::simd_shuffle_rotate_up(1.0f, 0);
}
#endif

#if defined(__HAVE_SIMDGROUP__) || defined(__HAVE_SIMDGROUP_REDUCTION__)
// builtin=__metal_simd_sum
extern "C" float probe_p07f_simd_sum_67() {
  return metal::simd_sum(1.0f);
}
#endif

#if defined(__HAVE_SIMDGROUP__) || defined(__HAVE_SIMDGROUP_REDUCTION__)
// builtin=__metal_simd_xor
// DISABLED_BY_LOOP extern "C" float probe_p07f_simd_xor_68() {
// DISABLED_LINE   return metal::simd_xor(1.0f);
// DISABLED_LINE }
#endif

#if defined(__HAVE_PACK_UNPACK_RGB10A2_SNORM_FUNCTIONS__)
// builtin=__metal_unpack_snorm_rgb10a2
extern "C" half4 probe_p07f_unpack_snorm10a2_to_half_69() {
  return metal::unpack_snorm10a2_to_half(0u);
}
#endif

#if defined(__HAVE_VISIBLE_FUNCTION_TABLE__)
// builtin=__metal_visible_function_table_t
// DISABLED_BY_LOOP extern "C" bool probe_p07f_is_null_visible_function_table_70(visible_function_table<> vft) {
// DISABLED_LINE   return metal::is_null_visible_function_table(vft);
// DISABLED_LINE }
#endif
