; ModuleID = 'probe.metal'
source_filename = "probe.metal"
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-n8:16:32"
target triple = "air64_v28-apple-macosx26.0.0"

%struct._depth_2d_t = type opaque
%struct._depth_2d_ms_t = type opaque
%struct._texture_cube_t = type opaque
%struct._sampler_t = type opaque
%struct._texture_cube_array_t = type opaque

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define i32 @probe_p06m_get_height_16(%struct._depth_2d_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #0 {
  %2 = tail call i32 @air.get_height_depth_2d(%struct._depth_2d_t addrspace(1)* nocapture readonly %0, i32 0) #5
  ret i32 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define i32 @probe_p06m_get_num_samples_17(%struct._depth_2d_ms_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #0 {
  %2 = tail call i32 @air.get_num_samples_depth_2d_ms(%struct._depth_2d_ms_t addrspace(1)* nocapture readonly %0) #5
  ret i32 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define <4 x float> @probe_p06m_sample_18(%struct._texture_cube_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #1 {
  %3 = tail call { <4 x float>, i8 } @air.sample_texture_cube_grad.v4f32(%struct._texture_cube_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, <3 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, <3 x float> <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>, <3 x float> <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>, float 0.000000e+00, i32 0) #5
  %4 = extractvalue { <4 x float>, i8 } %3, 0
  ret <4 x float> %4
}

; Function Attrs: argmemonly mustprogress nounwind willreturn
define void @probe_p06m_write_19(%struct._texture_cube_array_t addrspace(1)* nocapture %0) local_unnamed_addr #2 {
  tail call void @air.write_texture_cube_array.i16.v4f32(%struct._texture_cube_array_t addrspace(1)* nocapture %0, <2 x i16> zeroinitializer, i16 0, i16 0, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, i16 0, i32 2) #6
  ret void
}

; Function Attrs: argmemonly mustprogress nounwind willreturn
define void @probe_p06m_write_20(%struct._texture_cube_t addrspace(1)* nocapture %0) local_unnamed_addr #2 {
  tail call void @air.write_texture_cube.i16.v4f32(%struct._texture_cube_t addrspace(1)* nocapture %0, <2 x i16> zeroinitializer, i16 0, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, i16 0, i32 2) #6
  ret void
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_height_depth_2d(%struct._depth_2d_t addrspace(1)* nocapture readonly, i32) local_unnamed_addr #3

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_num_samples_depth_2d_ms(%struct._depth_2d_ms_t addrspace(1)* nocapture readonly) local_unnamed_addr #3

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare { <4 x float>, i8 } @air.sample_texture_cube_grad.v4f32(%struct._texture_cube_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, <3 x float>, <3 x float>, <3 x float>, float, i32) local_unnamed_addr #3

; Function Attrs: argmemonly mustprogress nounwind willreturn
declare void @air.write_texture_cube_array.i16.v4f32(%struct._texture_cube_array_t addrspace(1)* nocapture, <2 x i16>, i16, i16, <4 x float>, i16, i32) local_unnamed_addr #4

; Function Attrs: argmemonly mustprogress nounwind willreturn
declare void @air.write_texture_cube.i16.v4f32(%struct._texture_cube_t addrspace(1)* nocapture, <2 x i16>, i16, <4 x float>, i16, i32) local_unnamed_addr #4

attributes #0 = { argmemonly mustprogress nofree nounwind readonly willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #1 = { argmemonly mustprogress nofree nounwind readonly willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="128" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #2 = { argmemonly mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="128" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #3 = { argmemonly mustprogress nofree nounwind readonly willreturn }
attributes #4 = { argmemonly mustprogress nounwind willreturn }
attributes #5 = { argmemonly nounwind readonly willreturn }
attributes #6 = { argmemonly nounwind willreturn }

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
!15 = !{!"/Users/runner/metal_probe/p11/P06M/probe.metal"}
