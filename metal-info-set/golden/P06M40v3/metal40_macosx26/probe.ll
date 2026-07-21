; ModuleID = 'probe.metal'
source_filename = "probe.metal"
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-n8:16:32"
target triple = "air64_v28-apple-macosx26.0.0"

%struct._texture_1d_array_t = type opaque
%struct._texture_1d_t = type opaque
%struct._texture_2d_array_t = type opaque
%struct._texture_2d_t = type opaque
%struct._texture_3d_t = type opaque
%struct._texture_buffer_1d_t = type opaque
%struct._texture_cube_array_t = type opaque
%struct._texture_cube_t = type opaque
%struct._sampler_t = type opaque
%"struct.metal::sparse_color" = type <{ <4 x float>, i64, [8 x i8] }>
%struct._depth_2d_t = type opaque
%struct._depth_2d_array_t = type opaque
%"struct.metal::sparse_color.91" = type { float, i8, i64 }
%struct._depth_2d_ms_array_t = type opaque
%struct._depth_cube_array_t = type opaque
%struct._depth_cube_t = type opaque

; Function Attrs: mustprogress nounwind willreturn
define zeroext i1 @probe_p06m_atomic_compare_exchange_weak_0(%struct._texture_1d_array_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  %2 = alloca <4 x i32>, align 16
  %3 = bitcast <4 x i32>* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %3) #13
  store <4 x i32> zeroinitializer, <4 x i32>* %2, align 16, !tbaa !16
  %4 = call i1 @air.atomic_compare_exchange_weak_explicit_texture_1d_array.u.v4i32(%struct._texture_1d_array_t addrspace(1)* nocapture %0, i32 0, i32 0, <4 x i32>* nonnull %2, <4 x i32> zeroinitializer, i32 0, i32 0, i32 3) #14
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %3) #13
  ret i1 %4
}

; Function Attrs: argmemonly mustprogress nocallback nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: argmemonly mustprogress nocallback nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: mustprogress nounwind willreturn
define zeroext i1 @probe_p06m_atomic_compare_exchange_weak_1(%struct._texture_1d_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  %2 = alloca <4 x i32>, align 16
  %3 = bitcast <4 x i32>* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %3) #13
  store <4 x i32> zeroinitializer, <4 x i32>* %2, align 16, !tbaa !16
  %4 = call i1 @air.atomic_compare_exchange_weak_explicit_texture_1d.u.v4i32(%struct._texture_1d_t addrspace(1)* nocapture %0, i32 0, <4 x i32>* nonnull %2, <4 x i32> zeroinitializer, i32 0, i32 0, i32 3) #14
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %3) #13
  ret i1 %4
}

; Function Attrs: mustprogress nounwind willreturn
define zeroext i1 @probe_p06m_atomic_compare_exchange_weak_2(%struct._texture_2d_array_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  %2 = alloca <4 x i32>, align 16
  %3 = bitcast <4 x i32>* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %3) #13
  store <4 x i32> zeroinitializer, <4 x i32>* %2, align 16, !tbaa !16
  %4 = call i1 @air.atomic_compare_exchange_weak_explicit_texture_2d_array.u.v4i32(%struct._texture_2d_array_t addrspace(1)* nocapture %0, <2 x i32> zeroinitializer, i32 0, <2 x i32> zeroinitializer, <4 x i32>* nonnull %2, <4 x i32> zeroinitializer, i32 0, i32 0, i32 3) #14
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %3) #13
  ret i1 %4
}

; Function Attrs: mustprogress nounwind willreturn
define zeroext i1 @probe_p06m_atomic_compare_exchange_weak_3(%struct._texture_2d_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  %2 = alloca <4 x i32>, align 16
  %3 = bitcast <4 x i32>* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %3) #13
  store <4 x i32> zeroinitializer, <4 x i32>* %2, align 16, !tbaa !16
  %4 = call i1 @air.atomic_compare_exchange_weak_explicit_texture_2d.u.v4i32(%struct._texture_2d_t addrspace(1)* nocapture %0, <2 x i32> zeroinitializer, <2 x i32> zeroinitializer, <4 x i32>* nonnull %2, <4 x i32> zeroinitializer, i32 0, i32 0, i32 3) #14
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %3) #13
  ret i1 %4
}

; Function Attrs: mustprogress nounwind willreturn
define zeroext i1 @probe_p06m_atomic_compare_exchange_weak_4(%struct._texture_3d_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  %2 = alloca <4 x i32>, align 16
  %3 = bitcast <4 x i32>* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %3) #13
  store <4 x i32> zeroinitializer, <4 x i32>* %2, align 16, !tbaa !16
  %4 = call i1 @air.atomic_compare_exchange_weak_explicit_texture_3d.u.v4i32(%struct._texture_3d_t addrspace(1)* nocapture %0, <3 x i32> zeroinitializer, <3 x i32> zeroinitializer, <4 x i32>* nonnull %2, <4 x i32> zeroinitializer, i32 0, i32 0, i32 3) #14
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %3) #13
  ret i1 %4
}

; Function Attrs: mustprogress nounwind willreturn
define zeroext i1 @probe_p06m_atomic_compare_exchange_weak_5(%struct._texture_buffer_1d_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  %2 = alloca <4 x i32>, align 16
  %3 = bitcast <4 x i32>* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %3) #13
  store <4 x i32> zeroinitializer, <4 x i32>* %2, align 16, !tbaa !16
  %4 = call i1 @air.atomic_compare_exchange_weak_explicit_texture_buffer_1d.u.v4i32(%struct._texture_buffer_1d_t addrspace(1)* nocapture %0, i32 0, <4 x i32>* nonnull %2, <4 x i32> zeroinitializer, i32 0, i32 0, i32 3) #14
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %3) #13
  ret i1 %4
}

; Function Attrs: mustprogress nounwind willreturn
define zeroext i1 @probe_p06m_atomic_compare_exchange_weak_6(%struct._texture_cube_array_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  %2 = alloca <4 x i32>, align 16
  %3 = bitcast <4 x i32>* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %3) #13
  store <4 x i32> zeroinitializer, <4 x i32>* %2, align 16, !tbaa !16
  %4 = call i1 @air.atomic_compare_exchange_weak_explicit_texture_cube_array.u.v4i32(%struct._texture_cube_array_t addrspace(1)* nocapture %0, <2 x i32> zeroinitializer, i32 0, i32 0, <4 x i32>* nonnull %2, <4 x i32> zeroinitializer, i32 0, i32 0, i32 3) #14
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %3) #13
  ret i1 %4
}

; Function Attrs: mustprogress nounwind willreturn
define zeroext i1 @probe_p06m_atomic_compare_exchange_weak_7(%struct._texture_cube_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  %2 = alloca <4 x i32>, align 16
  %3 = bitcast <4 x i32>* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %3) #13
  store <4 x i32> zeroinitializer, <4 x i32>* %2, align 16, !tbaa !16
  %4 = call i1 @air.atomic_compare_exchange_weak_explicit_texture_cube.u.v4i32(%struct._texture_cube_t addrspace(1)* nocapture %0, <2 x i32> zeroinitializer, i32 0, <4 x i32>* nonnull %2, <4 x i32> zeroinitializer, i32 0, i32 0, i32 3) #14
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %3) #13
  ret i1 %4
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define <4 x float> @probe_p06m_gather_24(%struct._texture_2d_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #2 {
  %3 = tail call { <4 x float>, i8 } @air.gather_texture_2d_array.v4f32(%struct._texture_2d_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, <2 x float> <float 1.000000e+00, float 1.000000e+00>, i32 0, i1 true, <2 x i32> zeroinitializer, i32 0, i32 0) #15
  %4 = extractvalue { <4 x float>, i8 } %3, 0
  ret <4 x float> %4
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define <4 x float> @probe_p06m_gather_25(%struct._texture_2d_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #2 {
  %3 = tail call { <4 x float>, i8 } @air.gather_texture_2d.v4f32(%struct._texture_2d_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, <2 x float> <float 1.000000e+00, float 1.000000e+00>, i1 true, <2 x i32> zeroinitializer, i32 0, i32 0) #15
  %4 = extractvalue { <4 x float>, i8 } %3, 0
  ret <4 x float> %4
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define %"struct.metal::sparse_color" @probe_p06m_sparse_gather_26(%struct._texture_cube_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #2 {
  %3 = tail call { <4 x float>, i8 } @air.gather_texture_cube_array.v4f32(%struct._texture_cube_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, <3 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, i32 0, i32 0, i32 0) #15
  %4 = extractvalue { <4 x float>, i8 } %3, 1
  %5 = extractvalue { <4 x float>, i8 } %3, 0
  %6 = and i8 %4, 1
  %7 = xor i8 %6, 1
  %8 = zext i8 %7 to i64
  %9 = insertvalue %"struct.metal::sparse_color" poison, <4 x float> %5, 0
  %10 = insertvalue %"struct.metal::sparse_color" %9, i64 %8, 1
  ret %"struct.metal::sparse_color" %10
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define <4 x float> @probe_p06m_gather_27(%struct._texture_cube_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #2 {
  %3 = tail call { <4 x float>, i8 } @air.gather_texture_cube.v4f32(%struct._texture_cube_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, <3 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, i32 0, i32 0) #15
  %4 = extractvalue { <4 x float>, i8 } %3, 0
  ret <4 x float> %4
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define i32 @probe_p06m_get_width_30(%struct._depth_2d_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #3 {
  %2 = tail call i32 @air.get_width_depth_2d(%struct._depth_2d_t addrspace(1)* nocapture readonly %0, i32 0) #15
  ret i32 %2
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define float @probe_p06m_read_31(%struct._depth_2d_array_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #4 {
  %2 = tail call %struct._sampler_t addrspace(2)* @air.get_read_sampler() #16
  %3 = tail call { float, i8 } @air.read_depth_2d_array.f32(%struct._depth_2d_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* %2, i32 1, <2 x i32> zeroinitializer, i32 0, <2 x i32> zeroinitializer, i32 0, i32 0) #15
  %4 = extractvalue { float, i8 } %3, 0
  ret float %4
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define %"struct.metal::sparse_color.91" @probe_p06m_sparse_read_32(%struct._depth_2d_ms_array_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #4 {
  %2 = tail call %struct._sampler_t addrspace(2)* @air.get_read_sampler() #16
  %3 = tail call { float, i8 } @air.read_depth_2d_ms_array.f32(%struct._depth_2d_ms_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* %2, i32 1, <2 x i32> zeroinitializer, i32 0, i32 0, i32 1) #15
  %4 = extractvalue { float, i8 } %3, 1
  %5 = extractvalue { float, i8 } %3, 0
  %6 = and i8 %4, 1
  %7 = xor i8 %6, 1
  %8 = insertvalue %"struct.metal::sparse_color.91" poison, float %5, 0
  %9 = insertvalue %"struct.metal::sparse_color.91" %8, i8 %7, 1
  ret %"struct.metal::sparse_color.91" %9
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define float @probe_p06m_read_33(%struct._depth_2d_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #4 {
  %2 = tail call %struct._sampler_t addrspace(2)* @air.get_read_sampler() #16
  %3 = tail call { float, i8 } @air.read_depth_2d.f32(%struct._depth_2d_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* %2, i32 1, <2 x i32> zeroinitializer, <2 x i32> zeroinitializer, i32 0, i32 0) #15
  %4 = extractvalue { float, i8 } %3, 0
  ret float %4
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define %"struct.metal::sparse_color.91" @probe_p06m_sparse_read_34(%struct._depth_cube_array_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #4 {
  %2 = tail call %struct._sampler_t addrspace(2)* @air.get_read_sampler() #16
  %3 = tail call { float, i8 } @air.read_depth_cube_array.f32(%struct._depth_cube_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* %2, i32 1, <2 x i32> zeroinitializer, i32 0, i32 0, i32 0, i32 0) #15
  %4 = extractvalue { float, i8 } %3, 1
  %5 = extractvalue { float, i8 } %3, 0
  %6 = and i8 %4, 1
  %7 = xor i8 %6, 1
  %8 = insertvalue %"struct.metal::sparse_color.91" poison, float %5, 0
  %9 = insertvalue %"struct.metal::sparse_color.91" %8, i8 %7, 1
  ret %"struct.metal::sparse_color.91" %9
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define %"struct.metal::sparse_color.91" @probe_p06m_sparse_read_35(%struct._depth_cube_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #4 {
  %2 = tail call %struct._sampler_t addrspace(2)* @air.get_read_sampler() #16
  %3 = tail call { float, i8 } @air.read_depth_cube.f32(%struct._depth_cube_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* %2, i32 1, <2 x i32> zeroinitializer, i32 0, i32 0, i32 0) #15
  %4 = extractvalue { float, i8 } %3, 1
  %5 = extractvalue { float, i8 } %3, 0
  %6 = and i8 %4, 1
  %7 = xor i8 %6, 1
  %8 = insertvalue %"struct.metal::sparse_color.91" poison, float %5, 0
  %9 = insertvalue %"struct.metal::sparse_color.91" %8, i8 %7, 1
  ret %"struct.metal::sparse_color.91" %9
}

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
define float @probe_p06m_sample_compare_36(%struct._depth_2d_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #5 {
  %3 = tail call { float, i8 } @air.sample_compare_depth_2d_array.f32(%struct._depth_2d_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, i32 1, <2 x float> <float 1.000000e+00, float 1.000000e+00>, i32 0, float 1.000000e+00, i1 true, <2 x i32> zeroinitializer, i1 false, float 0.000000e+00, float 0.000000e+00, i32 0) #17
  %4 = extractvalue { float, i8 } %3, 0
  ret float %4
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define %"struct.metal::sparse_color.91" @probe_p06m_sparse_sample_compare_37(%struct._depth_2d_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #6 {
  %3 = tail call { float, i8 } @air.sample_compare_depth_2d_array_grad.f32(%struct._depth_2d_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, i32 1, <2 x float> <float 1.000000e+00, float 1.000000e+00>, i32 0, float 1.000000e+00, <2 x float> <float 5.000000e-01, float 5.000000e-01>, <2 x float> <float 5.000000e-01, float 5.000000e-01>, float 0.000000e+00, i1 true, <2 x i32> zeroinitializer, i32 0) #15
  %4 = extractvalue { float, i8 } %3, 1
  %5 = extractvalue { float, i8 } %3, 0
  %6 = and i8 %4, 1
  %7 = xor i8 %6, 1
  %8 = insertvalue %"struct.metal::sparse_color.91" poison, float %5, 0
  %9 = insertvalue %"struct.metal::sparse_color.91" %8, i8 %7, 1
  ret %"struct.metal::sparse_color.91" %9
}

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
define float @probe_p06m_sample_compare_38(%struct._depth_2d_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #5 {
  %3 = tail call { float, i8 } @air.sample_compare_depth_2d.f32(%struct._depth_2d_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, i32 1, <2 x float> <float 1.000000e+00, float 1.000000e+00>, float 1.000000e+00, i1 true, <2 x i32> zeroinitializer, i1 false, float 0.000000e+00, float 0.000000e+00, i32 0) #17
  %4 = extractvalue { float, i8 } %3, 0
  ret float %4
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define %"struct.metal::sparse_color.91" @probe_p06m_sparse_sample_compare_39(%struct._depth_2d_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #6 {
  %3 = tail call { float, i8 } @air.sample_compare_depth_2d_grad.f32(%struct._depth_2d_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, i32 1, <2 x float> <float 1.000000e+00, float 1.000000e+00>, float 1.000000e+00, <2 x float> <float 5.000000e-01, float 5.000000e-01>, <2 x float> <float 5.000000e-01, float 5.000000e-01>, float 1.000000e+00, i1 true, <2 x i32> zeroinitializer, i32 0) #15
  %4 = extractvalue { float, i8 } %3, 1
  %5 = extractvalue { float, i8 } %3, 0
  %6 = and i8 %4, 1
  %7 = xor i8 %6, 1
  %8 = insertvalue %"struct.metal::sparse_color.91" poison, float %5, 0
  %9 = insertvalue %"struct.metal::sparse_color.91" %8, i8 %7, 1
  ret %"struct.metal::sparse_color.91" %9
}

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
define %"struct.metal::sparse_color.91" @probe_p06m_sparse_sample_compare_40(%struct._depth_cube_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #7 {
  %3 = tail call { float, i8 } @air.sample_compare_depth_cube_array.f32(%struct._depth_cube_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, i32 1, <3 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, i32 0, float 1.000000e+00, i1 false, float 1.000000e+00, float 1.000000e+00, i32 0) #17
  %4 = extractvalue { float, i8 } %3, 1
  %5 = extractvalue { float, i8 } %3, 0
  %6 = and i8 %4, 1
  %7 = xor i8 %6, 1
  %8 = insertvalue %"struct.metal::sparse_color.91" poison, float %5, 0
  %9 = insertvalue %"struct.metal::sparse_color.91" %8, i8 %7, 1
  ret %"struct.metal::sparse_color.91" %9
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define %"struct.metal::sparse_color.91" @probe_p06m_sparse_sample_compare_41(%struct._depth_cube_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #8 {
  %3 = tail call { float, i8 } @air.sample_compare_depth_cube_array_grad.f32(%struct._depth_cube_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, i32 1, <3 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, i32 0, float 1.000000e+00, <3 x float> <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>, <3 x float> <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>, float 1.000000e+00, i32 0) #15
  %4 = extractvalue { float, i8 } %3, 1
  %5 = extractvalue { float, i8 } %3, 0
  %6 = and i8 %4, 1
  %7 = xor i8 %6, 1
  %8 = insertvalue %"struct.metal::sparse_color.91" poison, float %5, 0
  %9 = insertvalue %"struct.metal::sparse_color.91" %8, i8 %7, 1
  ret %"struct.metal::sparse_color.91" %9
}

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
define float @probe_p06m_sample_compare_42(%struct._depth_cube_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #7 {
  %3 = tail call { float, i8 } @air.sample_compare_depth_cube.f32(%struct._depth_cube_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, i32 1, <3 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, float 1.000000e+00, i1 false, float 0.000000e+00, float 0.000000e+00, i32 0) #17
  %4 = extractvalue { float, i8 } %3, 0
  ret float %4
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define %"struct.metal::sparse_color.91" @probe_p06m_sparse_sample_compare_43(%struct._depth_cube_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #8 {
  %3 = tail call { float, i8 } @air.sample_compare_depth_cube_grad.f32(%struct._depth_cube_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, i32 1, <3 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, float 1.000000e+00, <3 x float> <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>, <3 x float> <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>, float 1.000000e+00, i32 0) #15
  %4 = extractvalue { float, i8 } %3, 1
  %5 = extractvalue { float, i8 } %3, 0
  %6 = and i8 %4, 1
  %7 = xor i8 %6, 1
  %8 = insertvalue %"struct.metal::sparse_color.91" poison, float %5, 0
  %9 = insertvalue %"struct.metal::sparse_color.91" %8, i8 %7, 1
  ret %"struct.metal::sparse_color.91" %9
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define float @probe_p06m_sample_44(%struct._depth_2d_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #6 {
  %3 = tail call { float, i8 } @air.sample_depth_2d_grad.f32(%struct._depth_2d_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, i32 1, <2 x float> <float 1.000000e+00, float 1.000000e+00>, <2 x float> <float 5.000000e-01, float 5.000000e-01>, <2 x float> <float 5.000000e-01, float 5.000000e-01>, float 0.000000e+00, i1 true, <2 x i32> zeroinitializer, i32 0) #15
  %4 = extractvalue { float, i8 } %3, 0
  ret float %4
}

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
define %"struct.metal::sparse_color.91" @probe_p06m_sparse_sample_45(%struct._depth_cube_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #7 {
  %3 = tail call { float, i8 } @air.sample_depth_cube_array.f32(%struct._depth_cube_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, i32 1, <3 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, i32 0, i1 false, float 1.000000e+00, float 1.000000e+00, i32 0) #17
  %4 = extractvalue { float, i8 } %3, 1
  %5 = extractvalue { float, i8 } %3, 0
  %6 = and i8 %4, 1
  %7 = xor i8 %6, 1
  %8 = insertvalue %"struct.metal::sparse_color.91" poison, float %5, 0
  %9 = insertvalue %"struct.metal::sparse_color.91" %8, i8 %7, 1
  ret %"struct.metal::sparse_color.91" %9
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define %"struct.metal::sparse_color.91" @probe_p06m_sparse_sample_46(%struct._depth_cube_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1) local_unnamed_addr #8 {
  %3 = tail call { float, i8 } @air.sample_depth_cube_array_grad.f32(%struct._depth_cube_array_t addrspace(1)* nocapture readonly %0, %struct._sampler_t addrspace(2)* nocapture readonly %1, i32 1, <3 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, i32 0, <3 x float> <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>, <3 x float> <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>, float 1.000000e+00, i32 0) #15
  %4 = extractvalue { float, i8 } %3, 1
  %5 = extractvalue { float, i8 } %3, 0
  %6 = and i8 %4, 1
  %7 = xor i8 %6, 1
  %8 = insertvalue %"struct.metal::sparse_color.91" poison, float %5, 0
  %9 = insertvalue %"struct.metal::sparse_color.91" %8, i8 %7, 1
  ret %"struct.metal::sparse_color.91" %9
}

; Function Attrs: mustprogress nounwind willreturn
declare i1 @air.atomic_compare_exchange_weak_explicit_texture_1d_array.u.v4i32(%struct._texture_1d_array_t addrspace(1)* nocapture, i32, i32, <4 x i32>*, <4 x i32>, i32, i32, i32) local_unnamed_addr #9

; Function Attrs: mustprogress nounwind willreturn
declare i1 @air.atomic_compare_exchange_weak_explicit_texture_1d.u.v4i32(%struct._texture_1d_t addrspace(1)* nocapture, i32, <4 x i32>*, <4 x i32>, i32, i32, i32) local_unnamed_addr #9

; Function Attrs: mustprogress nounwind willreturn
declare i1 @air.atomic_compare_exchange_weak_explicit_texture_2d_array.u.v4i32(%struct._texture_2d_array_t addrspace(1)* nocapture, <2 x i32>, i32, <2 x i32>, <4 x i32>*, <4 x i32>, i32, i32, i32) local_unnamed_addr #9

; Function Attrs: mustprogress nounwind willreturn
declare i1 @air.atomic_compare_exchange_weak_explicit_texture_2d.u.v4i32(%struct._texture_2d_t addrspace(1)* nocapture, <2 x i32>, <2 x i32>, <4 x i32>*, <4 x i32>, i32, i32, i32) local_unnamed_addr #9

; Function Attrs: mustprogress nounwind willreturn
declare i1 @air.atomic_compare_exchange_weak_explicit_texture_3d.u.v4i32(%struct._texture_3d_t addrspace(1)* nocapture, <3 x i32>, <3 x i32>, <4 x i32>*, <4 x i32>, i32, i32, i32) local_unnamed_addr #9

; Function Attrs: mustprogress nounwind willreturn
declare i1 @air.atomic_compare_exchange_weak_explicit_texture_buffer_1d.u.v4i32(%struct._texture_buffer_1d_t addrspace(1)* nocapture, i32, <4 x i32>*, <4 x i32>, i32, i32, i32) local_unnamed_addr #9

; Function Attrs: mustprogress nounwind willreturn
declare i1 @air.atomic_compare_exchange_weak_explicit_texture_cube_array.u.v4i32(%struct._texture_cube_array_t addrspace(1)* nocapture, <2 x i32>, i32, i32, <4 x i32>*, <4 x i32>, i32, i32, i32) local_unnamed_addr #9

; Function Attrs: mustprogress nounwind willreturn
declare i1 @air.atomic_compare_exchange_weak_explicit_texture_cube.u.v4i32(%struct._texture_cube_t addrspace(1)* nocapture, <2 x i32>, i32, <4 x i32>*, <4 x i32>, i32, i32, i32) local_unnamed_addr #9

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare { <4 x float>, i8 } @air.gather_texture_2d_array.v4f32(%struct._texture_2d_array_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, <2 x float>, i32, i1, <2 x i32>, i32, i32) local_unnamed_addr #10

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare { <4 x float>, i8 } @air.gather_texture_2d.v4f32(%struct._texture_2d_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, <2 x float>, i1, <2 x i32>, i32, i32) local_unnamed_addr #10

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare { <4 x float>, i8 } @air.gather_texture_cube_array.v4f32(%struct._texture_cube_array_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, <3 x float>, i32, i32, i32) local_unnamed_addr #10

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare { <4 x float>, i8 } @air.gather_texture_cube.v4f32(%struct._texture_cube_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, <3 x float>, i32, i32) local_unnamed_addr #10

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i32 @air.get_width_depth_2d(%struct._depth_2d_t addrspace(1)* nocapture readonly, i32) local_unnamed_addr #10

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind readonly willreturn
declare %struct._sampler_t addrspace(2)* @air.get_read_sampler() local_unnamed_addr #11

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare { float, i8 } @air.read_depth_2d_array.f32(%struct._depth_2d_array_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)*, i32, <2 x i32>, i32, <2 x i32>, i32, i32) local_unnamed_addr #10

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare { float, i8 } @air.read_depth_2d_ms_array.f32(%struct._depth_2d_ms_array_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)*, i32, <2 x i32>, i32, i32, i32) local_unnamed_addr #10

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare { float, i8 } @air.read_depth_2d.f32(%struct._depth_2d_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)*, i32, <2 x i32>, <2 x i32>, i32, i32) local_unnamed_addr #10

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare { float, i8 } @air.read_depth_cube_array.f32(%struct._depth_cube_array_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)*, i32, <2 x i32>, i32, i32, i32, i32) local_unnamed_addr #10

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare { float, i8 } @air.read_depth_cube.f32(%struct._depth_cube_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)*, i32, <2 x i32>, i32, i32, i32) local_unnamed_addr #10

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
declare { float, i8 } @air.sample_compare_depth_2d_array.f32(%struct._depth_2d_array_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, i32, <2 x float>, i32, float, i1, <2 x i32>, i1, float, float, i32) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare { float, i8 } @air.sample_compare_depth_2d_array_grad.f32(%struct._depth_2d_array_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, i32, <2 x float>, i32, float, <2 x float>, <2 x float>, float, i1, <2 x i32>, i32) local_unnamed_addr #10

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
declare { float, i8 } @air.sample_compare_depth_2d.f32(%struct._depth_2d_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, i32, <2 x float>, float, i1, <2 x i32>, i1, float, float, i32) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare { float, i8 } @air.sample_compare_depth_2d_grad.f32(%struct._depth_2d_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, i32, <2 x float>, float, <2 x float>, <2 x float>, float, i1, <2 x i32>, i32) local_unnamed_addr #10

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
declare { float, i8 } @air.sample_compare_depth_cube_array.f32(%struct._depth_cube_array_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, i32, <3 x float>, i32, float, i1, float, float, i32) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare { float, i8 } @air.sample_compare_depth_cube_array_grad.f32(%struct._depth_cube_array_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, i32, <3 x float>, i32, float, <3 x float>, <3 x float>, float, i32) local_unnamed_addr #10

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
declare { float, i8 } @air.sample_compare_depth_cube.f32(%struct._depth_cube_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, i32, <3 x float>, float, i1, float, float, i32) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare { float, i8 } @air.sample_compare_depth_cube_grad.f32(%struct._depth_cube_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, i32, <3 x float>, float, <3 x float>, <3 x float>, float, i32) local_unnamed_addr #10

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare { float, i8 } @air.sample_depth_2d_grad.f32(%struct._depth_2d_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, i32, <2 x float>, <2 x float>, <2 x float>, float, i1, <2 x i32>, i32) local_unnamed_addr #10

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
declare { float, i8 } @air.sample_depth_cube_array.f32(%struct._depth_cube_array_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, i32, <3 x float>, i32, i1, float, float, i32) local_unnamed_addr #12

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare { float, i8 } @air.sample_depth_cube_array_grad.f32(%struct._depth_cube_array_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, i32, <3 x float>, i32, <3 x float>, <3 x float>, float, i32) local_unnamed_addr #10

attributes #0 = { mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="128" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #1 = { argmemonly mustprogress nocallback nofree nosync nounwind willreturn }
attributes #2 = { argmemonly mustprogress nofree nounwind readonly willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="128" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #3 = { argmemonly mustprogress nofree nounwind readonly willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #4 = { mustprogress nofree nounwind readonly willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="64" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #5 = { argmemonly convergent mustprogress nofree nounwind readonly willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="64" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #6 = { argmemonly mustprogress nofree nounwind readonly willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="64" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #7 = { argmemonly convergent mustprogress nofree nounwind readonly willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="96" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #8 = { argmemonly mustprogress nofree nounwind readonly willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="96" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #9 = { mustprogress nounwind willreturn }
attributes #10 = { argmemonly mustprogress nofree nounwind readonly willreturn }
attributes #11 = { inaccessiblememonly mustprogress nofree nounwind readonly willreturn }
attributes #12 = { argmemonly convergent mustprogress nofree nounwind readonly willreturn }
attributes #13 = { nounwind }
attributes #14 = { nounwind willreturn }
attributes #15 = { argmemonly nounwind readonly willreturn }
attributes #16 = { inaccessiblememonly nounwind readonly willreturn }
attributes #17 = { argmemonly convergent nounwind readonly willreturn }

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
!15 = !{!"/Users/runner/metal_probe/p6/P06M/probe.metal"}
!16 = !{!17, !17, i64 0}
!17 = !{!"omnipotent char", !18, i64 0}
!18 = !{!"Simple C++ TBAA"}
