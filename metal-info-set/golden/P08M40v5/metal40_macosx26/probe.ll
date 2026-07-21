; ModuleID = 'probe.metal'
source_filename = "probe.metal"
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-n8:16:32"
target triple = "air64_v28-apple-macosx26.0.0"

%struct._intersection_function_table_t = type opaque
%struct._interpolant_t = type opaque
%"struct.metal::compute_pipeline_state" = type { %struct._compute_pipeline_state_t addrspace(1)* }
%struct._compute_pipeline_state_t = type opaque
%"struct.metal::depth_stencil_state" = type { %struct._depth_stencil_state_t addrspace(1)* }
%struct._depth_stencil_state_t = type opaque
%"struct.metal::raytracing::intersection_function_table" = type { %struct._intersection_function_table_t addrspace(1)* }
%"struct.metal::raytracing::intersection_result" = type <{ %"struct.metal::raytracing::_intersection_result_base", %"struct.metal::raytracing::_intersection_result_instancing_ext", %"struct.metal::raytracing::_intersection_result_triangle_data_ext.base", [7 x i8] }>
%"struct.metal::raytracing::_intersection_result_base" = type { i32, float, i32, i32, i8 addrspace(1)* }
%"struct.metal::raytracing::_intersection_result_instancing_ext" = type { i32, i32 }
%"struct.metal::raytracing::_intersection_result_triangle_data_ext.base" = type <{ <2 x float>, i8 }>

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define i32 @probe_p08m_ift_15() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_function_table_t addrspace(1)* @air.get_null_intersection_function_table() #8
  %2 = tail call i32 @air.get_size_intersection_function_table(%struct._intersection_function_table_t addrspace(1)* nocapture readonly %1) #9
  ret i32 %2
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define i32 @probe_p08m_ip_20() local_unnamed_addr #0 {
  %1 = tail call fast float @air.interpolate_center_no_perspective.f32(%struct._interpolant_t addrspace(1)* nocapture readonly undef) #9
  %2 = tail call i32 @air.convert.s.i32.f.f32(float %1) #10
  ret i32 %2
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare i32 @air.convert.s.i32.f.f32(float) local_unnamed_addr #1

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define i32 @probe_p08m_ip_21() local_unnamed_addr #0 {
  %1 = tail call fast float @air.interpolate_center_perspective.f32(%struct._interpolant_t addrspace(1)* nocapture readonly undef) #9
  %2 = tail call i32 @air.convert.s.i32.f.f32(float %1) #10
  ret i32 %2
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define i32 @probe_p08m_ip_22() local_unnamed_addr #0 {
  %1 = tail call fast float @air.interpolate_centroid_no_perspective.f32(%struct._interpolant_t addrspace(1)* nocapture readonly undef) #9
  %2 = tail call i32 @air.convert.s.i32.f.f32(float %1) #10
  ret i32 %2
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define i32 @probe_p08m_ip_23() local_unnamed_addr #0 {
  %1 = tail call fast float @air.interpolate_centroid_perspective.f32(%struct._interpolant_t addrspace(1)* nocapture readonly undef) #9
  %2 = tail call i32 @air.convert.s.i32.f.f32(float %1) #10
  ret i32 %2
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define i32 @probe_p08m_ip_24() local_unnamed_addr #2 {
  %1 = tail call fast float @air.interpolate_offset_no_perspective.f32(%struct._interpolant_t addrspace(1)* nocapture readonly undef, <2 x float> zeroinitializer) #9
  %2 = tail call i32 @air.convert.s.i32.f.f32(float %1) #10
  ret i32 %2
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define i32 @probe_p08m_ip_25() local_unnamed_addr #2 {
  %1 = tail call fast float @air.interpolate_offset_perspective.f32(%struct._interpolant_t addrspace(1)* nocapture readonly undef, <2 x float> zeroinitializer) #9
  %2 = tail call i32 @air.convert.s.i32.f.f32(float %1) #10
  ret i32 %2
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define i32 @probe_p08m_ip_26() local_unnamed_addr #0 {
  %1 = tail call fast float @air.interpolate_sample_no_perspective.f32(%struct._interpolant_t addrspace(1)* nocapture readonly undef, i32 0) #9
  %2 = tail call i32 @air.convert.s.i32.f.f32(float %1) #10
  ret i32 %2
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define i32 @probe_p08m_ip_27() local_unnamed_addr #0 {
  %1 = tail call fast float @air.interpolate_sample_perspective.f32(%struct._interpolant_t addrspace(1)* nocapture readonly undef, i32 0) #9
  %2 = tail call i32 @air.convert.s.i32.f.f32(float %1) #10
  ret i32 %2
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_ift_29(i8 addrspace(1)* noundef %0) local_unnamed_addr #3 {
  %2 = tail call %struct._intersection_function_table_t addrspace(1)* @air.get_null_intersection_function_table() #8
  tail call void @air.set_buffer_intersection_function_table.p1i8(%struct._intersection_function_table_t addrspace(1)* nocapture %2, i8 addrspace(1)* readonly %0, i32 0) #11
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define %"struct.metal::compute_pipeline_state" @probe_p08m_type_32(%struct._compute_pipeline_state_t addrspace(1)* %0) local_unnamed_addr #4 {
  %2 = insertvalue %"struct.metal::compute_pipeline_state" poison, %struct._compute_pipeline_state_t addrspace(1)* %0, 0
  ret %"struct.metal::compute_pipeline_state" %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define %"struct.metal::depth_stencil_state" @probe_p08m_type_33(%struct._depth_stencil_state_t addrspace(1)* %0) local_unnamed_addr #4 {
  %2 = insertvalue %"struct.metal::depth_stencil_state" poison, %struct._depth_stencil_state_t addrspace(1)* %0, 0
  ret %"struct.metal::depth_stencil_state" %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define %"struct.metal::raytracing::intersection_function_table" @probe_p08m_type_34(%struct._intersection_function_table_t addrspace(1)* %0) local_unnamed_addr #4 {
  %2 = insertvalue %"struct.metal::raytracing::intersection_function_table" poison, %struct._intersection_function_table_t addrspace(1)* %0, 0
  ret %"struct.metal::raytracing::intersection_function_table" %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define %"struct.metal::raytracing::intersection_result" @probe_p08m_type_35(%"struct.metal::raytracing::_intersection_result_base" %0, %"struct.metal::raytracing::_intersection_result_instancing_ext" %1, %"struct.metal::raytracing::_intersection_result_triangle_data_ext.base" %2, [7 x i8] %3) local_unnamed_addr #4 {
  %5 = extractvalue %"struct.metal::raytracing::_intersection_result_base" %0, 0
  %6 = extractvalue %"struct.metal::raytracing::_intersection_result_base" %0, 1
  %7 = extractvalue %"struct.metal::raytracing::_intersection_result_base" %0, 2
  %8 = extractvalue %"struct.metal::raytracing::_intersection_result_base" %0, 3
  %9 = extractvalue %"struct.metal::raytracing::_intersection_result_base" %0, 4
  %10 = extractvalue %"struct.metal::raytracing::_intersection_result_instancing_ext" %1, 0
  %11 = extractvalue %"struct.metal::raytracing::_intersection_result_instancing_ext" %1, 1
  %12 = extractvalue %"struct.metal::raytracing::_intersection_result_triangle_data_ext.base" %2, 0
  %13 = extractvalue %"struct.metal::raytracing::_intersection_result_triangle_data_ext.base" %2, 1
  %14 = extractvalue [7 x i8] %3, 0
  %15 = extractvalue [7 x i8] %3, 1
  %16 = extractvalue [7 x i8] %3, 2
  %17 = extractvalue [7 x i8] %3, 3
  %18 = extractvalue [7 x i8] %3, 4
  %19 = extractvalue [7 x i8] %3, 5
  %20 = extractvalue [7 x i8] %3, 6
  %21 = insertvalue %"struct.metal::raytracing::intersection_result" poison, i32 %5, 0, 0
  %22 = insertvalue %"struct.metal::raytracing::intersection_result" %21, float %6, 0, 1
  %23 = insertvalue %"struct.metal::raytracing::intersection_result" %22, i32 %7, 0, 2
  %24 = insertvalue %"struct.metal::raytracing::intersection_result" %23, i32 %8, 0, 3
  %25 = insertvalue %"struct.metal::raytracing::intersection_result" %24, i8 addrspace(1)* %9, 0, 4
  %26 = insertvalue %"struct.metal::raytracing::intersection_result" %25, i32 %10, 1, 0
  %27 = insertvalue %"struct.metal::raytracing::intersection_result" %26, i32 %11, 1, 1
  %28 = insertvalue %"struct.metal::raytracing::intersection_result" %27, <2 x float> %12, 2, 0
  %29 = insertvalue %"struct.metal::raytracing::intersection_result" %28, i8 %13, 2, 1
  %30 = insertvalue %"struct.metal::raytracing::intersection_result" %29, i8 %14, 3, 0
  %31 = insertvalue %"struct.metal::raytracing::intersection_result" %30, i8 %15, 3, 1
  %32 = insertvalue %"struct.metal::raytracing::intersection_result" %31, i8 %16, 3, 2
  %33 = insertvalue %"struct.metal::raytracing::intersection_result" %32, i8 %17, 3, 3
  %34 = insertvalue %"struct.metal::raytracing::intersection_result" %33, i8 %18, 3, 4
  %35 = insertvalue %"struct.metal::raytracing::intersection_result" %34, i8 %19, 3, 5
  %36 = insertvalue %"struct.metal::raytracing::intersection_result" %35, i8 %20, 3, 6
  ret %"struct.metal::raytracing::intersection_result" %36
}

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind readonly willreturn
declare %struct._intersection_function_table_t addrspace(1)* @air.get_null_intersection_function_table() local_unnamed_addr #5

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_size_intersection_function_table(%struct._intersection_function_table_t addrspace(1)* nocapture readonly) local_unnamed_addr #6

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare float @air.interpolate_center_no_perspective.f32(%struct._interpolant_t addrspace(1)* nocapture readonly) local_unnamed_addr #6

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare float @air.interpolate_center_perspective.f32(%struct._interpolant_t addrspace(1)* nocapture readonly) local_unnamed_addr #6

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare float @air.interpolate_centroid_no_perspective.f32(%struct._interpolant_t addrspace(1)* nocapture readonly) local_unnamed_addr #6

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare float @air.interpolate_centroid_perspective.f32(%struct._interpolant_t addrspace(1)* nocapture readonly) local_unnamed_addr #6

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare float @air.interpolate_offset_no_perspective.f32(%struct._interpolant_t addrspace(1)* nocapture readonly, <2 x float>) local_unnamed_addr #6

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare float @air.interpolate_offset_perspective.f32(%struct._interpolant_t addrspace(1)* nocapture readonly, <2 x float>) local_unnamed_addr #6

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare float @air.interpolate_sample_no_perspective.f32(%struct._interpolant_t addrspace(1)* nocapture readonly, i32) local_unnamed_addr #6

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare float @air.interpolate_sample_perspective.f32(%struct._interpolant_t addrspace(1)* nocapture readonly, i32) local_unnamed_addr #6

; Function Attrs: argmemonly mustprogress nounwind willreturn
declare void @air.set_buffer_intersection_function_table.p1i8(%struct._intersection_function_table_t addrspace(1)* nocapture, i8 addrspace(1)* readonly, i32) local_unnamed_addr #7

attributes #0 = { mustprogress nofree nounwind readonly willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #1 = { mustprogress nofree nosync nounwind readnone willreturn }
attributes #2 = { mustprogress nofree nounwind readonly willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="64" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #3 = { mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #4 = { mustprogress nofree norecurse nosync nounwind readnone willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #5 = { inaccessiblememonly mustprogress nofree nounwind readonly willreturn }
attributes #6 = { argmemonly mustprogress nofree nounwind readonly willreturn }
attributes #7 = { argmemonly mustprogress nounwind willreturn }
attributes #8 = { inaccessiblememonly nounwind readonly willreturn }
attributes #9 = { argmemonly nounwind readonly willreturn }
attributes #10 = { nounwind readnone willreturn }
attributes #11 = { argmemonly nounwind willreturn }

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
!15 = !{!"/Users/runner/metal_probe/p7/P08M/probe.metal"}
