; ModuleID = 'probe.metal'
source_filename = "probe.metal"
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-n8:16:32"
target triple = "air64_v28-apple-macosx26.0.0"

%struct._intersection_query_t = type opaque
%struct._command_buffer_t = type opaque
%"struct.metal::_command.base" = type <{ %struct._command_buffer_t addrspace(1)*, i32 }>
%"struct.metal::matrix" = type { [4 x <3 x float>] }
%struct._instance_acceleration_structure_t = type opaque
%"struct.metal::raytracing::_intersection_params" = type <{ i32, i32, i32, i32, i32, i32, i32, i32, i32, i8, i8, [2 x i8] }>
%struct._intersection_function_table_t = type opaque
%struct._depth_stencil_state_t = type opaque
%"struct.metal::compute_pipeline_state" = type { %struct._compute_pipeline_state_t addrspace(1)* }
%struct._compute_pipeline_state_t = type opaque
%"struct.metal::depth_stencil_state" = type { %struct._depth_stencil_state_t addrspace(1)* }
%"struct.metal::raytracing::intersection_function_table" = type { %struct._intersection_function_table_t addrspace(1)* }
%"struct.metal::render_pipeline_state" = type { %struct._render_pipeline_state_t addrspace(1)* }
%struct._render_pipeline_state_t = type opaque

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_iq_0() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #11
  tail call void @air.abort_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
declare %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t*) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_cc_1() local_unnamed_addr #2 {
  tail call void @air.clear_barrier_compute_command(%struct._command_buffer_t addrspace(1)* nocapture undef, i32 0) #11
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_rc_2() local_unnamed_addr #2 {
  tail call void @air.clear_barrier_render_command(%struct._command_buffer_t addrspace(1)* nocapture undef, i32 0) #11
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_iq_3() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #11
  tail call void @air.commit_bounding_box_intersection_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1, float 1.000000e+00) #11
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_iq_4() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data.curve_data() #11
  tail call void @air.commit_curve_intersection_intersection_query.instancing.triangle_data.curve_data(%struct._intersection_query_t* %1) #11
  tail call void @air.deallocate_intersection_query.instancing.triangle_data.curve_data(%struct._intersection_query_t* %1) #11
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
declare %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data.curve_data() local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare void @air.deallocate_intersection_query.instancing.triangle_data.curve_data(%struct._intersection_query_t*) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_iq_5() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #11
  tail call void @air.commit_triangle_intersection_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_cc_6() local_unnamed_addr #0 {
  tail call void @air.concurrent_dispatch_threadgroups_compute_command(%struct._command_buffer_t addrspace(1)* nocapture undef, i32 0, <3 x i32> zeroinitializer, <3 x i32> zeroinitializer) #11
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_cc_7() local_unnamed_addr #0 {
  tail call void @air.concurrent_dispatch_threads_compute_command(%struct._command_buffer_t addrspace(1)* nocapture undef, i32 0, <3 x i32> zeroinitializer, <3 x i32> zeroinitializer) #11
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_cc_8(%"struct.metal::_command.base" %0, [4 x i8] %1) local_unnamed_addr #2 {
  %3 = extractvalue %"struct.metal::_command.base" %0, 0
  %4 = extractvalue %"struct.metal::_command.base" %0, 1
  tail call void @air.copy_compute_command(%struct._command_buffer_t addrspace(1)* nocapture undef, i32 0, %struct._command_buffer_t addrspace(1)* nocapture readonly %3, i32 %4) #11
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_rc_9(%"struct.metal::_command.base" %0, [4 x i8] %1) local_unnamed_addr #2 {
  %3 = extractvalue %"struct.metal::_command.base" %0, 0
  %4 = extractvalue %"struct.metal::_command.base" %0, 1
  tail call void @air.copy_render_command(%struct._command_buffer_t addrspace(1)* nocapture undef, i32 0, %struct._command_buffer_t addrspace(1)* nocapture readonly %3, i32 %4) #11
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_rc_10() local_unnamed_addr #0 {
  tail call void @air.draw_mesh_threadgroups_render_command(%struct._command_buffer_t addrspace(1)* nocapture undef, i32 0, <3 x i32> zeroinitializer, <3 x i32> zeroinitializer, <3 x i32> zeroinitializer) #11
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_rc_11() local_unnamed_addr #0 {
  tail call void @air.draw_mesh_threads_render_command(%struct._command_buffer_t addrspace(1)* nocapture undef, i32 0, <3 x i32> zeroinitializer, <3 x i32> zeroinitializer, <3 x i32> zeroinitializer) #11
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_rc_12() local_unnamed_addr #2 {
  tail call void @air.draw_primitives_render_command(%struct._command_buffer_t addrspace(1)* nocapture undef, i32 0, i32 3, i32 0, i32 0, i32 0, i32 0) #11
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define float @probe_p08m_iq_13() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data.curve_data() #11
  %2 = tail call fast float @air.get_candidate_curve_distance_intersection_query.instancing.triangle_data.curve_data(%struct._intersection_query_t* nocapture readonly %1) #12
  tail call void @air.deallocate_intersection_query.instancing.triangle_data.curve_data(%struct._intersection_query_t* %1) #11
  ret float %2
}

; Function Attrs: mustprogress nounwind willreturn
define float @probe_p08m_iq_14() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data.curve_data() #11
  %2 = tail call fast float @air.get_candidate_curve_parameter_intersection_query.instancing.triangle_data.curve_data(%struct._intersection_query_t* nocapture readonly %1) #12
  tail call void @air.deallocate_intersection_query.instancing.triangle_data.curve_data(%struct._intersection_query_t* %1) #11
  ret float %2
}

; Function Attrs: mustprogress nounwind willreturn
define i32 @probe_p08m_iq_15() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #11
  %2 = tail call i32 @air.get_candidate_geometry_id_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #12
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  ret i32 %2
}

; Function Attrs: mustprogress nounwind willreturn
define i32 @probe_p08m_iq_17() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #11
  %2 = tail call i32 @air.get_candidate_instance_id_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #12
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  ret i32 %2
}

; Function Attrs: mustprogress nounwind willreturn
define i32 @probe_p08m_iq_18() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #11
  %2 = tail call i32 @air.get_candidate_intersection_type_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #12
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  ret i32 %2
}

; Function Attrs: mustprogress nounwind willreturn
define %"struct.metal::matrix" @probe_p08m_iq_19() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #11
  %2 = tail call { <3 x float>, <3 x float>, <3 x float>, <3 x float> } @air.get_candidate_object_to_world_transform_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #12
  %3 = extractvalue { <3 x float>, <3 x float>, <3 x float>, <3 x float> } %2, 0
  %4 = extractvalue { <3 x float>, <3 x float>, <3 x float>, <3 x float> } %2, 1
  %5 = extractvalue { <3 x float>, <3 x float>, <3 x float>, <3 x float> } %2, 2
  %6 = extractvalue { <3 x float>, <3 x float>, <3 x float>, <3 x float> } %2, 3
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  %7 = insertvalue %"struct.metal::matrix" poison, <3 x float> %3, 0, 0
  %8 = insertvalue %"struct.metal::matrix" %7, <3 x float> %4, 0, 1
  %9 = insertvalue %"struct.metal::matrix" %8, <3 x float> %5, 0, 2
  %10 = insertvalue %"struct.metal::matrix" %9, <3 x float> %6, 0, 3
  ret %"struct.metal::matrix" %10
}

; Function Attrs: mustprogress nounwind willreturn
define i32 @probe_p08m_iq_20() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #11
  %2 = tail call i32 @air.get_candidate_primitive_id_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #12
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  ret i32 %2
}

; Function Attrs: mustprogress nounwind willreturn
define <3 x float> @probe_p08m_iq_21() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #11
  %2 = tail call fast <3 x float> @air.get_candidate_ray_direction_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #12
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  ret <3 x float> %2
}

; Function Attrs: mustprogress nounwind willreturn
define <3 x float> @probe_p08m_iq_22() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #11
  %2 = tail call fast <3 x float> @air.get_candidate_ray_origin_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #12
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  ret <3 x float> %2
}

; Function Attrs: mustprogress nounwind willreturn
define <2 x float> @probe_p08m_iq_23() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #11
  %2 = tail call fast <2 x float> @air.get_candidate_triangle_barycentric_coord_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #12
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  ret <2 x float> %2
}

; Function Attrs: mustprogress nounwind willreturn
define float @probe_p08m_iq_24() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #11
  %2 = tail call fast float @air.get_candidate_triangle_distance_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #12
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  ret float %2
}

; Function Attrs: mustprogress nounwind willreturn
define i32 @probe_p08m_iq_25() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #11
  %2 = tail call i32 @air.get_candidate_user_instance_id_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #12
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  ret i32 %2
}

; Function Attrs: mustprogress nounwind willreturn
define %"struct.metal::matrix" @probe_p08m_iq_26() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #11
  %2 = tail call { <3 x float>, <3 x float>, <3 x float>, <3 x float> } @air.get_candidate_world_to_object_transform_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #12
  %3 = extractvalue { <3 x float>, <3 x float>, <3 x float>, <3 x float> } %2, 0
  %4 = extractvalue { <3 x float>, <3 x float>, <3 x float>, <3 x float> } %2, 1
  %5 = extractvalue { <3 x float>, <3 x float>, <3 x float>, <3 x float> } %2, 2
  %6 = extractvalue { <3 x float>, <3 x float>, <3 x float>, <3 x float> } %2, 3
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  %7 = insertvalue %"struct.metal::matrix" poison, <3 x float> %3, 0, 0
  %8 = insertvalue %"struct.metal::matrix" %7, <3 x float> %4, 0, 1
  %9 = insertvalue %"struct.metal::matrix" %8, <3 x float> %5, 0, 2
  %10 = insertvalue %"struct.metal::matrix" %9, <3 x float> %6, 0, 3
  ret %"struct.metal::matrix" %10
}

; Function Attrs: mustprogress nounwind willreturn
define float @probe_p08m_iq_27() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data.curve_data() #11
  %2 = tail call fast float @air.get_committed_curve_parameter_intersection_query.instancing.triangle_data.curve_data(%struct._intersection_query_t* nocapture readonly %1) #12
  tail call void @air.deallocate_intersection_query.instancing.triangle_data.curve_data(%struct._intersection_query_t* %1) #11
  ret float %2
}

; Function Attrs: mustprogress nounwind willreturn
define float @probe_p08m_iq_28() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #11
  %2 = tail call fast float @air.get_committed_distance_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #12
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  ret float %2
}

; Function Attrs: mustprogress nounwind willreturn
define i32 @probe_p08m_iq_29() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #11
  %2 = tail call i32 @air.get_committed_geometry_id_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #12
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  ret i32 %2
}

; Function Attrs: mustprogress nounwind willreturn
define i32 @probe_p08m_iq_31() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #11
  %2 = tail call i32 @air.get_committed_instance_id_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #12
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  ret i32 %2
}

; Function Attrs: mustprogress nounwind willreturn
define i32 @probe_p08m_iq_32() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #11
  %2 = tail call i32 @air.get_committed_intersection_type_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #12
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  ret i32 %2
}

; Function Attrs: mustprogress nounwind willreturn
define %"struct.metal::matrix" @probe_p08m_iq_33() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #11
  %2 = tail call { <3 x float>, <3 x float>, <3 x float>, <3 x float> } @air.get_committed_object_to_world_transform_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #12
  %3 = extractvalue { <3 x float>, <3 x float>, <3 x float>, <3 x float> } %2, 0
  %4 = extractvalue { <3 x float>, <3 x float>, <3 x float>, <3 x float> } %2, 1
  %5 = extractvalue { <3 x float>, <3 x float>, <3 x float>, <3 x float> } %2, 2
  %6 = extractvalue { <3 x float>, <3 x float>, <3 x float>, <3 x float> } %2, 3
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  %7 = insertvalue %"struct.metal::matrix" poison, <3 x float> %3, 0, 0
  %8 = insertvalue %"struct.metal::matrix" %7, <3 x float> %4, 0, 1
  %9 = insertvalue %"struct.metal::matrix" %8, <3 x float> %5, 0, 2
  %10 = insertvalue %"struct.metal::matrix" %9, <3 x float> %6, 0, 3
  ret %"struct.metal::matrix" %10
}

; Function Attrs: mustprogress nounwind willreturn
define i32 @probe_p08m_iq_34() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #11
  %2 = tail call i32 @air.get_committed_primitive_id_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #12
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  ret i32 %2
}

; Function Attrs: mustprogress nounwind willreturn
define <3 x float> @probe_p08m_iq_35() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #11
  %2 = tail call fast <3 x float> @air.get_committed_ray_direction_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #12
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  ret <3 x float> %2
}

; Function Attrs: mustprogress nounwind willreturn
define <3 x float> @probe_p08m_iq_36() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #11
  %2 = tail call fast <3 x float> @air.get_committed_ray_origin_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #12
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  ret <3 x float> %2
}

; Function Attrs: mustprogress nounwind willreturn
define <2 x float> @probe_p08m_iq_37() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #11
  %2 = tail call fast <2 x float> @air.get_committed_triangle_barycentric_coord_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #12
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  ret <2 x float> %2
}

; Function Attrs: mustprogress nounwind willreturn
define i32 @probe_p08m_iq_38() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #11
  %2 = tail call i32 @air.get_committed_user_instance_id_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #12
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  ret i32 %2
}

; Function Attrs: mustprogress nounwind willreturn
define %"struct.metal::matrix" @probe_p08m_iq_39() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #11
  %2 = tail call { <3 x float>, <3 x float>, <3 x float>, <3 x float> } @air.get_committed_world_to_object_transform_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #12
  %3 = extractvalue { <3 x float>, <3 x float>, <3 x float>, <3 x float> } %2, 0
  %4 = extractvalue { <3 x float>, <3 x float>, <3 x float>, <3 x float> } %2, 1
  %5 = extractvalue { <3 x float>, <3 x float>, <3 x float>, <3 x float> } %2, 2
  %6 = extractvalue { <3 x float>, <3 x float>, <3 x float>, <3 x float> } %2, 3
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  %7 = insertvalue %"struct.metal::matrix" poison, <3 x float> %3, 0, 0
  %8 = insertvalue %"struct.metal::matrix" %7, <3 x float> %4, 0, 1
  %9 = insertvalue %"struct.metal::matrix" %8, <3 x float> %5, 0, 2
  %10 = insertvalue %"struct.metal::matrix" %9, <3 x float> %6, 0, 3
  ret %"struct.metal::matrix" %10
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define float @probe_p08m_irr_40() local_unnamed_addr #3 {
  ret float 0.000000e+00
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define float @probe_p08m_irr_41() local_unnamed_addr #3 {
  ret float 0.000000e+00
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p08m_irr_42() local_unnamed_addr #3 {
  ret i32 0
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define i32 @probe_p08m_as_43() local_unnamed_addr #4 {
  %1 = tail call %struct._instance_acceleration_structure_t addrspace(1)* @air.get_null_instance_acceleration_structure() #13
  %2 = tail call i32 @air.get_instance_count_instance_acceleration_structure(%struct._instance_acceleration_structure_t addrspace(1)* nocapture readonly %1) #12
  ret i32 %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p08m_irr_44() local_unnamed_addr #3 {
  ret i32 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p08m_irr_45() local_unnamed_addr #3 {
  ret i32 0
}

; Function Attrs: mustprogress nounwind willreturn
define %"struct.metal::raytracing::_intersection_params" @probe_p08m_iq_46() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #11
  %2 = tail call { i32, i32, i32, i32, i32, i32, i32, i32, i32, i1, i1 } @air.get_intersection_params_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #12
  %3 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i1, i1 } %2, 0
  %4 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i1, i1 } %2, 1
  %5 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i1, i1 } %2, 2
  %6 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i1, i1 } %2, 3
  %7 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i1, i1 } %2, 4
  %8 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i1, i1 } %2, 5
  %9 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i1, i1 } %2, 6
  %10 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i1, i1 } %2, 7
  %11 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i1, i1 } %2, 8
  %12 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i1, i1 } %2, 9
  %13 = zext i1 %12 to i8
  %14 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i1, i1 } %2, 10
  %15 = zext i1 %14 to i8
  %16 = insertvalue %"struct.metal::raytracing::_intersection_params" poison, i32 %3, 0
  %17 = insertvalue %"struct.metal::raytracing::_intersection_params" %16, i32 %4, 1
  %18 = insertvalue %"struct.metal::raytracing::_intersection_params" %17, i32 %5, 2
  %19 = insertvalue %"struct.metal::raytracing::_intersection_params" %18, i32 %6, 3
  %20 = insertvalue %"struct.metal::raytracing::_intersection_params" %19, i32 %7, 4
  %21 = insertvalue %"struct.metal::raytracing::_intersection_params" %20, i32 %8, 5
  %22 = insertvalue %"struct.metal::raytracing::_intersection_params" %21, i32 %9, 6
  %23 = insertvalue %"struct.metal::raytracing::_intersection_params" %22, i32 %10, 7
  %24 = insertvalue %"struct.metal::raytracing::_intersection_params" %23, i32 %11, 8
  %25 = insertvalue %"struct.metal::raytracing::_intersection_params" %24, i8 %13, 9
  %26 = insertvalue %"struct.metal::raytracing::_intersection_params" %25, i8 %15, 10
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  ret %"struct.metal::raytracing::_intersection_params" %26
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p08m_as_47() local_unnamed_addr #4 {
  %1 = tail call %struct._instance_acceleration_structure_t addrspace(1)* @air.get_null_instance_acceleration_structure() #13
  %2 = tail call i1 @air.is_null_instance_acceleration_structure(%struct._instance_acceleration_structure_t addrspace(1)* nocapture readonly %1) #12
  ret i1 %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define %"struct.metal::matrix" @probe_p08m_irr_48() local_unnamed_addr #3 {
  ret %"struct.metal::matrix" zeroinitializer
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p08m_irr_49() local_unnamed_addr #3 {
  ret i32 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define <3 x float> @probe_p08m_irr_50() local_unnamed_addr #3 {
  ret <3 x float> zeroinitializer
}

; Function Attrs: mustprogress nounwind willreturn
define float @probe_p08m_iq_51() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #11
  %2 = tail call fast float @air.get_ray_min_distance_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #12
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  ret float %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define float @probe_p08m_irr_52() local_unnamed_addr #3 {
  ret float 0.000000e+00
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define <3 x float> @probe_p08m_irr_53() local_unnamed_addr #3 {
  ret <3 x float> zeroinitializer
}

; Function Attrs: mustprogress nounwind willreturn
define i32 @probe_p08m_ir_54() local_unnamed_addr #0 {
  %1 = tail call %struct._instance_acceleration_structure_t addrspace(1)* @air.get_null_instance_acceleration_structure() #13
  %2 = tail call %struct._intersection_function_table_t addrspace(1)* @air.get_null_intersection_function_table() #13
  %3 = tail call { i32, float, i32, i32, i8 addrspace(1)*, i32, i32, <2 x float>, i1 } @air.intersect.instancing.triangle_data(<3 x float> zeroinitializer, <3 x float> zeroinitializer, float 0.000000e+00, float 0x7FF0000000000000, %struct._instance_acceleration_structure_t addrspace(1)* readonly %1, i32 -1, %struct._intersection_function_table_t addrspace(1)* readonly %2, i8* null, i64 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 3, i32 -1, i32 -1, i32 0, i1 false, i1 false) #11
  ret i32 undef
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define <2 x float> @probe_p08m_irr_55() local_unnamed_addr #3 {
  ret <2 x float> zeroinitializer
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p08m_irr_56() local_unnamed_addr #3 {
  ret i32 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p08m_irr_57() local_unnamed_addr #3 {
  ret i32 0
}

; Function Attrs: mustprogress nounwind willreturn
define <3 x float> @probe_p08m_iq_58() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #11
  %2 = tail call fast <3 x float> @air.get_world_space_ray_direction_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #12
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  ret <3 x float> %2
}

; Function Attrs: mustprogress nounwind willreturn
define <3 x float> @probe_p08m_iq_59() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #11
  %2 = tail call fast <3 x float> @air.get_world_space_ray_origin_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #12
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  ret <3 x float> %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define %"struct.metal::matrix" @probe_p08m_irr_60() local_unnamed_addr #3 {
  ret %"struct.metal::matrix" zeroinitializer
}

; Function Attrs: mustprogress nounwind willreturn
define zeroext i1 @probe_p08m_iq_61() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #11
  %2 = tail call i1 @air.is_candidate_non_opaque_bounding_box_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #12
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  ret i1 %2
}

; Function Attrs: mustprogress nounwind willreturn
define zeroext i1 @probe_p08m_iq_62() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #11
  %2 = tail call i1 @air.is_candidate_triangle_front_facing_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #12
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  ret i1 %2
}

; Function Attrs: mustprogress nounwind willreturn
define zeroext i1 @probe_p08m_iq_63() local_unnamed_addr #0 {
  %1 = tail call %struct._intersection_query_t* @air.allocate_intersection_query.instancing.triangle_data() #11
  %2 = tail call i1 @air.is_committed_triangle_front_facing_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly %1) #12
  tail call void @air.deallocate_intersection_query.instancing.triangle_data(%struct._intersection_query_t* %1) #11
  ret i1 %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define zeroext i1 @probe_p08m_irr_64() local_unnamed_addr #3 {
  ret i1 false
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_cc_65() local_unnamed_addr #2 {
  tail call void @air.reset_compute_command(%struct._command_buffer_t addrspace(1)* nocapture undef, i32 0) #11
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_rc_66() local_unnamed_addr #2 {
  tail call void @air.reset_render_command(%struct._command_buffer_t addrspace(1)* nocapture undef, i32 0) #11
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_cc_67() local_unnamed_addr #2 {
  tail call void @air.set_barrier_compute_command(%struct._command_buffer_t addrspace(1)* nocapture undef, i32 0) #11
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_rc_68() local_unnamed_addr #2 {
  tail call void @air.set_barrier_render_command(%struct._command_buffer_t addrspace(1)* nocapture undef, i32 0) #11
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_rc_69() local_unnamed_addr #2 {
  tail call void @air.set_cull_mode_render_command(%struct._command_buffer_t addrspace(1)* nocapture undef, i32 0, i32 2) #11
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_rc_70() local_unnamed_addr #2 {
  tail call void @air.set_depth_bias_render_command(%struct._command_buffer_t addrspace(1)* nocapture undef, i32 0, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00) #11
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_rc_71() local_unnamed_addr #2 {
  tail call void @air.set_depth_clip_mode_render_command(%struct._command_buffer_t addrspace(1)* nocapture undef, i32 0, i32 0) #11
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_rc_72(%struct._depth_stencil_state_t addrspace(1)* %0) local_unnamed_addr #2 {
  tail call void @air.set_depth_stencil_state_render_command(%struct._command_buffer_t addrspace(1)* nocapture undef, i32 0, %struct._depth_stencil_state_t addrspace(1)* readonly %0) #11
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_cc_74() local_unnamed_addr #5 {
  tail call void @air.set_imageblock_size_compute_command(%struct._command_buffer_t addrspace(1)* nocapture undef, i32 0, <2 x i16> zeroinitializer) #11
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_rc_75() local_unnamed_addr #2 {
  tail call void @air.set_object_threadgroup_memory_length_render_command(%struct._command_buffer_t addrspace(1)* nocapture undef, i32 0, i32 0, i32 0) #11
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_cc_76() local_unnamed_addr #0 {
  tail call void @air.set_stage_in_region_compute_command(%struct._command_buffer_t addrspace(1)* nocapture undef, i32 0, <3 x i32> zeroinitializer, <3 x i32> zeroinitializer) #11
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_cc_77() local_unnamed_addr #2 {
  tail call void @air.set_threadgroup_memory_length_compute_command(%struct._command_buffer_t addrspace(1)* nocapture undef, i32 0, i32 0, i32 0) #11
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p08m_rc_78() local_unnamed_addr #2 {
  tail call void @air.set_triangle_fill_mode_render_command(%struct._command_buffer_t addrspace(1)* nocapture undef, i32 0, i32 0) #11
  ret void
}

; Function Attrs: convergent mustprogress nounwind willreturn
define zeroext i1 @probe_p08m_vote_79() local_unnamed_addr #6 {
  %1 = tail call i1 @air.simd_vote_all.i64(i64 0) #14
  ret i1 %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define zeroext i1 @probe_p08m_vote_80() local_unnamed_addr #6 {
  %1 = tail call i1 @air.simd_vote_any.i64(i64 0) #14
  ret i1 %1
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define %"struct.metal::compute_pipeline_state" @probe_p08m_type_81(%struct._compute_pipeline_state_t addrspace(1)* %0) local_unnamed_addr #7 {
  %2 = insertvalue %"struct.metal::compute_pipeline_state" poison, %struct._compute_pipeline_state_t addrspace(1)* %0, 0
  ret %"struct.metal::compute_pipeline_state" %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define %"struct.metal::depth_stencil_state" @probe_p08m_type_82(%struct._depth_stencil_state_t addrspace(1)* %0) local_unnamed_addr #7 {
  %2 = insertvalue %"struct.metal::depth_stencil_state" poison, %struct._depth_stencil_state_t addrspace(1)* %0, 0
  ret %"struct.metal::depth_stencil_state" %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define %"struct.metal::raytracing::intersection_function_table" @probe_p08m_type_83(%struct._intersection_function_table_t addrspace(1)* %0) local_unnamed_addr #7 {
  %2 = insertvalue %"struct.metal::raytracing::intersection_function_table" poison, %struct._intersection_function_table_t addrspace(1)* %0, 0
  ret %"struct.metal::raytracing::intersection_function_table" %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define %"struct.metal::render_pipeline_state" @probe_p08m_type_84(%struct._render_pipeline_state_t addrspace(1)* %0) local_unnamed_addr #7 {
  %2 = insertvalue %"struct.metal::render_pipeline_state" poison, %struct._render_pipeline_state_t addrspace(1)* %0, 0
  ret %"struct.metal::render_pipeline_state" %2
}

; Function Attrs: mustprogress nounwind willreturn
declare void @air.clear_barrier_compute_command(%struct._command_buffer_t addrspace(1)* nocapture, i32) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare void @air.clear_barrier_render_command(%struct._command_buffer_t addrspace(1)* nocapture, i32) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare void @air.concurrent_dispatch_threadgroups_compute_command(%struct._command_buffer_t addrspace(1)* nocapture, i32, <3 x i32>, <3 x i32>) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare void @air.concurrent_dispatch_threads_compute_command(%struct._command_buffer_t addrspace(1)* nocapture, i32, <3 x i32>, <3 x i32>) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare void @air.copy_compute_command(%struct._command_buffer_t addrspace(1)* nocapture, i32, %struct._command_buffer_t addrspace(1)* nocapture readonly, i32) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare void @air.copy_render_command(%struct._command_buffer_t addrspace(1)* nocapture, i32, %struct._command_buffer_t addrspace(1)* nocapture readonly, i32) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare void @air.draw_mesh_threadgroups_render_command(%struct._command_buffer_t addrspace(1)* nocapture, i32, <3 x i32>, <3 x i32>, <3 x i32>) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare void @air.draw_mesh_threads_render_command(%struct._command_buffer_t addrspace(1)* nocapture, i32, <3 x i32>, <3 x i32>, <3 x i32>) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare void @air.draw_primitives_render_command(%struct._command_buffer_t addrspace(1)* nocapture, i32, i32, i32, i32, i32, i32) local_unnamed_addr #1

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i1 @air.is_null_instance_acceleration_structure(%struct._instance_acceleration_structure_t addrspace(1)* nocapture readonly) local_unnamed_addr #8

; Function Attrs: mustprogress nounwind willreturn
declare void @air.reset_compute_command(%struct._command_buffer_t addrspace(1)* nocapture, i32) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare void @air.reset_render_command(%struct._command_buffer_t addrspace(1)* nocapture, i32) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare void @air.set_barrier_compute_command(%struct._command_buffer_t addrspace(1)* nocapture, i32) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare void @air.set_barrier_render_command(%struct._command_buffer_t addrspace(1)* nocapture, i32) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare void @air.set_cull_mode_render_command(%struct._command_buffer_t addrspace(1)* nocapture, i32, i32) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare void @air.set_depth_bias_render_command(%struct._command_buffer_t addrspace(1)* nocapture, i32, float, float, float) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare void @air.set_depth_clip_mode_render_command(%struct._command_buffer_t addrspace(1)* nocapture, i32, i32) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare void @air.set_depth_stencil_state_render_command(%struct._command_buffer_t addrspace(1)* nocapture, i32, %struct._depth_stencil_state_t addrspace(1)* readonly) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare void @air.set_imageblock_size_compute_command(%struct._command_buffer_t addrspace(1)* nocapture, i32, <2 x i16>) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare void @air.set_object_threadgroup_memory_length_render_command(%struct._command_buffer_t addrspace(1)* nocapture, i32, i32, i32) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare void @air.set_stage_in_region_compute_command(%struct._command_buffer_t addrspace(1)* nocapture, i32, <3 x i32>, <3 x i32>) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare void @air.set_threadgroup_memory_length_compute_command(%struct._command_buffer_t addrspace(1)* nocapture, i32, i32, i32) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare void @air.set_triangle_fill_mode_render_command(%struct._command_buffer_t addrspace(1)* nocapture, i32, i32) local_unnamed_addr #1

; Function Attrs: convergent mustprogress nounwind willreturn
declare i1 @air.simd_vote_all.i64(i64) local_unnamed_addr #9

; Function Attrs: convergent mustprogress nounwind willreturn
declare i1 @air.simd_vote_any.i64(i64) local_unnamed_addr #9

; Function Attrs: mustprogress nounwind willreturn
declare void @air.abort_intersection_query.instancing.triangle_data(%struct._intersection_query_t*) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare void @air.commit_bounding_box_intersection_intersection_query.instancing.triangle_data(%struct._intersection_query_t*, float) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare void @air.commit_curve_intersection_intersection_query.instancing.triangle_data.curve_data(%struct._intersection_query_t*) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
declare void @air.commit_triangle_intersection_intersection_query.instancing.triangle_data(%struct._intersection_query_t*) local_unnamed_addr #1

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare float @air.get_candidate_curve_distance_intersection_query.instancing.triangle_data.curve_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #8

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare float @air.get_candidate_curve_parameter_intersection_query.instancing.triangle_data.curve_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #8

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_candidate_geometry_id_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #8

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_candidate_instance_id_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #8

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_candidate_intersection_type_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #8

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare { <3 x float>, <3 x float>, <3 x float>, <3 x float> } @air.get_candidate_object_to_world_transform_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #8

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_candidate_primitive_id_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #8

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare <3 x float> @air.get_candidate_ray_direction_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #8

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare <3 x float> @air.get_candidate_ray_origin_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #8

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare <2 x float> @air.get_candidate_triangle_barycentric_coord_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #8

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare float @air.get_candidate_triangle_distance_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #8

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_candidate_user_instance_id_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #8

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare { <3 x float>, <3 x float>, <3 x float>, <3 x float> } @air.get_candidate_world_to_object_transform_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #8

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare float @air.get_committed_curve_parameter_intersection_query.instancing.triangle_data.curve_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #8

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare float @air.get_committed_distance_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #8

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_committed_geometry_id_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #8

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_committed_instance_id_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #8

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_committed_intersection_type_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #8

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare { <3 x float>, <3 x float>, <3 x float>, <3 x float> } @air.get_committed_object_to_world_transform_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #8

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_committed_primitive_id_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #8

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare <3 x float> @air.get_committed_ray_direction_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #8

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare <3 x float> @air.get_committed_ray_origin_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #8

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare <2 x float> @air.get_committed_triangle_barycentric_coord_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #8

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_committed_user_instance_id_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #8

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare { <3 x float>, <3 x float>, <3 x float>, <3 x float> } @air.get_committed_world_to_object_transform_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #8

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind readonly willreturn
declare %struct._instance_acceleration_structure_t addrspace(1)* @air.get_null_instance_acceleration_structure() local_unnamed_addr #10

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_instance_count_instance_acceleration_structure(%struct._instance_acceleration_structure_t addrspace(1)* nocapture readonly) local_unnamed_addr #8

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare { i32, i32, i32, i32, i32, i32, i32, i32, i32, i1, i1 } @air.get_intersection_params_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #8

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare float @air.get_ray_min_distance_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #8

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind readonly willreturn
declare %struct._intersection_function_table_t addrspace(1)* @air.get_null_intersection_function_table() local_unnamed_addr #10

; Function Attrs: mustprogress nounwind willreturn
declare { i32, float, i32, i32, i8 addrspace(1)*, i32, i32, <2 x float>, i1 } @air.intersect.instancing.triangle_data(<3 x float>, <3 x float>, float, float, %struct._instance_acceleration_structure_t addrspace(1)* readonly, i32, %struct._intersection_function_table_t addrspace(1)* readonly, i8*, i64, i32, i32, i32, i32, i32, i32, i32, i32, i32, i1, i1) local_unnamed_addr #1

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare <3 x float> @air.get_world_space_ray_direction_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #8

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare <3 x float> @air.get_world_space_ray_origin_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #8

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i1 @air.is_candidate_non_opaque_bounding_box_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #8

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i1 @air.is_candidate_triangle_front_facing_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #8

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i1 @air.is_committed_triangle_front_facing_intersection_query.instancing.triangle_data(%struct._intersection_query_t* nocapture readonly) local_unnamed_addr #8

attributes #0 = { mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="96" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #1 = { mustprogress nounwind willreturn }
attributes #2 = { mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #3 = { mustprogress nofree norecurse nosync nounwind readnone willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="96" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #4 = { mustprogress nofree nounwind readonly willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #5 = { mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="32" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #6 = { convergent mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #7 = { mustprogress nofree norecurse nosync nounwind readnone willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #8 = { argmemonly mustprogress nofree nounwind readonly willreturn }
attributes #9 = { convergent mustprogress nounwind willreturn }
attributes #10 = { inaccessiblememonly mustprogress nofree nounwind readonly willreturn }
attributes #11 = { nounwind willreturn }
attributes #12 = { argmemonly nounwind readonly willreturn }
attributes #13 = { inaccessiblememonly nounwind readonly willreturn }
attributes #14 = { convergent nounwind willreturn }

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
!15 = !{!"/Users/runner/metal_probe/p4/P08M/probe.metal"}
