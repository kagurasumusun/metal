; ModuleID = 'probe.metal'
source_filename = "probe.metal"
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-n8:16:32"
target triple = "air64_v28-apple-macosx26.0.0"

%struct._intersection_query_t = type opaque
%struct._instance_acceleration_structure_t = type opaque
%struct._intersection_function_table_t = type opaque
%struct._intersection_result_t = type opaque
%struct._primitive_acceleration_structure_t = type opaque
%struct._visible_function_table_t = type opaque
%struct._command_buffer_t = type opaque
%struct._patch_control_point_t = type opaque

; Function Attrs: mustprogress nounwind willreturn
define i8 addrspace(1)* @probe_p24m_pdc() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #16
  %2 = tail call i8 addrspace(1)* @air.get_candidate_primitive_data_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #17
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #16
  ret i8 addrspace(1)* %2
}

; Function Attrs: mustprogress nounwind willreturn
declare %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t*) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
define i8 addrspace(1)* @probe_p24m_pdc2() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #16
  %2 = tail call i8 addrspace(1)* @air.get_committed_primitive_data_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #17
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #16
  ret i8 addrspace(1)* %2
}

; Function Attrs: mustprogress nounwind willreturn
define zeroext i1 @probe_p24m_pdr(%struct._instance_acceleration_structure_t addrspace(1)* %0) local_unnamed_addr #2 {
  %2 = tail call %struct._intersection_function_table_t addrspace(1)* @air.get_null_intersection_function_table() #18
  %3 = tail call { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } @air.intersect_direct_access.instancing.triangle_data(<3 x float> zeroinitializer, <3 x float> zeroinitializer, float 0.000000e+00, float 0x7FF0000000000000, %struct._instance_acceleration_structure_t addrspace(1)* readonly %0, i32 -1, %struct._intersection_function_table_t addrspace(1)* readonly %2, i8* null, i64 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 3, i32 -1, i32 -1, i32 0, i1 false, i1 false) #16
  %4 = extractvalue { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } %3, 0
  %5 = tail call i8 addrspace(1)* @air.get_primitive_data_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)* %4) #19
  %6 = icmp ne i8 addrspace(1)* %5, null
  tail call void @air.release_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)* %4) #16
  ret i1 %6
}

; Function Attrs: mustprogress nounwind willreturn
define zeroext i1 @probe_p24m_next(%struct._instance_acceleration_structure_t addrspace(1)* %0) local_unnamed_addr #2 {
  %2 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #16
  tail call void @air.reset_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %2, <3 x float> zeroinitializer, <3 x float> zeroinitializer, float 0.000000e+00, float 0x7FF0000000000000, %struct._instance_acceleration_structure_t addrspace(1)* readonly %0, i32 -1, i32 0, i32 0, i32 0, i32 0, i32 0, i32 3, i32 -1, i32 -1, i32 0, i1 false, i1 false) #16
  %3 = tail call i1 @air.next_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %2) #16
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %2) #16
  ret i1 %3
}

; Function Attrs: mustprogress nounwind willreturn
define zeroext i1 @probe_p24m_reset(%struct._instance_acceleration_structure_t addrspace(1)* %0) local_unnamed_addr #2 {
  ret i1 true
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p24m_asnull(%struct._instance_acceleration_structure_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #3 {
  %2 = tail call i1 @air.is_null_instance_acceleration_structure(%struct._instance_acceleration_structure_t addrspace(1)* nocapture readonly %0) #17
  ret i1 %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p24m_asnullp(%struct._primitive_acceleration_structure_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #3 {
  %2 = tail call i1 @air.is_null_primitive_acceleration_structure(%struct._primitive_acceleration_structure_t addrspace(1)* nocapture readonly %0) #17
  ret i1 %2
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define i32 @probe_p24m_subas(%struct._instance_acceleration_structure_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #4 {
  %2 = tail call %struct._instance_acceleration_structure_t addrspace(1)* @air.get_instance_acceleration_structure_instance_acceleration_structure(%struct._instance_acceleration_structure_t addrspace(1)* nocapture readonly %0, i32 0) #17
  %3 = tail call i1 @air.is_null_instance_acceleration_structure(%struct._instance_acceleration_structure_t addrspace(1)* nocapture readonly %2) #17
  %4 = zext i1 %3 to i32
  ret i32 %4
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define i32 @probe_p24m_subasp(%struct._instance_acceleration_structure_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #4 {
  %2 = tail call %struct._primitive_acceleration_structure_t addrspace(1)* @air.get_primitive_acceleration_structure_instance_acceleration_structure(%struct._instance_acceleration_structure_t addrspace(1)* nocapture readonly %0, i32 0) #17
  %3 = tail call i1 @air.is_null_primitive_acceleration_structure(%struct._primitive_acceleration_structure_t addrspace(1)* nocapture readonly %2) #17
  %4 = zext i1 %3 to i32
  ret i32 %4
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p24m_iftbuf(%struct._intersection_function_table_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #3 {
  %2 = tail call i8 addrspace(1)* @air.get_buffer_intersection_function_table.p1i8(%struct._intersection_function_table_t addrspace(1)* nocapture readonly %0, i32 0) #17
  %3 = icmp ne i8 addrspace(1)* %2, null
  ret i1 %3
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p24m_iftvft(%struct._intersection_function_table_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #4 {
  %2 = tail call i8 addrspace(1)* @air.get_buffer_intersection_function_table.p1i8(%struct._intersection_function_table_t addrspace(1)* %0, i32 0) #20
  %3 = bitcast i8 addrspace(1)* %2 to %struct._visible_function_table_t addrspace(1)*
  %4 = tail call i32 @air.get_size_visible_function_table(%struct._visible_function_table_t addrspace(1)* nocapture readonly %3) #17
  %5 = icmp eq i32 %4, 0
  ret i1 %5
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p24m_vftfp(%struct._visible_function_table_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #3 {
  %2 = tail call i8* @air.get_function_pointer_visible_function_table(%struct._visible_function_table_t addrspace(1)* nocapture readonly %0, i32 0) #17
  %3 = icmp eq i8* %2, null
  ret i1 %3
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define i64 @probe_p24m_cbsize(%struct._command_buffer_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #4 {
  %2 = tail call i32 @air.get_size_command_buffer(%struct._command_buffer_t addrspace(1)* nocapture readonly %0) #19
  %3 = zext i32 %2 to i64
  ret i64 %3
}

; Function Attrs: convergent mustprogress nofree nounwind readonly willreturn
define <4 x float> @probe_p24m_cp(%struct._patch_control_point_t* %0, i16 noundef %1) local_unnamed_addr #5 {
  %3 = urem i16 %1, 3
  %4 = zext i16 %3 to i32
  %5 = tail call { <4 x float> } @_Z2CP.MTL_CONTROL_POINT_FN(i32 %4, %struct._patch_control_point_t* %0) #21
  %6 = extractvalue { <4 x float> } %5, 0
  ret <4 x float> %6
}

; Function Attrs: convergent mustprogress nofree nounwind readonly willreturn
declare { <4 x float> } @_Z2CP.MTL_CONTROL_POINT_FN(i32, %struct._patch_control_point_t*) local_unnamed_addr #6 section "air.externally_defined"

; Function Attrs: convergent mustprogress nounwind willreturn
define void @probe_p24m_mload(float addrspace(1)* nocapture noundef readonly %0, float addrspace(1)* nocapture noundef writeonly %1) local_unnamed_addr #7 {
  %3 = tail call fast <64 x float> @air.simdgroup_matrix_8x8_load.v64f32.p1f32(float addrspace(1)* nocapture readonly %0, <2 x i64> <i64 8, i64 8>, <2 x i64> <i64 1, i64 8>, <2 x i64> zeroinitializer) #21
  tail call void @air.simdgroup_matrix_8x8_store.v64f32.p1f32(<64 x float> %3, float addrspace(1)* nocapture writeonly %1, <2 x i64> <i64 8, i64 8>, <2 x i64> <i64 1, i64 8>, <2 x i64> zeroinitializer) #22
  ret void
}

; Function Attrs: mustprogress nofree nosync nounwind willreturn
define i32 @probe_p24m_unif(i32 noundef %0) local_unnamed_addr #8 {
  %2 = tail call i1 @air.is_uniform.i32(i32 %0) #23
  tail call void @llvm.assume(i1 %2) #20
  ret i32 %0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define float @probe_p24m_div(float noundef %0, float noundef %1) local_unnamed_addr #9 {
  %3 = fdiv reassoc nsz arcp contract afn float %0, %1
  ret float %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define float @probe_p24m_sel(float noundef %0, float noundef %1, i32 noundef %2) local_unnamed_addr #9 {
  %4 = icmp slt i32 %2, 0
  %5 = select reassoc nsz arcp contract afn i1 %4, float %0, float %1
  ret float %5
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i1 @air.is_null_instance_acceleration_structure(%struct._instance_acceleration_structure_t addrspace(1)* nocapture readonly) local_unnamed_addr #10

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i1 @air.is_null_primitive_acceleration_structure(%struct._primitive_acceleration_structure_t addrspace(1)* nocapture readonly) local_unnamed_addr #10

; Function Attrs: mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_size_command_buffer(%struct._command_buffer_t addrspace(1)* nocapture readonly) local_unnamed_addr #11

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare i1 @air.is_uniform.i32(i32) local_unnamed_addr #12

; Function Attrs: inaccessiblememonly mustprogress nocallback nofree nosync nounwind willreturn
declare void @llvm.assume(i1 noundef) #13

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i8 addrspace(1)* @air.get_candidate_primitive_data_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #10

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i8 addrspace(1)* @air.get_committed_primitive_data_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #10

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind readonly willreturn
declare %struct._intersection_function_table_t addrspace(1)* @air.get_null_intersection_function_table() local_unnamed_addr #14

; Function Attrs: mustprogress nounwind willreturn
declare { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } @air.intersect_direct_access.instancing.triangle_data(<3 x float>, <3 x float>, float, float, %struct._instance_acceleration_structure_t addrspace(1)* readonly, i32, %struct._intersection_function_table_t addrspace(1)* readonly, i8*, i64, i32, i32, i32, i32, i32, i32, i32, i32, i32, i1, i1) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare void @air.release_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)*) local_unnamed_addr #1

; Function Attrs: mustprogress nofree nounwind readonly willreturn
declare i8 addrspace(1)* @air.get_primitive_data_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)*) local_unnamed_addr #11

; Function Attrs: mustprogress nounwind willreturn
declare void @air.reset_intersection_query.instancing.triangle_data(%struct._intersection_query_t*, <3 x float>, <3 x float>, float, float, %struct._instance_acceleration_structure_t addrspace(1)* readonly, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i1, i1) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare i1 @air.next_intersection_query.instancing.triangle_data(%struct._intersection_query_t*) local_unnamed_addr #1

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare %struct._instance_acceleration_structure_t addrspace(1)* @air.get_instance_acceleration_structure_instance_acceleration_structure(%struct._instance_acceleration_structure_t addrspace(1)* nocapture readonly, i32) local_unnamed_addr #10

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare %struct._primitive_acceleration_structure_t addrspace(1)* @air.get_primitive_acceleration_structure_instance_acceleration_structure(%struct._instance_acceleration_structure_t addrspace(1)* nocapture readonly, i32) local_unnamed_addr #10

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i8 addrspace(1)* @air.get_buffer_intersection_function_table.p1i8(%struct._intersection_function_table_t addrspace(1)* nocapture readonly, i32) local_unnamed_addr #10

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_size_visible_function_table(%struct._visible_function_table_t addrspace(1)* nocapture readonly) local_unnamed_addr #10

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i8* @air.get_function_pointer_visible_function_table(%struct._visible_function_table_t addrspace(1)* nocapture readonly, i32) local_unnamed_addr #10

; Function Attrs: convergent mustprogress nofree nounwind readonly willreturn
declare <64 x float> @air.simdgroup_matrix_8x8_load.v64f32.p1f32(float addrspace(1)* nocapture readonly, <2 x i64>, <2 x i64>, <2 x i64>) local_unnamed_addr #6

; Function Attrs: convergent mustprogress nounwind willreturn writeonly
declare void @air.simdgroup_matrix_8x8_store.v64f32.p1f32(<64 x float>, float addrspace(1)* nocapture writeonly, <2 x i64>, <2 x i64>, <2 x i64>) local_unnamed_addr #15

attributes #0 = { mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #1 = { mustprogress nounwind willreturn }
attributes #2 = { mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="96" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #3 = { argmemonly mustprogress nofree nounwind readonly willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #4 = { mustprogress nofree nounwind readonly willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #5 = { convergent mustprogress nofree nounwind readonly willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="128" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #6 = { convergent mustprogress nofree nounwind readonly willreturn }
attributes #7 = { convergent mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="2048" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #8 = { mustprogress nofree nosync nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #9 = { mustprogress nofree norecurse nosync nounwind readnone willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #10 = { argmemonly mustprogress nofree nounwind readonly willreturn }
attributes #11 = { mustprogress nofree nounwind readonly willreturn }
attributes #12 = { mustprogress nofree nosync nounwind readnone willreturn }
attributes #13 = { inaccessiblememonly mustprogress nocallback nofree nosync nounwind willreturn }
attributes #14 = { inaccessiblememonly mustprogress nofree nounwind readonly willreturn }
attributes #15 = { convergent mustprogress nounwind willreturn writeonly }
attributes #16 = { nounwind willreturn }
attributes #17 = { argmemonly nounwind readonly willreturn }
attributes #18 = { inaccessiblememonly nounwind readonly willreturn }
attributes #19 = { nounwind readonly willreturn }
attributes #20 = { nounwind }
attributes #21 = { convergent nounwind readonly willreturn }
attributes #22 = { convergent nounwind willreturn writeonly }
attributes #23 = { nounwind readnone willreturn }

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5, !6, !7, !8}
!air.vertex = !{!9}
!air.compile_options = !{!18, !19, !20}
!llvm.ident = !{!21}
!air.version = !{!22}
!air.language_version = !{!23}
!air.source_file_name = !{!24}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 26, i32 5]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"frame-pointer", i32 2}
!3 = !{i32 7, !"air.max_device_buffers", i32 31}
!4 = !{i32 7, !"air.max_constant_buffers", i32 31}
!5 = !{i32 7, !"air.max_threadgroup_buffers", i32 31}
!6 = !{i32 7, !"air.max_textures", i32 128}
!7 = !{i32 7, !"air.max_read_write_textures", i32 8}
!8 = !{i32 7, !"air.max_samplers", i32 16}
!9 = !{<4 x float> (%struct._patch_control_point_t*, i16)* @probe_p24m_cp, !10, !12, !17}
!10 = !{!11}
!11 = !{!"air.position", !"air.arg_type_name", !"float4"}
!12 = !{!13, !16}
!13 = !{i32 0, !"air.patch_control_point_input", !14, !15}
!14 = !{!"air.patch_control_point_function", { <4 x float> } (i32, %struct._patch_control_point_t*)* @_Z2CP.MTL_CONTROL_POINT_FN}
!15 = !{!"air.location_index", i32 0, i32 1, !"air.arg_type_name", !"float4", !"air.arg_name", !"p"}
!16 = !{i32 1, !"air.patch_id", !"air.arg_type_name", !"ushort", !"air.arg_name", !"__pid"}
!17 = !{!"air.patch", !"triangle", !"air.patch_control_point", i32 3}
!18 = !{!"air.compile.denorms_disable"}
!19 = !{!"air.compile.fast_math_enable"}
!20 = !{!"air.compile.framebuffer_fetch_enable"}
!21 = !{!"Apple metal version 32023.883 (metalfe-32023.883)"}
!22 = !{i32 2, i32 8, i32 0}
!23 = !{!"Metal", i32 4, i32 0, i32 0}
!24 = !{!"/Users/runner/metal_probe/p24b/P24B/probe.metal"}
