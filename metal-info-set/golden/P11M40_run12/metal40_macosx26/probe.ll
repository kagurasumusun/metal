; ModuleID = 'probe.metal'
source_filename = "probe.metal"
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-n8:16:32"
target triple = "air64_v28-apple-macosx26.0.0"

%struct._function_handle_t = type opaque
%struct._visible_function_table_t = type opaque
%struct._command_buffer_t = type opaque

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p11m_texnull_0() local_unnamed_addr #0 {
  ret i32 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p11m_texnull_1() local_unnamed_addr #0 {
  ret i32 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p11m_texnull_2() local_unnamed_addr #0 {
  ret i32 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p11m_texnull_3() local_unnamed_addr #0 {
  ret i32 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p11m_texnull_4() local_unnamed_addr #0 {
  ret i32 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p11m_texnull_5() local_unnamed_addr #0 {
  ret i32 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p11m_texnull_6() local_unnamed_addr #0 {
  ret i32 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p11m_texnull_7() local_unnamed_addr #0 {
  ret i32 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p11m_texnull_8() local_unnamed_addr #0 {
  ret i32 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p11m_texnull_9() local_unnamed_addr #0 {
  ret i32 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p11m_texnull_10() local_unnamed_addr #0 {
  ret i32 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p11m_texnull_11() local_unnamed_addr #0 {
  ret i32 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p11m_texnull_12() local_unnamed_addr #0 {
  ret i32 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p11m_texnull_13() local_unnamed_addr #0 {
  ret i32 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p11m_texnull_14() local_unnamed_addr #0 {
  ret i32 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p11m_texnull_15() local_unnamed_addr #0 {
  ret i32 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p11m_asnull_16() local_unnamed_addr #0 {
  ret i32 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p11m_fhandle_17() local_unnamed_addr #0 {
  ret i32 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p11m_iftnull_18() local_unnamed_addr #0 {
  ret i32 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p11m_vftnull_19() local_unnamed_addr #0 {
  ret i32 0
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p11m_fequal_20() local_unnamed_addr #1 {
  %1 = tail call %struct._function_handle_t addrspace(1)* @air.get_null_function_handle() #7
  %2 = tail call i1 @air.is_equal_function_handle(%struct._function_handle_t addrspace(1)* nocapture readonly %1, %struct._function_handle_t addrspace(1)* nocapture readonly %1) #8
  ret i1 %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define float @probe_p11m_divide_21() local_unnamed_addr #2 {
  ret float 5.000000e-01
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define float @probe_p11m_select_22() local_unnamed_addr #0 {
  ret float -1.000000e+00
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p11m_sampler_23() local_unnamed_addr #0 {
  ret i32 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p11m_getsampler_24() local_unnamed_addr #0 {
  ret i32 0
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define i32 @probe_p11m_vftsize_25() local_unnamed_addr #1 {
  %1 = tail call %struct._visible_function_table_t addrspace(1)* @air.get_null_visible_function_table() #7
  %2 = tail call i32 @air.get_size_visible_function_table(%struct._visible_function_table_t addrspace(1)* nocapture readonly %1) #8
  ret i32 %2
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p11m_draw1_26(%struct._command_buffer_t addrspace(1)* nocapture %0) local_unnamed_addr #3 {
  tail call void @air.draw_indexed_primitives_render_command.p1i32(%struct._command_buffer_t addrspace(1)* nocapture %0, i32 0, i32 3, i32 0, i32 addrspace(1)* null, i32 0, i32 0, i32 0) #9
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p11m_draw2_27(%struct._command_buffer_t addrspace(1)* nocapture %0) local_unnamed_addr #3 {
  tail call void @air.draw_patches_render_command.p1i32.p1i8(%struct._command_buffer_t addrspace(1)* nocapture %0, i32 0, i32 0, i32 0, i32 0, i32 addrspace(1)* null, i32 0, i32 0, i8 addrspace(1)* null, i32 0, float 1.000000e+00) #9
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p11m_draw3_28(%struct._command_buffer_t addrspace(1)* nocapture %0) local_unnamed_addr #3 {
  tail call void @air.draw_indexed_patches_render_command.p1i32.p1i8.p1i8(%struct._command_buffer_t addrspace(1)* nocapture %0, i32 0, i32 0, i32 0, i32 0, i32 addrspace(1)* null, i8 addrspace(1)* null, i32 0, i32 0, i8 addrspace(1)* null, i32 0, float 1.000000e+00) #9
  ret void
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i1 @air.is_equal_function_handle(%struct._function_handle_t addrspace(1)* nocapture readonly, %struct._function_handle_t addrspace(1)* nocapture readonly) local_unnamed_addr #4

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind readonly willreturn
declare %struct._function_handle_t addrspace(1)* @air.get_null_function_handle() local_unnamed_addr #5

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind readonly willreturn
declare %struct._visible_function_table_t addrspace(1)* @air.get_null_visible_function_table() local_unnamed_addr #5

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_size_visible_function_table(%struct._visible_function_table_t addrspace(1)* nocapture readonly) local_unnamed_addr #4

; Function Attrs: mustprogress nounwind willreturn
declare void @air.draw_indexed_primitives_render_command.p1i32(%struct._command_buffer_t addrspace(1)* nocapture, i32, i32, i32, i32 addrspace(1)*, i32, i32, i32) local_unnamed_addr #6

; Function Attrs: mustprogress nounwind willreturn
declare void @air.draw_patches_render_command.p1i32.p1i8(%struct._command_buffer_t addrspace(1)* nocapture, i32, i32, i32, i32, i32 addrspace(1)*, i32, i32, i8 addrspace(1)*, i32, float) local_unnamed_addr #6

; Function Attrs: mustprogress nounwind willreturn
declare void @air.draw_indexed_patches_render_command.p1i32.p1i8.p1i8(%struct._command_buffer_t addrspace(1)* nocapture, i32, i32, i32, i32, i32 addrspace(1)*, i8 addrspace(1)*, i32, i32, i8 addrspace(1)*, i32, float) local_unnamed_addr #6

attributes #0 = { mustprogress nofree norecurse nosync nounwind readnone willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #1 = { mustprogress nofree nounwind readonly willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #2 = { mustprogress nofree norecurse nosync nounwind readnone willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #3 = { mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #4 = { argmemonly mustprogress nofree nounwind readonly willreturn }
attributes #5 = { inaccessiblememonly mustprogress nofree nounwind readonly willreturn }
attributes #6 = { mustprogress nounwind willreturn }
attributes #7 = { inaccessiblememonly nounwind readonly willreturn }
attributes #8 = { argmemonly nounwind readonly willreturn }
attributes #9 = { nounwind willreturn }

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
!15 = !{!"/Users/runner/metal_probe/p12/P11M/probe.metal"}
