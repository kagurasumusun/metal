; ModuleID = 'probe_scenes/scene_P02_vertex_fragment_meta/probe.metal'
source_filename = "probe_scenes/scene_P02_vertex_fragment_meta/probe.metal"
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-n8:16:32"
target triple = "air64_v28-apple-macosx26.0.0"

%struct._texture_2d_t = type opaque
%struct._sampler_t = type opaque

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define <{ <4 x float>, <2 x float> }> @probe_p02_vertex(<4 x float> %0, <2 x float> %1, i32 noundef %2, i32 noundef %3) local_unnamed_addr #0 {
  %5 = and i32 %2, 1
  %6 = tail call fast float @air.convert.f.f32.u.i32(i32 %5) #5
  %7 = insertelement <2 x float> undef, float %6, i64 0
  %8 = and i32 %3, 1
  %9 = tail call fast float @air.convert.f.f32.u.i32(i32 %8) #5
  %10 = insertelement <2 x float> %7, float %9, i64 1
  %11 = fadd fast <2 x float> %10, %1
  %12 = insertvalue <{ <4 x float>, <2 x float> }> undef, <4 x float> %0, 0
  %13 = insertvalue <{ <4 x float>, <2 x float> }> %12, <2 x float> %11, 1
  ret <{ <4 x float>, <2 x float> }> %13
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare float @air.convert.f.f32.u.i32(i32) local_unnamed_addr #1

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
define <4 x float> @probe_p02_fragment(<4 x float> %0, <2 x float> %1, %struct._texture_2d_t addrspace(1)* nocapture readonly %2, %struct._sampler_t addrspace(2)* nocapture readonly %3) local_unnamed_addr #2 {
  %5 = tail call { <4 x float>, i8 } @air.sample_texture_2d.v4f32(%struct._texture_2d_t addrspace(1)* nocapture readonly %2, %struct._sampler_t addrspace(2)* nocapture readonly %3, <2 x float> %1, i1 true, <2 x i32> zeroinitializer, i1 false, float 0.000000e+00, float 0.000000e+00, i32 0) #6, !alias.scope !37
  %6 = extractvalue { <4 x float>, i8 } %5, 0
  ret <4 x float> %6
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define <4 x float> @probe_p02_fragment_rog(<4 x float> returned %0, <2 x float> %1) local_unnamed_addr #3 {
  ret <4 x float> %0
}

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
declare { <4 x float>, i8 } @air.sample_texture_2d.v4f32(%struct._texture_2d_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, <2 x float>, i1, <2 x i32>, i1, float, float, i32) local_unnamed_addr #4

attributes #0 = { mustprogress nofree nosync nounwind readnone willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="128" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #1 = { mustprogress nofree nosync nounwind readnone willreturn }
attributes #2 = { argmemonly convergent mustprogress nofree nounwind readonly willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="128" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #3 = { mustprogress nofree norecurse nosync nounwind readnone willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="128" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #4 = { argmemonly convergent mustprogress nofree nounwind readonly willreturn }
attributes #5 = { nounwind readnone willreturn }
attributes #6 = { argmemonly convergent nounwind readonly willreturn }

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5, !6, !7, !8}
!air.vertex = !{!9}
!air.fragment = !{!18, !26}
!air.compile_options = !{!30, !31, !32}
!llvm.ident = !{!33}
!air.version = !{!34}
!air.language_version = !{!35}
!air.source_file_name = !{!36}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 26, i32 5]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"frame-pointer", i32 2}
!3 = !{i32 7, !"air.max_device_buffers", i32 31}
!4 = !{i32 7, !"air.max_constant_buffers", i32 31}
!5 = !{i32 7, !"air.max_threadgroup_buffers", i32 31}
!6 = !{i32 7, !"air.max_textures", i32 128}
!7 = !{i32 7, !"air.max_read_write_textures", i32 8}
!8 = !{i32 7, !"air.max_samplers", i32 16}
!9 = !{<{ <4 x float>, <2 x float> }> (<4 x float>, <2 x float>, i32, i32)* @probe_p02_vertex, !10, !13}
!10 = !{!11, !12}
!11 = !{!"air.position", !"air.arg_type_name", !"float4", !"air.arg_name", !"pos"}
!12 = !{!"air.vertex_output", !"generated(2uvDv2_f)", !"air.arg_type_name", !"float2", !"air.arg_name", !"uv"}
!13 = !{!14, !15, !16, !17}
!14 = !{i32 0, !"air.vertex_input", !"air.location_index", i32 0, i32 1, !"air.arg_type_name", !"float4", !"air.arg_name", !"pos"}
!15 = !{i32 1, !"air.vertex_input", !"air.location_index", i32 1, i32 1, !"air.arg_type_name", !"float2", !"air.arg_name", !"uv"}
!16 = !{i32 2, !"air.vertex_id", !"air.arg_type_name", !"uint", !"air.arg_name", !"vid"}
!17 = !{i32 3, !"air.instance_id", !"air.arg_type_name", !"uint", !"air.arg_name", !"iid"}
!18 = !{<4 x float> (<4 x float>, <2 x float>, %struct._texture_2d_t addrspace(1)*, %struct._sampler_t addrspace(2)*)* @probe_p02_fragment, !19, !21}
!19 = !{!20}
!20 = !{!"air.render_target", i32 0, i32 0, !"air.arg_type_name", !"float4"}
!21 = !{!22, !23, !24, !25}
!22 = !{i32 0, !"air.position", !"air.center", !"air.no_perspective", !"air.arg_type_name", !"float4", !"air.arg_name", !"pos", !"air.arg_unused"}
!23 = !{i32 1, !"air.fragment_input", !"generated(2uvDv2_f)", !"air.center", !"air.perspective", !"air.arg_type_name", !"float2", !"air.arg_name", !"uv"}
!24 = !{i32 2, !"air.texture", !"air.location_index", i32 0, i32 1, !"air.sample", !"air.arg_type_name", !"texture2d<float, sample>", !"air.arg_name", !"t"}
!25 = !{i32 3, !"air.sampler", !"air.location_index", i32 0, i32 1, !"air.arg_type_name", !"sampler", !"air.arg_name", !"s"}
!26 = !{<4 x float> (<4 x float>, <2 x float>)* @probe_p02_fragment_rog, !19, !27, !"early_fragment_tests"}
!27 = !{!28, !29}
!28 = !{i32 0, !"air.position", !"air.center", !"air.no_perspective", !"air.arg_type_name", !"float4", !"air.arg_name", !"pos"}
!29 = !{i32 1, !"air.fragment_input", !"generated(2uvDv2_f)", !"air.center", !"air.perspective", !"air.arg_type_name", !"float2", !"air.arg_name", !"uv", !"air.arg_unused"}
!30 = !{!"air.compile.denorms_disable"}
!31 = !{!"air.compile.fast_math_enable"}
!32 = !{!"air.compile.framebuffer_fetch_enable"}
!33 = !{!"Apple metal version 32023.883 (metalfe-32023.883)"}
!34 = !{i32 2, i32 8, i32 0}
!35 = !{!"Metal", i32 3, i32 2, i32 0}
!36 = !{!"/Users/runner/metal_probe/probe_scenes/scene_P02_vertex_fragment_meta/probe.metal"}
!37 = !{!38, !40}
!38 = distinct !{!38, !39, !"air-alias-scope-textures"}
!39 = distinct !{!39, !"air-alias-scopes(probe_p02_fragment)"}
!40 = distinct !{!40, !39, !"air-alias-scope-samplers"}
