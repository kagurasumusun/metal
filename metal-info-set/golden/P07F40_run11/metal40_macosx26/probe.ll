; ModuleID = 'probe.metal'
source_filename = "probe.metal"
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-n8:16:32"
target triple = "air64_v28-apple-macosx26.0.0"

%struct._visible_function_table_t = type opaque
%struct._intersection_function_table_t = type opaque

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p07f_is_null_visible_function_table_0(%struct._visible_function_table_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #0 {
  %2 = tail call i1 @air.is_null_visible_function_table(%struct._visible_function_table_t addrspace(1)* nocapture readonly %0) #3
  ret i1 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p07f_is_null_visible_function_table_1(%struct._visible_function_table_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #0 {
  %2 = tail call i1 @air.is_null_visible_function_table(%struct._visible_function_table_t addrspace(1)* nocapture readonly %0) #3
  ret i1 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p07f_is_null_visible_function_table_2(%struct._visible_function_table_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #0 {
  %2 = tail call i1 @air.is_null_visible_function_table(%struct._visible_function_table_t addrspace(1)* nocapture readonly %0) #3
  ret i1 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p07f_is_null_intersection_function_table_3(%struct._intersection_function_table_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #0 {
  %2 = tail call i1 @air.is_null_intersection_function_table(%struct._intersection_function_table_t addrspace(1)* nocapture readonly %0) #3
  ret i1 %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define float @probe_p07f_fdim_4() local_unnamed_addr #1 {
  ret float 0.000000e+00
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p07f_is_null_visible_function_table_5(%struct._visible_function_table_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #0 {
  %2 = tail call i1 @air.is_null_visible_function_table(%struct._visible_function_table_t addrspace(1)* nocapture readonly %0) #3
  ret i1 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i1 @air.is_null_visible_function_table(%struct._visible_function_table_t addrspace(1)* nocapture readonly) local_unnamed_addr #2

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i1 @air.is_null_intersection_function_table(%struct._intersection_function_table_t addrspace(1)* nocapture readonly) local_unnamed_addr #2

attributes #0 = { argmemonly mustprogress nofree nounwind readonly willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #1 = { mustprogress nofree norecurse nosync nounwind readnone willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" }
attributes #2 = { argmemonly mustprogress nofree nounwind readonly willreturn }
attributes #3 = { argmemonly nounwind readonly willreturn }

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
!15 = !{!"/Users/runner/metal_probe/p11/P07F/probe.metal"}
