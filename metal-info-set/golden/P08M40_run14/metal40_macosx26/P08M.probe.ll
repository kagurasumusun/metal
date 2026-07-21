; ModuleID = 'probe.metal'
source_filename = "probe.metal"
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-n8:16:32"
target triple = "air64_v28-apple-macosx26.0.0"

%struct._intersection_query_t = type opaque
%struct._instance_acceleration_structure_t = type opaque
%struct._intersection_function_table_t = type opaque
%struct._intersection_result_t = type opaque
%"struct.metal::matrix" = type { [4 x <3 x float>] }
%struct._visible_function_table_t = type opaque
%"struct.metal::compute_pipeline_state" = type { %struct._compute_pipeline_state_t addrspace(1)* }
%struct._compute_pipeline_state_t = type opaque
%"struct.metal::depth_stencil_state" = type { %struct._depth_stencil_state_t addrspace(1)* }
%struct._depth_stencil_state_t = type opaque
%"struct.metal::raytracing::intersection_function_table" = type { %struct._intersection_function_table_t addrspace(1)* }
%"struct.metal::raytracing::intersection_result" = type <{ %"struct.metal::raytracing::_intersection_result_base", %"struct.metal::raytracing::_intersection_result_instancing_ext", %"struct.metal::raytracing::_intersection_result_triangle_data_ext.base", [7 x i8] }>
%"struct.metal::raytracing::_intersection_result_base" = type { i32, float, i32, i32, i8 addrspace(1)* }
%"struct.metal::raytracing::_intersection_result_instancing_ext" = type { i32, i32 }
%"struct.metal::raytracing::_intersection_result_triangle_data_ext.base" = type <{ <2 x float>, i8 }>
%"struct.metal::render_pipeline_state" = type { %struct._render_pipeline_state_t addrspace(1)* }
%struct._render_pipeline_state_t = type opaque
%"struct.metal::tensor" = type { %struct._tensor_t addrspace(1)* }
%struct._tensor_t = type opaque
%"struct.metal::visible_function_table" = type { %struct._visible_function_table_t addrspace(1)* }

; Function Attrs: mustprogress nounwind willreturn
define i32 @probe_p08m_iq_0() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #8
  %2 = tail call i32 @air.get_candidate_intersection_type_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #9
  %3 = icmp ne i32 %2, 0
  %4 = zext i1 %3 to i32
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #8
  ret i32 %4
}

; Function Attrs: mustprogress nounwind willreturn
declare %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t*) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
define i32 @probe_p08m_iq_1() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #8
  %2 = tail call i32 @air.get_committed_intersection_type_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #9
  %3 = icmp ne i32 %2, 0
  %4 = zext i1 %3 to i32
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #8
  ret i32 %4
}

; Function Attrs: mustprogress nounwind willreturn
define float @probe_p08m_irr_2(%struct._instance_acceleration_structure_t addrspace(1)* %0) local_unnamed_addr #0 {
  %2 = tail call %struct._intersection_function_table_t addrspace(1)* @air.get_null_intersection_function_table() #10
  %3 = tail call { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } @air.intersect_direct_access.instancing.triangle_data.curve_data(<3 x float> zeroinitializer, <3 x float> zeroinitializer, float 0.000000e+00, float 0x7FF0000000000000, %struct._instance_acceleration_structure_t addrspace(1)* readonly %0, i32 -1, %struct._intersection_function_table_t addrspace(1)* readonly %2, i8* null, i64 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 3, i32 -1, i32 -1, i32 0, i1 false, i1 false) #8
  %4 = extractvalue { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } %3, 0
  %5 = tail call fast float @air.get_curve_parameter_intersection_result.instancing.triangle_data.curve_data(%struct._intersection_result_t addrspace(9)* %4) #11
  tail call void @air.release_intersection_result.instancing.triangle_data.curve_data(%struct._intersection_result_t addrspace(9)* %4) #8
  ret float %5
}

; Function Attrs: mustprogress nounwind willreturn
define float @probe_p08m_irr_3(%struct._instance_acceleration_structure_t addrspace(1)* %0) local_unnamed_addr #0 {
  %2 = tail call %struct._intersection_function_table_t addrspace(1)* @air.get_null_intersection_function_table() #10
  %3 = tail call { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } @air.intersect_direct_access.instancing.triangle_data(<3 x float> zeroinitializer, <3 x float> zeroinitializer, float 0.000000e+00, float 0x7FF0000000000000, %struct._instance_acceleration_structure_t addrspace(1)* readonly %0, i32 -1, %struct._intersection_function_table_t addrspace(1)* readonly %2, i8* null, i64 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 3, i32 -1, i32 -1, i32 0, i1 false, i1 false) #8
  %4 = extractvalue { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } %3, 0
  %5 = tail call fast float @air.get_distance_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)* %4) #11
  tail call void @air.release_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)* %4) #8
  ret float %5
}

; Function Attrs: mustprogress nounwind willreturn
define i32 @probe_p08m_irr_4(%struct._instance_acceleration_structure_t addrspace(1)* %0) local_unnamed_addr #0 {
  %2 = tail call %struct._intersection_function_table_t addrspace(1)* @air.get_null_intersection_function_table() #10
  %3 = tail call { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } @air.intersect_direct_access.instancing.triangle_data(<3 x float> zeroinitializer, <3 x float> zeroinitializer, float 0.000000e+00, float 0x7FF0000000000000, %struct._instance_acceleration_structure_t addrspace(1)* readonly %0, i32 -1, %struct._intersection_function_table_t addrspace(1)* readonly %2, i8* null, i64 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 3, i32 -1, i32 -1, i32 0, i1 false, i1 false) #8
  %4 = extractvalue { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } %3, 0
  %5 = tail call i32 @air.get_geometry_id_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)* %4) #11
  tail call void @air.release_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)* %4) #8
  ret i32 %5
}

; Function Attrs: mustprogress nounwind willreturn
define i32 @probe_p08m_irr_5(%struct._instance_acceleration_structure_t addrspace(1)* %0) local_unnamed_addr #0 {
  %2 = tail call %struct._intersection_function_table_t addrspace(1)* @air.get_null_intersection_function_table() #10
  %3 = tail call { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } @air.intersect_direct_access.instancing.triangle_data(<3 x float> zeroinitializer, <3 x float> zeroinitializer, float 0.000000e+00, float 0x7FF0000000000000, %struct._instance_acceleration_structure_t addrspace(1)* readonly %0, i32 -1, %struct._intersection_function_table_t addrspace(1)* readonly %2, i8* null, i64 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 3, i32 -1, i32 -1, i32 0, i1 false, i1 false) #8
  %4 = extractvalue { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } %3, 0
  %5 = tail call i32 @air.get_type_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)* %4) #11
  %6 = icmp ne i32 %5, 0
  %7 = zext i1 %6 to i32
  tail call void @air.release_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)* %4) #8
  ret i32 %7
}

; Function Attrs: mustprogress nounwind willreturn
define i32 @probe_p08m_irr_6(%struct._instance_acceleration_structure_t addrspace(1)* %0) local_unnamed_addr #0 {
  %2 = tail call %struct._intersection_function_table_t addrspace(1)* @air.get_null_intersection_function_table() #10
  %3 = tail call { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } @air.intersect_direct_access.instancing.triangle_data(<3 x float> zeroinitializer, <3 x float> zeroinitializer, float 0.000000e+00, float 0x7FF0000000000000, %struct._instance_acceleration_structure_t addrspace(1)* readonly %0, i32 -1, %struct._intersection_function_table_t addrspace(1)* readonly %2, i8* null, i64 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 3, i32 -1, i32 -1, i32 0, i1 false, i1 false) #8
  %4 = extractvalue { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } %3, 0
  %5 = tail call i32 @air.get_instance_id_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)* %4) #11
  tail call void @air.release_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)* %4) #8
  ret i32 %5
}

; Function Attrs: mustprogress nounwind willreturn
define %"struct.metal::matrix" @probe_p08m_irr_7(%struct._instance_acceleration_structure_t addrspace(1)* %0) local_unnamed_addr #0 {
  %2 = tail call %struct._intersection_function_table_t addrspace(1)* @air.get_null_intersection_function_table() #10
  %3 = tail call { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } @air.intersect_direct_access.instancing.triangle_data.world_space_data(<3 x float> zeroinitializer, <3 x float> zeroinitializer, float 0.000000e+00, float 0x7FF0000000000000, %struct._instance_acceleration_structure_t addrspace(1)* readonly %0, i32 -1, %struct._intersection_function_table_t addrspace(1)* readonly %2, i8* null, i64 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 3, i32 -1, i32 -1, i32 0, i1 false, i1 false) #8
  %4 = extractvalue { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } %3, 0
  %5 = tail call { <3 x float>, <3 x float>, <3 x float>, <3 x float> } @air.get_object_to_world_transform_intersection_result.instancing.triangle_data.world_space_data(%struct._intersection_result_t addrspace(9)* %4) #11
  %6 = extractvalue { <3 x float>, <3 x float>, <3 x float>, <3 x float> } %5, 0
  %7 = extractvalue { <3 x float>, <3 x float>, <3 x float>, <3 x float> } %5, 1
  %8 = extractvalue { <3 x float>, <3 x float>, <3 x float>, <3 x float> } %5, 2
  %9 = extractvalue { <3 x float>, <3 x float>, <3 x float>, <3 x float> } %5, 3
  tail call void @air.release_intersection_result.instancing.triangle_data.world_space_data(%struct._intersection_result_t addrspace(9)* %4) #8
  %10 = insertvalue %"struct.metal::matrix" poison, <3 x float> %6, 0, 0
  %11 = insertvalue %"struct.metal::matrix" %10, <3 x float> %7, 0, 1
  %12 = insertvalue %"struct.metal::matrix" %11, <3 x float> %8, 0, 2
  %13 = insertvalue %"struct.metal::matrix" %12, <3 x float> %9, 0, 3
  ret %"struct.metal::matrix" %13
}

; Function Attrs: mustprogress nounwind willreturn
define i32 @probe_p08m_irr_8(%struct._instance_acceleration_structure_t addrspace(1)* %0) local_unnamed_addr #0 {
  %2 = tail call %struct._intersection_function_table_t addrspace(1)* @air.get_null_intersection_function_table() #10
  %3 = tail call { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } @air.intersect_direct_access.instancing.triangle_data(<3 x float> zeroinitializer, <3 x float> zeroinitializer, float 0.000000e+00, float 0x7FF0000000000000, %struct._instance_acceleration_structure_t addrspace(1)* readonly %0, i32 -1, %struct._intersection_function_table_t addrspace(1)* readonly %2, i8* null, i64 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 3, i32 -1, i32 -1, i32 0, i1 false, i1 false) #8
  %4 = extractvalue { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } %3, 0
  %5 = tail call i32 @air.get_primitive_id_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)* %4) #11
  tail call void @air.release_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)* %4) #8
  ret i32 %5
}

; Function Attrs: mustprogress nounwind willreturn
define <3 x float> @probe_p08m_irr_9(%struct._instance_acceleration_structure_t addrspace(1)* %0) local_unnamed_addr #0 {
  %2 = tail call %struct._intersection_function_table_t addrspace(1)* @air.get_null_intersection_function_table() #10
  %3 = tail call { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } @air.intersect_direct_access.instancing.triangle_data(<3 x float> zeroinitializer, <3 x float> zeroinitializer, float 0.000000e+00, float 0x7FF0000000000000, %struct._instance_acceleration_structure_t addrspace(1)* readonly %0, i32 -1, %struct._intersection_function_table_t addrspace(1)* readonly %2, i8* null, i64 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 3, i32 -1, i32 -1, i32 0, i1 false, i1 false) #8
  %4 = extractvalue { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } %3, 0
  %5 = tail call fast <3 x float> @air.get_ray_direction_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)* %4) #11
  tail call void @air.release_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)* %4) #8
  ret <3 x float> %5
}

; Function Attrs: mustprogress nounwind willreturn
define float @probe_p08m_irr_10(%struct._instance_acceleration_structure_t addrspace(1)* %0) local_unnamed_addr #0 {
  %2 = tail call %struct._intersection_function_table_t addrspace(1)* @air.get_null_intersection_function_table() #10
  %3 = tail call { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } @air.intersect_direct_access.instancing.triangle_data(<3 x float> zeroinitializer, <3 x float> zeroinitializer, float 0.000000e+00, float 0x7FF0000000000000, %struct._instance_acceleration_structure_t addrspace(1)* readonly %0, i32 -1, %struct._intersection_function_table_t addrspace(1)* readonly %2, i8* null, i64 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 3, i32 -1, i32 -1, i32 0, i1 false, i1 false) #8
  %4 = extractvalue { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } %3, 0
  %5 = tail call fast float @air.get_ray_min_distance_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)* %4) #11
  tail call void @air.release_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)* %4) #8
  ret float %5
}

; Function Attrs: mustprogress nounwind willreturn
define <3 x float> @probe_p08m_irr_11(%struct._instance_acceleration_structure_t addrspace(1)* %0) local_unnamed_addr #0 {
  %2 = tail call %struct._intersection_function_table_t addrspace(1)* @air.get_null_intersection_function_table() #10
  %3 = tail call { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } @air.intersect_direct_access.instancing.triangle_data(<3 x float> zeroinitializer, <3 x float> zeroinitializer, float 0.000000e+00, float 0x7FF0000000000000, %struct._instance_acceleration_structure_t addrspace(1)* readonly %0, i32 -1, %struct._intersection_function_table_t addrspace(1)* readonly %2, i8* null, i64 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 3, i32 -1, i32 -1, i32 0, i1 false, i1 false) #8
  %4 = extractvalue { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } %3, 0
  %5 = tail call fast <3 x float> @air.get_ray_origin_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)* %4) #11
  tail call void @air.release_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)* %4) #8
  ret <3 x float> %5
}

; Function Attrs: mustprogress nounwind willreturn
define <2 x float> @probe_p08m_irr_12(%struct._instance_acceleration_structure_t addrspace(1)* %0) local_unnamed_addr #0 {
  %2 = tail call %struct._intersection_function_table_t addrspace(1)* @air.get_null_intersection_function_table() #10
  %3 = tail call { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } @air.intersect_direct_access.instancing.triangle_data(<3 x float> zeroinitializer, <3 x float> zeroinitializer, float 0.000000e+00, float 0x7FF0000000000000, %struct._instance_acceleration_structure_t addrspace(1)* readonly %0, i32 -1, %struct._intersection_function_table_t addrspace(1)* readonly %2, i8* null, i64 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 3, i32 -1, i32 -1, i32 0, i1 false, i1 false) #8
  %4 = extractvalue { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } %3, 0
  %5 = tail call fast <2 x float> @air.get_triangle_barycentric_coord_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)* %4) #11
  tail call void @air.release_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)* %4) #8
  ret <2 x float> %5
}

; Function Attrs: mustprogress nounwind willreturn
define i32 @probe_p08m_irr_13(%struct._instance_acceleration_structure_t addrspace(1)* %0) local_unnamed_addr #0 {
  %2 = tail call %struct._intersection_function_table_t addrspace(1)* @air.get_null_intersection_function_table() #10
  %3 = tail call { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } @air.intersect_direct_access.instancing.triangle_data(<3 x float> zeroinitializer, <3 x float> zeroinitializer, float 0.000000e+00, float 0x7FF0000000000000, %struct._instance_acceleration_structure_t addrspace(1)* readonly %0, i32 -1, %struct._intersection_function_table_t addrspace(1)* readonly %2, i8* null, i64 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 3, i32 -1, i32 -1, i32 0, i1 false, i1 false) #8
  %4 = extractvalue { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } %3, 0
  %5 = tail call i32 @air.get_user_instance_id_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)* %4) #11
  tail call void @air.release_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)* %4) #8
  ret i32 %5
}

; Function Attrs: mustprogress nounwind willreturn
define %"struct.metal::matrix" @probe_p08m_irr_14(%struct._instance_acceleration_structure_t addrspace(1)* %0) local_unnamed_addr #0 {
  %2 = tail call %struct._intersection_function_table_t addrspace(1)* @air.get_null_intersection_function_table() #10
  %3 = tail call { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } @air.intersect_direct_access.instancing.triangle_data.world_space_data(<3 x float> zeroinitializer, <3 x float> zeroinitializer, float 0.000000e+00, float 0x7FF0000000000000, %struct._instance_acceleration_structure_t addrspace(1)* readonly %0, i32 -1, %struct._intersection_function_table_t addrspace(1)* readonly %2, i8* null, i64 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 3, i32 -1, i32 -1, i32 0, i1 false, i1 false) #8
  %4 = extractvalue { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } %3, 0
  %5 = tail call { <3 x float>, <3 x float>, <3 x float>, <3 x float> } @air.get_world_to_object_transform_intersection_result.instancing.triangle_data.world_space_data(%struct._intersection_result_t addrspace(9)* %4) #11
  %6 = extractvalue { <3 x float>, <3 x float>, <3 x float>, <3 x float> } %5, 0
  %7 = extractvalue { <3 x float>, <3 x float>, <3 x float>, <3 x float> } %5, 1
  %8 = extractvalue { <3 x float>, <3 x float>, <3 x float>, <3 x float> } %5, 2
  %9 = extractvalue { <3 x float>, <3 x float>, <3 x float>, <3 x float> } %5, 3
  tail call void @air.release_intersection_result.instancing.triangle_data.world_space_data(%struct._intersection_result_t addrspace(9)* %4) #8
  %10 = insertvalue %"struct.metal::matrix" poison, <3 x float> %6, 0, 0
  %11 = insertvalue %"struct.metal::matrix" %10, <3 x float> %7, 0, 1
  %12 = insertvalue %"struct.metal::matrix" %11, <3 x float> %8, 0, 2
  %13 = insertvalue %"struct.metal::matrix" %12, <3 x float> %9, 0, 3
  ret %"struct.metal::matrix" %13
}

; Function Attrs: mustprogress nounwind willreturn
define zeroext i1 @probe_p08m_irr_15(%struct._instance_acceleration_structure_t addrspace(1)* %0) local_unnamed_addr #0 {
  %2 = tail call %struct._intersection_function_table_t addrspace(1)* @air.get_null_intersection_function_table() #10
  %3 = tail call { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } @air.intersect_direct_access.instancing.triangle_data(<3 x float> zeroinitializer, <3 x float> zeroinitializer, float 0.000000e+00, float 0x7FF0000000000000, %struct._instance_acceleration_structure_t addrspace(1)* readonly %0, i32 -1, %struct._intersection_function_table_t addrspace(1)* readonly %2, i8* null, i64 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 3, i32 -1, i32 -1, i32 0, i1 false, i1 false) #8
  %4 = extractvalue { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } %3, 0
  %5 = tail call i1 @air.is_triangle_front_facing_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)* %4) #11
  tail call void @air.release_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)* %4) #8
  ret i1 %5
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_ift_16(%struct._visible_function_table_t addrspace(1)* %0) local_unnamed_addr #2 {
  %2 = tail call %struct._intersection_function_table_t addrspace(1)* @air.get_null_intersection_function_table() #10
  %3 = bitcast %struct._visible_function_table_t addrspace(1)* %0 to i8 addrspace(1)*
  tail call void @air.set_buffer_intersection_function_table.p1i8(%struct._intersection_function_table_t addrspace(1)* %2, i8 addrspace(1)* %3, i32 0) #12
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define %"struct.metal::compute_pipeline_state" @probe_p08m_type_17(%struct._compute_pipeline_state_t addrspace(1)* %0) local_unnamed_addr #3 {
  %2 = insertvalue %"struct.metal::compute_pipeline_state" poison, %struct._compute_pipeline_state_t addrspace(1)* %0, 0
  ret %"struct.metal::compute_pipeline_state" %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define %"struct.metal::depth_stencil_state" @probe_p08m_type_18(%struct._depth_stencil_state_t addrspace(1)* %0) local_unnamed_addr #3 {
  %2 = insertvalue %"struct.metal::depth_stencil_state" poison, %struct._depth_stencil_state_t addrspace(1)* %0, 0
  ret %"struct.metal::depth_stencil_state" %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define %"struct.metal::raytracing::intersection_function_table" @probe_p08m_type_19(%struct._intersection_function_table_t addrspace(1)* %0) local_unnamed_addr #3 {
  %2 = insertvalue %"struct.metal::raytracing::intersection_function_table" poison, %struct._intersection_function_table_t addrspace(1)* %0, 0
  ret %"struct.metal::raytracing::intersection_function_table" %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define %"struct.metal::raytracing::intersection_result" @probe_p08m_type_20(%"struct.metal::raytracing::_intersection_result_base" %0, %"struct.metal::raytracing::_intersection_result_instancing_ext" %1, %"struct.metal::raytracing::_intersection_result_triangle_data_ext.base" %2, [7 x i8] %3) local_unnamed_addr #3 {
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

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define %"struct.metal::render_pipeline_state" @probe_p08m_type_21(%struct._render_pipeline_state_t addrspace(1)* %0) local_unnamed_addr #3 {
  %2 = insertvalue %"struct.metal::render_pipeline_state" poison, %struct._render_pipeline_state_t addrspace(1)* %0, 0
  ret %"struct.metal::render_pipeline_state" %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define %"struct.metal::tensor" @probe_p08m_type_22(%struct._tensor_t addrspace(1)* %0) local_unnamed_addr #3 {
  %2 = insertvalue %"struct.metal::tensor" poison, %struct._tensor_t addrspace(1)* %0, 0
  ret %"struct.metal::tensor" %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define %"struct.metal::visible_function_table" @probe_p08m_type_23(%struct._visible_function_table_t addrspace(1)* %0) local_unnamed_addr #3 {
  %2 = insertvalue %"struct.metal::visible_function_table" poison, %struct._visible_function_table_t addrspace(1)* %0, 0
  ret %"struct.metal::visible_function_table" %2
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_candidate_intersection_type_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #4

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_committed_intersection_type_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #4

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind readonly willreturn
declare %struct._intersection_function_table_t addrspace(1)* @air.get_null_intersection_function_table() local_unnamed_addr #5

; Function Attrs: mustprogress nounwind willreturn
declare { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } @air.intersect_direct_access.instancing.triangle_data.curve_data(<3 x float>, <3 x float>, float, float, %struct._instance_acceleration_structure_t addrspace(1)* readonly, i32, %struct._intersection_function_table_t addrspace(1)* readonly, i8*, i64, i32, i32, i32, i32, i32, i32, i32, i32, i32, i1, i1) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare void @air.release_intersection_result.instancing.triangle_data.curve_data(%struct._intersection_result_t addrspace(9)*) local_unnamed_addr #1

; Function Attrs: mustprogress nofree nounwind readonly willreturn
declare float @air.get_curve_parameter_intersection_result.instancing.triangle_data.curve_data(%struct._intersection_result_t addrspace(9)*) local_unnamed_addr #6

; Function Attrs: mustprogress nounwind willreturn
declare { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } @air.intersect_direct_access.instancing.triangle_data(<3 x float>, <3 x float>, float, float, %struct._instance_acceleration_structure_t addrspace(1)* readonly, i32, %struct._intersection_function_table_t addrspace(1)* readonly, i8*, i64, i32, i32, i32, i32, i32, i32, i32, i32, i32, i1, i1) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare void @air.release_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)*) local_unnamed_addr #1

; Function Attrs: mustprogress nofree nounwind readonly willreturn
declare float @air.get_distance_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)*) local_unnamed_addr #6

; Function Attrs: mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_geometry_id_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)*) local_unnamed_addr #6

; Function Attrs: mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_type_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)*) local_unnamed_addr #6

; Function Attrs: mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_instance_id_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)*) local_unnamed_addr #6

; Function Attrs: mustprogress nounwind willreturn
declare { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } @air.intersect_direct_access.instancing.triangle_data.world_space_data(<3 x float>, <3 x float>, float, float, %struct._instance_acceleration_structure_t addrspace(1)* readonly, i32, %struct._intersection_function_table_t addrspace(1)* readonly, i8*, i64, i32, i32, i32, i32, i32, i32, i32, i32, i32, i1, i1) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare void @air.release_intersection_result.instancing.triangle_data.world_space_data(%struct._intersection_result_t addrspace(9)*) local_unnamed_addr #1

; Function Attrs: mustprogress nofree nounwind readonly willreturn
declare { <3 x float>, <3 x float>, <3 x float>, <3 x float> } @air.get_object_to_world_transform_intersection_result.instancing.triangle_data.world_space_data(%struct._intersection_result_t addrspace(9)*) local_unnamed_addr #6

; Function Attrs: mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_primitive_id_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)*) local_unnamed_addr #6

; Function Attrs: mustprogress nofree nounwind readonly willreturn
declare <3 x float> @air.get_ray_direction_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)*) local_unnamed_addr #6

; Function Attrs: mustprogress nofree nounwind readonly willreturn
declare float @air.get_ray_min_distance_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)*) local_unnamed_addr #6

; Function Attrs: mustprogress nofree nounwind readonly willreturn
declare <3 x float> @air.get_ray_origin_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)*) local_unnamed_addr #6

; Function Attrs: mustprogress nofree nounwind readonly willreturn
declare <2 x float> @air.get_triangle_barycentric_coord_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)*) local_unnamed_addr #6

; Function Attrs: mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_user_instance_id_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)*) local_unnamed_addr #6

; Function Attrs: mustprogress nofree nounwind readonly willreturn
declare { <3 x float>, <3 x float>, <3 x float>, <3 x float> } @air.get_world_to_object_transform_intersection_result.instancing.triangle_data.world_space_data(%struct._intersection_result_t addrspace(9)*) local_unnamed_addr #6

; Function Attrs: mustprogress nofree nounwind readonly willreturn
declare i1 @air.is_triangle_front_facing_intersection_result.instancing.triangle_data(%struct._intersection_result_t addrspace(9)*) local_unnamed_addr #6

; Function Attrs: argmemonly mustprogress nounwind willreturn
declare void @air.set_buffer_intersection_function_table.p1i8(%struct._intersection_function_table_t addrspace(1)* nocapture, i8 addrspace(1)* readonly, i32) local_unnamed_addr #7

attributes #0 = { mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="96" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #1 = { mustprogress nounwind willreturn }
attributes #2 = { mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #3 = { mustprogress nofree norecurse nosync nounwind readnone willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #4 = { argmemonly mustprogress nofree nounwind readonly willreturn }
attributes #5 = { inaccessiblememonly mustprogress nofree nounwind readonly willreturn }
attributes #6 = { mustprogress nofree nounwind readonly willreturn }
attributes #7 = { argmemonly mustprogress nounwind willreturn }
attributes #8 = { nounwind willreturn }
attributes #9 = { argmemonly nounwind readonly willreturn }
attributes #10 = { inaccessiblememonly nounwind readonly willreturn }
attributes #11 = { nounwind readonly willreturn }
attributes #12 = { nounwind }

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
!15 = !{!"/Users/runner/metal_probe/p14/P08M/probe.metal"}
