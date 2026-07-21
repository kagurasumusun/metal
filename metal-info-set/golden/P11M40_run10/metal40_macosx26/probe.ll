; ModuleID = 'probe.metal'
source_filename = "probe.metal"
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-n8:16:32"
target triple = "air64_v28-apple-macosx26.0.0"

%"struct.metal::rasterization_rate_map_data" = type opaque

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

; Function Attrs: convergent mustprogress nounwind willreturn
define zeroext i1 @probe_p11m_qvotea_21() local_unnamed_addr #1 {
  %1 = tail call i1 @air.quad_vote_all(i16 1) #6
  ret i1 %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define zeroext i1 @probe_p11m_qvoteb_22() local_unnamed_addr #1 {
  %1 = tail call i1 @air.quad_vote_any(i16 1) #6
  ret i1 %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define i32 @probe_p11m_qand_23() local_unnamed_addr #1 {
  %1 = tail call i32 @air.quad_and.s.i32(i32 3) #6
  ret i32 %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define i32 @probe_p11m_qor_24() local_unnamed_addr #1 {
  %1 = tail call i32 @air.quad_or.s.i32(i32 3) #6
  ret i32 %1
}

; Function Attrs: convergent mustprogress nounwind willreturn
define i32 @probe_p11m_qxor_25() local_unnamed_addr #1 {
  %1 = tail call i32 @air.quad_xor.s.i32(i32 3) #6
  ret i32 %1
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define float @probe_p11m_divide_26() local_unnamed_addr #2 {
  ret float 5.000000e-01
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define float @probe_p11m_select_27() local_unnamed_addr #0 {
  ret float -1.000000e+00
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define i32 @probe_p11m_sampler_28() local_unnamed_addr #0 {
  ret i32 0
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define <2 x float> @probe_p11m_rrm_p2s_f_31(%"struct.metal::rasterization_rate_map_data" addrspace(2)* nocapture noundef readonly %0, i32 noundef %1) local_unnamed_addr #3 {
  %3 = bitcast %"struct.metal::rasterization_rate_map_data" addrspace(2)* %0 to i8 addrspace(2)*
  %4 = tail call fast <2 x float> @air.map_physical_to_screen_coordinates.v2f32.p2i8.i32(<2 x float> zeroinitializer, i8 addrspace(2)* nocapture readonly %3, i32 %1) #7
  ret <2 x float> %4
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define <2 x float> @probe_p11m_rrm_s2p_f_32(%"struct.metal::rasterization_rate_map_data" addrspace(2)* nocapture noundef readonly %0, i32 noundef %1) local_unnamed_addr #3 {
  %3 = bitcast %"struct.metal::rasterization_rate_map_data" addrspace(2)* %0 to i8 addrspace(2)*
  %4 = tail call fast <2 x float> @air.map_screen_to_physical_coordinates.v2f32.p2i8.i32(<2 x float> zeroinitializer, i8 addrspace(2)* nocapture readonly %3, i32 %1) #7
  ret <2 x float> %4
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define <2 x i32> @probe_p11m_rrm_p2s_u_33(%"struct.metal::rasterization_rate_map_data" addrspace(2)* nocapture noundef readonly %0, i32 noundef %1) local_unnamed_addr #3 {
  %3 = bitcast %"struct.metal::rasterization_rate_map_data" addrspace(2)* %0 to i8 addrspace(2)*
  %4 = tail call <2 x i32> @air.map_physical_to_screen_coordinates.v2i32.p2i8.i32(<2 x i32> zeroinitializer, i8 addrspace(2)* nocapture readonly %3, i32 %1) #7
  ret <2 x i32> %4
}

; Function Attrs: convergent mustprogress nounwind willreturn
declare i1 @air.quad_vote_all(i16) local_unnamed_addr #4

; Function Attrs: convergent mustprogress nounwind willreturn
declare i1 @air.quad_vote_any(i16) local_unnamed_addr #4

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare <2 x float> @air.map_physical_to_screen_coordinates.v2f32.p2i8.i32(<2 x float>, i8 addrspace(2)* nocapture readonly, i32) local_unnamed_addr #5

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare <2 x float> @air.map_screen_to_physical_coordinates.v2f32.p2i8.i32(<2 x float>, i8 addrspace(2)* nocapture readonly, i32) local_unnamed_addr #5

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare <2 x i32> @air.map_physical_to_screen_coordinates.v2i32.p2i8.i32(<2 x i32>, i8 addrspace(2)* nocapture readonly, i32) local_unnamed_addr #5

; Function Attrs: convergent mustprogress nounwind willreturn
declare i32 @air.quad_and.s.i32(i32) local_unnamed_addr #4

; Function Attrs: convergent mustprogress nounwind willreturn
declare i32 @air.quad_or.s.i32(i32) local_unnamed_addr #4

; Function Attrs: convergent mustprogress nounwind willreturn
declare i32 @air.quad_xor.s.i32(i32) local_unnamed_addr #4

attributes #0 = { mustprogress nofree norecurse nosync nounwind readnone willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #1 = { convergent mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #2 = { mustprogress nofree norecurse nosync nounwind readnone willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #3 = { mustprogress nofree nosync nounwind readnone willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="64" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #4 = { convergent mustprogress nounwind willreturn }
attributes #5 = { argmemonly mustprogress nofree nounwind readonly willreturn }
attributes #6 = { convergent nounwind willreturn }
attributes #7 = { argmemonly nounwind readonly willreturn }

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
!15 = !{!"/Users/runner/metal_probe/p10/P11M/probe.metal"}
