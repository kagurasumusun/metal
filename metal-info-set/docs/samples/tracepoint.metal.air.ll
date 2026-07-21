source_filename = "/AppleInternal/Library/BuildRoots/4~CNlHugDNtO_m7KjkKLmRk5uZxVDqkJ9-kVFTx8Y/Library/Caches/com.apple.xbs/TemporaryDirectory.rtt6Ki/Sources/GPUCompiler/clang/runtime/compiler-rt-extra/lib/tracepoint-rt/tracepoint.metal"
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-n8:16:32"
target triple = "air64-apple-macosx10.14.0"

@__tracepoint_library_version = hidden addrspace(2) constant i32 2, align 4
@llvm.used = appending global [1 x ptr] [ptr addrspacecast (ptr addrspace(2) @__tracepoint_library_version to ptr)], section "llvm.metadata"

; Function Attrs: noinline nounwind optsize
define weak hidden <3 x i32> @__tracepoint_get_thread_position_in_grid() local_unnamed_addr #0 {
  ret <3 x i32> zeroinitializer
}

; Function Attrs: noinline nounwind optsize
define weak hidden i32 @__tracepoint_get_vertex_id() local_unnamed_addr #1 {
  ret i32 0
}

; Function Attrs: noinline nounwind optsize
define weak hidden i32 @__tracepoint_get_instance_id() local_unnamed_addr #1 {
  ret i32 0
}

; Function Attrs: noinline nounwind optsize
define weak hidden <4 x float> @__tracepoint_get_position() local_unnamed_addr #2 {
  ret <4 x float> zeroinitializer
}

; Function Attrs: noinline nounwind optsize
define weak hidden i32 @__tracepoint_get_sample_id() local_unnamed_addr #1 {
  ret i32 0
}

; Function Attrs: noinline nounwind optsize
define weak hidden i32 @__tracepoint_get_patch_id() local_unnamed_addr #1 {
  ret i32 0
}

; Function Attrs: noinline nounwind optsize
define weak hidden <3 x float> @__tracepoint_get_position_in_patch() local_unnamed_addr #0 {
  ret <3 x float> zeroinitializer
}

; Function Attrs: noinline nounwind optsize
define weak hidden i32 @__tracepoint_get_amplification_id() local_unnamed_addr #1 {
  ret i32 0
}

; Function Attrs: noinline nounwind optsize
define weak hidden i32 @__tracepoint_get_render_target_array_index() local_unnamed_addr #1 {
  ret i32 0
}

; Function Attrs: noinline nounwind optsize
define weak hidden <3 x i32> @__tracepoint_get_object_threadgroup_position_in_grid() local_unnamed_addr #0 {
  ret <3 x i32> zeroinitializer
}

; Function Attrs: convergent noinline nounwind optsize
define hidden void @__tracepoint_thread(ptr addrspace(2) %0, i32 %1, i32 %2) local_unnamed_addr #3 {
  switch i32 %2, label %25 [
    i32 0, label %4
    i32 1, label %6
    i32 2, label %10
    i32 3, label %14
    i32 4, label %19
    i32 5, label %21
  ]

4:                                                ; preds = %3
  %5 = tail call <3 x i32> @__tracepoint_get_thread_position_in_grid() #5
  tail call void @_Z24kernel_thread_tracepointPU11MTLconstantKjjDv3_j(ptr addrspace(2) %0, i32 %1, <3 x i32> %5) #6
  br label %25

6:                                                ; preds = %3
  %7 = tail call i32 @__tracepoint_get_vertex_id() #5
  %8 = tail call i32 @__tracepoint_get_instance_id() #5
  %9 = tail call i32 @__tracepoint_get_amplification_id() #5
  tail call void @_Z24vertex_thread_tracepointPU11MTLconstantKjjjjj(ptr addrspace(2) %0, i32 %1, i32 %7, i32 %8, i32 %9) #6
  br label %25

10:                                               ; preds = %3
  %11 = tail call fast <4 x float> @__tracepoint_get_position() #5
  %12 = tail call i32 @__tracepoint_get_sample_id() #5
  %13 = tail call i32 @__tracepoint_get_render_target_array_index() #5
  tail call void @_Z26fragment_thread_tracepointPU11MTLconstantKjjDv4_fjj(ptr addrspace(2) %0, i32 %1, <4 x float> %11, i32 %12, i32 %13) #6
  br label %25

14:                                               ; preds = %3
  %15 = tail call i32 @__tracepoint_get_patch_id() #5
  %16 = tail call i32 @__tracepoint_get_instance_id() #5
  %17 = tail call fast <3 x float> @__tracepoint_get_position_in_patch() #5
  %18 = tail call i32 @__tracepoint_get_amplification_id() #5
  tail call void @_Z41post_tesselation_vertex_thread_tracepointPU11MTLconstantKjjjjDv3_fj(ptr addrspace(2) %0, i32 %1, i32 %15, i32 %16, <3 x float> %17, i32 %18) #6
  br label %25

19:                                               ; preds = %3
  %20 = tail call <3 x i32> @__tracepoint_get_thread_position_in_grid() #5
  tail call void @_Z24object_thread_tracepointPU11MTLconstantKjjDv3_j(ptr addrspace(2) %0, i32 %1, <3 x i32> %20) #6
  br label %25

21:                                               ; preds = %3
  %22 = tail call <3 x i32> @__tracepoint_get_thread_position_in_grid() #5
  %23 = tail call <3 x i32> @__tracepoint_get_object_threadgroup_position_in_grid() #5
  %24 = tail call i32 @__tracepoint_get_amplification_id() #5
  tail call void @_Z22mesh_thread_tracepointPU11MTLconstantKjjDv3_jS1_j(ptr addrspace(2) %0, i32 %1, <3 x i32> %22, <3 x i32> %23, i32 %24) #6
  br label %25

25:                                               ; preds = %21, %19, %14, %10, %6, %4, %3
  ret void
}

; Function Attrs: convergent optsize
declare void @_Z24kernel_thread_tracepointPU11MTLconstantKjjDv3_j(ptr addrspace(2), i32, <3 x i32>) local_unnamed_addr #4

; Function Attrs: convergent optsize
declare void @_Z24vertex_thread_tracepointPU11MTLconstantKjjjjj(ptr addrspace(2), i32, i32, i32, i32) local_unnamed_addr #4

; Function Attrs: convergent optsize
declare void @_Z26fragment_thread_tracepointPU11MTLconstantKjjDv4_fjj(ptr addrspace(2), i32, <4 x float>, i32, i32) local_unnamed_addr #4

; Function Attrs: convergent optsize
declare void @_Z41post_tesselation_vertex_thread_tracepointPU11MTLconstantKjjjjDv3_fj(ptr addrspace(2), i32, i32, i32, <3 x float>, i32) local_unnamed_addr #4

; Function Attrs: convergent optsize
declare void @_Z24object_thread_tracepointPU11MTLconstantKjjDv3_j(ptr addrspace(2), i32, <3 x i32>) local_unnamed_addr #4

; Function Attrs: convergent optsize
declare void @_Z22mesh_thread_tracepointPU11MTLconstantKjjDv3_jS1_j(ptr addrspace(2), i32, <3 x i32>, <3 x i32>, i32) local_unnamed_addr #4

attributes #0 = { noinline nounwind optsize "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="96" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #1 = { noinline nounwind optsize "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #2 = { noinline nounwind optsize "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="128" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #3 = { convergent noinline nounwind optsize "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="128" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #4 = { convergent optsize "approx-func-fp-math"="true" "frame-pointer"="all" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #5 = { nobuiltin optsize "no-builtins" }
attributes #6 = { convergent nobuiltin nounwind optsize "no-builtins" }

!llvm.module.flags = !{!0}
!air.compile_options = !{!1, !2, !3}
!llvm.ident = !{!4}
!air.version = !{!5}
!air.language_version = !{!6}
!air.source_file_name = !{!7}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"air.compile.denorms_disable"}
!2 = !{!"air.compile.fast_math_enable"}
!3 = !{!"air.compile.framebuffer_fetch_disable"}
!4 = !{!"Apple metal version 32023.883 (metalfe-32023.883)"}
!5 = !{i32 2, i32 1, i32 0}
!6 = !{!"Metal", i32 2, i32 1, i32 0}
!7 = !{!"/AppleInternal/Library/BuildRoots/4~CNlHugDNtO_m7KjkKLmRk5uZxVDqkJ9-kVFTx8Y/Library/Caches/com.apple.xbs/TemporaryDirectory.rtt6Ki/Sources/GPUCompiler/clang/runtime/compiler-rt-extra/lib/tracepoint-rt/tracepoint.metal"}
