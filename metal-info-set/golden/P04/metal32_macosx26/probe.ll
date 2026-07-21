; ModuleID = 'probe_scenes/scene_P04_integer/probe.metal'
source_filename = "probe_scenes/scene_P04_integer/probe.metal"
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-n8:16:32"
target triple = "air64_v28-apple-macosx26.0.0"

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define zeroext i8 @probe_p04_absdiff(i8 noundef signext %0, i8 noundef signext %1) local_unnamed_addr #0 {
  %3 = tail call i8 @air.abs_diff.s.i8(i8 %0, i8 %1) #2
  ret i8 %3
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define signext i8 @probe_p04_addsat(i8 noundef signext %0, i8 noundef signext %1) local_unnamed_addr #0 {
  %3 = tail call i8 @air.add_sat.s.i8(i8 %0, i8 %1) #2
  ret i8 %3
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define signext i8 @probe_p04_extract_bits(i8 noundef signext %0, i32 noundef %1, i32 noundef %2) local_unnamed_addr #0 {
  %4 = tail call i8 @air.extract_bits.s.i8(i8 %0, i32 %1, i32 %2) #2
  ret i8 %4
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define signext i8 @probe_p04_insert_bits(i8 noundef signext %0, i8 noundef signext %1, i32 noundef %2, i32 noundef %3) local_unnamed_addr #0 {
  %5 = tail call i8 @air.insert_bits.s.i8(i8 %0, i8 %1, i32 %2, i32 %3) #2
  ret i8 %5
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define signext i8 @probe_p04_madhi(i8 noundef signext %0, i8 noundef signext %1, i8 noundef signext %2) local_unnamed_addr #0 {
  %4 = tail call i8 @air.mad_hi.s.i8(i8 %0, i8 %1, i8 %2) #2
  ret i8 %4
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define signext i8 @probe_p04_madsat(i8 noundef signext %0, i8 noundef signext %1, i8 noundef signext %2) local_unnamed_addr #0 {
  %4 = tail call i8 @air.mad_sat.s.i8(i8 %0, i8 %1, i8 %2) #2
  ret i8 %4
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define signext i8 @probe_p04_max3(i8 noundef signext %0, i8 noundef signext %1, i8 noundef signext %2) local_unnamed_addr #0 {
  %4 = tail call i8 @air.max3.s.i8(i8 %0, i8 %1, i8 %2) #2
  ret i8 %4
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define signext i8 @probe_p04_median3(i8 noundef signext %0, i8 noundef signext %1, i8 noundef signext %2) local_unnamed_addr #0 {
  %4 = tail call i8 @air.median3.s.i8(i8 %0, i8 %1, i8 %2) #2
  ret i8 %4
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define signext i8 @probe_p04_min3(i8 noundef signext %0, i8 noundef signext %1, i8 noundef signext %2) local_unnamed_addr #0 {
  %4 = tail call i8 @air.min3.s.i8(i8 %0, i8 %1, i8 %2) #2
  ret i8 %4
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define signext i8 @probe_p04_mulhi(i8 noundef signext %0, i8 noundef signext %1) local_unnamed_addr #0 {
  %3 = tail call i8 @air.mul_hi.s.i8(i8 %0, i8 %1) #2
  ret i8 %3
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define signext i8 @probe_p04_reverse_bits(i8 noundef signext %0) local_unnamed_addr #0 {
  %2 = tail call i8 @air.reverse_bits.i8(i8 %0) #2
  ret i8 %2
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define signext i8 @probe_p04_subsat(i8 noundef signext %0, i8 noundef signext %1) local_unnamed_addr #0 {
  %3 = tail call i8 @air.sub_sat.s.i8(i8 %0, i8 %1) #2
  ret i8 %3
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare i8 @air.abs_diff.s.i8(i8, i8) local_unnamed_addr #1

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare i8 @air.add_sat.s.i8(i8, i8) local_unnamed_addr #1

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare i8 @air.extract_bits.s.i8(i8, i32, i32) local_unnamed_addr #1

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare i8 @air.insert_bits.s.i8(i8, i8, i32, i32) local_unnamed_addr #1

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare i8 @air.mad_hi.s.i8(i8, i8, i8) local_unnamed_addr #1

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare i8 @air.mad_sat.s.i8(i8, i8, i8) local_unnamed_addr #1

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare i8 @air.max3.s.i8(i8, i8, i8) local_unnamed_addr #1

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare i8 @air.median3.s.i8(i8, i8, i8) local_unnamed_addr #1

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare i8 @air.min3.s.i8(i8, i8, i8) local_unnamed_addr #1

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare i8 @air.mul_hi.s.i8(i8, i8) local_unnamed_addr #1

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare i8 @air.reverse_bits.i8(i8) local_unnamed_addr #1

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare i8 @air.sub_sat.s.i8(i8, i8) local_unnamed_addr #1

attributes #0 = { mustprogress nofree nosync nounwind readnone willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #1 = { mustprogress nofree nosync nounwind readnone willreturn }
attributes #2 = { nounwind readnone willreturn }

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
!15 = !{!"/Users/runner/metal_probe/probe_scenes/scene_P04_integer/probe.metal"}
