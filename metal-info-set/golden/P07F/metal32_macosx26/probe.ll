; ModuleID = 'probe.metal'
source_filename = "probe.metal"
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-n8:16:32"
target triple = "air64_v28-apple-macosx26.0.0"

%struct._texture_cube_array_t = type opaque

; Function Attrs: convergent mustprogress nounwind willreturn
define half @probe_p07f_dfdx_0() local_unnamed_addr #0 {
  %1 = tail call fast half @air.dfdx.f16(half 0xH3C00) #8
  ret half %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define half @probe_p07f_dfdy_1() local_unnamed_addr #0 {
  %1 = tail call fast half @air.dfdy.f16(half 0xH3C00) #8
  ret half %1
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p07f_discard_fragment_2() local_unnamed_addr #1 {
  tail call void @air.discard_fragment() #9
  ret void
}

; Function Attrs: convergent mustprogress nounwind willreturn
define half @probe_p07f_fwidth_3() local_unnamed_addr #0 {
  %1 = tail call fast half @air.fwidth.f16(half 0xH3C00) #8
  ret half %1
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define i32 @probe_p07f_get_num_samples_6() local_unnamed_addr #2 {
  %1 = tail call i32 @air.get_num_samples.i32(i32 0) #10
  ret i32 %1
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p07f_is_null_texture_27(%struct._texture_cube_array_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #3 {
  %2 = tail call i1 @air.is_null_texture_cube_array(%struct._texture_cube_array_t addrspace(1)* nocapture readonly %0) #11
  ret i1 %2
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_quad_broadcast_35() local_unnamed_addr #0 {
  %1 = tail call fast float @air.quad_broadcast.f32(float 1.000000e+00, i16 0) #8
  ret float %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_quad_shuffle_47() local_unnamed_addr #0 {
  %1 = tail call fast float @air.quad_shuffle.f32(float 1.000000e+00, i16 0) #8
  ret float %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_quad_shuffle_down_50() local_unnamed_addr #0 {
  %1 = tail call fast float @air.quad_shuffle_down.f32(float 1.000000e+00, i16 0) #8
  ret float %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_quad_shuffle_up_53() local_unnamed_addr #0 {
  %1 = tail call fast float @air.quad_shuffle_up.f32(float 1.000000e+00, i16 0) #8
  ret float %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_quad_shuffle_xor_54() local_unnamed_addr #0 {
  %1 = tail call fast float @air.quad_shuffle_xor.f32(float 1.000000e+00, i16 0) #8
  ret float %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_simd_broadcast_63() local_unnamed_addr #0 {
  %1 = tail call fast float @air.simd_broadcast.f32(float 1.000000e+00, i16 0) #8
  ret float %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_simd_shuffle_75() local_unnamed_addr #0 {
  %1 = tail call fast float @air.simd_shuffle.f32(float 1.000000e+00, i16 0) #8
  ret float %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_simd_shuffle_down_78() local_unnamed_addr #0 {
  %1 = tail call fast float @air.simd_shuffle_down.f32(float 1.000000e+00, i16 0) #8
  ret float %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_simd_shuffle_up_81() local_unnamed_addr #0 {
  %1 = tail call fast float @air.simd_shuffle_up.f32(float 1.000000e+00, i16 0) #8
  ret float %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define float @probe_p07f_simd_shuffle_xor_82() local_unnamed_addr #0 {
  %1 = tail call fast float @air.simd_shuffle_xor.f32(float 1.000000e+00, i16 0) #8
  ret float %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define void @probe_p07f_simdgroup_barrier_85() local_unnamed_addr #0 {
  tail call void @air.simdgroup.barrier(i32 1, i32 4) #8
  ret void
}

; Function Attrs: convergent mustprogress nounwind willreturn
declare half @air.dfdx.f16(half) local_unnamed_addr #4

; Function Attrs: convergent mustprogress nounwind willreturn
declare half @air.dfdy.f16(half) local_unnamed_addr #4

; Function Attrs: mustprogress nounwind willreturn
declare void @air.discard_fragment() local_unnamed_addr #5

; Function Attrs: convergent mustprogress nounwind willreturn
declare half @air.fwidth.f16(half) local_unnamed_addr #4

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare i32 @air.get_num_samples.i32(i32) local_unnamed_addr #6

; Function Attrs: convergent mustprogress nounwind willreturn
declare void @air.simdgroup.barrier(i32, i32) local_unnamed_addr #4

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i1 @air.is_null_texture_cube_array(%struct._texture_cube_array_t addrspace(1)* nocapture readonly) local_unnamed_addr #7

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.quad_broadcast.f32(float, i16) local_unnamed_addr #4

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.quad_shuffle.f32(float, i16) local_unnamed_addr #4

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.quad_shuffle_down.f32(float, i16) local_unnamed_addr #4

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.quad_shuffle_up.f32(float, i16) local_unnamed_addr #4

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.quad_shuffle_xor.f32(float, i16) local_unnamed_addr #4

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.simd_broadcast.f32(float, i16) local_unnamed_addr #4

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.simd_shuffle.f32(float, i16) local_unnamed_addr #4

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.simd_shuffle_down.f32(float, i16) local_unnamed_addr #4

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.simd_shuffle_up.f32(float, i16) local_unnamed_addr #4

; Function Attrs: convergent mustprogress nounwind willreturn
declare float @air.simd_shuffle_xor.f32(float, i16) local_unnamed_addr #4

attributes #0 = { convergent mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #1 = { mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #2 = { mustprogress nofree nosync nounwind readnone willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #3 = { argmemonly mustprogress nofree nounwind readonly willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #4 = { convergent mustprogress nounwind willreturn }
attributes #5 = { mustprogress nounwind willreturn }
attributes #6 = { mustprogress nofree nosync nounwind readnone willreturn }
attributes #7 = { argmemonly mustprogress nofree nounwind readonly willreturn }
attributes #8 = { convergent nounwind willreturn }
attributes #9 = { nounwind willreturn }
attributes #10 = { nounwind readnone willreturn }
attributes #11 = { argmemonly nounwind readonly willreturn }

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
!15 = !{!"/Users/runner/metal_probe/p2/P07F/probe.metal"}
