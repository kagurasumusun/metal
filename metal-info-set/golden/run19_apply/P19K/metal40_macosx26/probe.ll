; ModuleID = 'probe.metal'
source_filename = "probe.metal"
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-n8:16:32"
target triple = "air64_v28-apple-macosx26.0.0"

%struct._patch_control_point_t = type opaque

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define <4 x float> @probe_p19k_patch(%struct._patch_control_point_t* nocapture readnone %0, i16 noundef %1) local_unnamed_addr #0 {
  %3 = tail call fast float @air.convert.f.f32.u.i16(i16 %1) #2
  %4 = insertelement <4 x float> <float 3.000000e+00, float poison, float 0.000000e+00, float 1.000000e+00>, float %3, i64 1
  ret <4 x float> %4
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare float @air.convert.f.f32.u.i16(i16) local_unnamed_addr #1

attributes #0 = { mustprogress nofree nosync nounwind readnone willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="128" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #1 = { mustprogress nofree nosync nounwind readnone willreturn }
attributes #2 = { nounwind readnone willreturn }

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
!9 = !{<4 x float> (%struct._patch_control_point_t*, i16)* @probe_p19k_patch, !10, !12, !17}
!10 = !{!11}
!11 = !{!"air.position", !"air.arg_type_name", !"float4"}
!12 = !{!13, !16}
!13 = !{i32 0, !"air.patch_control_point_input", !14, !15, !"air.arg_unused"}
!14 = !{!"air.patch_control_point_function", null}
!15 = !{!"air.location_index", i32 0, i32 1, !"air.arg_type_name", !"float4", !"air.arg_name", !"p", !"air.arg_unused"}
!16 = !{i32 1, !"air.patch_id", !"air.arg_type_name", !"ushort", !"air.arg_name", !"__pid"}
!17 = !{!"air.patch", !"triangle", !"air.patch_control_point", i32 3}
!18 = !{!"air.compile.denorms_disable"}
!19 = !{!"air.compile.fast_math_enable"}
!20 = !{!"air.compile.framebuffer_fetch_enable"}
!21 = !{!"Apple metal version 32023.883 (metalfe-32023.883)"}
!22 = !{i32 2, i32 8, i32 0}
!23 = !{!"Metal", i32 4, i32 0, i32 0}
!24 = !{!"/Users/runner/metal_probe/p19/P19K/probe.metal"}
