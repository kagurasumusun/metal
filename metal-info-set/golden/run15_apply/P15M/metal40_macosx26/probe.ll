; ModuleID = 'probe.metal'
source_filename = "probe.metal"
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-n8:16:32"
target triple = "air64_v28-apple-macosx26.0.0"

%struct._intersection_query_t = type opaque
%struct._instance_acceleration_structure_t = type opaque
%struct._intersection_function_table_t = type opaque
%struct._intersection_result_t = type opaque

; Function Attrs: mustprogress nounwind willreturn
define i32 @probe_p15m_iq_0() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.multi_level_instancing.triangle_data(i8 3) #6
  %2 = tail call i8 @air.get_candidate_instance_count_intersection_query.multi_level_instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #7
  %3 = zext i8 %2 to i32
  tail call void @air.deallocate_intersection_query.multi_level_instancing.triangle_data(%struct._intersection_query_t* %1) #6
  ret i32 %3
}

; Function Attrs: mustprogress nounwind willreturn
declare %struct._intersection_query_t* @air.allocate_intersection_query.multi_level_instancing.triangle_data(i8) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare void @air.deallocate_intersection_query.multi_level_instancing.triangle_data(%struct._intersection_query_t*) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
define i32 @probe_p15m_iq_1() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.multi_level_instancing.triangle_data(i8 3) #6
  %2 = tail call i8 @air.get_committed_instance_count_intersection_query.multi_level_instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #7
  %3 = zext i8 %2 to i32
  tail call void @air.deallocate_intersection_query.multi_level_instancing.triangle_data(%struct._intersection_query_t* %1) #6
  ret i32 %3
}

; Function Attrs: mustprogress nounwind willreturn
define i32 @probe_p15m_irr_2(%struct._instance_acceleration_structure_t addrspace(1)* %0) local_unnamed_addr #2 {
  %2 = tail call %struct._intersection_function_table_t addrspace(1)* @air.get_null_intersection_function_table() #8
  %3 = tail call { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } @air.intersect_direct_access.multi_level_instancing.triangle_data(<3 x float> zeroinitializer, <3 x float> zeroinitializer, float 0.000000e+00, float 0x7FF0000000000000, %struct._instance_acceleration_structure_t addrspace(1)* readonly %0, i32 -1, %struct._intersection_function_table_t addrspace(1)* readonly %2, i8* null, i64 0, i8 3, i32 0, i32 0, i32 0, i32 0, i32 0, i32 3, i32 -1, i32 -1, i32 0, i1 false, i1 false) #6
  %4 = extractvalue { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } %3, 0
  %5 = tail call i8 @air.get_instance_count_intersection_result.multi_level_instancing.triangle_data(%struct._intersection_result_t addrspace(9)* %4) #9
  %6 = zext i8 %5 to i32
  tail call void @air.release_intersection_result.multi_level_instancing.triangle_data(%struct._intersection_result_t addrspace(9)* %4) #6
  ret i32 %6
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i8 @air.get_candidate_instance_count_intersection_query.multi_level_instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #3

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i8 @air.get_committed_instance_count_intersection_query.multi_level_instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #3

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind readonly willreturn
declare %struct._intersection_function_table_t addrspace(1)* @air.get_null_intersection_function_table() local_unnamed_addr #4

; Function Attrs: mustprogress nounwind willreturn
declare { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } @air.intersect_direct_access.multi_level_instancing.triangle_data(<3 x float>, <3 x float>, float, float, %struct._instance_acceleration_structure_t addrspace(1)* readonly, i32, %struct._intersection_function_table_t addrspace(1)* readonly, i8*, i64, i8, i32, i32, i32, i32, i32, i32, i32, i32, i32, i1, i1) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare void @air.release_intersection_result.multi_level_instancing.triangle_data(%struct._intersection_result_t addrspace(9)*) local_unnamed_addr #1

; Function Attrs: mustprogress nofree nounwind readonly willreturn
declare i8 @air.get_instance_count_intersection_result.multi_level_instancing.triangle_data(%struct._intersection_result_t addrspace(9)*) local_unnamed_addr #5

attributes #0 = { mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #1 = { mustprogress nounwind willreturn }
attributes #2 = { mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="96" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #3 = { argmemonly mustprogress nofree nounwind readonly willreturn }
attributes #4 = { inaccessiblememonly mustprogress nofree nounwind readonly willreturn }
attributes #5 = { mustprogress nofree nounwind readonly willreturn }
attributes #6 = { nounwind willreturn }
attributes #7 = { argmemonly nounwind readonly willreturn }
attributes #8 = { inaccessiblememonly nounwind readonly willreturn }
attributes #9 = { nounwind readonly willreturn }

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
!15 = !{!"/Users/runner/metal_probe/p15/P15M/probe.metal"}
