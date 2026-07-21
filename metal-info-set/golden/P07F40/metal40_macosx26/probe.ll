; ModuleID = 'probe.metal'
source_filename = "probe.metal"
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-n8:16:32"
target triple = "air64_v28-apple-macosx26.0.0"

%struct._depth_2d_array_t = type opaque
%struct._depth_2d_ms_array_t = type opaque
%struct._depth_2d_ms_t = type opaque
%struct._depth_2d_t = type opaque
%struct._depth_cube_array_t = type opaque
%struct._depth_cube_t = type opaque
%struct._function_handle_t = type opaque
%struct._texture_1d_array_t = type opaque
%struct._texture_1d_t = type opaque
%struct._texture_2d_array_t = type opaque
%struct._texture_2d_ms_array_t = type opaque
%struct._texture_2d_ms_t = type opaque
%struct._texture_2d_t = type opaque
%struct._texture_3d_t = type opaque
%struct._texture_buffer_1d_t = type opaque
%struct._texture_cube_t = type opaque
%"struct.metal::quad_vote" = type { i16 }
%"struct.metal::simd_vote" = type { i64 }

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define <2 x float> @probe_p07f_get_sample_position_2() local_unnamed_addr #0 {
  %1 = tail call fast <2 x float> @air.get_sample_position.v2f32(i32 0, i32 0) #9
  ret <2 x float> %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_simd_shuffle_and_fill_up_3() local_unnamed_addr #1 {
  %1 = tail call i16 @air.get_simdgroup_size.i16() #9
  %2 = tail call fast float @air.simd_shuffle_and_fill_up.f32(float 1.000000e+00, float 1.000000e+00, i16 0, i16 %1) #10
  ret float %2
}

; Function Attrs: convergent mustprogress nounwind
define i32 @probe_p07f_ilogb_5() local_unnamed_addr #2 {
  %1 = tail call i32 @___metal_ilogb_float(float 1.000000e+00, i32 0) #11
  ret i32 %1
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p07f_is_null_texture_6(%struct._depth_2d_array_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #3 {
  %2 = tail call i1 @air.is_null_depth_2d_array(%struct._depth_2d_array_t addrspace(1)* nocapture readonly %0) #12
  ret i1 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p07f_is_null_texture_7(%struct._depth_2d_ms_array_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #3 {
  %2 = tail call i1 @air.is_null_depth_2d_ms_array(%struct._depth_2d_ms_array_t addrspace(1)* nocapture readonly %0) #12
  ret i1 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p07f_is_null_texture_8(%struct._depth_2d_ms_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #3 {
  %2 = tail call i1 @air.is_null_depth_2d_ms(%struct._depth_2d_ms_t addrspace(1)* nocapture readonly %0) #12
  ret i1 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p07f_is_null_texture_9(%struct._depth_2d_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #3 {
  %2 = tail call i1 @air.is_null_depth_2d(%struct._depth_2d_t addrspace(1)* nocapture readonly %0) #12
  ret i1 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p07f_is_null_texture_10(%struct._depth_cube_array_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #3 {
  %2 = tail call i1 @air.is_null_depth_cube_array(%struct._depth_cube_array_t addrspace(1)* nocapture readonly %0) #12
  ret i1 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p07f_is_null_texture_11(%struct._depth_cube_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #3 {
  %2 = tail call i1 @air.is_null_depth_cube(%struct._depth_cube_t addrspace(1)* nocapture readonly %0) #12
  ret i1 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p07f_is_null_function_handle_12(%struct._function_handle_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #3 {
  %2 = tail call i1 @air.is_null_function_handle(%struct._function_handle_t addrspace(1)* nocapture readonly %0) #12
  ret i1 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p07f_is_null_texture_14(%struct._texture_1d_array_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #3 {
  %2 = tail call i1 @air.is_null_texture_1d_array(%struct._texture_1d_array_t addrspace(1)* nocapture readonly %0) #12
  ret i1 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p07f_is_null_texture_15(%struct._texture_1d_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #3 {
  %2 = tail call i1 @air.is_null_texture_1d(%struct._texture_1d_t addrspace(1)* nocapture readonly %0) #12
  ret i1 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p07f_is_null_texture_16(%struct._texture_2d_array_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #3 {
  %2 = tail call i1 @air.is_null_texture_2d_array(%struct._texture_2d_array_t addrspace(1)* nocapture readonly %0) #12
  ret i1 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p07f_is_null_texture_17(%struct._texture_2d_ms_array_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #3 {
  %2 = tail call i1 @air.is_null_texture_2d_ms_array(%struct._texture_2d_ms_array_t addrspace(1)* nocapture readonly %0) #12
  ret i1 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p07f_is_null_texture_18(%struct._texture_2d_ms_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #3 {
  %2 = tail call i1 @air.is_null_texture_2d_ms(%struct._texture_2d_ms_t addrspace(1)* nocapture readonly %0) #12
  ret i1 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p07f_is_null_texture_19(%struct._texture_2d_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #3 {
  %2 = tail call i1 @air.is_null_texture_2d(%struct._texture_2d_t addrspace(1)* nocapture readonly %0) #12
  ret i1 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p07f_is_null_texture_20(%struct._texture_3d_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #3 {
  %2 = tail call i1 @air.is_null_texture_3d(%struct._texture_3d_t addrspace(1)* nocapture readonly %0) #12
  ret i1 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p07f_is_null_texture_21(%struct._texture_buffer_1d_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #3 {
  %2 = tail call i1 @air.is_null_texture_buffer_1d(%struct._texture_buffer_1d_t addrspace(1)* nocapture readonly %0) #12
  ret i1 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p07f_is_null_texture_22(%struct._texture_cube_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #3 {
  %2 = tail call i1 @air.is_null_texture_cube(%struct._texture_cube_t addrspace(1)* nocapture readonly %0) #12
  ret i1 %2
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define i32 @probe_p07f_pack_half_to_snorm10a2_23() local_unnamed_addr #0 {
  %1 = tail call i32 @air.pack.snorm.rgb10a2.v4f16(<4 x half> <half 0xH3C00, half 0xH3C00, half 0xH3C00, half 0xH3C00>) #9
  ret i32 %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define %"struct.metal::quad_vote" @probe_p07f_quad_active_threads_mask_24() local_unnamed_addr #1 {
  %1 = tail call i16 @air.quad_active_threads_mask() #10
  %2 = and i16 %1, 15
  %3 = insertvalue %"struct.metal::quad_vote" poison, i16 %2, 0
  ret %"struct.metal::quad_vote" %3
}

; Function Attrs: convergent mustprogress nounwind willreturn
define zeroext i1 @probe_p07f_quad_all_25() local_unnamed_addr #1 {
  %1 = tail call i1 @air.quad_all(i1 true) #10
  ret i1 %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define zeroext i1 @probe_p07f_quad_any_27() local_unnamed_addr #1 {
  %1 = tail call i1 @air.quad_any(i1 true) #10
  ret i1 %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define %"struct.metal::quad_vote" @probe_p07f_quad_ballot_28() local_unnamed_addr #1 {
  %1 = tail call i16 @air.quad_ballot(i1 true) #10
  %2 = and i16 %1, 15
  %3 = insertvalue %"struct.metal::quad_vote" poison, i16 %2, 0
  ret %"struct.metal::quad_vote" %3
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_quad_broadcast_first_29() local_unnamed_addr #1 {
  %1 = tail call fast float @air.quad_broadcast_first.f32(float 1.000000e+00) #10
  ret float %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define zeroext i1 @probe_p07f_quad_is_first_30() local_unnamed_addr #1 {
  %1 = tail call i1 @air.quad_is_first() #10
  ret i1 %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define zeroext i1 @probe_p07f_quad_is_helper_thread_31() local_unnamed_addr #1 {
  %1 = tail call i1 @air.quad_is_helper_thread() #10
  ret i1 %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_quad_max_32() local_unnamed_addr #1 {
  %1 = tail call fast float @air.quad_max.f32(float 1.000000e+00) #10
  ret float %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_quad_min_33() local_unnamed_addr #1 {
  %1 = tail call fast float @air.quad_min.f32(float 1.000000e+00) #10
  ret float %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_quad_prefix_exclusive_product_35() local_unnamed_addr #1 {
  %1 = tail call fast float @air.quad_prefix_exclusive_product.f32(float 1.000000e+00) #10
  ret float %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_quad_prefix_exclusive_sum_36() local_unnamed_addr #1 {
  %1 = tail call fast float @air.quad_prefix_exclusive_sum.f32(float 1.000000e+00) #10
  ret float %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_quad_prefix_inclusive_product_37() local_unnamed_addr #1 {
  %1 = tail call fast float @air.quad_prefix_inclusive_product.f32(float 1.000000e+00) #10
  ret float %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_quad_prefix_inclusive_sum_38() local_unnamed_addr #1 {
  %1 = tail call fast float @air.quad_prefix_inclusive_sum.f32(float 1.000000e+00) #10
  ret float %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_quad_product_39() local_unnamed_addr #1 {
  %1 = tail call fast float @air.quad_product.f32(float 1.000000e+00) #10
  ret float %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_quad_shuffle_and_fill_down_40() local_unnamed_addr #1 {
  %1 = tail call fast float @air.quad_shuffle_and_fill_down.f32(float 1.000000e+00, float 1.000000e+00, i16 0, i16 4) #10
  ret float %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_quad_shuffle_and_fill_up_41() local_unnamed_addr #1 {
  %1 = tail call fast float @air.quad_shuffle_and_fill_up.f32(float 1.000000e+00, float 1.000000e+00, i16 0, i16 4) #10
  ret float %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_quad_shuffle_rotate_down_42() local_unnamed_addr #1 {
  %1 = tail call fast float @air.quad_shuffle_rotate_down.f32(float 1.000000e+00, i16 0) #10
  ret float %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_quad_shuffle_rotate_up_43() local_unnamed_addr #1 {
  %1 = tail call fast float @air.quad_shuffle_rotate_up.f32(float 1.000000e+00, i16 0) #10
  ret float %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_quad_sum_44() local_unnamed_addr #1 {
  %1 = tail call fast float @air.quad_sum.f32(float 1.000000e+00) #10
  ret float %1
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define float @probe_p07f_fdim_46() local_unnamed_addr #4 {
  ret float 0.000000e+00
}

; Function Attrs: convergent mustprogress nounwind willreturn
define %"struct.metal::simd_vote" @probe_p07f_simd_active_threads_mask_47() local_unnamed_addr #1 {
  %1 = tail call i64 @air.simd_active_threads_mask.i64() #10
  %2 = insertvalue %"struct.metal::simd_vote" poison, i64 %1, 0
  ret %"struct.metal::simd_vote" %2
}

; Function Attrs: convergent mustprogress nounwind willreturn
define zeroext i1 @probe_p07f_simd_all_48() local_unnamed_addr #1 {
  %1 = tail call i1 @air.simd_all(i1 true) #10
  ret i1 %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define zeroext i1 @probe_p07f_simd_any_50() local_unnamed_addr #1 {
  %1 = tail call i1 @air.simd_any(i1 true) #10
  ret i1 %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define %"struct.metal::simd_vote" @probe_p07f_simd_ballot_51() local_unnamed_addr #1 {
  %1 = tail call i64 @air.simd_ballot.i64(i1 true) #10
  %2 = insertvalue %"struct.metal::simd_vote" poison, i64 %1, 0
  ret %"struct.metal::simd_vote" %2
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_simd_broadcast_first_52() local_unnamed_addr #1 {
  %1 = tail call fast float @air.simd_broadcast_first.f32(float 1.000000e+00) #10
  ret float %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define zeroext i1 @probe_p07f_simd_is_first_53() local_unnamed_addr #1 {
  %1 = tail call i1 @air.simd_is_first() #10
  ret i1 %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define zeroext i1 @probe_p07f_simd_is_helper_thread_54() local_unnamed_addr #1 {
  %1 = tail call i1 @air.simd_is_helper_thread() #10
  ret i1 %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_simd_max_55() local_unnamed_addr #1 {
  %1 = tail call fast float @air.simd_max.f32(float 1.000000e+00) #10
  ret float %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_simd_min_56() local_unnamed_addr #1 {
  %1 = tail call fast float @air.simd_min.f32(float 1.000000e+00) #10
  ret float %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_simd_prefix_exclusive_product_58() local_unnamed_addr #1 {
  %1 = tail call fast float @air.simd_prefix_exclusive_product.f32(float 1.000000e+00) #10
  ret float %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_simd_prefix_exclusive_sum_59() local_unnamed_addr #1 {
  %1 = tail call fast float @air.simd_prefix_exclusive_sum.f32(float 1.000000e+00) #10
  ret float %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_simd_prefix_inclusive_product_60() local_unnamed_addr #1 {
  %1 = tail call fast float @air.simd_prefix_inclusive_product.f32(float 1.000000e+00) #10
  ret float %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_simd_prefix_inclusive_sum_61() local_unnamed_addr #1 {
  %1 = tail call fast float @air.simd_prefix_inclusive_sum.f32(float 1.000000e+00) #10
  ret float %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_simd_product_62() local_unnamed_addr #1 {
  %1 = tail call fast float @air.simd_product.f32(float 1.000000e+00) #10
  ret float %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_simd_shuffle_and_fill_down_63() local_unnamed_addr #1 {
  %1 = tail call i16 @air.get_simdgroup_size.i16() #9
  %2 = tail call fast float @air.simd_shuffle_and_fill_down.f32(float 1.000000e+00, float 1.000000e+00, i16 0, i16 %1) #10
  ret float %2
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_simd_shuffle_and_fill_up_64() local_unnamed_addr #1 {
  %1 = tail call i16 @air.get_simdgroup_size.i16() #9
  %2 = tail call fast float @air.simd_shuffle_and_fill_up.f32(float 1.000000e+00, float 1.000000e+00, i16 0, i16 %1) #10
  ret float %2
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_simd_shuffle_rotate_down_65() local_unnamed_addr #1 {
  %1 = tail call fast float @air.simd_shuffle_rotate_down.f32(float 1.000000e+00, i16 0) #10
  ret float %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_simd_shuffle_rotate_up_66() local_unnamed_addr #1 {
  %1 = tail call fast float @air.simd_shuffle_rotate_up.f32(float 1.000000e+00, i16 0) #10
  ret float %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_simd_sum_67() local_unnamed_addr #1 {
  %1 = tail call fast float @air.simd_sum.f32(float 1.000000e+00) #10
  ret float %1
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define <4 x half> @probe_p07f_unpack_snorm10a2_to_half_69() local_unnamed_addr #0 {
  %1 = tail call fast <4 x half> @air.unpack.snorm.rgb10a2.v4f16(i32 0) #9
  ret <4 x half> %1
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare <2 x float> @air.get_sample_position.v2f32(i32, i32) local_unnamed_addr #5

; Function Attrs: convergent
declare i32 @___metal_ilogb_float(float, i32) local_unnamed_addr #6

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i1 @air.is_null_function_handle(%struct._function_handle_t addrspace(1)* nocapture readonly) local_unnamed_addr #7

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare i32 @air.pack.snorm.rgb10a2.v4f16(<4 x half>) local_unnamed_addr #5

; Function Attrs: convergent mustprogress nounwind willreturn
declare i16 @air.quad_active_threads_mask() local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare i1 @air.quad_all(i1) local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare i1 @air.quad_any(i1) local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare i16 @air.quad_ballot(i1) local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare i1 @air.quad_is_first() local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare i1 @air.quad_is_helper_thread() local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare i64 @air.simd_active_threads_mask.i64() local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare i1 @air.simd_all(i1) local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare i1 @air.simd_any(i1) local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare i64 @air.simd_ballot.i64(i1) local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare i1 @air.simd_is_first() local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare i1 @air.simd_is_helper_thread() local_unnamed_addr #8

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare <4 x half> @air.unpack.snorm.rgb10a2.v4f16(i32) local_unnamed_addr #5

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare i16 @air.get_simdgroup_size.i16() local_unnamed_addr #5

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.simd_shuffle_and_fill_up.f32(float, float, i16, i16) local_unnamed_addr #8

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i1 @air.is_null_depth_2d_array(%struct._depth_2d_array_t addrspace(1)* nocapture readonly) local_unnamed_addr #7

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i1 @air.is_null_depth_2d_ms_array(%struct._depth_2d_ms_array_t addrspace(1)* nocapture readonly) local_unnamed_addr #7

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i1 @air.is_null_depth_2d_ms(%struct._depth_2d_ms_t addrspace(1)* nocapture readonly) local_unnamed_addr #7

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i1 @air.is_null_depth_2d(%struct._depth_2d_t addrspace(1)* nocapture readonly) local_unnamed_addr #7

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i1 @air.is_null_depth_cube_array(%struct._depth_cube_array_t addrspace(1)* nocapture readonly) local_unnamed_addr #7

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i1 @air.is_null_depth_cube(%struct._depth_cube_t addrspace(1)* nocapture readonly) local_unnamed_addr #7

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i1 @air.is_null_texture_1d_array(%struct._texture_1d_array_t addrspace(1)* nocapture readonly) local_unnamed_addr #7

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i1 @air.is_null_texture_1d(%struct._texture_1d_t addrspace(1)* nocapture readonly) local_unnamed_addr #7

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i1 @air.is_null_texture_2d_array(%struct._texture_2d_array_t addrspace(1)* nocapture readonly) local_unnamed_addr #7

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i1 @air.is_null_texture_2d_ms_array(%struct._texture_2d_ms_array_t addrspace(1)* nocapture readonly) local_unnamed_addr #7

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i1 @air.is_null_texture_2d_ms(%struct._texture_2d_ms_t addrspace(1)* nocapture readonly) local_unnamed_addr #7

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i1 @air.is_null_texture_2d(%struct._texture_2d_t addrspace(1)* nocapture readonly) local_unnamed_addr #7

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i1 @air.is_null_texture_3d(%struct._texture_3d_t addrspace(1)* nocapture readonly) local_unnamed_addr #7

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i1 @air.is_null_texture_buffer_1d(%struct._texture_buffer_1d_t addrspace(1)* nocapture readonly) local_unnamed_addr #7

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i1 @air.is_null_texture_cube(%struct._texture_cube_t addrspace(1)* nocapture readonly) local_unnamed_addr #7

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.quad_broadcast_first.f32(float) local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.quad_max.f32(float) local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.quad_min.f32(float) local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.quad_prefix_exclusive_product.f32(float) local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.quad_prefix_exclusive_sum.f32(float) local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.quad_prefix_inclusive_product.f32(float) local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.quad_prefix_inclusive_sum.f32(float) local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.quad_product.f32(float) local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.quad_shuffle_and_fill_down.f32(float, float, i16, i16) local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.quad_shuffle_and_fill_up.f32(float, float, i16, i16) local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.quad_shuffle_rotate_down.f32(float, i16) local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.quad_shuffle_rotate_up.f32(float, i16) local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.quad_sum.f32(float) local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.simd_broadcast_first.f32(float) local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.simd_max.f32(float) local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.simd_min.f32(float) local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.simd_prefix_exclusive_product.f32(float) local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.simd_prefix_exclusive_sum.f32(float) local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.simd_prefix_inclusive_product.f32(float) local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.simd_prefix_inclusive_sum.f32(float) local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.simd_product.f32(float) local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.simd_shuffle_and_fill_down.f32(float, float, i16, i16) local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.simd_shuffle_rotate_down.f32(float, i16) local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.simd_shuffle_rotate_up.f32(float, i16) local_unnamed_addr #8

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.simd_sum.f32(float) local_unnamed_addr #8

attributes #0 = { mustprogress nofree nosync nounwind readnone willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="64" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #1 = { convergent mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #2 = { convergent mustprogress nounwind "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #3 = { argmemonly mustprogress nofree nounwind readonly willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #4 = { mustprogress nofree norecurse nosync nounwind readnone willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" }
attributes #5 = { mustprogress nofree nosync nounwind readnone willreturn }
attributes #6 = { convergent }
attributes #7 = { argmemonly mustprogress nofree nounwind readonly willreturn }
attributes #8 = { convergent mustprogress nounwind willreturn }
attributes #9 = { nounwind readnone willreturn }
attributes #10 = { convergent nounwind willreturn }
attributes #11 = { convergent nounwind }
attributes #12 = { argmemonly nounwind readonly willreturn }

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5, !6, !7, !8}
!air.compile_options = !{!9, !10, !11}
!llvm.ident = !{!12}
!air.version = !{!13}
!air.language_version = !{!14}
!air.source_file_name = !{!15}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 26, i32 5]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"frame-pointer", i32 2}
!3 = !{i32 7, !"air.max_device_buffers", i32 31}
!4 = !{i32 7, !"air.max_constant_buffers", i32 31}
!5 = !{i32 7, !"air.max_threadgroup_buffers", i32 31}
!6 = !{i32 7, !"air.max_textures", i32 128}
!7 = !{i32 7, !"air.max_read_write_textures", i32 8}
!8 = !{i32 7, !"air.max_samplers", i32 16}
!9 = !{!"air.compile.denorms_disable"}
!10 = !{!"air.compile.fast_math_enable"}
!11 = !{!"air.compile.framebuffer_fetch_enable"}
!12 = !{!"Apple metal version 32023.883 (metalfe-32023.883)"}
!13 = !{i32 2, i32 8, i32 0}
!14 = !{!"Metal", i32 4, i32 0, i32 0}
!15 = !{!"/Users/runner/metal_probe/p3/P07F/probe.metal"}
