; ModuleID = 'probe.metal'
source_filename = "probe.metal"
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-n8:16:32"
target triple = "air64_v28-apple-macosx26.0.0"

%struct._tensor_t = type opaque
%"struct.metal::tensor" = type { %struct._tensor_t addrspace(1)* }

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p10t_extent_0() local_unnamed_addr #0 {
  ret i32 4
}

; Function Attrs: argmemonly mustprogress nocallback nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: argmemonly mustprogress nocallback nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: mustprogress nounwind willreturn
define i32 @probe_p10t_stride_1() local_unnamed_addr #2 {
  %1 = tail call %struct._tensor_t addrspace(1)* @air.get_null_global_tensor() #8
  %2 = tail call i32 @air.get_stride_global_tensor.i32(%struct._tensor_t addrspace(1)* nocapture readonly %1, i16 2, i16 0) #9
  ret i32 %2
}

; Function Attrs: mustprogress nounwind willreturn
define float @probe_p10t_load_2() local_unnamed_addr #2 {
  %1 = tail call %struct._tensor_t addrspace(1)* @air.get_null_global_tensor() #8
  %2 = tail call fast float @air.load_global_tensor.s.i32.global.f32(%struct._tensor_t addrspace(1)* nocapture readonly %1, i16 0, i8* nocapture readonly null, i8* nocapture readonly null) #10
  ret float %2
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p10t_store_3() local_unnamed_addr #2 {
  %1 = tail call %struct._tensor_t addrspace(1)* @air.get_null_global_tensor() #8
  tail call void @air.store_global_tensor.s.i32.global.f32(%struct._tensor_t addrspace(1)* nocapture readonly %1, i16 0, i8* nocapture readonly null, i8* nocapture readonly null, float 1.000000e+00) #10
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define float @probe_p10t_dptr_4() local_unnamed_addr #2 {
  %1 = alloca [2 x i32], align 4
  %2 = tail call %struct._tensor_t addrspace(1)* @air.get_null_global_tensor() #8
  %3 = bitcast [2 x i32]* %1 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3)
  %4 = getelementptr inbounds [2 x i32], [2 x i32]* %1, i64 0, i64 0
  store i32 0, i32* %4, align 4, !tbaa !16
  %5 = getelementptr inbounds [2 x i32], [2 x i32]* %1, i64 0, i64 1
  store i32 0, i32* %5, align 4, !tbaa !16
  %6 = call i8 addrspace(1)* @air.get_data_pointer_typed_global_tensor.s.i32.global(%struct._tensor_t addrspace(1)* nocapture readonly %2, i16 2, i8* nocapture nonnull readonly %3, i8 0) #9
  %7 = bitcast i8 addrspace(1)* %6 to float addrspace(1)*
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3)
  %8 = load float, float addrspace(1)* %7, align 4, !tbaa !20
  ret float %8
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define void @probe_p10t_slice_5(%"struct.metal::tensor" addrspace(1)* nocapture noundef %0) local_unnamed_addr #0 {
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define void @probe_p10t_init_6() local_unnamed_addr #0 {
  ret void
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p10t_isnull_7() local_unnamed_addr #3 {
  %1 = tail call %struct._tensor_t addrspace(1)* @air.get_null_global_tensor() #8
  %2 = tail call i1 @air.is_null_global_tensor(%struct._tensor_t addrspace(1)* nocapture readonly %1) #11
  ret i1 %2
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p10t_null_8() local_unnamed_addr #3 {
  %1 = tail call %struct._tensor_t addrspace(1)* @air.get_null_global_tensor() #8
  %2 = tail call i1 @air.is_null_global_tensor(%struct._tensor_t addrspace(1)* nocapture readonly %1) #11
  ret i1 %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p10t_handle_9() local_unnamed_addr #0 {
  ret i32 4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define void @probe_p10t_descsize_10() local_unnamed_addr #0 {
  ret void
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p10t_type_h_11() local_unnamed_addr #3 {
  %1 = tail call %struct._tensor_t addrspace(1)* @air.get_null_global_tensor() #8
  %2 = tail call i1 @air.is_null_global_tensor(%struct._tensor_t addrspace(1)* nocapture readonly %1) #11
  ret i1 %2
}

; Function Attrs: mustprogress nofree nounwind readonly willreturn
define zeroext i1 @probe_p10t_type_th_12() local_unnamed_addr #3 {
  %1 = tail call %struct._tensor_t addrspace(1)* @air.get_null_global_tensor() #8
  %2 = tail call i1 @air.is_null_global_tensor(%struct._tensor_t addrspace(1)* nocapture readonly %1) #11
  ret i1 %2
}

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind readonly willreturn
declare %struct._tensor_t addrspace(1)* @air.get_null_global_tensor() local_unnamed_addr #4

; Function Attrs: argmemonly mustprogress nounwind willreturn
declare i32 @air.get_stride_global_tensor.i32(%struct._tensor_t addrspace(1)* nocapture readonly, i16, i16) local_unnamed_addr #5

; Function Attrs: mustprogress nounwind willreturn
declare float @air.load_global_tensor.s.i32.global.f32(%struct._tensor_t addrspace(1)* nocapture readonly, i16, i8* nocapture readonly, i8* nocapture readonly) local_unnamed_addr #6

; Function Attrs: mustprogress nounwind willreturn
declare void @air.store_global_tensor.s.i32.global.f32(%struct._tensor_t addrspace(1)* nocapture readonly, i16, i8* nocapture readonly, i8* nocapture readonly, float) local_unnamed_addr #6

; Function Attrs: argmemonly mustprogress nounwind willreturn
declare i8 addrspace(1)* @air.get_data_pointer_typed_global_tensor.s.i32.global(%struct._tensor_t addrspace(1)* nocapture readonly, i16, i8* nocapture readonly, i8) local_unnamed_addr #5

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare i1 @air.is_null_global_tensor(%struct._tensor_t addrspace(1)* nocapture readonly) local_unnamed_addr #7

attributes #0 = { mustprogress nofree norecurse nosync nounwind readnone willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #1 = { argmemonly mustprogress nocallback nofree nosync nounwind willreturn }
attributes #2 = { mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #3 = { mustprogress nofree nounwind readonly willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #4 = { inaccessiblememonly mustprogress nofree nounwind readonly willreturn }
attributes #5 = { argmemonly mustprogress nounwind willreturn }
attributes #6 = { mustprogress nounwind willreturn }
attributes #7 = { argmemonly mustprogress nofree nounwind readonly willreturn }
attributes #8 = { inaccessiblememonly nounwind readonly willreturn }
attributes #9 = { argmemonly nounwind willreturn }
attributes #10 = { nounwind willreturn }
attributes #11 = { argmemonly nounwind readonly willreturn }

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
!15 = !{!"/Users/runner/metal_probe/p10/P10T/probe.metal"}
!16 = !{!17, !17, i64 0}
!17 = !{!"int", !18, i64 0}
!18 = !{!"omnipotent char", !19, i64 0}
!19 = !{!"Simple C++ TBAA"}
!20 = !{!21, !21, i64 0}
!21 = !{!"float", !18, i64 0}
