; ModuleID = 'probe_scenes/scene_P05_convert/probe.metal'
source_filename = "probe_scenes/scene_P05_convert/probe.metal"
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-n8:16:32"
target triple = "air64_v28-apple-macosx26.0.0"

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define i32 @probe_p05_pack_float_to_snorm2x16(<2 x float> noundef %0) local_unnamed_addr #0 {
  %2 = tail call i32 @air.pack.snorm2x16.v2f32(<2 x float> %0) #5
  ret i32 %2
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define i32 @probe_p05_pack_float_to_snorm4x8(<4 x float> noundef %0) local_unnamed_addr #1 {
  %2 = tail call i32 @air.pack.snorm4x8.v4f32(<4 x float> %0) #5
  ret i32 %2
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define i32 @probe_p05_pack_float_to_unorm2x16(<2 x float> noundef %0) local_unnamed_addr #0 {
  %2 = tail call i32 @air.pack.unorm2x16.v2f32(<2 x float> %0) #5
  ret i32 %2
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define i32 @probe_p05_pack_float_to_unorm4x8(<4 x float> noundef %0) local_unnamed_addr #1 {
  %2 = tail call i32 @air.pack.unorm4x8.v4f32(<4 x float> %0) #5
  ret i32 %2
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define i32 @probe_p05_pack_float_to_srgb_unorm4x8(<4 x float> noundef %0) local_unnamed_addr #1 {
  %2 = tail call i32 @air.pack.unorm4x8.srgb.v4f32(<4 x float> %0) #5
  ret i32 %2
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define i32 @probe_p05_pack_float_to_unorm10a2(<4 x float> noundef %0) local_unnamed_addr #1 {
  %2 = tail call i32 @air.pack.unorm.rgb10a2.v4f32(<4 x float> %0) #5
  ret i32 %2
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define zeroext i16 @probe_p05_pack_float_to_unorm565(<3 x float> noundef %0) local_unnamed_addr #2 {
  %2 = tail call i16 @air.pack.unorm.rgb565.v3f32(<3 x float> %0) #5
  ret i16 %2
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define float @probe_p05_saturate(float noundef %0) local_unnamed_addr #3 {
  %2 = tail call fast float @air.fast_saturate.f32(float %0) #5
  ret float %2
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define <2 x float> @probe_p05_unpack_snorm2x16_to_float(i32 noundef %0) local_unnamed_addr #0 {
  %2 = tail call fast <2 x float> @air.unpack.snorm2x16.v2f32(i32 %0) #5
  ret <2 x float> %2
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define <4 x float> @probe_p05_unpack_snorm4x8_to_float(i32 noundef %0) local_unnamed_addr #1 {
  %2 = tail call fast <4 x float> @air.unpack.snorm4x8.v4f32(i32 %0) #5
  ret <4 x float> %2
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define <2 x float> @probe_p05_unpack_unorm2x16_to_float(i32 noundef %0) local_unnamed_addr #0 {
  %2 = tail call fast <2 x float> @air.unpack.unorm2x16.v2f32(i32 %0) #5
  ret <2 x float> %2
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define <4 x float> @probe_p05_unpack_unorm4x8_to_float(i32 noundef %0) local_unnamed_addr #1 {
  %2 = tail call fast <4 x float> @air.unpack.unorm4x8.v4f32(i32 %0) #5
  ret <4 x float> %2
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define <4 x float> @probe_p05_unpack_unorm4x8_srgb_to_float(i32 noundef %0) local_unnamed_addr #1 {
  %2 = tail call fast <4 x float> @air.unpack.unorm4x8.srgb.v4f32(i32 %0) #5
  ret <4 x float> %2
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define <4 x float> @probe_p05_unpack_unorm10a2_to_float(i32 noundef %0) local_unnamed_addr #1 {
  %2 = tail call fast <4 x float> @air.unpack.unorm.rgb10a2.v4f32(i32 %0) #5
  ret <4 x float> %2
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define <3 x float> @probe_p05_unpack_unorm565_to_float(i16 noundef zeroext %0) local_unnamed_addr #2 {
  %2 = tail call fast <3 x float> @air.unpack.unorm.rgb565.v3f32(i16 %0) #5
  ret <3 x float> %2
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare i32 @air.pack.snorm2x16.v2f32(<2 x float>) local_unnamed_addr #4

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare i32 @air.pack.snorm4x8.v4f32(<4 x float>) local_unnamed_addr #4

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare i32 @air.pack.unorm2x16.v2f32(<2 x float>) local_unnamed_addr #4

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare i32 @air.pack.unorm4x8.v4f32(<4 x float>) local_unnamed_addr #4

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare i32 @air.pack.unorm4x8.srgb.v4f32(<4 x float>) local_unnamed_addr #4

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare i32 @air.pack.unorm.rgb10a2.v4f32(<4 x float>) local_unnamed_addr #4

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare i16 @air.pack.unorm.rgb565.v3f32(<3 x float>) local_unnamed_addr #4

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare float @air.fast_saturate.f32(float) local_unnamed_addr #4

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare <2 x float> @air.unpack.snorm2x16.v2f32(i32) local_unnamed_addr #4

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare <4 x float> @air.unpack.snorm4x8.v4f32(i32) local_unnamed_addr #4

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare <2 x float> @air.unpack.unorm2x16.v2f32(i32) local_unnamed_addr #4

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare <4 x float> @air.unpack.unorm4x8.v4f32(i32) local_unnamed_addr #4

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare <4 x float> @air.unpack.unorm4x8.srgb.v4f32(i32) local_unnamed_addr #4

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare <4 x float> @air.unpack.unorm.rgb10a2.v4f32(i32) local_unnamed_addr #4

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare <3 x float> @air.unpack.unorm.rgb565.v3f32(i16) local_unnamed_addr #4

attributes #0 = { mustprogress nofree nosync nounwind readnone willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="64" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #1 = { mustprogress nofree nosync nounwind readnone willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="128" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #2 = { mustprogress nofree nosync nounwind readnone willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="96" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #3 = { mustprogress nofree nosync nounwind readnone willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #4 = { mustprogress nofree nosync nounwind readnone willreturn }
attributes #5 = { nounwind readnone willreturn }

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
!15 = !{!"/Users/runner/metal_probe/probe_scenes/scene_P05_convert/probe.metal"}
