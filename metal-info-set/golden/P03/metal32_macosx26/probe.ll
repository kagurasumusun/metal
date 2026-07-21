; ModuleID = 'probe_scenes/scene_P03_math/probe.metal'
source_filename = "probe_scenes/scene_P03_math/probe.metal"
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-n8:16:32"
target triple = "air64_v28-apple-macosx26.0.0"

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define float @probe_p03_divide(float noundef %0, float noundef %1) local_unnamed_addr #0 {
  %3 = fdiv reassoc nsz arcp contract afn float %0, %1
  ret float %3
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define float @probe_p03_fmax3(float noundef %0, float noundef %1, float noundef %2) local_unnamed_addr #1 {
  %4 = tail call fast float @air.fast_fmax3.f32(float %0, float %1, float %2) #6
  ret float %4
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define float @probe_p03_fmedian3(float noundef %0, float noundef %1, float noundef %2) local_unnamed_addr #1 {
  %4 = tail call fast float @air.fast_fmedian3.f32(float %0, float %1, float %2) #6
  ret float %4
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define float @probe_p03_fmin3(float noundef %0, float noundef %1, float noundef %2) local_unnamed_addr #1 {
  %4 = tail call fast float @air.fast_fmin3.f32(float %0, float %1, float %2) #6
  ret float %4
}

; Function Attrs: convergent mustprogress nounwind
define i32 @probe_p03_ilogb(float noundef %0) local_unnamed_addr #2 {
  %2 = tail call i32 @___metal_ilogb_float(float %0, i32 0) #7
  ret i32 %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define float @probe_p03_fdim(float noundef %0, float noundef %1) local_unnamed_addr #3 {
  %3 = fsub float %0, %1
  %4 = fcmp olt float %3, 0.000000e+00
  %5 = fcmp oeq float %0, %1
  %6 = or i1 %5, %4
  %7 = select reassoc nsz arcp contract afn i1 %6, float 0.000000e+00, float %3
  ret float %7
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare float @air.fast_fmax3.f32(float, float, float) local_unnamed_addr #4

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare float @air.fast_fmedian3.f32(float, float, float) local_unnamed_addr #4

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare float @air.fast_fmin3.f32(float, float, float) local_unnamed_addr #4

; Function Attrs: convergent
declare i32 @___metal_ilogb_float(float, i32) local_unnamed_addr #5

attributes #0 = { mustprogress nofree norecurse nosync nounwind readnone willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #1 = { mustprogress nofree nosync nounwind readnone willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #2 = { convergent mustprogress nounwind "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #3 = { mustprogress nofree norecurse nosync nounwind readnone willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" }
attributes #4 = { mustprogress nofree nosync nounwind readnone willreturn }
attributes #5 = { convergent }
attributes #6 = { nounwind readnone willreturn }
attributes #7 = { convergent nounwind }

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
!14 = !{!"Metal", i32 3, i32 2, i32 0}
!15 = !{!"/Users/runner/metal_probe/probe_scenes/scene_P03_math/probe.metal"}
