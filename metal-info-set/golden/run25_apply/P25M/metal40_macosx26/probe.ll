; ModuleID = 'probe.metal'
source_filename = "probe.metal"
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-n8:16:32"
target triple = "air64_v28-apple-macosx26.0.0"

%"struct.metal::_imageblock_base" = type { %struct._imageblock_t addrspace(4)* }
%struct._imageblock_t = type opaque
%struct._texture_1d_t = type opaque
%struct._texture_1d_array_t = type opaque
%struct._texture_2d_t = type opaque
%struct._texture_2d_array_t = type opaque
%struct._texture_3d_t = type opaque
%struct._texture_cube_t = type opaque
%struct._texture_cube_array_t = type opaque
%struct._texture_2d_ms_t = type opaque
%struct._texture_2d_ms_array_t = type opaque
%struct._texture_buffer_1d_t = type opaque
%struct._depth_2d_t = type opaque
%struct._depth_2d_ms_t = type opaque
%struct._depth_2d_array_t = type opaque
%struct._depth_2d_ms_array_t = type opaque
%struct._depth_cube_t = type opaque
%struct._depth_cube_array_t = type opaque
%struct._visible_function_table_t = type opaque
%"struct.metal::function_handle" = type { %struct._function_handle_t addrspace(1)* }
%struct._function_handle_t = type opaque
%"struct.metal::raytracing::_acceleration_structure" = type { %struct._primitive_acceleration_structure_t addrspace(1)* }
%struct._primitive_acceleration_structure_t = type opaque
%struct._intersection_function_table_t = type opaque
%struct.PL25 = type { <2 x float>, i32 }
%struct._intersection_result_t = type opaque
%struct._instance_acceleration_structure_t = type opaque
%struct._sampler_t = type opaque

@__air_sampler_state = internal addrspace(2) constant [2 x i64] [i64 34901797601020489, i64 0], align 8
@_Z6__fc25.MTL_FC_INIT_0_b = linkonce_odr hidden addrspace(2) externally_initialized constant i8 undef, section "air.fc_initializer", align 1
@llvm.global_ctors = appending global [0 x { i32, void ()*, i8* }] zeroinitializer

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p25m_islice1d(%"struct.metal::_imageblock_base" %0, %struct._texture_1d_t addrspace(1)* %1, <2 x i16> noundef %2) local_unnamed_addr #0 {
  %4 = tail call i8 addrspace(4)* @air.implicit_imageblock_data(i32 0, <2 x i16> zeroinitializer, i32 0, i16 0) #16
  tail call void @air.write_imageblock_slice_to_texture_1d.i16.v4f32(%struct._texture_1d_t addrspace(1)* nocapture %1, i8 addrspace(4)* nocapture %4, i1 false, <2 x i16> zeroinitializer, <2 x i16> undef, i16 0, i16 0, i1 true, i32 2) #17
  ret void
}

; Function Attrs: argmemonly mustprogress nocallback nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: argmemonly mustprogress nocallback nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p25m_islice1da(%"struct.metal::_imageblock_base" %0, %struct._texture_1d_array_t addrspace(1)* %1, <2 x i16> noundef %2) local_unnamed_addr #0 {
  %4 = tail call i8 addrspace(4)* @air.implicit_imageblock_data(i32 0, <2 x i16> zeroinitializer, i32 0, i16 0) #16
  tail call void @air.write_imageblock_slice_to_texture_1d_array.i16.v4f32(%struct._texture_1d_array_t addrspace(1)* nocapture %1, i8 addrspace(4)* nocapture %4, i1 false, <2 x i16> zeroinitializer, <2 x i16> undef, i16 0, i16 0, i16 0, i1 true, i32 2) #17
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p25m_islice2d(%"struct.metal::_imageblock_base" %0, %struct._texture_2d_t addrspace(1)* %1, <2 x i16> noundef %2) local_unnamed_addr #0 {
  %4 = tail call i8 addrspace(4)* @air.implicit_imageblock_data(i32 0, <2 x i16> zeroinitializer, i32 0, i16 0) #16
  tail call void @air.write_imageblock_slice_to_texture_2d.i16.v4f32(%struct._texture_2d_t addrspace(1)* nocapture %1, i8 addrspace(4)* nocapture %4, i1 false, <2 x i16> zeroinitializer, <2 x i16> undef, <2 x i16> %2, i16 0, i1 true, i32 2) #17
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p25m_islice2da(%"struct.metal::_imageblock_base" %0, %struct._texture_2d_array_t addrspace(1)* %1, <2 x i16> noundef %2) local_unnamed_addr #0 {
  %4 = tail call i8 addrspace(4)* @air.implicit_imageblock_data(i32 0, <2 x i16> zeroinitializer, i32 0, i16 0) #16
  tail call void @air.write_imageblock_slice_to_texture_2d_array.i16.v4f32(%struct._texture_2d_array_t addrspace(1)* nocapture %1, i8 addrspace(4)* nocapture %4, i1 false, <2 x i16> zeroinitializer, <2 x i16> undef, <2 x i16> %2, i16 0, i16 0, i1 true, i32 2) #17
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p25m_islice3d(%"struct.metal::_imageblock_base" %0, %struct._texture_3d_t addrspace(1)* %1, <2 x i16> noundef %2) local_unnamed_addr #2 {
  %4 = tail call i8 addrspace(4)* @air.implicit_imageblock_data(i32 0, <2 x i16> zeroinitializer, i32 0, i16 0) #16
  %5 = shufflevector <2 x i16> %2, <2 x i16> poison, <3 x i32> <i32 0, i32 1, i32 undef>
  %6 = insertelement <3 x i16> %5, i16 0, i64 2
  tail call void @air.write_imageblock_slice_to_texture_3d.i16.v4f32(%struct._texture_3d_t addrspace(1)* nocapture %1, i8 addrspace(4)* nocapture %4, i1 false, <2 x i16> zeroinitializer, <2 x i16> undef, <3 x i16> %6, i16 0, i1 true, i32 2) #17
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p25m_islicecube(%"struct.metal::_imageblock_base" %0, %struct._texture_cube_t addrspace(1)* %1, <2 x i16> noundef %2) local_unnamed_addr #0 {
  %4 = tail call i8 addrspace(4)* @air.implicit_imageblock_data(i32 0, <2 x i16> zeroinitializer, i32 0, i16 0) #16
  tail call void @air.write_imageblock_slice_to_texture_cube.i16.v4f32(%struct._texture_cube_t addrspace(1)* nocapture %1, i8 addrspace(4)* nocapture %4, i1 false, <2 x i16> zeroinitializer, <2 x i16> undef, <2 x i16> %2, i16 0, i16 0, i1 true, i32 2) #17
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p25m_islicecubearr(%"struct.metal::_imageblock_base" %0, %struct._texture_cube_array_t addrspace(1)* %1, <2 x i16> noundef %2) local_unnamed_addr #0 {
  %4 = tail call i8 addrspace(4)* @air.implicit_imageblock_data(i32 0, <2 x i16> zeroinitializer, i32 0, i16 0) #16
  tail call void @air.write_imageblock_slice_to_texture_cube_array.i16.v4f32(%struct._texture_cube_array_t addrspace(1)* nocapture %1, i8 addrspace(4)* nocapture %4, i1 false, <2 x i16> zeroinitializer, <2 x i16> undef, <2 x i16> %2, i16 0, i16 0, i16 0, i1 true, i32 2) #17
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p25m_imw(%"struct.metal::_imageblock_base" %0, <4 x float> addrspace(1)* nocapture noundef readonly "air-buffer-no-alias" %1, <2 x i16> noundef %2) local_unnamed_addr #3 {
  %4 = tail call i16 @air.get_color_coverage_mask(<2 x i16> %2, i16 0) #18
  %5 = load <4 x float>, <4 x float> addrspace(1)* %1, align 16, !tbaa !54, !alias.scope !57
  %6 = getelementptr inbounds <4 x float>, <4 x float> addrspace(1)* %1, i64 1
  %7 = load <4 x float>, <4 x float> addrspace(1)* %6, align 16, !tbaa !54, !alias.scope !57
  tail call void @air.store.implicit_imageblock.mask.v4f32(<4 x float> %5, i32 0, <2 x i16> %2, i16 %4) #19
  tail call void @air.store.implicit_imageblock.mask.v4f32(<4 x float> %7, i32 1, <2 x i16> %2, i16 %4) #19
  ret void
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define zeroext i16 @probe_p25m_nt1d() local_unnamed_addr #4 {
  %1 = tail call %struct._texture_1d_t addrspace(1)* @air.get_null_texture_1d() #20
  %2 = tail call i32 @air.get_width_texture_1d(%struct._texture_1d_t addrspace(1)* nocapture readonly %1, i32 0) #21
  %3 = trunc i32 %2 to i16
  ret i16 %3
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define zeroext i16 @probe_p25m_nt1da() local_unnamed_addr #4 {
  %1 = tail call %struct._texture_1d_array_t addrspace(1)* @air.get_null_texture_1d_array() #20
  %2 = tail call i32 @air.get_width_texture_1d_array(%struct._texture_1d_array_t addrspace(1)* nocapture readonly %1, i32 0) #21
  %3 = trunc i32 %2 to i16
  ret i16 %3
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define zeroext i16 @probe_p25m_nt2d() local_unnamed_addr #4 {
  %1 = tail call %struct._texture_2d_t addrspace(1)* @air.get_null_texture_2d() #20
  %2 = tail call i32 @air.get_width_texture_2d(%struct._texture_2d_t addrspace(1)* nocapture readonly %1, i32 0) #21
  %3 = trunc i32 %2 to i16
  ret i16 %3
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define zeroext i16 @probe_p25m_nt2da() local_unnamed_addr #4 {
  %1 = tail call %struct._texture_2d_array_t addrspace(1)* @air.get_null_texture_2d_array() #20
  %2 = tail call i32 @air.get_width_texture_2d_array(%struct._texture_2d_array_t addrspace(1)* nocapture readonly %1, i32 0) #21
  %3 = trunc i32 %2 to i16
  ret i16 %3
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define zeroext i16 @probe_p25m_nt2ms() local_unnamed_addr #4 {
  %1 = tail call %struct._texture_2d_ms_t addrspace(1)* @air.get_null_texture_2d_ms() #20
  %2 = tail call i32 @air.get_width_texture_2d_ms(%struct._texture_2d_ms_t addrspace(1)* nocapture readonly %1) #21
  %3 = trunc i32 %2 to i16
  ret i16 %3
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define zeroext i16 @probe_p25m_nt2msa() local_unnamed_addr #4 {
  %1 = tail call %struct._texture_2d_ms_array_t addrspace(1)* @air.get_null_texture_2d_ms_array() #20
  %2 = tail call i32 @air.get_width_texture_2d_ms_array(%struct._texture_2d_ms_array_t addrspace(1)* nocapture readonly %1) #21
  %3 = trunc i32 %2 to i16
  ret i16 %3
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define zeroext i16 @probe_p25m_nt3d() local_unnamed_addr #4 {
  %1 = tail call %struct._texture_3d_t addrspace(1)* @air.get_null_texture_3d() #20
  %2 = tail call i32 @air.get_width_texture_3d(%struct._texture_3d_t addrspace(1)* nocapture readonly %1, i32 0) #21
  %3 = trunc i32 %2 to i16
  ret i16 %3
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define i32 @probe_p25m_ntbuf1d() local_unnamed_addr #4 {
  %1 = tail call %struct._texture_buffer_1d_t addrspace(1)* @air.get_null_texture_buffer_1d() #20
  %2 = tail call i32 @air.get_width_texture_buffer_1d(%struct._texture_buffer_1d_t addrspace(1)* nocapture readonly %1) #21
  ret i32 %2
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define zeroext i16 @probe_p25m_ntcube() local_unnamed_addr #4 {
  %1 = tail call %struct._texture_cube_t addrspace(1)* @air.get_null_texture_cube() #20
  %2 = tail call i32 @air.get_width_texture_cube(%struct._texture_cube_t addrspace(1)* nocapture readonly %1, i32 0) #21
  %3 = trunc i32 %2 to i16
  ret i16 %3
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define zeroext i16 @probe_p25m_ntcubearr() local_unnamed_addr #4 {
  %1 = tail call %struct._texture_cube_array_t addrspace(1)* @air.get_null_texture_cube_array() #20
  %2 = tail call i32 @air.get_width_texture_cube_array(%struct._texture_cube_array_t addrspace(1)* nocapture readonly %1, i32 0) #21
  %3 = trunc i32 %2 to i16
  ret i16 %3
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define zeroext i16 @probe_p25m_nd2d() local_unnamed_addr #4 {
  %1 = tail call %struct._depth_2d_t addrspace(1)* @air.get_null_depth_2d() #20
  %2 = tail call i32 @air.get_width_depth_2d(%struct._depth_2d_t addrspace(1)* nocapture readonly %1, i32 0) #21
  %3 = trunc i32 %2 to i16
  ret i16 %3
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define zeroext i16 @probe_p25m_nd2ms() local_unnamed_addr #4 {
  %1 = tail call %struct._depth_2d_ms_t addrspace(1)* @air.get_null_depth_2d_ms() #20
  %2 = tail call i32 @air.get_width_depth_2d_ms(%struct._depth_2d_ms_t addrspace(1)* nocapture readonly %1) #21
  %3 = trunc i32 %2 to i16
  ret i16 %3
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define zeroext i16 @probe_p25m_nd2da() local_unnamed_addr #4 {
  %1 = tail call %struct._depth_2d_array_t addrspace(1)* @air.get_null_depth_2d_array() #20
  %2 = tail call i32 @air.get_width_depth_2d_array(%struct._depth_2d_array_t addrspace(1)* nocapture readonly %1, i32 0) #21
  %3 = trunc i32 %2 to i16
  ret i16 %3
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define zeroext i16 @probe_p25m_nd2msa() local_unnamed_addr #4 {
  %1 = tail call %struct._depth_2d_ms_array_t addrspace(1)* @air.get_null_depth_2d_ms_array() #20
  %2 = tail call i32 @air.get_width_depth_2d_ms_array(%struct._depth_2d_ms_array_t addrspace(1)* nocapture readonly %1) #21
  %3 = trunc i32 %2 to i16
  ret i16 %3
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define zeroext i16 @probe_p25m_ndcube() local_unnamed_addr #4 {
  %1 = tail call %struct._depth_cube_t addrspace(1)* @air.get_null_depth_cube() #20
  %2 = tail call i32 @air.get_width_depth_cube(%struct._depth_cube_t addrspace(1)* nocapture readonly %1, i32 0) #21
  %3 = trunc i32 %2 to i16
  ret i16 %3
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define zeroext i16 @probe_p25m_ndcubearr() local_unnamed_addr #4 {
  %1 = tail call %struct._depth_cube_array_t addrspace(1)* @air.get_null_depth_cube_array() #20
  %2 = tail call i32 @air.get_width_depth_cube_array(%struct._depth_cube_array_t addrspace(1)* nocapture readonly %1, i32 0) #21
  %3 = trunc i32 %2 to i16
  ret i16 %3
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define i32 @probe_p25m_nullvft() local_unnamed_addr #4 {
  %1 = tail call %struct._visible_function_table_t addrspace(1)* @air.get_null_visible_function_table() #20
  %2 = tail call i32 @air.get_size_visible_function_table(%struct._visible_function_table_t addrspace(1)* nocapture readonly %1) #21
  ret i32 %2
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define %"struct.metal::function_handle" @probe_p25m_nullfh() local_unnamed_addr #4 {
  %1 = tail call %struct._function_handle_t addrspace(1)* @air.get_null_function_handle() #20
  %2 = insertvalue %"struct.metal::function_handle" poison, %struct._function_handle_t addrspace(1)* %1, 0
  ret %"struct.metal::function_handle" %2
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define %"struct.metal::raytracing::_acceleration_structure" @probe_p25m_nullpas() local_unnamed_addr #4 {
  %1 = tail call %struct._primitive_acceleration_structure_t addrspace(1)* @air.get_null_primitive_acceleration_structure() #20
  %2 = insertvalue %"struct.metal::raytracing::_acceleration_structure" poison, %struct._primitive_acceleration_structure_t addrspace(1)* %1, 0
  ret %"struct.metal::raytracing::_acceleration_structure" %2
}

; Function Attrs: mustprogress nounwind willreturn
define zeroext i1 @probe_p25m_itpl(%struct._primitive_acceleration_structure_t addrspace(1)* %0, %struct._intersection_function_table_t addrspace(1)* %1) local_unnamed_addr #5 {
  %3 = alloca %struct.PL25, align 8
  %4 = bitcast %struct.PL25* %3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %4) #22
  %5 = call { i32, float, i32, i32, i8 addrspace(1)*, <2 x float>, i1 } @air.intersect.triangle_data(<3 x float> zeroinitializer, <3 x float> zeroinitializer, float 0.000000e+00, float 0x7FF0000000000000, %struct._primitive_acceleration_structure_t addrspace(1)* readonly %0, %struct._intersection_function_table_t addrspace(1)* readonly %1, i8* nonnull align 8 %4, i64 16, i32 0, i32 0, i32 0, i32 0, i32 0, i32 3, i32 -1, i32 -1, i32 0, i1 false) #23
  %6 = getelementptr inbounds %struct.PL25, %struct.PL25* %3, i64 0, i32 1
  %7 = load i32, i32* %6, align 8, !tbaa !60
  %8 = icmp eq i32 %7, 42
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %4) #22
  ret i1 %8
}

; Function Attrs: mustprogress nounwind willreturn
define i32 @probe_p25m_itplcb(%struct._primitive_acceleration_structure_t addrspace(1)* %0, %struct._intersection_function_table_t addrspace(1)* %1) local_unnamed_addr #5 {
  %3 = alloca %struct.PL25, align 8
  %4 = bitcast %struct.PL25* %3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %4) #22
  %5 = call { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } @air.intersect_direct_access.triangle_data(<3 x float> zeroinitializer, <3 x float> zeroinitializer, float 0.000000e+00, float 0x7FF0000000000000, %struct._primitive_acceleration_structure_t addrspace(1)* readonly %0, %struct._intersection_function_table_t addrspace(1)* readonly %1, i8* nonnull align 8 %4, i64 16, i32 0, i32 0, i32 0, i32 0, i32 0, i32 3, i32 -1, i32 -1, i32 0, i1 false) #23
  %6 = extractvalue { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } %5, 0
  %7 = extractvalue { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } %5, 1
  %8 = getelementptr inbounds i8, i8 addrspace(5)* %7, i64 8
  %9 = bitcast i8 addrspace(5)* %8 to i32 addrspace(5)*
  %10 = load i32, i32 addrspace(5)* %9, align 8, !tbaa !60
  call void @air.release_intersection_result.triangle_data(%struct._intersection_result_t addrspace(9)* %6) #23
  call void @air.release_intersect_payload.triangle_data(i8 addrspace(5)* %7, i64 16) #23
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %4) #22
  ret i32 %10
}

; Function Attrs: mustprogress nounwind willreturn
define zeroext i1 @probe_p25m_rtype(%struct._primitive_acceleration_structure_t addrspace(1)* %0, %struct._intersection_function_table_t addrspace(1)* nocapture readnone %1) local_unnamed_addr #5 {
  %3 = tail call %struct._intersection_function_table_t addrspace(1)* @air.get_null_intersection_function_table() #20
  %4 = tail call { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } @air.intersect_direct_access.triangle_data(<3 x float> zeroinitializer, <3 x float> zeroinitializer, float 0.000000e+00, float 0x7FF0000000000000, %struct._primitive_acceleration_structure_t addrspace(1)* readonly %0, %struct._intersection_function_table_t addrspace(1)* readonly %3, i8* null, i64 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 3, i32 -1, i32 -1, i32 0, i1 false) #23
  %5 = extractvalue { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } %4, 0
  %6 = tail call i32 @air.get_type_intersection_result.triangle_data(%struct._intersection_result_t addrspace(9)* %5) #16
  %7 = icmp eq i32 %6, 1
  tail call void @air.release_intersection_result.triangle_data(%struct._intersection_result_t addrspace(9)* %5) #23
  ret i1 %7
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p25m_ridias(%struct._instance_acceleration_structure_t addrspace(1)* %0) local_unnamed_addr #4 {
  %2 = tail call i64 @air.get_resource_id_instance_acceleration_structure(%struct._instance_acceleration_structure_t addrspace(1)* readonly %0) #21
  %3 = icmp eq i64 %2, 0
  ret i1 %3
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p25m_ridpas(%struct._primitive_acceleration_structure_t addrspace(1)* %0) local_unnamed_addr #4 {
  %2 = tail call i64 @air.get_resource_id_primitive_acceleration_structure(%struct._primitive_acceleration_structure_t addrspace(1)* readonly %0) #21
  %3 = icmp eq i64 %2, 0
  ret i1 %3
}

; Function Attrs: argmemonly convergent mustprogress nofree nounwind willreturn
define void @probe_p25m_gsampler(%struct._texture_2d_t addrspace(1)* nocapture readonly %0, <4 x float> addrspace(1)* nocapture noundef writeonly "air-buffer-no-alias" %1) local_unnamed_addr #6 {
  %3 = tail call { <4 x float>, i8 } @air.sample_texture_2d.v4f32(%struct._texture_2d_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly bitcast ([2 x i64] addrspace(2)* @__air_sampler_state to %struct._sampler_t addrspace(2)*), <2 x float> <float 2.500000e-01, float 5.000000e-01>, i1 true, <2 x i32> zeroinitializer, i1 false, float 0.000000e+00, float 0.000000e+00, i32 0) #24
  %4 = extractvalue { <4 x float>, i8 } %3, 0
  store <4 x float> %4, <4 x float> addrspace(1)* %1, align 16, !tbaa !54, !alias.scope !63, !noalias !66
  ret void
}

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn writeonly
define void @probe_p25m_ifcd(i32 addrspace(1)* nocapture noundef writeonly "air-buffer-no-alias" %0) local_unnamed_addr #7 {
  %2 = tail call i1 @air.is_function_constant_defined(i8 addrspace(2)* nocapture @_Z6__fc25.MTL_FC_INIT_0_b) #18
  %3 = zext i1 %2 to i32
  store i32 %3, i32 addrspace(1)* %0, align 4, !tbaa !68, !alias.scope !69
  ret void
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare i1 @air.is_function_constant_defined(i8 addrspace(2)* nocapture) local_unnamed_addr #8

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare i16 @air.get_color_coverage_mask(<2 x i16>, i16) local_unnamed_addr #8

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind readonly willreturn
declare %struct._function_handle_t addrspace(1)* @air.get_null_function_handle() local_unnamed_addr #9

; Function Attrs: mustprogress nofree nounwind readonly willreturn
declare i8 addrspace(4)* @air.implicit_imageblock_data(i32, <2 x i16>, i32, i16) local_unnamed_addr #10

; Function Attrs: argmemonly mustprogress nounwind willreturn
declare void @air.write_imageblock_slice_to_texture_1d.i16.v4f32(%struct._texture_1d_t addrspace(1)* nocapture, i8 addrspace(4)* nocapture, i1, <2 x i16>, <2 x i16>, i16, i16, i1, i32) local_unnamed_addr #11

; Function Attrs: argmemonly mustprogress nounwind willreturn
declare void @air.write_imageblock_slice_to_texture_1d_array.i16.v4f32(%struct._texture_1d_array_t addrspace(1)* nocapture, i8 addrspace(4)* nocapture, i1, <2 x i16>, <2 x i16>, i16, i16, i16, i1, i32) local_unnamed_addr #11

; Function Attrs: argmemonly mustprogress nounwind willreturn
declare void @air.write_imageblock_slice_to_texture_2d.i16.v4f32(%struct._texture_2d_t addrspace(1)* nocapture, i8 addrspace(4)* nocapture, i1, <2 x i16>, <2 x i16>, <2 x i16>, i16, i1, i32) local_unnamed_addr #11

; Function Attrs: argmemonly mustprogress nounwind willreturn
declare void @air.write_imageblock_slice_to_texture_2d_array.i16.v4f32(%struct._texture_2d_array_t addrspace(1)* nocapture, i8 addrspace(4)* nocapture, i1, <2 x i16>, <2 x i16>, <2 x i16>, i16, i16, i1, i32) local_unnamed_addr #11

; Function Attrs: argmemonly mustprogress nounwind willreturn
declare void @air.write_imageblock_slice_to_texture_3d.i16.v4f32(%struct._texture_3d_t addrspace(1)* nocapture, i8 addrspace(4)* nocapture, i1, <2 x i16>, <2 x i16>, <3 x i16>, i16, i1, i32) local_unnamed_addr #11

; Function Attrs: argmemonly mustprogress nounwind willreturn
declare void @air.write_imageblock_slice_to_texture_cube.i16.v4f32(%struct._texture_cube_t addrspace(1)* nocapture, i8 addrspace(4)* nocapture, i1, <2 x i16>, <2 x i16>, <2 x i16>, i16, i16, i1, i32) local_unnamed_addr #11

; Function Attrs: argmemonly mustprogress nounwind willreturn
declare void @air.write_imageblock_slice_to_texture_cube_array.i16.v4f32(%struct._texture_cube_array_t addrspace(1)* nocapture, i8 addrspace(4)* nocapture, i1, <2 x i16>, <2 x i16>, <2 x i16>, i16, i16, i16, i1, i32) local_unnamed_addr #11

; Function Attrs: mustprogress nounwind willreturn writeonly
declare void @air.store.implicit_imageblock.mask.v4f32(<4 x float>, i32, <2 x i16>, i16) local_unnamed_addr #12

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind readonly willreturn
declare %struct._texture_1d_t addrspace(1)* @air.get_null_texture_1d() local_unnamed_addr #9

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_width_texture_1d(%struct._texture_1d_t addrspace(1)* nocapture readonly, i32) local_unnamed_addr #13

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind readonly willreturn
declare %struct._texture_1d_array_t addrspace(1)* @air.get_null_texture_1d_array() local_unnamed_addr #9

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_width_texture_1d_array(%struct._texture_1d_array_t addrspace(1)* nocapture readonly, i32) local_unnamed_addr #13

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind readonly willreturn
declare %struct._texture_2d_t addrspace(1)* @air.get_null_texture_2d() local_unnamed_addr #9

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_width_texture_2d(%struct._texture_2d_t addrspace(1)* nocapture readonly, i32) local_unnamed_addr #13

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind readonly willreturn
declare %struct._texture_2d_array_t addrspace(1)* @air.get_null_texture_2d_array() local_unnamed_addr #9

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_width_texture_2d_array(%struct._texture_2d_array_t addrspace(1)* nocapture readonly, i32) local_unnamed_addr #13

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind readonly willreturn
declare %struct._texture_2d_ms_t addrspace(1)* @air.get_null_texture_2d_ms() local_unnamed_addr #9

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_width_texture_2d_ms(%struct._texture_2d_ms_t addrspace(1)* nocapture readonly) local_unnamed_addr #13

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind readonly willreturn
declare %struct._texture_2d_ms_array_t addrspace(1)* @air.get_null_texture_2d_ms_array() local_unnamed_addr #9

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_width_texture_2d_ms_array(%struct._texture_2d_ms_array_t addrspace(1)* nocapture readonly) local_unnamed_addr #13

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind readonly willreturn
declare %struct._texture_3d_t addrspace(1)* @air.get_null_texture_3d() local_unnamed_addr #9

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_width_texture_3d(%struct._texture_3d_t addrspace(1)* nocapture readonly, i32) local_unnamed_addr #13

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind readonly willreturn
declare %struct._texture_buffer_1d_t addrspace(1)* @air.get_null_texture_buffer_1d() local_unnamed_addr #9

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_width_texture_buffer_1d(%struct._texture_buffer_1d_t addrspace(1)* nocapture readonly) local_unnamed_addr #13

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind readonly willreturn
declare %struct._texture_cube_t addrspace(1)* @air.get_null_texture_cube() local_unnamed_addr #9

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_width_texture_cube(%struct._texture_cube_t addrspace(1)* nocapture readonly, i32) local_unnamed_addr #13

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind readonly willreturn
declare %struct._texture_cube_array_t addrspace(1)* @air.get_null_texture_cube_array() local_unnamed_addr #9

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_width_texture_cube_array(%struct._texture_cube_array_t addrspace(1)* nocapture readonly, i32) local_unnamed_addr #13

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind readonly willreturn
declare %struct._depth_2d_t addrspace(1)* @air.get_null_depth_2d() local_unnamed_addr #9

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_width_depth_2d(%struct._depth_2d_t addrspace(1)* nocapture readonly, i32) local_unnamed_addr #13

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind readonly willreturn
declare %struct._depth_2d_ms_t addrspace(1)* @air.get_null_depth_2d_ms() local_unnamed_addr #9

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_width_depth_2d_ms(%struct._depth_2d_ms_t addrspace(1)* nocapture readonly) local_unnamed_addr #13

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind readonly willreturn
declare %struct._depth_2d_array_t addrspace(1)* @air.get_null_depth_2d_array() local_unnamed_addr #9

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_width_depth_2d_array(%struct._depth_2d_array_t addrspace(1)* nocapture readonly, i32) local_unnamed_addr #13

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind readonly willreturn
declare %struct._depth_2d_ms_array_t addrspace(1)* @air.get_null_depth_2d_ms_array() local_unnamed_addr #9

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_width_depth_2d_ms_array(%struct._depth_2d_ms_array_t addrspace(1)* nocapture readonly) local_unnamed_addr #13

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind readonly willreturn
declare %struct._depth_cube_t addrspace(1)* @air.get_null_depth_cube() local_unnamed_addr #9

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_width_depth_cube(%struct._depth_cube_t addrspace(1)* nocapture readonly, i32) local_unnamed_addr #13

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind readonly willreturn
declare %struct._depth_cube_array_t addrspace(1)* @air.get_null_depth_cube_array() local_unnamed_addr #9

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_width_depth_cube_array(%struct._depth_cube_array_t addrspace(1)* nocapture readonly, i32) local_unnamed_addr #13

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind readonly willreturn
declare %struct._visible_function_table_t addrspace(1)* @air.get_null_visible_function_table() local_unnamed_addr #9

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_size_visible_function_table(%struct._visible_function_table_t addrspace(1)* nocapture readonly) local_unnamed_addr #13

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind readonly willreturn
declare %struct._primitive_acceleration_structure_t addrspace(1)* @air.get_null_primitive_acceleration_structure() local_unnamed_addr #9

; Function Attrs: mustprogress nounwind willreturn
declare { i32, float, i32, i32, i8 addrspace(1)*, <2 x float>, i1 } @air.intersect.triangle_data(<3 x float>, <3 x float>, float, float, %struct._primitive_acceleration_structure_t addrspace(1)* readonly, %struct._intersection_function_table_t addrspace(1)* readonly, i8*, i64, i32, i32, i32, i32, i32, i32, i32, i32, i32, i1) local_unnamed_addr #14

; Function Attrs: mustprogress nounwind willreturn
declare { %struct._intersection_result_t addrspace(9)*, i8 addrspace(5)* } @air.intersect_direct_access.triangle_data(<3 x float>, <3 x float>, float, float, %struct._primitive_acceleration_structure_t addrspace(1)* readonly, %struct._intersection_function_table_t addrspace(1)* readonly, i8*, i64, i32, i32, i32, i32, i32, i32, i32, i32, i32, i1) local_unnamed_addr #14

; Function Attrs: mustprogress nounwind willreturn
declare void @air.release_intersection_result.triangle_data(%struct._intersection_result_t addrspace(9)*) local_unnamed_addr #14

; Function Attrs: mustprogress nounwind willreturn
declare void @air.release_intersect_payload.triangle_data(i8 addrspace(5)*, i64) local_unnamed_addr #14

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind readonly willreturn
declare %struct._intersection_function_table_t addrspace(1)* @air.get_null_intersection_function_table() local_unnamed_addr #9

; Function Attrs: mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_type_intersection_result.triangle_data(%struct._intersection_result_t addrspace(9)*) local_unnamed_addr #10

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i64 @air.get_resource_id_instance_acceleration_structure(%struct._instance_acceleration_structure_t addrspace(1)* readonly) local_unnamed_addr #13

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i64 @air.get_resource_id_primitive_acceleration_structure(%struct._primitive_acceleration_structure_t addrspace(1)* readonly) local_unnamed_addr #13

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
declare { <4 x float>, i8 } @air.sample_texture_2d.v4f32(%struct._texture_2d_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, <2 x float>, i1, <2 x i32>, i1, float, float, i32) local_unnamed_addr #15

attributes #0 = { mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="32" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #1 = { argmemonly mustprogress nocallback nofree nosync nounwind willreturn }
attributes #2 = { mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="48" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #3 = { mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="128" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #4 = { mustprogress nofree nounwind readonly willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #5 = { mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="96" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #6 = { argmemonly convergent mustprogress nofree nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="128" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #7 = { argmemonly mustprogress nofree nosync nounwind willreturn writeonly "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #8 = { mustprogress nofree nosync nounwind readnone willreturn }
attributes #9 = { inaccessiblememonly mustprogress nofree nounwind readonly willreturn }
attributes #10 = { mustprogress nofree nounwind readonly willreturn }
attributes #11 = { argmemonly mustprogress nounwind willreturn }
attributes #12 = { mustprogress nounwind willreturn writeonly }
attributes #13 = { argmemonly mustprogress nofree nounwind readonly willreturn }
attributes #14 = { mustprogress nounwind willreturn }
attributes #15 = { argmemonly convergent mustprogress nofree nounwind readonly willreturn }
attributes #16 = { nounwind readonly willreturn }
attributes #17 = { argmemonly nounwind willreturn }
attributes #18 = { nounwind readnone willreturn }
attributes #19 = { nounwind willreturn writeonly }
attributes #20 = { inaccessiblememonly nounwind readonly willreturn }
attributes #21 = { argmemonly nounwind readonly willreturn }
attributes #22 = { nounwind }
attributes #23 = { nounwind willreturn }
attributes #24 = { argmemonly convergent nounwind readonly willreturn }

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5, !6, !7, !8}
!air.kernel = !{!9, !16, !19, !23, !26, !29, !32, !35, !38, !42}
!air.compile_options = !{!45, !46, !47}
!air.function_constants = !{!48}
!air.sampler_states = !{!49}
!llvm.ident = !{!50}
!air.version = !{!51}
!air.language_version = !{!52}
!air.source_file_name = !{!53}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 26, i32 5]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"frame-pointer", i32 2}
!3 = !{i32 7, !"air.max_device_buffers", i32 31}
!4 = !{i32 7, !"air.max_constant_buffers", i32 31}
!5 = !{i32 7, !"air.max_threadgroup_buffers", i32 31}
!6 = !{i32 7, !"air.max_textures", i32 128}
!7 = !{i32 7, !"air.max_read_write_textures", i32 8}
!8 = !{i32 7, !"air.max_samplers", i32 16}
!9 = !{void (%"struct.metal::_imageblock_base", %struct._texture_1d_t addrspace(1)*, <2 x i16>)* @probe_p25m_islice1d, !10, !11}
!10 = !{}
!11 = !{!12, !14, !15}
!12 = !{i32 0, !"air.imageblock", !"implicit", !"air.struct_type_info", !13, !"air.arg_type_align_size", i32 16, !"air.arg_type_name", !"imageblock<IB25C, layout_implicit>", !"air.arg_name", !"__ib"}
!13 = !{i32 0, i32 16, i32 0, !"float4", !"a", !"air.render_target", i32 0, i32 16, i32 16, i32 0, !"float4", !"b", !"air.render_target", i32 1}
!14 = !{i32 1, !"air.texture", !"air.location_index", i32 0, i32 1, !"air.write", !"air.arg_type_name", !"texture1d<float, write>", !"air.arg_name", !"__t"}
!15 = !{i32 2, !"air.thread_position_in_threadgroup", !"air.arg_type_name", !"ushort2", !"air.arg_name", !"__lid", !"air.arg_unused"}
!16 = !{void (%"struct.metal::_imageblock_base", %struct._texture_1d_array_t addrspace(1)*, <2 x i16>)* @probe_p25m_islice1da, !10, !17}
!17 = !{!12, !18, !15}
!18 = !{i32 1, !"air.texture", !"air.location_index", i32 0, i32 1, !"air.write", !"air.arg_type_name", !"texture1d_array<float, write>", !"air.arg_name", !"__t"}
!19 = !{void (%"struct.metal::_imageblock_base", %struct._texture_2d_t addrspace(1)*, <2 x i16>)* @probe_p25m_islice2d, !10, !20}
!20 = !{!12, !21, !22}
!21 = !{i32 1, !"air.texture", !"air.location_index", i32 0, i32 1, !"air.write", !"air.arg_type_name", !"texture2d<float, write>", !"air.arg_name", !"__t"}
!22 = !{i32 2, !"air.thread_position_in_threadgroup", !"air.arg_type_name", !"ushort2", !"air.arg_name", !"__lid"}
!23 = !{void (%"struct.metal::_imageblock_base", %struct._texture_2d_array_t addrspace(1)*, <2 x i16>)* @probe_p25m_islice2da, !10, !24}
!24 = !{!12, !25, !22}
!25 = !{i32 1, !"air.texture", !"air.location_index", i32 0, i32 1, !"air.write", !"air.arg_type_name", !"texture2d_array<float, write>", !"air.arg_name", !"__t"}
!26 = !{void (%"struct.metal::_imageblock_base", %struct._texture_3d_t addrspace(1)*, <2 x i16>)* @probe_p25m_islice3d, !10, !27}
!27 = !{!12, !28, !22}
!28 = !{i32 1, !"air.texture", !"air.location_index", i32 0, i32 1, !"air.write", !"air.arg_type_name", !"texture3d<float, write>", !"air.arg_name", !"__t"}
!29 = !{void (%"struct.metal::_imageblock_base", %struct._texture_cube_t addrspace(1)*, <2 x i16>)* @probe_p25m_islicecube, !10, !30}
!30 = !{!12, !31, !22}
!31 = !{i32 1, !"air.texture", !"air.location_index", i32 0, i32 1, !"air.write", !"air.arg_type_name", !"texturecube<float, write>", !"air.arg_name", !"__t"}
!32 = !{void (%"struct.metal::_imageblock_base", %struct._texture_cube_array_t addrspace(1)*, <2 x i16>)* @probe_p25m_islicecubearr, !10, !33}
!33 = !{!12, !34, !22}
!34 = !{i32 1, !"air.texture", !"air.location_index", i32 0, i32 1, !"air.write", !"air.arg_type_name", !"texturecube_array<float, write>", !"air.arg_name", !"__t"}
!35 = !{void (%"struct.metal::_imageblock_base", <4 x float> addrspace(1)*, <2 x i16>)* @probe_p25m_imw, !10, !36}
!36 = !{!12, !37, !22}
!37 = !{i32 1, !"air.buffer", !"air.location_index", i32 0, i32 1, !"air.read_write", !"air.address_space", i32 1, !"air.arg_type_size", i32 16, !"air.arg_type_align_size", i32 16, !"air.arg_type_name", !"float4", !"air.arg_name", !"__in"}
!38 = !{void (%struct._texture_2d_t addrspace(1)*, <4 x float> addrspace(1)*)* @probe_p25m_gsampler, !10, !39}
!39 = !{!40, !41}
!40 = !{i32 0, !"air.texture", !"air.location_index", i32 0, i32 1, !"air.sample", !"air.arg_type_name", !"texture2d<float, sample>", !"air.arg_name", !"__t"}
!41 = !{i32 1, !"air.buffer", !"air.location_index", i32 0, i32 1, !"air.read_write", !"air.address_space", i32 1, !"air.arg_type_size", i32 16, !"air.arg_type_align_size", i32 16, !"air.arg_type_name", !"float4", !"air.arg_name", !"__out"}
!42 = !{void (i32 addrspace(1)*)* @probe_p25m_ifcd, !10, !43}
!43 = !{!44}
!44 = !{i32 0, !"air.buffer", !"air.location_index", i32 0, i32 1, !"air.read_write", !"air.address_space", i32 1, !"air.arg_type_size", i32 4, !"air.arg_type_align_size", i32 4, !"air.arg_type_name", !"uint", !"air.arg_name", !"__out"}
!45 = !{!"air.compile.denorms_disable"}
!46 = !{!"air.compile.fast_math_enable"}
!47 = !{!"air.compile.framebuffer_fetch_enable"}
!48 = !{i8 addrspace(2)* @_Z6__fc25.MTL_FC_INIT_0_b, !"bool", !"__fc25", i32 0}
!49 = !{!"air.sampler_state", [2 x i64] addrspace(2)* @__air_sampler_state}
!50 = !{!"Apple metal version 32023.883 (metalfe-32023.883)"}
!51 = !{i32 2, i32 8, i32 0}
!52 = !{!"Metal", i32 4, i32 0, i32 0}
!53 = !{!"/Users/runner/metal_probe/p25/P25M/probe.metal"}
!54 = !{!55, !55, i64 0}
!55 = !{!"omnipotent char", !56, i64 0}
!56 = !{!"Simple C++ TBAA"}
!57 = !{!58}
!58 = distinct !{!58, !59, !"air-alias-scope-arg(1)"}
!59 = distinct !{!59, !"air-alias-scopes(probe_p25m_imw)"}
!60 = !{!61, !62, i64 8}
!61 = !{!"_ZTS4PL25", !55, i64 0, !62, i64 8}
!62 = !{!"int", !55, i64 0}
!63 = !{!64}
!64 = distinct !{!64, !65, !"air-alias-scope-arg(1)"}
!65 = distinct !{!65, !"air-alias-scopes(probe_p25m_gsampler)"}
!66 = !{!67}
!67 = distinct !{!67, !65, !"air-alias-scope-textures"}
!68 = !{!62, !62, i64 0}
!69 = !{!70}
!70 = distinct !{!70, !71, !"air-alias-scope-arg(0)"}
!71 = distinct !{!71, !"air-alias-scopes(probe_p25m_ifcd)"}
