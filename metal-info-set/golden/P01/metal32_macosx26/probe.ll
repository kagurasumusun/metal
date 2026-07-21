; ModuleID = 'probe_scenes/scene_P01_kernel_meta/probe.metal'
source_filename = "probe_scenes/scene_P01_kernel_meta/probe.metal"
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-n8:16:32"
target triple = "air64_v28-apple-macosx26.0.0"

%struct.Params = type { <4 x float>, i32, [12 x i8] }
%struct._texture_2d_t = type opaque
%struct._sampler_t = type opaque

; Function Attrs: convergent mustprogress nounwind willreturn
define void @probe_p01_kernel(float addrspace(1)* nocapture noundef "air-buffer-no-alias" %0, %struct.Params addrspace(2)* nocapture noundef readonly align 16 dereferenceable(32) "air-buffer-no-alias" %1, %struct._texture_2d_t addrspace(1)* %2, %struct._sampler_t addrspace(2)* nocapture readonly %3, float addrspace(3)* nocapture noundef "air-buffer-no-alias" %4, i32 noundef %5) local_unnamed_addr #0 {
  %7 = and i32 %5, 1023
  %8 = zext i32 %5 to i64
  %9 = getelementptr inbounds float, float addrspace(1)* %0, i64 %8
  %10 = load float, float addrspace(1)* %9, align 4, !tbaa !26, !alias.scope !30, !noalias !33
  %11 = getelementptr inbounds %struct.Params, %struct.Params addrspace(2)* %1, i64 0, i32 0
  %12 = load <4 x float>, <4 x float> addrspace(2)* %11, align 16, !alias.scope !38, !noalias !39
  %13 = extractelement <4 x float> %12, i64 0
  %14 = fmul fast float %13, %10
  %15 = tail call { <4 x float>, i8 } @air.sample_texture_2d.v4f32(%struct._texture_2d_t addrspace(1)* nocapture readonly %2, %struct._sampler_t addrspace(2)* nocapture readonly %3, <2 x float> <float 5.000000e-01, float 5.000000e-01>, i1 true, <2 x i32> zeroinitializer, i1 false, float 0.000000e+00, float 0.000000e+00, i32 0) #3, !alias.scope !40, !noalias !41
  %16 = extractvalue { <4 x float>, i8 } %15, 0
  %17 = extractelement <4 x float> %16, i64 0
  %18 = fadd fast float %17, %14
  %19 = zext i32 %7 to i64
  %20 = getelementptr inbounds float, float addrspace(3)* %4, i64 %19
  store float %18, float addrspace(3)* %20, align 4, !tbaa !26, !alias.scope !42, !noalias !43
  tail call void @air.wg.barrier(i32 2, i32 1) #4
  %21 = icmp eq i32 %7, 0
  br i1 %21, label %22, label %25

22:                                               ; preds = %6
  %23 = getelementptr inbounds float, float addrspace(3)* %4, i64 1023
  %24 = load float, float addrspace(3)* %23, align 4, !tbaa !26, !alias.scope !42, !noalias !43
  store float %24, float addrspace(1)* %9, align 4, !tbaa !26, !alias.scope !30, !noalias !33
  br label %25

25:                                               ; preds = %22, %6
  ret void
}

; Function Attrs: convergent mustprogress nounwind willreturn
declare void @air.wg.barrier(i32, i32) local_unnamed_addr #1

; Function Attrs: argmemonly convergent mustprogress nofree nounwind readonly willreturn
declare { <4 x float>, i8 } @air.sample_texture_2d.v4f32(%struct._texture_2d_t addrspace(1)* nocapture readonly, %struct._sampler_t addrspace(2)* nocapture readonly, <2 x float>, i1, <2 x i32>, i1, float, float, i32) local_unnamed_addr #2

attributes #0 = { convergent mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="128" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #1 = { convergent mustprogress nounwind willreturn }
attributes #2 = { argmemonly convergent mustprogress nofree nounwind readonly willreturn }
attributes #3 = { argmemonly convergent nounwind readonly willreturn }
attributes #4 = { convergent nounwind willreturn }

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5, !6, !7, !8}
!air.kernel = !{!9}
!air.compile_options = !{!19, !20, !21}
!llvm.ident = !{!22}
!air.version = !{!23}
!air.language_version = !{!24}
!air.source_file_name = !{!25}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 26, i32 5]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"frame-pointer", i32 2}
!3 = !{i32 7, !"air.max_device_buffers", i32 31}
!4 = !{i32 7, !"air.max_constant_buffers", i32 31}
!5 = !{i32 7, !"air.max_threadgroup_buffers", i32 31}
!6 = !{i32 7, !"air.max_textures", i32 128}
!7 = !{i32 7, !"air.max_read_write_textures", i32 8}
!8 = !{i32 7, !"air.max_samplers", i32 16}
!9 = !{void (float addrspace(1)*, %struct.Params addrspace(2)*, %struct._texture_2d_t addrspace(1)*, %struct._sampler_t addrspace(2)*, float addrspace(3)*, i32)* @probe_p01_kernel, !10, !11}
!10 = !{}
!11 = !{!12, !13, !15, !16, !17, !18}
!12 = !{i32 0, !"air.buffer", !"air.location_index", i32 0, i32 1, !"air.read_write", !"air.address_space", i32 1, !"air.arg_type_size", i32 4, !"air.arg_type_align_size", i32 4, !"air.arg_type_name", !"float", !"air.arg_name", !"b"}
!13 = !{i32 1, !"air.buffer", !"air.buffer_size", i32 32, !"air.location_index", i32 1, i32 1, !"air.read", !"air.address_space", i32 2, !"air.struct_type_info", !14, !"air.arg_type_size", i32 32, !"air.arg_type_align_size", i32 16, !"air.arg_type_name", !"Params", !"air.arg_name", !"p"}
!14 = !{i32 0, i32 16, i32 0, !"float4", !"scale", i32 16, i32 4, i32 0, !"uint", !"mode"}
!15 = !{i32 2, !"air.texture", !"air.location_index", i32 0, i32 1, !"air.sample", !"air.arg_type_name", !"texture2d<float, sample>", !"air.arg_name", !"t"}
!16 = !{i32 3, !"air.sampler", !"air.location_index", i32 0, i32 1, !"air.arg_type_name", !"sampler", !"air.arg_name", !"s"}
!17 = !{i32 4, !"air.buffer", !"air.location_index", i32 0, i32 1, !"air.read_write", !"air.address_space", i32 3, !"air.arg_type_size", i32 4, !"air.arg_type_align_size", i32 4, !"air.arg_type_name", !"float", !"air.arg_name", !"shm"}
!18 = !{i32 5, !"air.thread_position_in_grid", !"air.arg_type_name", !"uint", !"air.arg_name", !"i"}
!19 = !{!"air.compile.denorms_disable"}
!20 = !{!"air.compile.fast_math_enable"}
!21 = !{!"air.compile.framebuffer_fetch_enable"}
!22 = !{!"Apple metal version 32023.883 (metalfe-32023.883)"}
!23 = !{i32 2, i32 8, i32 0}
!24 = !{!"Metal", i32 3, i32 2, i32 0}
!25 = !{!"/Users/runner/metal_probe/probe_scenes/scene_P01_kernel_meta/probe.metal"}
!26 = !{!27, !27, i64 0}
!27 = !{!"float", !28, i64 0}
!28 = !{!"omnipotent char", !29, i64 0}
!29 = !{!"Simple C++ TBAA"}
!30 = !{!31}
!31 = distinct !{!31, !32, !"air-alias-scope-arg(0)"}
!32 = distinct !{!32, !"air-alias-scopes(probe_p01_kernel)"}
!33 = !{!34, !35, !36, !37}
!34 = distinct !{!34, !32, !"air-alias-scope-arg(1)"}
!35 = distinct !{!35, !32, !"air-alias-scope-textures"}
!36 = distinct !{!36, !32, !"air-alias-scope-samplers"}
!37 = distinct !{!37, !32, !"air-alias-scope-arg(4)"}
!38 = !{!34}
!39 = !{!31, !35, !36, !37}
!40 = !{!35, !36}
!41 = !{!31, !34, !37}
!42 = !{!37}
!43 = !{!31, !34, !35, !36}
