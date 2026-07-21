; ModuleID = 'probe.metal'
source_filename = "probe.metal"
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-n8:16:32"
target triple = "air64_v28-apple-macosx26.0.0"

%struct._texture_buffer_1d_t = type opaque
%struct._depth_2d_array_t = type opaque
%struct._sampler_t = type opaque
%struct._depth_2d_t = type opaque
%struct._depth_cube_array_t = type opaque
%struct._depth_cube_t = type opaque
%struct._texture_2d_array_t = type opaque
%struct._texture_2d_t = type opaque
%struct._texture_3d_t = type opaque
%struct._texture_cube_array_t = type opaque
%struct._texture_cube_t = type opaque
%struct._texture_1d_array_t = type opaque
%struct._texture_1d_t = type opaque
%"struct.metal::sparse_color" = type <{ <4 x float>, i64, [8 x i8] }>
%struct._depth_2d_ms_array_t = type opaque

; Function Attrs: mustprogress nounwind willreturn
define <4 x i32> @probe_p06m_atomic_exchange_0(%struct._texture_buffer_1d_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  %2 = tail call <4 x i32> @air.atomic_exchange_explicit_texture_buffer_1d.u.v4i32(%struct._texture_buffer_1d_t addrspace(1)* nocapture %0, i32 0, <4 x i32> zeroinitializer, i32 0, i32 3) #14
  ret <4 x i32> %2
}

; Function Attrs: mustprogress nounwind willreturn
define <4 x i32> @probe_p06m_atomic_fetch_add_3(%struct._texture_buffer_1d_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  %2 = tail call <4 x i32> @air.atomic_fetch_add_explicit_texture_buffer_1d.u.v4i32(%struct._texture_buffer_1d_t addrspace(1)* nocapture %0, i32 0, <4 x i32> zeroinitializer, i32 0, i32 3) #14
  ret <4 x i32> %2
}

; Function Attrs: mustprogress nounwind willreturn
define <4 x i32> @probe_p06m_atomic_fetch_and_6(%struct._texture_buffer_1d_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  %2 = tail call <4 x i32> @air.atomic_fetch_and_explicit_texture_buffer_1d.u.v4i32(%struct._texture_buffer_1d_t addrspace(1)* nocapture %0, i32 0, <4 x i32> zeroinitializer, i32 0, i32 3) #14
  ret <4 x i32> %2
}

; Function Attrs: mustprogress nounwind willreturn
define <4 x i32> @probe_p06m_atomic_fetch_max_9(%struct._texture_buffer_1d_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  %2 = tail call <4 x i32> @air.atomic_fetch_max_explicit_texture_buffer_1d.u.v4i32(%struct._texture_buffer_1d_t addrspace(1)* nocapture %0, i32 0, <4 x i32> zeroinitializer, i32 0, i32 3) #14
  ret <4 x i32> %2
}

; Function Attrs: mustprogress nounwind willreturn
define <4 x i32> @probe_p06m_atomic_fetch_min_12(%struct._texture_buffer_1d_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  %2 = tail call <4 x i32> @air.atomic_fetch_min_explicit_texture_buffer_1d.u.v4i32(%struct._texture_buffer_1d_t addrspace(1)* nocapture %0, i32 0, <4 x i32> zeroinitializer, i32 0, i32 3) #14
  ret <4 x i32> %2
}

; Function Attrs: mustprogress nounwind willreturn
define <4 x i32> @probe_p06m_atomic_fetch_or_15(%struct._texture_buffer_1d_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  %2 = tail call <4 x i32> @air.atomic_fetch_or_explicit_texture_buffer_1d.u.v4i32(%struct._texture_buffer_1d_t addrspace(1)* nocapture %0, i32 0, <4 x i32> zeroinitializer, i32 0, i32 3) #14
  ret <4 x i32> %2
}

; Function Attrs: mustprogress nounwind willreturn
define <4 x i32> @probe_p06m_atomic_fetch_sub_18(%struct._texture_buffer_1d_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  %2 = tail call <4 x i32> @air.atomic_fetch_sub_explicit_texture_buffer_1d.u.v4i32(%struct._texture_buffer_1d_t addrspace(1)* nocapture %0, i32 0, <4 x i32> zeroinitializer, i32 0, i32 3) #14
  ret <4 x i32> %2
}

; Function Attrs: mustprogress nounwind willreturn
define <4 x i32> @probe_p06m_atomic_fetch_xor_21(%struct._texture_buffer_1d_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  %2 = tail call <4 x i32> @air.atomic_fetch_xor_explicit_texture_buffer_1d.u.v4i32(%struct._texture_buffer_1d_t addrspace(1)* nocapture %0, i32 0, <4 x i32> zeroinitializer, i32 0, i32 3) #14
  ret <4 x i32> %2
}

; Function Attrs: mustprogress nounwind willreturn
define <4 x i32> @probe_p06m_atomic_load_24(%struct._texture_buffer_1d_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  %2 = tail call <4 x i32> @air.atomic_load_explicit_texture_buffer_1d.u.v4i32(%struct._texture_buffer_1d_t addrspace(1)* nocapture %0, i32 0, i32 0, i32 3) #14
  ret <4 x i32> %2
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p06m_atomic_store_43(%struct._texture_buffer_1d_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  tail call void @air.atomic_store_explicit_texture_buffer_1d.u.v4i32(%struct._texture_buffer_1d_t addrspace(1)* nocapture %0, <4 x i32> zeroinitializer, i32 0, i32 0, i32 3) #14
  ret void
}

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
define float @probe_p06m_calculate_clamped_lod_46(%struct._depth_2d_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #1 {
  %3 = tail call fast float @air.calculate_clamped_lod_depth_2d_array(%struct._depth_2d_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, <2 x float> <float 1.000000e+00, float 1.000000e+00>, i32 0) #15
  ret float %3
}

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
define float @probe_p06m_calculate_clamped_lod_47(%struct._depth_2d_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #1 {
  %3 = tail call fast float @air.calculate_clamped_lod_depth_2d(%struct._depth_2d_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, <2 x float> <float 1.000000e+00, float 1.000000e+00>, i32 0) #15
  ret float %3
}

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
define float @probe_p06m_calculate_clamped_lod_48(%struct._depth_cube_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #2 {
  %3 = tail call fast float @air.calculate_clamped_lod_depth_cube_array(%struct._depth_cube_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, <3 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, i32 0) #15
  ret float %3
}

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
define float @probe_p06m_calculate_clamped_lod_49(%struct._depth_cube_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #2 {
  %3 = tail call fast float @air.calculate_clamped_lod_depth_cube(%struct._depth_cube_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, <3 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, i32 0) #15
  ret float %3
}

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
define float @probe_p06m_calculate_clamped_lod_50(%struct._texture_2d_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #1 {
  %3 = tail call fast float @air.calculate_clamped_lod_texture_2d_array(%struct._texture_2d_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, <2 x float> <float 1.000000e+00, float 1.000000e+00>, i32 0) #15
  ret float %3
}

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
define float @probe_p06m_calculate_clamped_lod_51(%struct._texture_2d_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #1 {
  %3 = tail call fast float @air.calculate_clamped_lod_texture_2d(%struct._texture_2d_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, <2 x float> <float 1.000000e+00, float 1.000000e+00>, i32 0) #15
  ret float %3
}

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
define float @probe_p06m_calculate_clamped_lod_52(%struct._texture_3d_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #2 {
  %3 = tail call fast float @air.calculate_clamped_lod_texture_3d(%struct._texture_3d_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, <3 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, i32 0) #15
  ret float %3
}

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
define float @probe_p06m_calculate_clamped_lod_53(%struct._texture_cube_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #2 {
  %3 = tail call fast float @air.calculate_clamped_lod_texture_cube_array(%struct._texture_cube_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, <3 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, i32 0) #15
  ret float %3
}

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
define float @probe_p06m_calculate_clamped_lod_54(%struct._texture_cube_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #2 {
  %3 = tail call fast float @air.calculate_clamped_lod_texture_cube(%struct._texture_cube_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, <3 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, i32 0) #15
  ret float %3
}

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
define float @probe_p06m_calculate_unclamped_lod_55(%struct._depth_2d_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #1 {
  %3 = tail call fast float @air.calculate_unclamped_lod_depth_2d_array(%struct._depth_2d_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, <2 x float> <float 1.000000e+00, float 1.000000e+00>, i32 0) #15
  ret float %3
}

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
define float @probe_p06m_calculate_unclamped_lod_56(%struct._depth_2d_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #1 {
  %3 = tail call fast float @air.calculate_unclamped_lod_depth_2d(%struct._depth_2d_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, <2 x float> <float 1.000000e+00, float 1.000000e+00>, i32 0) #15
  ret float %3
}

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
define float @probe_p06m_calculate_unclamped_lod_57(%struct._depth_cube_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #2 {
  %3 = tail call fast float @air.calculate_unclamped_lod_depth_cube_array(%struct._depth_cube_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, <3 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, i32 0) #15
  ret float %3
}

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
define float @probe_p06m_calculate_unclamped_lod_58(%struct._depth_cube_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #2 {
  %3 = tail call fast float @air.calculate_unclamped_lod_depth_cube(%struct._depth_cube_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, <3 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, i32 0) #15
  ret float %3
}

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
define float @probe_p06m_calculate_unclamped_lod_59(%struct._texture_2d_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #1 {
  %3 = tail call fast float @air.calculate_unclamped_lod_texture_2d_array(%struct._texture_2d_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, <2 x float> <float 1.000000e+00, float 1.000000e+00>, i32 0) #15
  ret float %3
}

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
define float @probe_p06m_calculate_unclamped_lod_60(%struct._texture_2d_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #1 {
  %3 = tail call fast float @air.calculate_unclamped_lod_texture_2d(%struct._texture_2d_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, <2 x float> <float 1.000000e+00, float 1.000000e+00>, i32 0) #15
  ret float %3
}

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
define float @probe_p06m_calculate_unclamped_lod_61(%struct._texture_3d_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #2 {
  %3 = tail call fast float @air.calculate_unclamped_lod_texture_3d(%struct._texture_3d_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, <3 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, i32 0) #15
  ret float %3
}

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
define float @probe_p06m_calculate_unclamped_lod_62(%struct._texture_cube_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #2 {
  %3 = tail call fast float @air.calculate_unclamped_lod_texture_cube_array(%struct._texture_cube_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, <3 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, i32 0) #15
  ret float %3
}

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
define float @probe_p06m_calculate_unclamped_lod_63(%struct._texture_cube_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #2 {
  %3 = tail call fast float @air.calculate_unclamped_lod_texture_cube(%struct._texture_cube_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, <3 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, i32 0) #15
  ret float %3
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p06m_fence_64(%struct._texture_1d_array_t addrspace(1)* nocapture %0) local_unnamed_addr #3 {
  tail call void @air.fence_texture_1d_array(%struct._texture_1d_array_t addrspace(1)* nocapture %0) #14
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p06m_fence_65(%struct._texture_1d_t addrspace(1)* nocapture %0) local_unnamed_addr #3 {
  tail call void @air.fence_texture_1d(%struct._texture_1d_t addrspace(1)* nocapture %0) #14
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p06m_fence_66(%struct._texture_2d_array_t addrspace(1)* nocapture %0) local_unnamed_addr #3 {
  tail call void @air.fence_texture_2d_array(%struct._texture_2d_array_t addrspace(1)* nocapture %0) #14
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p06m_fence_67(%struct._texture_2d_t addrspace(1)* nocapture %0) local_unnamed_addr #3 {
  tail call void @air.fence_texture_2d(%struct._texture_2d_t addrspace(1)* nocapture %0) #14
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p06m_fence_68(%struct._texture_3d_t addrspace(1)* nocapture %0) local_unnamed_addr #3 {
  tail call void @air.fence_texture_3d(%struct._texture_3d_t addrspace(1)* nocapture %0) #14
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p06m_fence_69(%struct._texture_buffer_1d_t addrspace(1)* nocapture %0) local_unnamed_addr #3 {
  tail call void @air.fence_texture_buffer_1d(%struct._texture_buffer_1d_t addrspace(1)* nocapture %0) #14
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p06m_fence_70(%struct._texture_cube_array_t addrspace(1)* nocapture %0) local_unnamed_addr #3 {
  tail call void @air.fence_texture_cube_array(%struct._texture_cube_array_t addrspace(1)* nocapture %0) #14
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p06m_fence_71(%struct._texture_cube_t addrspace(1)* nocapture %0) local_unnamed_addr #3 {
  tail call void @air.fence_texture_cube(%struct._texture_cube_t addrspace(1)* nocapture %0) #14
  ret void
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define <4 x float> @probe_p06m_gather_compare_72(%struct._depth_2d_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #4 {
  %3 = tail call { <4 x float>, i8 } @air.gather_compare_depth_2d.f32(%struct._depth_2d_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, i32 1, <2 x float> <float 1.000000e+00, float 1.000000e+00>, float 1.000000e+00, i1 true, <2 x i32> zeroinitializer, i32 0) #16
  %4 = extractvalue { <4 x float>, i8 } %3, 0
  ret <4 x float> %4
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define %"struct.metal::sparse_color" @probe_p06m_sparse_gather_compare_73(%struct._depth_cube_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #4 {
  %3 = tail call { <4 x float>, i8 } @air.gather_compare_depth_cube_array.f32(%struct._depth_cube_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, i32 1, <3 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, i32 0, float 1.000000e+00, i32 0) #16
  %4 = extractvalue { <4 x float>, i8 } %3, 1
  %5 = extractvalue { <4 x float>, i8 } %3, 0
  %6 = and i8 %4, 1
  %7 = xor i8 %6, 1
  %8 = zext i8 %7 to i64
  %9 = insertvalue %"struct.metal::sparse_color" poison, <4 x float> %5, 0
  %10 = insertvalue %"struct.metal::sparse_color" %9, i64 %8, 1
  ret %"struct.metal::sparse_color" %10
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define <4 x float> @probe_p06m_gather_74(%struct._depth_2d_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #4 {
  %3 = tail call { <4 x float>, i8 } @air.gather_depth_2d.v4f32(%struct._depth_2d_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, i32 1, <2 x float> <float 1.000000e+00, float 1.000000e+00>, i1 true, <2 x i32> zeroinitializer, i32 0) #16
  %4 = extractvalue { <4 x float>, i8 } %3, 0
  ret <4 x float> %4
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define %"struct.metal::sparse_color" @probe_p06m_sparse_gather_75(%struct._depth_cube_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #4 {
  %3 = tail call { <4 x float>, i8 } @air.gather_depth_cube_array.v4f32(%struct._depth_cube_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, i32 1, <3 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, i32 0, i32 0) #16
  %4 = extractvalue { <4 x float>, i8 } %3, 1
  %5 = extractvalue { <4 x float>, i8 } %3, 0
  %6 = and i8 %4, 1
  %7 = xor i8 %6, 1
  %8 = zext i8 %7 to i64
  %9 = insertvalue %"struct.metal::sparse_color" poison, <4 x float> %5, 0
  %10 = insertvalue %"struct.metal::sparse_color" %9, i64 %8, 1
  ret %"struct.metal::sparse_color" %10
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define i32 @probe_p06m_get_array_size_76(%struct._depth_2d_array_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #5 {
  %2 = tail call i32 @air.get_array_size_depth_2d_array(%struct._depth_2d_array_t addrspace(1)* nocapture readonly %0) #16
  ret i32 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define i32 @probe_p06m_get_array_size_77(%struct._depth_2d_ms_array_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #5 {
  %2 = tail call i32 @air.get_array_size_depth_2d_ms_array(%struct._depth_2d_ms_array_t addrspace(1)* nocapture readonly %0) #16
  ret i32 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define i32 @probe_p06m_get_array_size_78(%struct._depth_cube_array_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #5 {
  %2 = tail call i32 @air.get_array_size_depth_cube_array(%struct._depth_cube_array_t addrspace(1)* nocapture readonly %0) #16
  ret i32 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define i32 @probe_p06m_get_array_size_79(%struct._texture_cube_array_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #5 {
  %2 = tail call i32 @air.get_array_size_texture_cube_array(%struct._texture_cube_array_t addrspace(1)* nocapture readonly %0) #16
  ret i32 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define i32 @probe_p06m_get_height_80(%struct._depth_2d_array_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #5 {
  %2 = tail call i32 @air.get_height_depth_2d_array(%struct._depth_2d_array_t addrspace(1)* nocapture readonly %0, i32 0) #16
  ret i32 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define i32 @probe_p06m_get_height_81(%struct._depth_2d_ms_array_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #5 {
  %2 = tail call i32 @air.get_height_depth_2d_ms_array(%struct._depth_2d_ms_array_t addrspace(1)* nocapture readonly %0) #16
  ret i32 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define i32 @probe_p06m_get_height_82(%struct._depth_2d_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #5 {
  %2 = tail call i32 @air.get_height_depth_2d(%struct._depth_2d_t addrspace(1)* nocapture readonly %0, i32 0) #16
  ret i32 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define i32 @probe_p06m_get_height_83(%struct._depth_cube_array_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #5 {
  %2 = tail call i32 @air.get_height_depth_cube_array(%struct._depth_cube_array_t addrspace(1)* nocapture readonly %0, i32 0) #16
  ret i32 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define i32 @probe_p06m_get_height_84(%struct._depth_cube_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #5 {
  %2 = tail call i32 @air.get_height_depth_cube(%struct._depth_cube_t addrspace(1)* nocapture readonly %0, i32 0) #16
  ret i32 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define i32 @probe_p06m_get_height_85(%struct._texture_cube_array_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #5 {
  %2 = tail call i32 @air.get_height_texture_cube_array(%struct._texture_cube_array_t addrspace(1)* nocapture readonly %0, i32 0) #16
  ret i32 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define i32 @probe_p06m_get_num_mip_levels_86(%struct._depth_2d_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #5 {
  %2 = tail call i32 @air.get_num_mip_levels_depth_2d(%struct._depth_2d_t addrspace(1)* nocapture readonly %0) #16
  ret i32 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define i32 @probe_p06m_get_num_mip_levels_87(%struct._depth_cube_array_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #5 {
  %2 = tail call i32 @air.get_num_mip_levels_depth_cube_array(%struct._depth_cube_array_t addrspace(1)* nocapture readonly %0) #16
  ret i32 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define i32 @probe_p06m_get_num_mip_levels_88(%struct._texture_3d_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #5 {
  %2 = tail call i32 @air.get_num_mip_levels_texture_3d(%struct._texture_3d_t addrspace(1)* nocapture readonly %0) #16
  ret i32 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define i32 @probe_p06m_get_num_mip_levels_89(%struct._texture_cube_array_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #5 {
  %2 = tail call i32 @air.get_num_mip_levels_texture_cube_array(%struct._texture_cube_array_t addrspace(1)* nocapture readonly %0) #16
  ret i32 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define i32 @probe_p06m_get_num_mip_levels_90(%struct._texture_cube_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #5 {
  %2 = tail call i32 @air.get_num_mip_levels_texture_cube(%struct._texture_cube_t addrspace(1)* nocapture readonly %0) #16
  ret i32 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define i32 @probe_p06m_get_num_samples_91(%struct._depth_2d_ms_array_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #5 {
  %2 = tail call i32 @air.get_num_samples_depth_2d_ms_array(%struct._depth_2d_ms_array_t addrspace(1)* nocapture readonly %0) #16
  ret i32 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define i32 @probe_p06m_get_width_93(%struct._depth_2d_array_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #5 {
  %2 = tail call i32 @air.get_width_depth_2d_array(%struct._depth_2d_array_t addrspace(1)* nocapture readonly %0, i32 0) #16
  ret i32 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define i32 @probe_p06m_get_width_94(%struct._depth_2d_ms_array_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #5 {
  %2 = tail call i32 @air.get_width_depth_2d_ms_array(%struct._depth_2d_ms_array_t addrspace(1)* nocapture readonly %0) #16
  ret i32 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define i32 @probe_p06m_get_width_95(%struct._depth_2d_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #5 {
  %2 = tail call i32 @air.get_width_depth_2d(%struct._depth_2d_t addrspace(1)* nocapture readonly %0, i32 0) #16
  ret i32 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define i32 @probe_p06m_get_width_96(%struct._depth_cube_array_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #5 {
  %2 = tail call i32 @air.get_width_depth_cube_array(%struct._depth_cube_array_t addrspace(1)* nocapture readonly %0, i32 0) #16
  ret i32 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define i32 @probe_p06m_get_width_97(%struct._depth_cube_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #5 {
  %2 = tail call i32 @air.get_width_depth_cube(%struct._depth_cube_t addrspace(1)* nocapture readonly %0, i32 0) #16
  ret i32 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define i32 @probe_p06m_get_width_98(%struct._texture_cube_array_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #5 {
  %2 = tail call i32 @air.get_width_texture_cube_array(%struct._texture_cube_array_t addrspace(1)* nocapture readonly %0, i32 0) #16
  ret i32 %2
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define float @probe_p06m_read_99(%struct._depth_2d_array_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #6 {
  %2 = tail call %struct._sampler_t addrspace(2)* @air.get_read_sampler() #17
  %3 = tail call { float, i8 } @air.read_depth_2d_array.f32(%struct._depth_2d_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* %2, i32 1, <2 x i32> zeroinitializer, i32 0, <2 x i32> zeroinitializer, i32 0, i32 0) #16
  %4 = extractvalue { float, i8 } %3, 0
  ret float %4
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define float @probe_p06m_read_101(%struct._depth_2d_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #6 {
  %2 = tail call %struct._sampler_t addrspace(2)* @air.get_read_sampler() #17
  %3 = tail call { float, i8 } @air.read_depth_2d.f32(%struct._depth_2d_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* %2, i32 1, <2 x i32> zeroinitializer, <2 x i32> zeroinitializer, i32 0, i32 0) #16
  %4 = extractvalue { float, i8 } %3, 0
  ret float %4
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define %"struct.metal::sparse_color" @probe_p06m_sparse_read_104(%struct._texture_cube_array_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #7 {
  %2 = tail call %struct._sampler_t addrspace(2)* @air.get_read_sampler() #17
  %3 = tail call { <4 x float>, i8 } @air.read_texture_cube_array.v4f32(%struct._texture_cube_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* %2, <2 x i32> zeroinitializer, i32 0, i32 0, i32 0, i32 0) #16
  %4 = extractvalue { <4 x float>, i8 } %3, 1
  %5 = extractvalue { <4 x float>, i8 } %3, 0
  %6 = and i8 %4, 1
  %7 = xor i8 %6, 1
  %8 = zext i8 %7 to i64
  %9 = insertvalue %"struct.metal::sparse_color" poison, <4 x float> %5, 0
  %10 = insertvalue %"struct.metal::sparse_color" %9, i64 %8, 1
  ret %"struct.metal::sparse_color" %10
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define %"struct.metal::sparse_color" @probe_p06m_sparse_read_105(%struct._texture_cube_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #7 {
  %2 = tail call %struct._sampler_t addrspace(2)* @air.get_read_sampler() #17
  %3 = tail call { <4 x float>, i8 } @air.read_texture_cube.v4f32(%struct._texture_cube_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* %2, <2 x i32> zeroinitializer, i32 0, i32 0, i32 0) #16
  %4 = extractvalue { <4 x float>, i8 } %3, 1
  %5 = extractvalue { <4 x float>, i8 } %3, 0
  %6 = and i8 %4, 1
  %7 = xor i8 %6, 1
  %8 = zext i8 %7 to i64
  %9 = insertvalue %"struct.metal::sparse_color" poison, <4 x float> %5, 0
  %10 = insertvalue %"struct.metal::sparse_color" %9, i64 %8, 1
  ret %"struct.metal::sparse_color" %10
}

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
define float @probe_p06m_sample_compare_106(%struct._depth_2d_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #1 {
  %3 = tail call { float, i8 } @air.sample_compare_depth_2d_array.f32(%struct._depth_2d_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, i32 1, <2 x float> <float 1.000000e+00, float 1.000000e+00>, i32 0, float 1.000000e+00, i1 true, <2 x i32> zeroinitializer, i1 false, float 0.000000e+00, float 0.000000e+00, i32 0) #15
  %4 = extractvalue { float, i8 } %3, 0
  ret float %4
}

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
define float @probe_p06m_sample_compare_108(%struct._depth_2d_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #1 {
  %3 = tail call { float, i8 } @air.sample_compare_depth_2d.f32(%struct._depth_2d_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, i32 1, <2 x float> <float 1.000000e+00, float 1.000000e+00>, float 1.000000e+00, i1 true, <2 x i32> zeroinitializer, i1 false, float 0.000000e+00, float 0.000000e+00, i32 0) #15
  %4 = extractvalue { float, i8 } %3, 0
  ret float %4
}

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
define float @probe_p06m_sample_compare_112(%struct._depth_cube_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #2 {
  %3 = tail call { float, i8 } @air.sample_compare_depth_cube.f32(%struct._depth_cube_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, i32 1, <3 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, float 1.000000e+00, i1 false, float 0.000000e+00, float 0.000000e+00, i32 0) #15
  %4 = extractvalue { float, i8 } %3, 0
  ret float %4
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define float @probe_p06m_sample_114(%struct._depth_2d_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #8 {
  %3 = tail call { float, i8 } @air.sample_depth_2d_grad.f32(%struct._depth_2d_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, i32 1, <2 x float> <float 1.000000e+00, float 1.000000e+00>, <2 x float> <float 5.000000e-01, float 5.000000e-01>, <2 x float> <float 5.000000e-01, float 5.000000e-01>, float 0.000000e+00, i1 true, <2 x i32> zeroinitializer, i32 0) #16
  %4 = extractvalue { float, i8 } %3, 0
  ret float %4
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define <4 x float> @probe_p06m_sample_117(%struct._texture_3d_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #4 {
  %3 = tail call { <4 x float>, i8 } @air.sample_texture_3d_grad.v4f32(%struct._texture_3d_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, <3 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, <3 x float> <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>, <3 x float> <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>, float 0.000000e+00, i1 true, <3 x i32> zeroinitializer, i32 0) #16
  %4 = extractvalue { <4 x float>, i8 } %3, 0
  ret <4 x float> %4
}

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
define %"struct.metal::sparse_color" @probe_p06m_sparse_sample_118(%struct._texture_cube_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #9 {
  %3 = tail call { <4 x float>, i8 } @air.sample_texture_cube_array.v4f32(%struct._texture_cube_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, <3 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, i32 0, i1 false, float 1.000000e+00, float 1.000000e+00, i32 0) #15
  %4 = extractvalue { <4 x float>, i8 } %3, 1
  %5 = extractvalue { <4 x float>, i8 } %3, 0
  %6 = and i8 %4, 1
  %7 = xor i8 %6, 1
  %8 = zext i8 %7 to i64
  %9 = insertvalue %"struct.metal::sparse_color" poison, <4 x float> %5, 0
  %10 = insertvalue %"struct.metal::sparse_color" %9, i64 %8, 1
  ret %"struct.metal::sparse_color" %10
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define %"struct.metal::sparse_color" @probe_p06m_sparse_sample_119(%struct._texture_cube_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #4 {
  %3 = tail call { <4 x float>, i8 } @air.sample_texture_cube_array_grad.v4f32(%struct._texture_cube_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, <3 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, i32 0, <3 x float> <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>, <3 x float> <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>, float 1.000000e+00, i32 0) #16
  %4 = extractvalue { <4 x float>, i8 } %3, 1
  %5 = extractvalue { <4 x float>, i8 } %3, 0
  %6 = and i8 %4, 1
  %7 = xor i8 %6, 1
  %8 = zext i8 %7 to i64
  %9 = insertvalue %"struct.metal::sparse_color" poison, <4 x float> %5, 0
  %10 = insertvalue %"struct.metal::sparse_color" %9, i64 %8, 1
  ret %"struct.metal::sparse_color" %10
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define <4 x float> @probe_p06m_sample_120(%struct._texture_cube_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #4 {
  %3 = tail call { <4 x float>, i8 } @air.sample_texture_cube_grad.v4f32(%struct._texture_cube_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, <3 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, <3 x float> <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>, <3 x float> <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>, float 0.000000e+00, i32 0) #16
  %4 = extractvalue { <4 x float>, i8 } %3, 0
  ret <4 x float> %4
}

; Function Attrs: mustprogress nounwind willreturn
declare <4 x i32> @air.atomic_exchange_explicit_texture_buffer_1d.u.v4i32(%struct._texture_buffer_1d_t addrspace(1)* nocapture, i32, <4 x i32>, i32, i32) local_unnamed_addr #10

; Function Attrs: mustprogress nounwind willreturn
declare <4 x i32> @air.atomic_fetch_add_explicit_texture_buffer_1d.u.v4i32(%struct._texture_buffer_1d_t addrspace(1)* nocapture, i32, <4 x i32>, i32, i32) local_unnamed_addr #10

; Function Attrs: mustprogress nounwind willreturn
declare <4 x i32> @air.atomic_fetch_and_explicit_texture_buffer_1d.u.v4i32(%struct._texture_buffer_1d_t addrspace(1)* nocapture, i32, <4 x i32>, i32, i32) local_unnamed_addr #10

; Function Attrs: mustprogress nounwind willreturn
declare <4 x i32> @air.atomic_fetch_max_explicit_texture_buffer_1d.u.v4i32(%struct._texture_buffer_1d_t addrspace(1)* nocapture, i32, <4 x i32>, i32, i32) local_unnamed_addr #10

; Function Attrs: mustprogress nounwind willreturn
declare <4 x i32> @air.atomic_fetch_min_explicit_texture_buffer_1d.u.v4i32(%struct._texture_buffer_1d_t addrspace(1)* nocapture, i32, <4 x i32>, i32, i32) local_unnamed_addr #10

; Function Attrs: mustprogress nounwind willreturn
declare <4 x i32> @air.atomic_fetch_or_explicit_texture_buffer_1d.u.v4i32(%struct._texture_buffer_1d_t addrspace(1)* nocapture, i32, <4 x i32>, i32, i32) local_unnamed_addr #10

; Function Attrs: mustprogress nounwind willreturn
declare <4 x i32> @air.atomic_fetch_sub_explicit_texture_buffer_1d.u.v4i32(%struct._texture_buffer_1d_t addrspace(1)* nocapture, i32, <4 x i32>, i32, i32) local_unnamed_addr #10

; Function Attrs: mustprogress nounwind willreturn
declare <4 x i32> @air.atomic_fetch_xor_explicit_texture_buffer_1d.u.v4i32(%struct._texture_buffer_1d_t addrspace(1)* nocapture, i32, <4 x i32>, i32, i32) local_unnamed_addr #10

; Function Attrs: mustprogress nounwind willreturn
declare <4 x i32> @air.atomic_load_explicit_texture_buffer_1d.u.v4i32(%struct._texture_buffer_1d_t addrspace(1)* nocapture, i32, i32, i32) local_unnamed_addr #10

; Function Attrs: mustprogress nounwind willreturn
declare void @air.atomic_store_explicit_texture_buffer_1d.u.v4i32(%struct._texture_buffer_1d_t addrspace(1)* nocapture, <4 x i32>, i32, i32, i32) local_unnamed_addr #10

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
declare float @air.calculate_clamped_lod_depth_2d_array(%struct._depth_2d_array_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, <2 x float>, i32) local_unnamed_addr #11

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
declare float @air.calculate_clamped_lod_depth_2d(%struct._depth_2d_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, <2 x float>, i32) local_unnamed_addr #11

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
declare float @air.calculate_clamped_lod_depth_cube_array(%struct._depth_cube_array_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, <3 x float>, i32) local_unnamed_addr #11

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
declare float @air.calculate_clamped_lod_depth_cube(%struct._depth_cube_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, <3 x float>, i32) local_unnamed_addr #11

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
declare float @air.calculate_clamped_lod_texture_2d_array(%struct._texture_2d_array_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, <2 x float>, i32) local_unnamed_addr #11

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
declare float @air.calculate_clamped_lod_texture_2d(%struct._texture_2d_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, <2 x float>, i32) local_unnamed_addr #11

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
declare float @air.calculate_clamped_lod_texture_3d(%struct._texture_3d_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, <3 x float>, i32) local_unnamed_addr #11

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
declare float @air.calculate_clamped_lod_texture_cube_array(%struct._texture_cube_array_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, <3 x float>, i32) local_unnamed_addr #11

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
declare float @air.calculate_clamped_lod_texture_cube(%struct._texture_cube_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, <3 x float>, i32) local_unnamed_addr #11

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
declare float @air.calculate_unclamped_lod_depth_2d_array(%struct._depth_2d_array_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, <2 x float>, i32) local_unnamed_addr #11

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
declare float @air.calculate_unclamped_lod_depth_2d(%struct._depth_2d_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, <2 x float>, i32) local_unnamed_addr #11

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
declare float @air.calculate_unclamped_lod_depth_cube_array(%struct._depth_cube_array_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, <3 x float>, i32) local_unnamed_addr #11

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
declare float @air.calculate_unclamped_lod_depth_cube(%struct._depth_cube_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, <3 x float>, i32) local_unnamed_addr #11

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
declare float @air.calculate_unclamped_lod_texture_2d_array(%struct._texture_2d_array_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, <2 x float>, i32) local_unnamed_addr #11

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
declare float @air.calculate_unclamped_lod_texture_2d(%struct._texture_2d_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, <2 x float>, i32) local_unnamed_addr #11

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
declare float @air.calculate_unclamped_lod_texture_3d(%struct._texture_3d_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, <3 x float>, i32) local_unnamed_addr #11

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
declare float @air.calculate_unclamped_lod_texture_cube_array(%struct._texture_cube_array_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, <3 x float>, i32) local_unnamed_addr #11

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
declare float @air.calculate_unclamped_lod_texture_cube(%struct._texture_cube_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, <3 x float>, i32) local_unnamed_addr #11

; Function Attrs: mustprogress nounwind willreturn
declare void @air.fence_texture_1d_array(%struct._texture_1d_array_t addrspace(1)* nocapture) local_unnamed_addr #10

; Function Attrs: mustprogress nounwind willreturn
declare void @air.fence_texture_1d(%struct._texture_1d_t addrspace(1)* nocapture) local_unnamed_addr #10

; Function Attrs: mustprogress nounwind willreturn
declare void @air.fence_texture_2d_array(%struct._texture_2d_array_t addrspace(1)* nocapture) local_unnamed_addr #10

; Function Attrs: mustprogress nounwind willreturn
declare void @air.fence_texture_2d(%struct._texture_2d_t addrspace(1)* nocapture) local_unnamed_addr #10

; Function Attrs: mustprogress nounwind willreturn
declare void @air.fence_texture_3d(%struct._texture_3d_t addrspace(1)* nocapture) local_unnamed_addr #10

; Function Attrs: mustprogress nounwind willreturn
declare void @air.fence_texture_buffer_1d(%struct._texture_buffer_1d_t addrspace(1)* nocapture) local_unnamed_addr #10

; Function Attrs: mustprogress nounwind willreturn
declare void @air.fence_texture_cube_array(%struct._texture_cube_array_t addrspace(1)* nocapture) local_unnamed_addr #10

; Function Attrs: mustprogress nounwind willreturn
declare void @air.fence_texture_cube(%struct._texture_cube_t addrspace(1)* nocapture) local_unnamed_addr #10

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare { <4 x float>, i8 } @air.gather_compare_depth_2d.f32(%struct._depth_2d_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, i32, <2 x float>, float, i1, <2 x i32>, i32) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare { <4 x float>, i8 } @air.gather_compare_depth_cube_array.f32(%struct._depth_cube_array_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, i32, <3 x float>, i32, float, i32) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare { <4 x float>, i8 } @air.gather_depth_2d.v4f32(%struct._depth_2d_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, i32, <2 x float>, i1, <2 x i32>, i32) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare { <4 x float>, i8 } @air.gather_depth_cube_array.v4f32(%struct._depth_cube_array_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, i32, <3 x float>, i32, i32) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_array_size_depth_2d_array(%struct._depth_2d_array_t addrspace(1)* nocapture readonly) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_array_size_depth_2d_ms_array(%struct._depth_2d_ms_array_t addrspace(1)* nocapture readonly) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_array_size_depth_cube_array(%struct._depth_cube_array_t addrspace(1)* nocapture readonly) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_array_size_texture_cube_array(%struct._texture_cube_array_t addrspace(1)* nocapture readonly) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_height_depth_2d_array(%struct._depth_2d_array_t addrspace(1)* nocapture readonly, i32) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_height_depth_2d_ms_array(%struct._depth_2d_ms_array_t addrspace(1)* nocapture readonly) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_height_depth_2d(%struct._depth_2d_t addrspace(1)* nocapture readonly, i32) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_height_depth_cube_array(%struct._depth_cube_array_t addrspace(1)* nocapture readonly, i32) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_height_depth_cube(%struct._depth_cube_t addrspace(1)* nocapture readonly, i32) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_height_texture_cube_array(%struct._texture_cube_array_t addrspace(1)* nocapture readonly, i32) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_num_mip_levels_depth_2d(%struct._depth_2d_t addrspace(1)* nocapture readonly) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_num_mip_levels_depth_cube_array(%struct._depth_cube_array_t addrspace(1)* nocapture readonly) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_num_mip_levels_texture_3d(%struct._texture_3d_t addrspace(1)* nocapture readonly) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_num_mip_levels_texture_cube_array(%struct._texture_cube_array_t addrspace(1)* nocapture readonly) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_num_mip_levels_texture_cube(%struct._texture_cube_t addrspace(1)* nocapture readonly) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_num_samples_depth_2d_ms_array(%struct._depth_2d_ms_array_t addrspace(1)* nocapture readonly) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_width_depth_2d_array(%struct._depth_2d_array_t addrspace(1)* nocapture readonly, i32) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_width_depth_2d_ms_array(%struct._depth_2d_ms_array_t addrspace(1)* nocapture readonly) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_width_depth_2d(%struct._depth_2d_t addrspace(1)* nocapture readonly, i32) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_width_depth_cube_array(%struct._depth_cube_array_t addrspace(1)* nocapture readonly, i32) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_width_depth_cube(%struct._depth_cube_t addrspace(1)* nocapture readonly, i32) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_width_texture_cube_array(%struct._texture_cube_array_t addrspace(1)* nocapture readonly, i32) local_unnamed_addr #12

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind readonly willreturn
declare %struct._sampler_t addrspace(2)* @air.get_read_sampler() local_unnamed_addr #13

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare { float, i8 } @air.read_depth_2d_array.f32(%struct._depth_2d_array_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)*, i32, <2 x i32>, i32, <2 x i32>, i32, i32) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare { float, i8 } @air.read_depth_2d.f32(%struct._depth_2d_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)*, i32, <2 x i32>, <2 x i32>, i32, i32) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare { <4 x float>, i8 } @air.read_texture_cube_array.v4f32(%struct._texture_cube_array_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)*, <2 x i32>, i32, i32, i32, i32) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare { <4 x float>, i8 } @air.read_texture_cube.v4f32(%struct._texture_cube_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)*, <2 x i32>, i32, i32, i32) local_unnamed_addr #12

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
declare { float, i8 } @air.sample_compare_depth_2d_array.f32(%struct._depth_2d_array_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, i32, <2 x float>, i32, float, i1, <2 x i32>, i1, float, float, i32) local_unnamed_addr #11

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
declare { float, i8 } @air.sample_compare_depth_2d.f32(%struct._depth_2d_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, i32, <2 x float>, float, i1, <2 x i32>, i1, float, float, i32) local_unnamed_addr #11

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
declare { float, i8 } @air.sample_compare_depth_cube.f32(%struct._depth_cube_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, i32, <3 x float>, float, i1, float, float, i32) local_unnamed_addr #11

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare { float, i8 } @air.sample_depth_2d_grad.f32(%struct._depth_2d_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, i32, <2 x float>, <2 x float>, <2 x float>, float, i1, <2 x i32>, i32) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare { <4 x float>, i8 } @air.sample_texture_3d_grad.v4f32(%struct._texture_3d_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, <3 x float>, <3 x float>, <3 x float>, float, i1, <3 x i32>, i32) local_unnamed_addr #12

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
declare { <4 x float>, i8 } @air.sample_texture_cube_array.v4f32(%struct._texture_cube_array_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, <3 x float>, i32, i1, float, float, i32) local_unnamed_addr #11

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare { <4 x float>, i8 } @air.sample_texture_cube_array_grad.v4f32(%struct._texture_cube_array_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, <3 x float>, i32, <3 x float>, <3 x float>, float, i32) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare { <4 x float>, i8 } @air.sample_texture_cube_grad.v4f32(%struct._texture_cube_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, <3 x float>, <3 x float>, <3 x float>, float, i32) local_unnamed_addr #12

attributes #0 = { mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="128" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #1 = { argmemonly convergent mustprogress nofree nounwind readonly willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="64" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #2 = { argmemonly convergent mustprogress nofree nounwind readonly willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="96" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #3 = { mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #4 = { argmemonly mustprogress nofree nounwind readonly willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="128" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #5 = { argmemonly mustprogress nofree nounwind readonly willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #6 = { mustprogress nofree nounwind readonly willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="64" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #7 = { mustprogress nofree nounwind readonly willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="128" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #8 = { argmemonly mustprogress nofree nounwind readonly willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="64" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #9 = { argmemonly convergent mustprogress nofree nounwind readonly willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="128" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #10 = { mustprogress nounwind willreturn }
attributes #11 = { argmemonly convergent mustprogress nofree nounwind readonly willreturn }
attributes #12 = { argmemonly mustprogress nofree nounwind readonly willreturn }
attributes #13 = { inaccessiblememonly mustprogress nofree nounwind readonly willreturn }
attributes #14 = { nounwind willreturn }
attributes #15 = { argmemonly convergent nounwind readonly willreturn }
attributes #16 = { argmemonly nounwind readonly willreturn }
attributes #17 = { inaccessiblememonly nounwind readonly willreturn }

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
!14 = !{!"Metal", i32 3, i32 2, i32 0}
!15 = !{!"/Users/runner/work/remote/remote/run27_apply/P06M32R/metal32_macosx26/probe.metal"}
