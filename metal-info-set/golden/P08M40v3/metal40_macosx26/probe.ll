; ModuleID = 'probe.metal'
source_filename = "probe.metal"
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-n8:16:32"
target triple = "air64_v28-apple-macosx26.0.0"

%"struct.metal::matrix" = type { [4 x <3 x float>] }
%struct._instance_acceleration_structure_t = type opaque
%struct._intersection_function_table_t = type opaque
%struct._command_buffer_t = type opaque
%"struct.metal::compute_pipeline_state" = type { %struct._compute_pipeline_state_t addrspace(1)* }
%struct._compute_pipeline_state_t = type opaque
%"struct.metal::depth_stencil_state" = type { %struct._depth_stencil_state_t addrspace(1)* }
%struct._depth_stencil_state_t = type opaque
%"struct.metal::raytracing::intersection_function_table" = type { %struct._intersection_function_table_t addrspace(1)* }
%"struct.metal::render_pipeline_state" = type { %struct._render_pipeline_state_t addrspace(1)* }
%struct._render_pipeline_state_t = type opaque

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define float @probe_p08m_irr_5() local_unnamed_addr #0 {
  ret float 0.000000e+00
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define float @probe_p08m_irr_6() local_unnamed_addr #0 {
  ret float 0.000000e+00
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p08m_irr_7() local_unnamed_addr #0 {
  ret i32 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p08m_irr_8() local_unnamed_addr #0 {
  ret i32 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p08m_irr_9() local_unnamed_addr #0 {
  ret i32 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define %"struct.metal::matrix" @probe_p08m_irr_10() local_unnamed_addr #0 {
  ret %"struct.metal::matrix" zeroinitializer
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p08m_irr_11() local_unnamed_addr #0 {
  ret i32 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define <3 x float> @probe_p08m_irr_12() local_unnamed_addr #0 {
  ret <3 x float> zeroinitializer
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define float @probe_p08m_irr_13() local_unnamed_addr #0 {
  ret float 0.000000e+00
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define <3 x float> @probe_p08m_irr_14() local_unnamed_addr #0 {
  ret <3 x float> zeroinitializer
}

; Function Attrs: mustprogress nounwind willreturn
define i32 @probe_p08m_ir_15() local_unnamed_addr #1 {
  %1 = tail call %struct._instance_acceleration_structure_t addrspace(1)* @air.get_null_instance_acceleration_structure() #6
  %2 = tail call %struct._intersection_function_table_t addrspace(1)* @air.get_null_intersection_function_table() #6
  %3 = tail call { i32, float, i32, i32, i8 addrspace(1)*, i32, i32, <2 x float>, i1 } @air.intersect.instancing.triangle_data(<3 x float> zeroinitializer, <3 x float> zeroinitializer, float 0.000000e+00, float 0x7FF0000000000000, %struct._instance_acceleration_structure_t addrspace(1)* readonly %1, i32 -1, %struct._intersection_function_table_t addrspace(1)* readonly %2, i8* null, i64 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 3, i32 -1, i32 -1, i32 0, i1 false, i1 false) #7
  ret i32 undef
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define <2 x float> @probe_p08m_irr_16() local_unnamed_addr #0 {
  ret <2 x float> zeroinitializer
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p08m_irr_17() local_unnamed_addr #0 {
  ret i32 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p08m_irr_18() local_unnamed_addr #0 {
  ret i32 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define %"struct.metal::matrix" @probe_p08m_irr_19() local_unnamed_addr #0 {
  ret %"struct.metal::matrix" zeroinitializer
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define zeroext i1 @probe_p08m_irr_20() local_unnamed_addr #0 {
  ret i1 false
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_ir_21(i8 addrspace(1)* nocapture noundef readnone %0) local_unnamed_addr #1 {
  %2 = tail call %struct._instance_acceleration_structure_t addrspace(1)* @air.get_null_instance_acceleration_structure() #6
  %3 = tail call %struct._intersection_function_table_t addrspace(1)* @air.get_null_intersection_function_table() #6
  %4 = tail call { i32, float, i32, i32, i8 addrspace(1)*, i32, i32, <2 x float>, i1 } @air.intersect.instancing.triangle_data(<3 x float> zeroinitializer, <3 x float> zeroinitializer, float 0.000000e+00, float 0x7FF0000000000000, %struct._instance_acceleration_structure_t addrspace(1)* readonly %2, i32 -1, %struct._intersection_function_table_t addrspace(1)* readonly %3, i8* null, i64 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 3, i32 -1, i32 -1, i32 0, i1 false, i1 false) #7
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_rc_22(i32 addrspace(1)* noundef %0) local_unnamed_addr #2 {
  %2 = bitcast i32 addrspace(1)* %0 to i8 addrspace(1)*
  tail call void @air.set_fragment_buffer_render_command.p1i8(%struct._command_buffer_t addrspace(1)* nocapture undef, i32 0, i8 addrspace(1)* %2, i32 0) #7
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_cc_24(i32 addrspace(1)* noundef %0) local_unnamed_addr #2 {
  %2 = bitcast i32 addrspace(1)* %0 to i8 addrspace(1)*
  tail call void @air.set_kernel_buffer_compute_command.p1i8(%struct._command_buffer_t addrspace(1)* nocapture undef, i32 0, i8 addrspace(1)* %2, i64 -1, i32 0) #7
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_rc_25(i32 addrspace(1)* noundef %0) local_unnamed_addr #2 {
  %2 = bitcast i32 addrspace(1)* %0 to i8 addrspace(1)*
  tail call void @air.set_mesh_buffer_render_command.p1i8(%struct._command_buffer_t addrspace(1)* nocapture undef, i32 0, i8 addrspace(1)* %2, i32 0) #7
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_rc_26(i32 addrspace(1)* noundef %0) local_unnamed_addr #2 {
  %2 = bitcast i32 addrspace(1)* %0 to i8 addrspace(1)*
  tail call void @air.set_object_buffer_render_command.p1i8(%struct._command_buffer_t addrspace(1)* nocapture undef, i32 0, i8 addrspace(1)* %2, i32 0) #7
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_rc_27(i32 addrspace(1)* noundef %0) local_unnamed_addr #2 {
  %2 = bitcast i32 addrspace(1)* %0 to i8 addrspace(1)*
  tail call void @air.set_vertex_buffer_render_command.p1i8(%struct._command_buffer_t addrspace(1)* nocapture undef, i32 0, i8 addrspace(1)* %2, i64 -1, i32 0) #7
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define %"struct.metal::compute_pipeline_state" @probe_p08m_type_28(%struct._compute_pipeline_state_t addrspace(1)* %0) local_unnamed_addr #3 {
  %2 = insertvalue %"struct.metal::compute_pipeline_state" poison, %struct._compute_pipeline_state_t addrspace(1)* %0, 0
  ret %"struct.metal::compute_pipeline_state" %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define %"struct.metal::depth_stencil_state" @probe_p08m_type_29(%struct._depth_stencil_state_t addrspace(1)* %0) local_unnamed_addr #3 {
  %2 = insertvalue %"struct.metal::depth_stencil_state" poison, %struct._depth_stencil_state_t addrspace(1)* %0, 0
  ret %"struct.metal::depth_stencil_state" %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define %"struct.metal::raytracing::intersection_function_table" @probe_p08m_type_30(%struct._intersection_function_table_t addrspace(1)* %0) local_unnamed_addr #3 {
  %2 = insertvalue %"struct.metal::raytracing::intersection_function_table" poison, %struct._intersection_function_table_t addrspace(1)* %0, 0
  ret %"struct.metal::raytracing::intersection_function_table" %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define %"struct.metal::render_pipeline_state" @probe_p08m_type_31(%struct._render_pipeline_state_t addrspace(1)* %0) local_unnamed_addr #3 {
  %2 = insertvalue %"struct.metal::render_pipeline_state" poison, %struct._render_pipeline_state_t addrspace(1)* %0, 0
  ret %"struct.metal::render_pipeline_state" %2
}

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind readonly willreturn
declare %struct._instance_acceleration_structure_t addrspace(1)* @air.get_null_instance_acceleration_structure() local_unnamed_addr #4

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind readonly willreturn
declare %struct._intersection_function_table_t addrspace(1)* @air.get_null_intersection_function_table() local_unnamed_addr #4

; Function Attrs: mustprogress nounwind willreturn
declare { i32, float, i32, i32, i8 addrspace(1)*, i32, i32, <2 x float>, i1 } @air.intersect.instancing.triangle_data(<3 x float>, <3 x float>, float, float, %struct._instance_acceleration_structure_t addrspace(1)* readonly, i32, %struct._intersection_function_table_t addrspace(1)* readonly, i8*, i64, i32, i32, i32, i32, i32, i32, i32, i32, i32, i1, i1) local_unnamed_addr #5

; Function Attrs: mustprogress nounwind willreturn
declare void @air.set_fragment_buffer_render_command.p1i8(%struct._command_buffer_t addrspace(1)* nocapture, i32, i8 addrspace(1)*, i32) local_unnamed_addr #5

; Function Attrs: mustprogress nounwind willreturn
declare void @air.set_kernel_buffer_compute_command.p1i8(%struct._command_buffer_t addrspace(1)* nocapture, i32, i8 addrspace(1)*, i64, i32) local_unnamed_addr #5

; Function Attrs: mustprogress nounwind willreturn
declare void @air.set_mesh_buffer_render_command.p1i8(%struct._command_buffer_t addrspace(1)* nocapture, i32, i8 addrspace(1)*, i32) local_unnamed_addr #5

; Function Attrs: mustprogress nounwind willreturn
declare void @air.set_object_buffer_render_command.p1i8(%struct._command_buffer_t addrspace(1)* nocapture, i32, i8 addrspace(1)*, i32) local_unnamed_addr #5

; Function Attrs: mustprogress nounwind willreturn
declare void @air.set_vertex_buffer_render_command.p1i8(%struct._command_buffer_t addrspace(1)* nocapture, i32, i8 addrspace(1)*, i64, i32) local_unnamed_addr #5

attributes #0 = { mustprogress nofree norecurse nosync nounwind readnone willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="96" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #1 = { mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="96" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #2 = { mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #3 = { mustprogress nofree norecurse nosync nounwind readnone willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #4 = { inaccessiblememonly mustprogress nofree nounwind readonly willreturn }
attributes #5 = { mustprogress nounwind willreturn }
attributes #6 = { inaccessiblememonly nounwind readonly willreturn }
attributes #7 = { nounwind willreturn }

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
!15 = !{!"/Users/runner/metal_probe/p6/P08M/probe.metal"}
