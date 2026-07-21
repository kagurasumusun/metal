; ModuleID = 'probe.metal'
source_filename = "probe.metal"
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-n8:16:32"
target triple = "air64_v28-apple-macosx26.0.0"

%struct._texture_1d_t = type opaque
%struct._texture_1d_array_t = type opaque
%struct._texture_2d_t = type opaque
%struct._texture_2d_array_t = type opaque
%struct._texture_3d_t = type opaque
%struct._texture_buffer_1d_t = type opaque
%struct._texture_cube_t = type opaque
%struct._texture_cube_array_t = type opaque

; Function Attrs: mustprogress nounwind
define void @probe_p26m_1d_max(%struct._texture_1d_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  tail call void @air.atomic_max_explicit_texture_1d.i16.u.v4i64(%struct._texture_1d_t addrspace(1)* nocapture %0, i16 0, <4 x i64> <i64 42, i64 42, i64 42, i64 42>, i32 0, i32 3) #1
  ret void
}

; Function Attrs: mustprogress nounwind
define void @probe_p26m_1d_min(%struct._texture_1d_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  tail call void @air.atomic_min_explicit_texture_1d.i16.u.v4i64(%struct._texture_1d_t addrspace(1)* nocapture %0, i16 0, <4 x i64> <i64 1, i64 1, i64 1, i64 1>, i32 0, i32 3) #1
  ret void
}

; Function Attrs: mustprogress nounwind
define void @probe_p26m_1da_max(%struct._texture_1d_array_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  tail call void @air.atomic_max_explicit_texture_1d_array.i16.u.v4i64(%struct._texture_1d_array_t addrspace(1)* nocapture %0, i16 0, i16 0, <4 x i64> <i64 42, i64 42, i64 42, i64 42>, i32 0, i32 3) #1
  ret void
}

; Function Attrs: mustprogress nounwind
define void @probe_p26m_1da_min(%struct._texture_1d_array_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  tail call void @air.atomic_min_explicit_texture_1d_array.i16.u.v4i64(%struct._texture_1d_array_t addrspace(1)* nocapture %0, i16 0, i16 0, <4 x i64> <i64 1, i64 1, i64 1, i64 1>, i32 0, i32 3) #1
  ret void
}

; Function Attrs: mustprogress nounwind
define void @probe_p26m_2d_max(%struct._texture_2d_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  tail call void @air.atomic_max_explicit_texture_2d.i16.u.v4i64(%struct._texture_2d_t addrspace(1)* nocapture %0, <2 x i16> zeroinitializer, <2 x i16> zeroinitializer, <4 x i64> <i64 42, i64 42, i64 42, i64 42>, i32 0, i32 3) #1
  ret void
}

; Function Attrs: mustprogress nounwind
define void @probe_p26m_2d_min(%struct._texture_2d_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  tail call void @air.atomic_min_explicit_texture_2d.i16.u.v4i64(%struct._texture_2d_t addrspace(1)* nocapture %0, <2 x i16> zeroinitializer, <2 x i16> zeroinitializer, <4 x i64> <i64 1, i64 1, i64 1, i64 1>, i32 0, i32 3) #1
  ret void
}

; Function Attrs: mustprogress nounwind
define void @probe_p26m_2da_max(%struct._texture_2d_array_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  tail call void @air.atomic_max_explicit_texture_2d_array.i16.u.v4i64(%struct._texture_2d_array_t addrspace(1)* nocapture %0, <2 x i16> zeroinitializer, i16 0, <2 x i16> zeroinitializer, <4 x i64> <i64 42, i64 42, i64 42, i64 42>, i32 0, i32 3) #1
  ret void
}

; Function Attrs: mustprogress nounwind
define void @probe_p26m_2da_min(%struct._texture_2d_array_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  tail call void @air.atomic_min_explicit_texture_2d_array.i16.u.v4i64(%struct._texture_2d_array_t addrspace(1)* nocapture %0, <2 x i16> zeroinitializer, i16 0, <2 x i16> zeroinitializer, <4 x i64> <i64 1, i64 1, i64 1, i64 1>, i32 0, i32 3) #1
  ret void
}

; Function Attrs: mustprogress nounwind
define void @probe_p26m_3d_max(%struct._texture_3d_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  tail call void @air.atomic_max_explicit_texture_3d.i16.u.v4i64(%struct._texture_3d_t addrspace(1)* nocapture %0, <3 x i16> zeroinitializer, <3 x i16> zeroinitializer, <4 x i64> <i64 42, i64 42, i64 42, i64 42>, i32 0, i32 3) #1
  ret void
}

; Function Attrs: mustprogress nounwind
define void @probe_p26m_3d_min(%struct._texture_3d_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  tail call void @air.atomic_min_explicit_texture_3d.i16.u.v4i64(%struct._texture_3d_t addrspace(1)* nocapture %0, <3 x i16> zeroinitializer, <3 x i16> zeroinitializer, <4 x i64> <i64 1, i64 1, i64 1, i64 1>, i32 0, i32 3) #1
  ret void
}

; Function Attrs: mustprogress nounwind
define void @probe_p26m_buf1d_max(%struct._texture_buffer_1d_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  tail call void @air.atomic_max_explicit_texture_buffer_1d.i16.u.v4i64(%struct._texture_buffer_1d_t addrspace(1)* nocapture %0, i16 0, <4 x i64> <i64 42, i64 42, i64 42, i64 42>, i32 0, i32 3) #1
  ret void
}

; Function Attrs: mustprogress nounwind
define void @probe_p26m_buf1d_min(%struct._texture_buffer_1d_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  tail call void @air.atomic_min_explicit_texture_buffer_1d.i16.u.v4i64(%struct._texture_buffer_1d_t addrspace(1)* nocapture %0, i16 0, <4 x i64> <i64 1, i64 1, i64 1, i64 1>, i32 0, i32 3) #1
  ret void
}

; Function Attrs: mustprogress nounwind
define void @probe_p26m_cube_max(%struct._texture_cube_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  tail call void @air.atomic_max_explicit_texture_cube.i16.u.v4i64(%struct._texture_cube_t addrspace(1)* nocapture %0, <2 x i16> zeroinitializer, i16 0, <4 x i64> <i64 42, i64 42, i64 42, i64 42>, i32 0, i32 3) #1
  ret void
}

; Function Attrs: mustprogress nounwind
define void @probe_p26m_cube_min(%struct._texture_cube_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  tail call void @air.atomic_min_explicit_texture_cube.i16.u.v4i64(%struct._texture_cube_t addrspace(1)* nocapture %0, <2 x i16> zeroinitializer, i16 0, <4 x i64> <i64 1, i64 1, i64 1, i64 1>, i32 0, i32 3) #1
  ret void
}

; Function Attrs: mustprogress nounwind
define void @probe_p26m_cubearr_max(%struct._texture_cube_array_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  tail call void @air.atomic_max_explicit_texture_cube_array.i16.u.v4i64(%struct._texture_cube_array_t addrspace(1)* nocapture %0, <2 x i16> zeroinitializer, i16 0, i16 0, <4 x i64> <i64 42, i64 42, i64 42, i64 42>, i32 0, i32 3) #1
  ret void
}

; Function Attrs: mustprogress nounwind
define void @probe_p26m_cubearr_min(%struct._texture_cube_array_t addrspace(1)* nocapture %0) local_unnamed_addr #0 {
  tail call void @air.atomic_min_explicit_texture_cube_array.i16.u.v4i64(%struct._texture_cube_array_t addrspace(1)* nocapture %0, <2 x i16> zeroinitializer, i16 0, i16 0, <4 x i64> <i64 1, i64 1, i64 1, i64 1>, i32 0, i32 3) #1
  ret void
}

; Function Attrs: nounwind
declare void @air.atomic_max_explicit_texture_1d.i16.u.v4i64(%struct._texture_1d_t addrspace(1)* nocapture, i16, <4 x i64>, i32, i32) local_unnamed_addr #1

; Function Attrs: nounwind
declare void @air.atomic_min_explicit_texture_1d.i16.u.v4i64(%struct._texture_1d_t addrspace(1)* nocapture, i16, <4 x i64>, i32, i32) local_unnamed_addr #1

; Function Attrs: nounwind
declare void @air.atomic_max_explicit_texture_1d_array.i16.u.v4i64(%struct._texture_1d_array_t addrspace(1)* nocapture, i16, i16, <4 x i64>, i32, i32) local_unnamed_addr #1

; Function Attrs: nounwind
declare void @air.atomic_min_explicit_texture_1d_array.i16.u.v4i64(%struct._texture_1d_array_t addrspace(1)* nocapture, i16, i16, <4 x i64>, i32, i32) local_unnamed_addr #1

; Function Attrs: nounwind
declare void @air.atomic_max_explicit_texture_2d.i16.u.v4i64(%struct._texture_2d_t addrspace(1)* nocapture, <2 x i16>, <2 x i16>, <4 x i64>, i32, i32) local_unnamed_addr #1

; Function Attrs: nounwind
declare void @air.atomic_min_explicit_texture_2d.i16.u.v4i64(%struct._texture_2d_t addrspace(1)* nocapture, <2 x i16>, <2 x i16>, <4 x i64>, i32, i32) local_unnamed_addr #1

; Function Attrs: nounwind
declare void @air.atomic_max_explicit_texture_2d_array.i16.u.v4i64(%struct._texture_2d_array_t addrspace(1)* nocapture, <2 x i16>, i16, <2 x i16>, <4 x i64>, i32, i32) local_unnamed_addr #1

; Function Attrs: nounwind
declare void @air.atomic_min_explicit_texture_2d_array.i16.u.v4i64(%struct._texture_2d_array_t addrspace(1)* nocapture, <2 x i16>, i16, <2 x i16>, <4 x i64>, i32, i32) local_unnamed_addr #1

; Function Attrs: nounwind
declare void @air.atomic_max_explicit_texture_3d.i16.u.v4i64(%struct._texture_3d_t addrspace(1)* nocapture, <3 x i16>, <3 x i16>, <4 x i64>, i32, i32) local_unnamed_addr #1

; Function Attrs: nounwind
declare void @air.atomic_min_explicit_texture_3d.i16.u.v4i64(%struct._texture_3d_t addrspace(1)* nocapture, <3 x i16>, <3 x i16>, <4 x i64>, i32, i32) local_unnamed_addr #1

; Function Attrs: nounwind
declare void @air.atomic_max_explicit_texture_buffer_1d.i16.u.v4i64(%struct._texture_buffer_1d_t addrspace(1)* nocapture, i16, <4 x i64>, i32, i32) local_unnamed_addr #1

; Function Attrs: nounwind
declare void @air.atomic_min_explicit_texture_buffer_1d.i16.u.v4i64(%struct._texture_buffer_1d_t addrspace(1)* nocapture, i16, <4 x i64>, i32, i32) local_unnamed_addr #1

; Function Attrs: nounwind
declare void @air.atomic_max_explicit_texture_cube.i16.u.v4i64(%struct._texture_cube_t addrspace(1)* nocapture, <2 x i16>, i16, <4 x i64>, i32, i32) local_unnamed_addr #1

; Function Attrs: nounwind
declare void @air.atomic_min_explicit_texture_cube.i16.u.v4i64(%struct._texture_cube_t addrspace(1)* nocapture, <2 x i16>, i16, <4 x i64>, i32, i32) local_unnamed_addr #1

; Function Attrs: nounwind
declare void @air.atomic_max_explicit_texture_cube_array.i16.u.v4i64(%struct._texture_cube_array_t addrspace(1)* nocapture, <2 x i16>, i16, i16, <4 x i64>, i32, i32) local_unnamed_addr #1

; Function Attrs: nounwind
declare void @air.atomic_min_explicit_texture_cube_array.i16.u.v4i64(%struct._texture_cube_array_t addrspace(1)* nocapture, <2 x i16>, i16, i16, <4 x i64>, i32, i32) local_unnamed_addr #1

attributes #0 = { mustprogress nounwind "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="256" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #1 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5, !6, !7, !8}
!air.kernel = !{!9, !13, !14, !17, !18, !21, !22, !25, !26, !29, !30, !33, !34, !37, !38, !41}
!air.compile_options = !{!42, !43, !44}
!llvm.ident = !{!45}
!air.version = !{!46}
!air.language_version = !{!47}
!air.source_file_name = !{!48}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 26, i32 5]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"frame-pointer", i32 2}
!3 = !{i32 7, !"air.max_device_buffers", i32 31}
!4 = !{i32 7, !"air.max_constant_buffers", i32 31}
!5 = !{i32 7, !"air.max_threadgroup_buffers", i32 31}
!6 = !{i32 7, !"air.max_textures", i32 128}
!7 = !{i32 7, !"air.max_read_write_textures", i32 8}
!8 = !{i32 7, !"air.max_samplers", i32 16}
!9 = !{void (%struct._texture_1d_t addrspace(1)*)* @probe_p26m_1d_max, !10, !11}
!10 = !{}
!11 = !{!12}
!12 = !{i32 0, !"air.texture", !"air.location_index", i32 0, i32 1, !"air.read_write", !"air.arg_type_name", !"texture1d<ulong, read_write>", !"air.arg_name", !"__t"}
!13 = !{void (%struct._texture_1d_t addrspace(1)*)* @probe_p26m_1d_min, !10, !11}
!14 = !{void (%struct._texture_1d_array_t addrspace(1)*)* @probe_p26m_1da_max, !10, !15}
!15 = !{!16}
!16 = !{i32 0, !"air.texture", !"air.location_index", i32 0, i32 1, !"air.read_write", !"air.arg_type_name", !"texture1d_array<ulong, read_write>", !"air.arg_name", !"__t"}
!17 = !{void (%struct._texture_1d_array_t addrspace(1)*)* @probe_p26m_1da_min, !10, !15}
!18 = !{void (%struct._texture_2d_t addrspace(1)*)* @probe_p26m_2d_max, !10, !19}
!19 = !{!20}
!20 = !{i32 0, !"air.texture", !"air.location_index", i32 0, i32 1, !"air.read_write", !"air.arg_type_name", !"texture2d<ulong, read_write>", !"air.arg_name", !"__t"}
!21 = !{void (%struct._texture_2d_t addrspace(1)*)* @probe_p26m_2d_min, !10, !19}
!22 = !{void (%struct._texture_2d_array_t addrspace(1)*)* @probe_p26m_2da_max, !10, !23}
!23 = !{!24}
!24 = !{i32 0, !"air.texture", !"air.location_index", i32 0, i32 1, !"air.read_write", !"air.arg_type_name", !"texture2d_array<ulong, read_write>", !"air.arg_name", !"__t"}
!25 = !{void (%struct._texture_2d_array_t addrspace(1)*)* @probe_p26m_2da_min, !10, !23}
!26 = !{void (%struct._texture_3d_t addrspace(1)*)* @probe_p26m_3d_max, !10, !27}
!27 = !{!28}
!28 = !{i32 0, !"air.texture", !"air.location_index", i32 0, i32 1, !"air.read_write", !"air.arg_type_name", !"texture3d<ulong, read_write>", !"air.arg_name", !"__t"}
!29 = !{void (%struct._texture_3d_t addrspace(1)*)* @probe_p26m_3d_min, !10, !27}
!30 = !{void (%struct._texture_buffer_1d_t addrspace(1)*)* @probe_p26m_buf1d_max, !10, !31}
!31 = !{!32}
!32 = !{i32 0, !"air.texture", !"air.location_index", i32 0, i32 1, !"air.read_write", !"air.arg_type_name", !"texture_buffer<ulong, read_write>", !"air.arg_name", !"__t"}
!33 = !{void (%struct._texture_buffer_1d_t addrspace(1)*)* @probe_p26m_buf1d_min, !10, !31}
!34 = !{void (%struct._texture_cube_t addrspace(1)*)* @probe_p26m_cube_max, !10, !35}
!35 = !{!36}
!36 = !{i32 0, !"air.texture", !"air.location_index", i32 0, i32 1, !"air.read_write", !"air.arg_type_name", !"texturecube<ulong, read_write>", !"air.arg_name", !"__t"}
!37 = !{void (%struct._texture_cube_t addrspace(1)*)* @probe_p26m_cube_min, !10, !35}
!38 = !{void (%struct._texture_cube_array_t addrspace(1)*)* @probe_p26m_cubearr_max, !10, !39}
!39 = !{!40}
!40 = !{i32 0, !"air.texture", !"air.location_index", i32 0, i32 1, !"air.read_write", !"air.arg_type_name", !"texturecube_array<ulong, read_write>", !"air.arg_name", !"__t"}
!41 = !{void (%struct._texture_cube_array_t addrspace(1)*)* @probe_p26m_cubearr_min, !10, !39}
!42 = !{!"air.compile.denorms_disable"}
!43 = !{!"air.compile.fast_math_enable"}
!44 = !{!"air.compile.framebuffer_fetch_enable"}
!45 = !{!"Apple metal version 32023.883 (metalfe-32023.883)"}
!46 = !{i32 2, i32 8, i32 0}
!47 = !{!"Metal", i32 4, i32 0, i32 0}
!48 = !{!"/Users/runner/metal_probe/p26/P26M/probe.metal"}
