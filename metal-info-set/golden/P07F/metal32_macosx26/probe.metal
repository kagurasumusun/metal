// scene P07F: free 関数 builtin wrapper (build_free_probes.py)
// 生成: 2026-07-21
#include <metal_stdlib>
using namespace metal;

// builtin=__metal_dfdx
extern "C" half probe_p07f_dfdx_0() {
  return metal::dfdx(1.0h);
}

// builtin=__metal_dfdy
extern "C" half probe_p07f_dfdy_1() {
  return metal::dfdy(1.0h);
}

// builtin=__metal_discard_fragment
extern "C" void probe_p07f_discard_fragment_2() {
  metal::discard_fragment();
}

// builtin=__metal_fwidth
extern "C" half probe_p07f_fwidth_3() {
  return metal::fwidth(1.0h);
}

#if defined(__HAVE_VISIBLE_FUNCTION_TABLE__)
// builtin=__metal_get_function_pointer_visible_function_table
// DISABLED_BY_LOOP extern "C" bool probe_p07f_is_null_visible_function_table_4(visible_function_table<> vft) {
// DISABLED_LINE   return metal::is_null_visible_function_table(vft);
// DISABLED_LINE }
#endif

#if defined(__HAVE_VISIBLE_FUNCTION_TABLE__)
// builtin=__metal_get_null_visible_function_table
// DISABLED_BY_LOOP extern "C" bool probe_p07f_is_null_visible_function_table_5(visible_function_table<> vft) {
// DISABLED_LINE   return metal::is_null_visible_function_table(vft);
// DISABLED_LINE }
#endif

// builtin=__metal_get_num_samples
extern "C" uint probe_p07f_get_num_samples_6() {
  return metal::get_num_samples();
}

// builtin=__metal_get_sample_position
// DISABLED_BY_LOOP extern "C" float2 probe_p07f_get_sample_position_7() {
// DISABLED_LINE   return metal::get_sample_position(0u);
// DISABLED_LINE }

// DISABLED_LINE #if defined(__HAVE_SIMDGROUP__|__HAVE_SIMDGROUP_SHUFFLE_AND_FILL__)
// builtin=__metal_get_simdgroup_size
// DISABLED_BY_LOOP extern "C" float probe_p07f_simd_shuffle_and_fill_up_8() {
// DISABLED_LINE   return metal::simd_shuffle_and_fill_up(1.0f, 1.0f, 0);
// DISABLED_LINE }
// DISABLED_LINE #endif

#if defined(__HAVE_VISIBLE_FUNCTION_TABLE__)
// builtin=__metal_get_size_visible_function_table
// DISABLED_BY_LOOP extern "C" bool probe_p07f_is_null_visible_function_table_9(visible_function_table<> vft) {
// DISABLED_LINE   return metal::is_null_visible_function_table(vft);
// DISABLED_LINE }
#endif

// builtin=__metal_ilogb
// DISABLED_BY_LOOP extern "C" int probe_p07f_ilogb_10() {
// DISABLED_LINE   return metal::ilogb(1.0f);
// DISABLED_LINE }

// DISABLED_LINE #if defined(__HAVE_NULL_TEXTURE__|__HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__)
// builtin=__metal_is_null_depth_2d_array_t
// DISABLED_BY_LOOP extern "C" bool probe_p07f_is_null_texture_11(depth2d_array<float> t0) {
// DISABLED_LINE   return metal::is_null_texture(t0);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_NULL_TEXTURE__|__HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__)
// builtin=__metal_is_null_depth_2d_ms_array_t
// DISABLED_BY_LOOP extern "C" bool probe_p07f_is_null_texture_12(depth2d_ms_array<float> t0) {
// DISABLED_LINE   return metal::is_null_texture(t0);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_NULL_TEXTURE__|__HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__)
// builtin=__metal_is_null_depth_2d_ms_t
// DISABLED_BY_LOOP extern "C" bool probe_p07f_is_null_texture_13(depth2d_ms<float> t0) {
// DISABLED_LINE   return metal::is_null_texture(t0);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_NULL_TEXTURE__|__HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__)
// builtin=__metal_is_null_depth_2d_t
// DISABLED_BY_LOOP extern "C" bool probe_p07f_is_null_texture_14(depth2d<float> t0) {
// DISABLED_LINE   return metal::is_null_texture(t0);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_NULL_TEXTURE__|__HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__)
// builtin=__metal_is_null_depth_cube_array_t
// DISABLED_BY_LOOP extern "C" bool probe_p07f_is_null_texture_15(depthcube_array<float> t0) {
// DISABLED_LINE   return metal::is_null_texture(t0);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_NULL_TEXTURE__|__HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__)
// builtin=__metal_is_null_depth_cube_t
// DISABLED_BY_LOOP extern "C" bool probe_p07f_is_null_texture_16(depthcube<float> t0) {
// DISABLED_LINE   return metal::is_null_texture(t0);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_VISIBLE_FUNCTION_TABLE__|__HAVE_FUNCTION_HANDLES__)
// builtin=__metal_is_null_function_handle
// DISABLED_BY_LOOP extern "C" bool probe_p07f_is_null_function_handle_17(function_handle fn) {
// DISABLED_LINE   return metal::is_null_function_handle(fn);
// DISABLED_LINE }
// DISABLED_LINE #endif

#if defined(__HAVE_RAYTRACING__)
// builtin=__metal_is_null_intersection_function_table
// DISABLED_BY_LOOP extern "C" bool probe_p07f_is_null_intersection_function_table_18(intersection_function_table<> vft) {
// DISABLED_LINE   return metal::is_null_intersection_function_table(vft);
// DISABLED_LINE }
#endif

// DISABLED_LINE #if defined(__HAVE_NULL_TEXTURE__|__HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__)
// builtin=__metal_is_null_texture_1d_array_t
// DISABLED_BY_LOOP extern "C" bool probe_p07f_is_null_texture_19(texture1d_array<float> t0) {
// DISABLED_LINE   return metal::is_null_texture(t0);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_NULL_TEXTURE__|__HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__)
// builtin=__metal_is_null_texture_1d_t
// DISABLED_BY_LOOP extern "C" bool probe_p07f_is_null_texture_20(texture1d<float> t0) {
// DISABLED_LINE   return metal::is_null_texture(t0);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_NULL_TEXTURE__|__HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__)
// builtin=__metal_is_null_texture_2d_array_t
// DISABLED_BY_LOOP extern "C" bool probe_p07f_is_null_texture_21(texture2d_array<float> t0) {
// DISABLED_LINE   return metal::is_null_texture(t0);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_NULL_TEXTURE__|__HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__)
// builtin=__metal_is_null_texture_2d_ms_array_t
// DISABLED_BY_LOOP extern "C" bool probe_p07f_is_null_texture_22(texture2d_ms_array<float> t0) {
// DISABLED_LINE   return metal::is_null_texture(t0);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_NULL_TEXTURE__|__HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__)
// builtin=__metal_is_null_texture_2d_ms_t
// DISABLED_BY_LOOP extern "C" bool probe_p07f_is_null_texture_23(texture2d_ms<float> t0) {
// DISABLED_LINE   return metal::is_null_texture(t0);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_NULL_TEXTURE__|__HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__)
// builtin=__metal_is_null_texture_2d_t
// DISABLED_BY_LOOP extern "C" bool probe_p07f_is_null_texture_24(texture2d<float> t0) {
// DISABLED_LINE   return metal::is_null_texture(t0);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_NULL_TEXTURE__|__HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__)
// builtin=__metal_is_null_texture_3d_t
// DISABLED_BY_LOOP extern "C" bool probe_p07f_is_null_texture_25(texture3d<float> t0) {
// DISABLED_LINE   return metal::is_null_texture(t0);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_NULL_TEXTURE__|__HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__)
// builtin=__metal_is_null_texture_buffer_1d_t
// DISABLED_BY_LOOP extern "C" bool probe_p07f_is_null_texture_26(texture_buffer<float> t0) {
// DISABLED_LINE   return metal::is_null_texture(t0);
// DISABLED_LINE }
// DISABLED_LINE #endif

#if defined(__HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__)
// builtin=__metal_is_null_texture_cube_array_t
extern "C" bool probe_p07f_is_null_texture_27(texturecube_array<float> t0) {
  return metal::is_null_texture(t0);
}
#endif

// DISABLED_LINE #if defined(__HAVE_NULL_TEXTURE__|__HAVE_DEVICE_COHERENT_READ_WRITE_TEXTURES__)
// builtin=__metal_is_null_texture_cube_t
// DISABLED_BY_LOOP extern "C" bool probe_p07f_is_null_texture_28(texturecube<float> t0) {
// DISABLED_LINE   return metal::is_null_texture(t0);
// DISABLED_LINE }
// DISABLED_LINE #endif

#if defined(__HAVE_PACK_UNPACK_RGB10A2_SNORM_FUNCTIONS__)
// builtin=__metal_pack_snorm_rgb10a2
extern "C" uint probe_p07f_pack_half_to_snorm10a2_29() {
  return metal::pack_half_to_snorm10a2(half4(1.0h));
}
#endif

// DISABLED_LINE #if defined(__HAVE_QUADGROUP__|__HAVE_QUADGROUP_BALLOT__)
// builtin=__metal_quad_active_threads_mask
// DISABLED_BY_LOOP extern "C" quad_vote probe_p07f_quad_active_threads_mask_30() {
// DISABLED_LINE   return metal::quad_active_threads_mask();
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_QUADGROUP__|__HAVE_QUADGROUP_BALLOT__)
// builtin=__metal_quad_all
// DISABLED_BY_LOOP extern "C" bool probe_p07f_quad_all_31() {
// DISABLED_LINE   return metal::quad_all(true);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_QUADGROUP__|__HAVE_QUADGROUP_REDUCTION__)
// builtin=__metal_quad_and
// DISABLED_BY_LOOP extern "C" float probe_p07f_quad_and_32() {
// DISABLED_LINE   return metal::quad_and(1.0f);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_QUADGROUP__|__HAVE_QUADGROUP_BALLOT__)
// builtin=__metal_quad_any
// DISABLED_BY_LOOP extern "C" bool probe_p07f_quad_any_33() {
// DISABLED_LINE   return metal::quad_any(true);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_QUADGROUP__|__HAVE_QUADGROUP_BALLOT__)
// builtin=__metal_quad_ballot
// DISABLED_BY_LOOP extern "C" quad_vote probe_p07f_quad_ballot_34() {
// DISABLED_LINE   return metal::quad_ballot(true);
// DISABLED_LINE }
// DISABLED_LINE #endif

#if defined(__HAVE_QUADGROUP__)
// builtin=__metal_quad_broadcast
extern "C" float probe_p07f_quad_broadcast_35() {
  return metal::quad_broadcast(1.0f, 0);
}
#endif

// DISABLED_LINE #if defined(__HAVE_QUADGROUP__|__HAVE_QUADGROUP_BROADCAST_FIRST__)
// builtin=__metal_quad_broadcast_first
// DISABLED_BY_LOOP extern "C" float probe_p07f_quad_broadcast_first_36() {
// DISABLED_LINE   return metal::quad_broadcast_first(1.0f);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_QUADGROUP__|__HAVE_QUADGROUP_IS_FIRST__)
// builtin=__metal_quad_is_first
// DISABLED_BY_LOOP extern "C" bool probe_p07f_quad_is_first_37() {
// DISABLED_LINE   return metal::quad_is_first();
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_QUADGROUP__|__HAVE_QUADGROUP_REDUCTION__)
// builtin=__metal_quad_is_helper_thread
// DISABLED_BY_LOOP extern "C" bool probe_p07f_quad_is_helper_thread_38() {
// DISABLED_LINE   return metal::quad_is_helper_thread();
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_QUADGROUP__|__HAVE_QUADGROUP_REDUCTION__)
// builtin=__metal_quad_max
// DISABLED_BY_LOOP extern "C" float probe_p07f_quad_max_39() {
// DISABLED_LINE   return metal::quad_max(1.0f);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_QUADGROUP__|__HAVE_QUADGROUP_REDUCTION__)
// builtin=__metal_quad_min
// DISABLED_BY_LOOP extern "C" float probe_p07f_quad_min_40() {
// DISABLED_LINE   return metal::quad_min(1.0f);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_QUADGROUP__|__HAVE_QUADGROUP_REDUCTION__)
// builtin=__metal_quad_or
// DISABLED_BY_LOOP extern "C" float probe_p07f_quad_or_41() {
// DISABLED_LINE   return metal::quad_or(1.0f);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_QUADGROUP__|__HAVE_QUADGROUP_REDUCTION__)
// builtin=__metal_quad_prefix_exclusive_product
// DISABLED_BY_LOOP extern "C" float probe_p07f_quad_prefix_exclusive_product_42() {
// DISABLED_LINE   return metal::quad_prefix_exclusive_product(1.0f);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_QUADGROUP__|__HAVE_QUADGROUP_REDUCTION__)
// builtin=__metal_quad_prefix_exclusive_sum
// DISABLED_BY_LOOP extern "C" float probe_p07f_quad_prefix_exclusive_sum_43() {
// DISABLED_LINE   return metal::quad_prefix_exclusive_sum(1.0f);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_QUADGROUP__|__HAVE_QUADGROUP_REDUCTION__)
// builtin=__metal_quad_prefix_inclusive_product
// DISABLED_BY_LOOP extern "C" float probe_p07f_quad_prefix_inclusive_product_44() {
// DISABLED_LINE   return metal::quad_prefix_inclusive_product(1.0f);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_QUADGROUP__|__HAVE_QUADGROUP_REDUCTION__)
// builtin=__metal_quad_prefix_inclusive_sum
// DISABLED_BY_LOOP extern "C" float probe_p07f_quad_prefix_inclusive_sum_45() {
// DISABLED_LINE   return metal::quad_prefix_inclusive_sum(1.0f);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_QUADGROUP__|__HAVE_QUADGROUP_REDUCTION__)
// builtin=__metal_quad_product
// DISABLED_BY_LOOP extern "C" float probe_p07f_quad_product_46() {
// DISABLED_LINE   return metal::quad_product(1.0f);
// DISABLED_LINE }
// DISABLED_LINE #endif

#if defined(__HAVE_QUADGROUP__)
// builtin=__metal_quad_shuffle
extern "C" float probe_p07f_quad_shuffle_47() {
  return metal::quad_shuffle(1.0f, 0);
}
#endif

// DISABLED_LINE #if defined(__HAVE_QUADGROUP__|__HAVE_QUADGROUP_SHUFFLE_AND_FILL__)
// builtin=__metal_quad_shuffle_and_fill_down
// DISABLED_BY_LOOP extern "C" float probe_p07f_quad_shuffle_and_fill_down_48() {
// DISABLED_LINE   return metal::quad_shuffle_and_fill_down(1.0f, 1.0f, 0);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_QUADGROUP__|__HAVE_QUADGROUP_SHUFFLE_AND_FILL__)
// builtin=__metal_quad_shuffle_and_fill_up
// DISABLED_BY_LOOP extern "C" float probe_p07f_quad_shuffle_and_fill_up_49() {
// DISABLED_LINE   return metal::quad_shuffle_and_fill_up(1.0f, 1.0f, 0);
// DISABLED_LINE }
// DISABLED_LINE #endif

#if defined(__HAVE_QUADGROUP__)
// builtin=__metal_quad_shuffle_down
extern "C" float probe_p07f_quad_shuffle_down_50() {
  return metal::quad_shuffle_down(1.0f, 0);
}
#endif

// DISABLED_LINE #if defined(__HAVE_QUADGROUP__|__HAVE_QUADGROUP_SHUFFLE_ROTATE_DOWN__)
// builtin=__metal_quad_shuffle_rotate_down
// DISABLED_BY_LOOP extern "C" float probe_p07f_quad_shuffle_rotate_down_51() {
// DISABLED_LINE   return metal::quad_shuffle_rotate_down(1.0f, 0);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_QUADGROUP__|__HAVE_QUADGROUP_SHUFFLE_ROTATE_UP__)
// builtin=__metal_quad_shuffle_rotate_up
// DISABLED_BY_LOOP extern "C" float probe_p07f_quad_shuffle_rotate_up_52() {
// DISABLED_LINE   return metal::quad_shuffle_rotate_up(1.0f, 0);
// DISABLED_LINE }
// DISABLED_LINE #endif

#if defined(__HAVE_QUADGROUP__)
// builtin=__metal_quad_shuffle_up
extern "C" float probe_p07f_quad_shuffle_up_53() {
  return metal::quad_shuffle_up(1.0f, 0);
}
#endif

#if defined(__HAVE_QUADGROUP__)
// builtin=__metal_quad_shuffle_xor
extern "C" float probe_p07f_quad_shuffle_xor_54() {
  return metal::quad_shuffle_xor(1.0f, 0);
}
#endif

// DISABLED_LINE #if defined(__HAVE_QUADGROUP__|__HAVE_QUADGROUP_REDUCTION__)
// builtin=__metal_quad_sum
// DISABLED_BY_LOOP extern "C" float probe_p07f_quad_sum_55() {
// DISABLED_LINE   return metal::quad_sum(1.0f);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_QUADGROUP__|__HAVE_QUADGROUP_REDUCTION__)
// builtin=__metal_quad_xor
// DISABLED_BY_LOOP extern "C" float probe_p07f_quad_xor_56() {
// DISABLED_LINE   return metal::quad_xor(1.0f);
// DISABLED_LINE }
// DISABLED_LINE #endif

// builtin=__metal_select
// DISABLED_BY_LOOP extern "C" float probe_p07f_fdim_57() {
// DISABLED_LINE   return metal::fdim(1.0f, 1.0f);
// DISABLED_LINE }

// DISABLED_LINE #if defined(__HAVE_SIMDGROUP__|__HAVE_SIMDGROUP_BALLOT__)
// builtin=__metal_simd_active_threads_mask
// DISABLED_BY_LOOP extern "C" simd_vote probe_p07f_simd_active_threads_mask_58() {
// DISABLED_LINE   return metal::simd_active_threads_mask();
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_SIMDGROUP__|__HAVE_SIMDGROUP_BALLOT__)
// builtin=__metal_simd_all
// DISABLED_BY_LOOP extern "C" bool probe_p07f_simd_all_59() {
// DISABLED_LINE   return metal::simd_all(true);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_SIMDGROUP__|__HAVE_SIMDGROUP_REDUCTION__)
// builtin=__metal_simd_and
// DISABLED_BY_LOOP extern "C" float probe_p07f_simd_and_60() {
// DISABLED_LINE   return metal::simd_and(1.0f);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_SIMDGROUP__|__HAVE_SIMDGROUP_BALLOT__)
// builtin=__metal_simd_any
// DISABLED_BY_LOOP extern "C" bool probe_p07f_simd_any_61() {
// DISABLED_LINE   return metal::simd_any(true);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_SIMDGROUP__|__HAVE_SIMDGROUP_BALLOT__)
// builtin=__metal_simd_ballot
// DISABLED_BY_LOOP extern "C" simd_vote probe_p07f_simd_ballot_62() {
// DISABLED_LINE   return metal::simd_ballot(true);
// DISABLED_LINE }
// DISABLED_LINE #endif

#if defined(__HAVE_SIMDGROUP__)
// builtin=__metal_simd_broadcast
extern "C" float probe_p07f_simd_broadcast_63() {
  return metal::simd_broadcast(1.0f, 0);
}
#endif

// DISABLED_LINE #if defined(__HAVE_SIMDGROUP__|__HAVE_SIMDGROUP_BROADCAST_FIRST__)
// builtin=__metal_simd_broadcast_first
// DISABLED_BY_LOOP extern "C" float probe_p07f_simd_broadcast_first_64() {
// DISABLED_LINE   return metal::simd_broadcast_first(1.0f);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_SIMDGROUP__|__HAVE_SIMDGROUP_IS_FIRST__)
// builtin=__metal_simd_is_first
// DISABLED_BY_LOOP extern "C" bool probe_p07f_simd_is_first_65() {
// DISABLED_LINE   return metal::simd_is_first();
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_SIMDGROUP__|__HAVE_SIMDGROUP_REDUCTION__)
// builtin=__metal_simd_is_helper_thread
// DISABLED_BY_LOOP extern "C" bool probe_p07f_simd_is_helper_thread_66() {
// DISABLED_LINE   return metal::simd_is_helper_thread();
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_SIMDGROUP__|__HAVE_SIMDGROUP_REDUCTION__)
// builtin=__metal_simd_max
// DISABLED_BY_LOOP extern "C" float probe_p07f_simd_max_67() {
// DISABLED_LINE   return metal::simd_max(1.0f);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_SIMDGROUP__|__HAVE_SIMDGROUP_REDUCTION__)
// builtin=__metal_simd_min
// DISABLED_BY_LOOP extern "C" float probe_p07f_simd_min_68() {
// DISABLED_LINE   return metal::simd_min(1.0f);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_SIMDGROUP__|__HAVE_SIMDGROUP_REDUCTION__)
// builtin=__metal_simd_or
// DISABLED_BY_LOOP extern "C" float probe_p07f_simd_or_69() {
// DISABLED_LINE   return metal::simd_or(1.0f);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_SIMDGROUP__|__HAVE_SIMDGROUP_REDUCTION__)
// builtin=__metal_simd_prefix_exclusive_product
// DISABLED_BY_LOOP extern "C" float probe_p07f_simd_prefix_exclusive_product_70() {
// DISABLED_LINE   return metal::simd_prefix_exclusive_product(1.0f);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_SIMDGROUP__|__HAVE_SIMDGROUP_REDUCTION__)
// builtin=__metal_simd_prefix_exclusive_sum
// DISABLED_BY_LOOP extern "C" float probe_p07f_simd_prefix_exclusive_sum_71() {
// DISABLED_LINE   return metal::simd_prefix_exclusive_sum(1.0f);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_SIMDGROUP__|__HAVE_SIMDGROUP_REDUCTION__)
// builtin=__metal_simd_prefix_inclusive_product
// DISABLED_BY_LOOP extern "C" float probe_p07f_simd_prefix_inclusive_product_72() {
// DISABLED_LINE   return metal::simd_prefix_inclusive_product(1.0f);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_SIMDGROUP__|__HAVE_SIMDGROUP_REDUCTION__)
// builtin=__metal_simd_prefix_inclusive_sum
// DISABLED_BY_LOOP extern "C" float probe_p07f_simd_prefix_inclusive_sum_73() {
// DISABLED_LINE   return metal::simd_prefix_inclusive_sum(1.0f);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_SIMDGROUP__|__HAVE_SIMDGROUP_REDUCTION__)
// builtin=__metal_simd_product
// DISABLED_BY_LOOP extern "C" float probe_p07f_simd_product_74() {
// DISABLED_LINE   return metal::simd_product(1.0f);
// DISABLED_LINE }
// DISABLED_LINE #endif

#if defined(__HAVE_SIMDGROUP__)
// builtin=__metal_simd_shuffle
extern "C" float probe_p07f_simd_shuffle_75() {
  return metal::simd_shuffle(1.0f, 0);
}
#endif

// DISABLED_LINE #if defined(__HAVE_SIMDGROUP__|__HAVE_SIMDGROUP_SHUFFLE_AND_FILL__)
// builtin=__metal_simd_shuffle_and_fill_down
// DISABLED_BY_LOOP extern "C" float probe_p07f_simd_shuffle_and_fill_down_76() {
// DISABLED_LINE   return metal::simd_shuffle_and_fill_down(1.0f, 1.0f, 0);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_SIMDGROUP__|__HAVE_SIMDGROUP_SHUFFLE_AND_FILL__)
// builtin=__metal_simd_shuffle_and_fill_up
// DISABLED_BY_LOOP extern "C" float probe_p07f_simd_shuffle_and_fill_up_77() {
// DISABLED_LINE   return metal::simd_shuffle_and_fill_up(1.0f, 1.0f, 0);
// DISABLED_LINE }
// DISABLED_LINE #endif

#if defined(__HAVE_SIMDGROUP__)
// builtin=__metal_simd_shuffle_down
extern "C" float probe_p07f_simd_shuffle_down_78() {
  return metal::simd_shuffle_down(1.0f, 0);
}
#endif

// DISABLED_LINE #if defined(__HAVE_SIMDGROUP__|__HAVE_SIMDGROUP_SHUFFLE_ROTATE_DOWN__)
// builtin=__metal_simd_shuffle_rotate_down
// DISABLED_BY_LOOP extern "C" float probe_p07f_simd_shuffle_rotate_down_79() {
// DISABLED_LINE   return metal::simd_shuffle_rotate_down(1.0f, 0);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_SIMDGROUP__|__HAVE_SIMDGROUP_SHUFFLE_ROTATE_UP__)
// builtin=__metal_simd_shuffle_rotate_up
// DISABLED_BY_LOOP extern "C" float probe_p07f_simd_shuffle_rotate_up_80() {
// DISABLED_LINE   return metal::simd_shuffle_rotate_up(1.0f, 0);
// DISABLED_LINE }
// DISABLED_LINE #endif

#if defined(__HAVE_SIMDGROUP__)
// builtin=__metal_simd_shuffle_up
extern "C" float probe_p07f_simd_shuffle_up_81() {
  return metal::simd_shuffle_up(1.0f, 0);
}
#endif

#if defined(__HAVE_SIMDGROUP__)
// builtin=__metal_simd_shuffle_xor
extern "C" float probe_p07f_simd_shuffle_xor_82() {
  return metal::simd_shuffle_xor(1.0f, 0);
}
#endif

// DISABLED_LINE #if defined(__HAVE_SIMDGROUP__|__HAVE_SIMDGROUP_REDUCTION__)
// builtin=__metal_simd_sum
// DISABLED_BY_LOOP extern "C" float probe_p07f_simd_sum_83() {
// DISABLED_LINE   return metal::simd_sum(1.0f);
// DISABLED_LINE }
// DISABLED_LINE #endif

// DISABLED_LINE #if defined(__HAVE_SIMDGROUP__|__HAVE_SIMDGROUP_REDUCTION__)
// builtin=__metal_simd_xor
// DISABLED_BY_LOOP extern "C" float probe_p07f_simd_xor_84() {
// DISABLED_LINE   return metal::simd_xor(1.0f);
// DISABLED_LINE }
// DISABLED_LINE #endif

#if defined(__HAVE_BARRIER_MEMORY_SCOPE__)
// builtin=__metal_simdgroup_barrier
extern "C" void probe_p07f_simdgroup_barrier_85() {
  metal::simdgroup_barrier(mem_flags::mem_device);
}
#endif

#if defined(__HAVE_PACK_UNPACK_RGB10A2_SNORM_FUNCTIONS__)
// builtin=__metal_unpack_snorm_rgb10a2
extern "C" half4 probe_p07f_unpack_snorm10a2_to_half_86() {
  return metal::unpack_snorm10a2_to_half(0u);
}
#endif

#if defined(__HAVE_VISIBLE_FUNCTION_TABLE__)
// builtin=__metal_visible_function_table_t
// DISABLED_BY_LOOP extern "C" bool probe_p07f_is_null_visible_function_table_87(visible_function_table<> vft) {
// DISABLED_LINE   return metal::is_null_visible_function_table(vft);
// DISABLED_LINE }
#endif
