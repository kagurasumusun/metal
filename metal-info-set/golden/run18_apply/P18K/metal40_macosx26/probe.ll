; ModuleID = 'probe.metal'
source_filename = "probe.metal"
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-n8:16:32"
target triple = "air64_v28-apple-macosx26.0.0"

%struct._mesh_t = type opaque
%struct._mesh_grid_properties_t = type opaque
%struct._vertex_value_t = type opaque

; Function Attrs: argmemonly mustprogress nounwind willreturn
define void @probe_p18k_set_index(%struct._mesh_t addrspace(7)* nocapture %0) local_unnamed_addr #0 {
  tail call void @air.set_index_mesh(%struct._mesh_t addrspace(7)* nocapture %0, i32 0, i8 0) #7
  ret void
}

; Function Attrs: argmemonly mustprogress nounwind willreturn
define void @probe_p18k_set_indices(%struct._mesh_t addrspace(7)* nocapture %0) local_unnamed_addr #1 {
  tail call void @air.set_indices_mesh.v4i8(%struct._mesh_t addrspace(7)* nocapture %0, i32 0, <4 x i8> zeroinitializer) #7
  ret void
}

; Function Attrs: argmemonly mustprogress nounwind willreturn
define void @probe_p18k_set_primcount(%struct._mesh_t addrspace(7)* nocapture %0) local_unnamed_addr #0 {
  tail call void @air.set_primitive_count_mesh(%struct._mesh_t addrspace(7)* nocapture %0, i32 1) #7
  ret void
}

; Function Attrs: argmemonly mustprogress nounwind willreturn
define void @probe_p18k_set_vertex(%struct._mesh_t addrspace(7)* nocapture %0) local_unnamed_addr #2 {
  tail call void @air.set_position_mesh(%struct._mesh_t addrspace(7)* nocapture %0, i32 0, <4 x float> zeroinitializer) #7
  ret void
}

; Function Attrs: argmemonly mustprogress nounwind willreturn
define void @probe_p18k_set_prim(%struct._mesh_t addrspace(7)* nocapture %0) local_unnamed_addr #0 {
  tail call void @air.set_primitive_id_mesh(%struct._mesh_t addrspace(7)* nocapture %0, i32 0, i32 0) #7
  ret void
}

; Function Attrs: argmemonly mustprogress nounwind willreturn
define void @probe_p18k_mgp(%struct._mesh_grid_properties_t addrspace(3)* nocapture %0) local_unnamed_addr #3 {
  tail call void @air.set_threadgroups_per_grid_mesh_properties(%struct._mesh_grid_properties_t addrspace(3)* nocapture %0, <3 x i32> <i32 1, i32 1, i32 1>) #7
  ret void
}

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
define <4 x float> @probe_p18k_vv(%struct._vertex_value_t addrspace(1)* nocapture readonly %0) local_unnamed_addr #4 {
  %2 = tail call fast float @air.get_vertex_value.f32(%struct._vertex_value_t addrspace(1)* nocapture readonly %0, i32 0) #8, !alias.scope !37
  %3 = insertelement <4 x float> poison, float %2, i64 0
  %4 = shufflevector <4 x float> %3, <4 x float> poison, <4 x i32> zeroinitializer
  ret <4 x float> %4
}

; Function Attrs: argmemonly mustprogress nounwind willreturn
declare void @air.set_threadgroups_per_grid_mesh_properties(%struct._mesh_grid_properties_t addrspace(3)* nocapture, <3 x i32>) local_unnamed_addr #5

; Function Attrs: argmemonly mustprogress nounwind willreturn
declare void @air.set_index_mesh(%struct._mesh_t addrspace(7)* nocapture, i32, i8) local_unnamed_addr #5

; Function Attrs: argmemonly mustprogress nounwind willreturn
declare void @air.set_indices_mesh.v4i8(%struct._mesh_t addrspace(7)* nocapture, i32, <4 x i8>) local_unnamed_addr #5

; Function Attrs: argmemonly mustprogress nounwind willreturn
declare void @air.set_primitive_count_mesh(%struct._mesh_t addrspace(7)* nocapture, i32) local_unnamed_addr #5

; Function Attrs: argmemonly mustprogress nounwind willreturn
declare void @air.set_position_mesh(%struct._mesh_t addrspace(7)* nocapture, i32, <4 x float>) local_unnamed_addr #5

; Function Attrs: argmemonly mustprogress nounwind willreturn
declare void @air.set_primitive_id_mesh(%struct._mesh_t addrspace(7)* nocapture, i32, i32) local_unnamed_addr #5

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare float @air.get_vertex_value.f32(%struct._vertex_value_t addrspace(1)* nocapture readonly, i32) local_unnamed_addr #6

attributes #0 = { argmemonly mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #1 = { argmemonly mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="32" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #2 = { argmemonly mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="128" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #3 = { argmemonly mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="96" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #4 = { argmemonly mustprogress nofree nounwind readonly willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="128" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #5 = { argmemonly mustprogress nounwind willreturn }
attributes #6 = { argmemonly mustprogress nofree nounwind readonly willreturn }
attributes #7 = { argmemonly nounwind willreturn }
attributes #8 = { argmemonly nounwind readonly willreturn }

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5, !6, !7, !8}
!air.mesh = !{!9, !18, !19, !20, !21}
!air.object = !{!22}
!air.fragment = !{!25}
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
!9 = !{void (%struct._mesh_t addrspace(7)*)* @probe_p18k_set_index, !10, !11}
!10 = !{}
!11 = !{!12}
!12 = !{i32 0, !"air.mesh", !13, !"air.arg_type_name", !"mesh<MeshV, MeshP, 8, 4, triangle>", !"air.arg_name", !"__m"}
!13 = !{!"air.mesh_type_info", !14, !16, i32 8, i32 4, !"air.triangle"}
!14 = !{!15}
!15 = !{!"air.position", !"air.arg_type_name", !"float4", !"air.arg_name", !"position"}
!16 = !{!17}
!17 = !{!"air.primitive_id", !"air.arg_type_name", !"uint", !"air.arg_name", !"primid"}
!18 = !{void (%struct._mesh_t addrspace(7)*)* @probe_p18k_set_indices, !10, !11}
!19 = !{void (%struct._mesh_t addrspace(7)*)* @probe_p18k_set_primcount, !10, !11}
!20 = !{void (%struct._mesh_t addrspace(7)*)* @probe_p18k_set_vertex, !10, !11}
!21 = !{void (%struct._mesh_t addrspace(7)*)* @probe_p18k_set_prim, !10, !11}
!22 = !{void (%struct._mesh_grid_properties_t addrspace(3)*)* @probe_p18k_mgp, !10, !23}
!23 = !{!24}
!24 = !{i32 0, !"air.mesh_grid_properties", !"air.arg_type_name", !"mesh_grid_properties", !"air.arg_name", !"__gp"}
!25 = !{<4 x float> (%struct._vertex_value_t addrspace(1)*)* @probe_p18k_vv, !26, !28}
!26 = !{!27}
!27 = !{!"air.render_target", i32 0, i32 0, !"air.arg_type_name", !"float4"}
!28 = !{!29}
!29 = !{i32 0, !"air.fragment_input", !"generated(4__vvf)", !"air.vertex_value", !"air.arg_type_name", !"float", !"air.arg_name", !"__vv"}
!30 = !{!"air.compile.denorms_disable"}
!31 = !{!"air.compile.fast_math_enable"}
!32 = !{!"air.compile.framebuffer_fetch_enable"}
!33 = !{!"Apple metal version 32023.883 (metalfe-32023.883)"}
!34 = !{i32 2, i32 8, i32 0}
!35 = !{!"Metal", i32 4, i32 0, i32 0}
!36 = !{!"/Users/runner/metal_probe/p18/P18K/probe.metal"}
!37 = !{!38}
!38 = distinct !{!38, !39, !"air-alias-scope-arg(0)"}
!39 = distinct !{!39, !"air-alias-scopes(probe_p18k_vv)"}
