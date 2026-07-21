; ModuleID = 'probe.metal'
source_filename = "probe.metal"
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-n8:16:32"
target triple = "air64_v28-apple-macosx26.0.0"

%"struct.metal::_atomic" = type { i64 }

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p23m_amax(%"struct.metal::_atomic" addrspace(1)* nocapture noundef %0) local_unnamed_addr #0 {
  %2 = getelementptr inbounds %"struct.metal::_atomic", %"struct.metal::_atomic" addrspace(1)* %0, i64 0, i32 0
  tail call void @air.atomic.global.max.u.i64(i64 addrspace(1)* nocapture %2, i64 0, i32 0, i32 2, i1 true) #7
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p23m_amin(%"struct.metal::_atomic" addrspace(1)* nocapture noundef %0) local_unnamed_addr #0 {
  %2 = getelementptr inbounds %"struct.metal::_atomic", %"struct.metal::_atomic" addrspace(1)* %0, i64 0, i32 0
  tail call void @air.atomic.global.min.u.i64(i64 addrspace(1)* nocapture %2, i64 0, i32 0, i32 2, i1 true) #7
  ret void
}

; Function Attrs: convergent mustprogress nounwind willreturn
define void @probe_p23m_mdiag(<4 x float> addrspace(1)* nocapture noundef writeonly %0) local_unnamed_addr #1 {
  %2 = tail call fast <64 x float> @air.simdgroup_matrix_8x8_init_diag.v64f32.f32(float 1.000000e+00) #8
  store <4 x float> zeroinitializer, <4 x float> addrspace(1)* %0, align 16, !tbaa !16
  ret void
}

; Function Attrs: convergent mustprogress nounwind willreturn
define void @probe_p23m_mfill(<4 x float> addrspace(1)* nocapture noundef writeonly %0) local_unnamed_addr #1 {
  %2 = tail call fast <64 x float> @air.simdgroup_matrix_8x8_init_filled.v64f32.f32(float 1.000000e+00) #8
  store <4 x float> zeroinitializer, <4 x float> addrspace(1)* %0, align 16, !tbaa !16
  ret void
}

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn writeonly
define void @probe_p23m_mload(float addrspace(1)* nocapture noundef readnone %0, <4 x float> addrspace(1)* nocapture noundef writeonly %1) local_unnamed_addr #2 {
  store <4 x float> zeroinitializer, <4 x float> addrspace(1)* %1, align 16, !tbaa !16
  ret void
}

; Function Attrs: convergent mustprogress nounwind willreturn
define void @probe_p23m_mstore(float addrspace(1)* nocapture noundef readonly %0, float addrspace(1)* nocapture noundef writeonly %1) local_unnamed_addr #1 {
  %3 = tail call fast <64 x float> @air.simdgroup_matrix_8x8_load.v64f32.p1f32(float addrspace(1)* nocapture readonly %0, <2 x i64> <i64 8, i64 8>, <2 x i64> <i64 1, i64 8>, <2 x i64> zeroinitializer) #9
  tail call void @air.simdgroup_matrix_8x8_store.v64f32.p1f32(<64 x float> %3, float addrspace(1)* nocapture writeonly %1, <2 x i64> <i64 8, i64 8>, <2 x i64> <i64 1, i64 8>, <2 x i64> zeroinitializer) #10
  ret void
}

; Function Attrs: convergent mustprogress nounwind willreturn
define void @probe_p23m_mmac(float addrspace(1)* nocapture noundef readonly %0, float addrspace(1)* nocapture noundef writeonly %1) local_unnamed_addr #1 {
  %3 = tail call fast <64 x float> @air.simdgroup_matrix_8x8_load.v64f32.p1f32(float addrspace(1)* nocapture readonly %0, <2 x i64> <i64 8, i64 8>, <2 x i64> <i64 1, i64 8>, <2 x i64> zeroinitializer) #9
  %4 = tail call fast <64 x float> @air.simdgroup_matrix_8x8_multiply_accumulate.v64f32.v64f32.v64f32.v64f32(<64 x float> %3, <64 x float> %3, <64 x float> %3) #8
  tail call void @air.simdgroup_matrix_8x8_store.v64f32.p1f32(<64 x float> %4, float addrspace(1)* nocapture writeonly %1, <2 x i64> <i64 8, i64 8>, <2 x i64> <i64 1, i64 8>, <2 x i64> zeroinitializer) #10
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
declare void @air.atomic.global.max.u.i64(i64 addrspace(1)* nocapture, i64, i32, i32, i1) local_unnamed_addr #3

; Function Attrs: mustprogress nounwind willreturn
declare void @air.atomic.global.min.u.i64(i64 addrspace(1)* nocapture, i64, i32, i32, i1) local_unnamed_addr #3

; Function Attrs: convergent mustprogress nounwind willreturn
declare <64 x float> @air.simdgroup_matrix_8x8_init_diag.v64f32.f32(float) local_unnamed_addr #4

; Function Attrs: convergent mustprogress nounwind willreturn
declare <64 x float> @air.simdgroup_matrix_8x8_init_filled.v64f32.f32(float) local_unnamed_addr #4

; Function Attrs: convergent mustprogress nofree nounwind readonly willreturn
declare <64 x float> @air.simdgroup_matrix_8x8_load.v64f32.p1f32(float addrspace(1)* nocapture readonly, <2 x i64>, <2 x i64>, <2 x i64>) local_unnamed_addr #5

; Function Attrs: convergent mustprogress nounwind willreturn writeonly
declare void @air.simdgroup_matrix_8x8_store.v64f32.p1f32(<64 x float>, float addrspace(1)* nocapture writeonly, <2 x i64>, <2 x i64>, <2 x i64>) local_unnamed_addr #6

; Function Attrs: convergent mustprogress nounwind willreturn
declare <64 x float> @air.simdgroup_matrix_8x8_multiply_accumulate.v64f32.v64f32.v64f32.v64f32(<64 x float>, <64 x float>, <64 x float>) local_unnamed_addr #4

attributes #0 = { mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #1 = { convergent mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="2048" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #2 = { argmemonly mustprogress nofree norecurse nosync nounwind willreturn writeonly "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="128" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #3 = { mustprogress nounwind willreturn }
attributes #4 = { convergent mustprogress nounwind willreturn }
attributes #5 = { convergent mustprogress nofree nounwind readonly willreturn }
attributes #6 = { convergent mustprogress nounwind willreturn writeonly }
attributes #7 = { nounwind willreturn }
attributes #8 = { convergent nounwind willreturn }
attributes #9 = { convergent nounwind readonly willreturn }
attributes #10 = { convergent nounwind willreturn writeonly }

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
!15 = !{!"/Users/runner/metal_probe/p23/P23M/probe.metal"}
!16 = !{!17, !17, i64 0}
!17 = !{!"omnipotent char", !18, i64 0}
!18 = !{!"Simple C++ TBAA"}
