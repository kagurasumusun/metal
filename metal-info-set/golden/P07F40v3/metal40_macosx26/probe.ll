; ModuleID = 'probe.metal'
source_filename = "probe.metal"
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-n8:16:32"
target triple = "air64_v28-apple-macosx26.0.0"

%"struct.metal::_atomic" = type { i32 }

; Function Attrs: mustprogress nounwind willreturn
define zeroext i1 @probe_p07f_atomic_compare_exchange_weak_explicit_0(%"struct.metal::_atomic" addrspace(1)* nocapture noundef %0) local_unnamed_addr #0 {
  %2 = alloca i32, align 4
  %3 = bitcast i32* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %3) #6
  store i32 0, i32* %2, align 4, !tbaa !16
  %4 = getelementptr inbounds %"struct.metal::_atomic", %"struct.metal::_atomic" addrspace(1)* %0, i64 0, i32 0
  %5 = call i32 @air.atomic.global.cmpxchg.weak.i32(i32 addrspace(1)* nocapture %4, i32* nocapture nonnull %2, i32 0, i32 0, i32 0, i32 2, i1 true) #7
  %6 = icmp eq i32 %5, 0
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %3) #6
  ret i1 %6
}

; Function Attrs: argmemonly mustprogress nocallback nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: argmemonly mustprogress nocallback nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: mustprogress nounwind willreturn
define i32 @probe_p07f_atomic_exchange_explicit_1(%"struct.metal::_atomic" addrspace(1)* nocapture noundef %0) local_unnamed_addr #0 {
  %2 = getelementptr inbounds %"struct.metal::_atomic", %"struct.metal::_atomic" addrspace(1)* %0, i64 0, i32 0
  %3 = tail call i32 @air.atomic.global.xchg.i32(i32 addrspace(1)* nocapture %2, i32 0, i32 0, i32 2, i1 true) #7
  ret i32 %3
}

; Function Attrs: mustprogress nounwind willreturn
define i32 @probe_p07f_atomic_fetch_add_explicit_2(%"struct.metal::_atomic" addrspace(1)* nocapture noundef %0) local_unnamed_addr #0 {
  %2 = getelementptr inbounds %"struct.metal::_atomic", %"struct.metal::_atomic" addrspace(1)* %0, i64 0, i32 0
  %3 = tail call i32 @air.atomic.global.add.s.i32(i32 addrspace(1)* nocapture %2, i32 0, i32 0, i32 2, i1 true) #7
  ret i32 %3
}

; Function Attrs: mustprogress nounwind willreturn
define i32 @probe_p07f_atomic_fetch_and_explicit_3(%"struct.metal::_atomic" addrspace(1)* nocapture noundef %0) local_unnamed_addr #0 {
  %2 = getelementptr inbounds %"struct.metal::_atomic", %"struct.metal::_atomic" addrspace(1)* %0, i64 0, i32 0
  %3 = tail call i32 @air.atomic.global.and.s.i32(i32 addrspace(1)* nocapture %2, i32 0, i32 0, i32 2, i1 true) #7
  ret i32 %3
}

; Function Attrs: mustprogress nounwind willreturn
define i32 @probe_p07f_atomic_fetch_max_explicit_4(%"struct.metal::_atomic" addrspace(1)* nocapture noundef %0) local_unnamed_addr #0 {
  %2 = getelementptr inbounds %"struct.metal::_atomic", %"struct.metal::_atomic" addrspace(1)* %0, i64 0, i32 0
  %3 = tail call i32 @air.atomic.global.max.s.i32(i32 addrspace(1)* nocapture %2, i32 0, i32 0, i32 2, i1 true) #7
  ret i32 %3
}

; Function Attrs: mustprogress nounwind willreturn
define i32 @probe_p07f_atomic_fetch_min_explicit_5(%"struct.metal::_atomic" addrspace(1)* nocapture noundef %0) local_unnamed_addr #0 {
  %2 = getelementptr inbounds %"struct.metal::_atomic", %"struct.metal::_atomic" addrspace(1)* %0, i64 0, i32 0
  %3 = tail call i32 @air.atomic.global.min.s.i32(i32 addrspace(1)* nocapture %2, i32 0, i32 0, i32 2, i1 true) #7
  ret i32 %3
}

; Function Attrs: mustprogress nounwind willreturn
define i32 @probe_p07f_atomic_fetch_or_explicit_6(%"struct.metal::_atomic" addrspace(1)* nocapture noundef %0) local_unnamed_addr #0 {
  %2 = getelementptr inbounds %"struct.metal::_atomic", %"struct.metal::_atomic" addrspace(1)* %0, i64 0, i32 0
  %3 = tail call i32 @air.atomic.global.or.s.i32(i32 addrspace(1)* nocapture %2, i32 0, i32 0, i32 2, i1 true) #7
  ret i32 %3
}

; Function Attrs: mustprogress nounwind willreturn
define i32 @probe_p07f_atomic_fetch_sub_explicit_7(%"struct.metal::_atomic" addrspace(1)* nocapture noundef %0) local_unnamed_addr #0 {
  %2 = getelementptr inbounds %"struct.metal::_atomic", %"struct.metal::_atomic" addrspace(1)* %0, i64 0, i32 0
  %3 = tail call i32 @air.atomic.global.sub.s.i32(i32 addrspace(1)* nocapture %2, i32 0, i32 0, i32 2, i1 true) #7
  ret i32 %3
}

; Function Attrs: mustprogress nounwind willreturn
define i32 @probe_p07f_atomic_fetch_xor_explicit_8(%"struct.metal::_atomic" addrspace(1)* nocapture noundef %0) local_unnamed_addr #0 {
  %2 = getelementptr inbounds %"struct.metal::_atomic", %"struct.metal::_atomic" addrspace(1)* %0, i64 0, i32 0
  %3 = tail call i32 @air.atomic.global.xor.s.i32(i32 addrspace(1)* nocapture %2, i32 0, i32 0, i32 2, i1 true) #7
  ret i32 %3
}

; Function Attrs: mustprogress nounwind willreturn
define i32 @probe_p07f_atomic_load_explicit_9(%"struct.metal::_atomic" addrspace(1)* nocapture noundef %0) local_unnamed_addr #0 {
  %2 = getelementptr inbounds %"struct.metal::_atomic", %"struct.metal::_atomic" addrspace(1)* %0, i64 0, i32 0
  %3 = tail call i32 @air.atomic.global.load.i32(i32 addrspace(1)* nocapture %2, i32 0, i32 2, i1 true) #7
  ret i32 %3
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p07f_atomic_store_explicit_12(%"struct.metal::_atomic" addrspace(1)* nocapture noundef %0) local_unnamed_addr #0 {
  %2 = getelementptr inbounds %"struct.metal::_atomic", %"struct.metal::_atomic" addrspace(1)* %0, i64 0, i32 0
  tail call void @air.atomic.global.store.i32(i32 addrspace(1)* nocapture %2, i32 0, i32 0, i32 2, i1 true) #7
  ret void
}

; Function Attrs: convergent mustprogress nounwind
define float @probe_p07f_frexp_13() local_unnamed_addr #2 {
  %1 = alloca i32, align 4
  %2 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %2) #6
  store i32 0, i32* %1, align 4, !tbaa !16
  %3 = call fast float @___metal_frexp_float_pthreadint32(float 1.000000e+00, i32* nonnull %1) #8
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %2) #6
  ret float %3
}

; Function Attrs: convergent mustprogress nounwind
define i32 @probe_p07f_ilogb_17() local_unnamed_addr #2 {
  %1 = tail call i32 @___metal_ilogb_float(float 1.000000e+00, i32 0) #8
  ret i32 %1
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define float @probe_p07f_fdim_22() local_unnamed_addr #3 {
  ret float 0.000000e+00
}

; Function Attrs: convergent
declare float @___metal_frexp_float_pthreadint32(float, i32*) local_unnamed_addr #4

; Function Attrs: convergent
declare i32 @___metal_ilogb_float(float, i32) local_unnamed_addr #4

; Function Attrs: mustprogress nounwind willreturn
declare i32 @air.atomic.global.cmpxchg.weak.i32(i32 addrspace(1)* nocapture, i32* nocapture, i32, i32, i32, i32, i1) local_unnamed_addr #5

; Function Attrs: mustprogress nounwind willreturn
declare i32 @air.atomic.global.xchg.i32(i32 addrspace(1)* nocapture, i32, i32, i32, i1) local_unnamed_addr #5

; Function Attrs: mustprogress nounwind willreturn
declare i32 @air.atomic.global.add.s.i32(i32 addrspace(1)* nocapture, i32, i32, i32, i1) local_unnamed_addr #5

; Function Attrs: mustprogress nounwind willreturn
declare i32 @air.atomic.global.and.s.i32(i32 addrspace(1)* nocapture, i32, i32, i32, i1) local_unnamed_addr #5

; Function Attrs: mustprogress nounwind willreturn
declare i32 @air.atomic.global.max.s.i32(i32 addrspace(1)* nocapture, i32, i32, i32, i1) local_unnamed_addr #5

; Function Attrs: mustprogress nounwind willreturn
declare i32 @air.atomic.global.min.s.i32(i32 addrspace(1)* nocapture, i32, i32, i32, i1) local_unnamed_addr #5

; Function Attrs: mustprogress nounwind willreturn
declare i32 @air.atomic.global.or.s.i32(i32 addrspace(1)* nocapture, i32, i32, i32, i1) local_unnamed_addr #5

; Function Attrs: mustprogress nounwind willreturn
declare i32 @air.atomic.global.sub.s.i32(i32 addrspace(1)* nocapture, i32, i32, i32, i1) local_unnamed_addr #5

; Function Attrs: mustprogress nounwind willreturn
declare i32 @air.atomic.global.xor.s.i32(i32 addrspace(1)* nocapture, i32, i32, i32, i1) local_unnamed_addr #5

; Function Attrs: mustprogress nounwind willreturn
declare i32 @air.atomic.global.load.i32(i32 addrspace(1)* nocapture, i32, i32, i1) local_unnamed_addr #5

; Function Attrs: mustprogress nounwind willreturn
declare void @air.atomic.global.store.i32(i32 addrspace(1)* nocapture, i32, i32, i32, i1) local_unnamed_addr #5

attributes #0 = { mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #1 = { argmemonly mustprogress nocallback nofree nosync nounwind willreturn }
attributes #2 = { convergent mustprogress nounwind "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #3 = { mustprogress nofree norecurse nosync nounwind readnone willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" }
attributes #4 = { convergent }
attributes #5 = { mustprogress nounwind willreturn }
attributes #6 = { nounwind }
attributes #7 = { nounwind willreturn }
attributes #8 = { convergent nounwind }

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
!15 = !{!"/Users/runner/metal_probe/p6/P07F/probe.metal"}
!16 = !{!17, !17, i64 0}
!17 = !{!"int", !18, i64 0}
!18 = !{!"omnipotent char", !19, i64 0}
!19 = !{!"Simple C++ TBAA"}
