; ModuleID = 'probe.metal'
source_filename = "probe.metal"
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-n8:16:32"
target triple = "air64_v28-apple-macosx26.0.0"

%"struct.metal::_imageblock_base" = type { %struct._imageblock_t addrspace(4)* }
%struct._imageblock_t = type opaque
%struct._texture_2d_t = type opaque

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn writeonly
define void @probe_p22k_ib_size(%"struct.metal::_imageblock_base" %0, float addrspace(1)* nocapture noundef writeonly "air-buffer-no-alias" %1, <2 x i16> noundef %2) local_unnamed_addr #0 {
  %4 = tail call i16 @air.get_imageblock_width() #9
  %5 = tail call fast float @air.convert.f.f32.u.i16(i16 %4) #9
  store float %5, float addrspace(1)* %1, align 4, !tbaa !39, !alias.scope !43
  %6 = tail call i16 @air.get_imageblock_height() #9
  %7 = tail call fast float @air.convert.f.f32.u.i16(i16 %6) #9
  %8 = getelementptr inbounds float, float addrspace(1)* %1, i64 1
  store float %7, float addrspace(1)* %8, align 4, !tbaa !39, !alias.scope !43
  %9 = tail call i16 @air.get_imageblock_num_colors(<2 x i16> %2) #9
  %10 = tail call fast float @air.convert.f.f32.u.i16(i16 %9) #9
  %11 = getelementptr inbounds float, float addrspace(1)* %1, i64 2
  store float %10, float addrspace(1)* %11, align 4, !tbaa !39, !alias.scope !43
  %12 = tail call i16 @air.get_imageblock_samples() #9
  %13 = tail call fast float @air.convert.f.f32.u.i16(i16 %12) #9
  %14 = getelementptr inbounds float, float addrspace(1)* %1, i64 3
  store float %13, float addrspace(1)* %14, align 4, !tbaa !39, !alias.scope !43
  %15 = tail call i16 @air.get_color_coverage_mask(<2 x i16> %2, i16 0) #9
  %16 = tail call fast float @air.convert.f.f32.u.i16(i16 %15) #9
  %17 = getelementptr inbounds float, float addrspace(1)* %1, i64 4
  store float %16, float addrspace(1)* %17, align 4, !tbaa !39, !alias.scope !43
  ret void
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare float @air.convert.f.f32.u.i16(i16) local_unnamed_addr #1

; Function Attrs: mustprogress nofree nounwind willreturn
define void @probe_p22k_ib_iread(%"struct.metal::_imageblock_base" %0, <4 x float> addrspace(1)* nocapture noundef writeonly "air-buffer-no-alias" %1, <2 x i16> noundef %2) local_unnamed_addr #2 {
  %4 = tail call fast <4 x float> @air.load.implicit_imageblock.v4f32(i32 0, <2 x i16> %2, i32 0, i16 0) #10
  store <4 x float> %4, <4 x float> addrspace(1)* %1, align 16, !tbaa !46, !alias.scope !47
  ret void
}

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p22k_ib_iwrite(%"struct.metal::_imageblock_base" %0, <4 x float> addrspace(1)* nocapture noundef readonly "air-buffer-no-alias" %1, <2 x i16> noundef %2) local_unnamed_addr #3 {
  %4 = load <4 x float>, <4 x float> addrspace(1)* %1, align 16, !tbaa !46, !alias.scope !50
  tail call void @air.store.implicit_imageblock.v4f32(<4 x float> %4, i32 0, <2 x i16> %2, i32 1, i16 0) #11
  tail call void @air.store.implicit_imageblock.v4i32(<4 x i32> zeroinitializer, i32 1, <2 x i16> %2, i32 1, i16 0) #11
  ret void
}

; Function Attrs: mustprogress nofree nounwind willreturn
define void @probe_p22k_ib_eread(%"struct.metal::_imageblock_base" %0, <4 x float> addrspace(1)* nocapture noundef writeonly "air-buffer-no-alias" %1, <2 x i16> noundef %2) local_unnamed_addr #4 {
  %4 = tail call i8 addrspace(4)* @air.imageblock_data(<2 x i16> %2, i32 0, i16 0) #10
  %5 = bitcast i8 addrspace(4)* %4 to <4 x half> addrspace(4)*
  %6 = load <4 x half>, <4 x half> addrspace(4)* %5, align 8, !tbaa !46
  %7 = tail call fast <4 x float> @air.convert.f.v4f32.f.v4f16(<4 x half> %6) #9
  store <4 x float> %7, <4 x float> addrspace(1)* %1, align 16, !tbaa !46, !alias.scope !53
  ret void
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare <4 x float> @air.convert.f.v4f32.f.v4f16(<4 x half>) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn
define void @probe_p22k_ib_ewrite(%"struct.metal::_imageblock_base" %0, <4 x float> addrspace(1)* nocapture noundef readonly "air-buffer-no-alias" %1, <2 x i16> noundef %2) local_unnamed_addr #5 {
  %4 = load <4 x float>, <4 x float> addrspace(1)* %1, align 16, !tbaa !46, !alias.scope !56
  %5 = tail call fast <4 x half> @air.convert.f.v4f16.f.v4f32(<4 x float> %4) #9
  %6 = tail call i8 addrspace(4)* @air.imageblock_data(<2 x i16> %2, i32 0, i16 0) #10
  %7 = bitcast i8 addrspace(4)* %6 to <4 x half> addrspace(4)*
  %8 = getelementptr inbounds i8, i8 addrspace(4)* %6, i64 8
  %9 = bitcast i8 addrspace(4)* %8 to i32 addrspace(4)*
  %10 = getelementptr inbounds i8, i8 addrspace(4)* %6, i64 12
  %11 = bitcast i8 addrspace(4)* %10 to float addrspace(4)*
  tail call void @air.store.imageblock.mask.v4f16(<4 x half> %5, <4 x half> addrspace(4)* %7, i16 -1, i32 8, i1 false) #11
  tail call void @air.store.imageblock.mask.i32(i32 0, i32 addrspace(4)* %9, i16 -1, i32 8, i1 false) #11
  tail call void @air.store.imageblock.mask.f32(float 0.000000e+00, float addrspace(4)* %11, i16 -1, i32 4, i1 false) #11
  ret void
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare <4 x half> @air.convert.f.v4f16.f.v4f32(<4 x float>) local_unnamed_addr #1

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define void @probe_p22k_ib_slice(%"struct.metal::_imageblock_base" %0, %struct._texture_2d_t addrspace(1)* nocapture %1, <2 x i16> noundef %2) local_unnamed_addr #6 {
  ret void
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare i16 @air.get_imageblock_width() local_unnamed_addr #1

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare i16 @air.get_imageblock_height() local_unnamed_addr #1

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare i16 @air.get_imageblock_num_colors(<2 x i16>) local_unnamed_addr #1

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare i16 @air.get_imageblock_samples() local_unnamed_addr #1

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
declare i16 @air.get_color_coverage_mask(<2 x i16>, i16) local_unnamed_addr #1

; Function Attrs: mustprogress nofree nounwind readonly willreturn
declare <4 x float> @air.load.implicit_imageblock.v4f32(i32, <2 x i16>, i32, i16) local_unnamed_addr #7

; Function Attrs: mustprogress nounwind willreturn writeonly
declare void @air.store.implicit_imageblock.v4f32(<4 x float>, i32, <2 x i16>, i32, i16) local_unnamed_addr #8

; Function Attrs: mustprogress nounwind willreturn writeonly
declare void @air.store.implicit_imageblock.v4i32(<4 x i32>, i32, <2 x i16>, i32, i16) local_unnamed_addr #8

; Function Attrs: mustprogress nofree nounwind readonly willreturn
declare i8 addrspace(4)* @air.imageblock_data(<2 x i16>, i32, i16) local_unnamed_addr #7

; Function Attrs: mustprogress nounwind willreturn writeonly
declare void @air.store.imageblock.mask.v4f16(<4 x half>, <4 x half> addrspace(4)*, i16, i32, i1) local_unnamed_addr #8

; Function Attrs: mustprogress nounwind willreturn writeonly
declare void @air.store.imageblock.mask.i32(i32, i32 addrspace(4)*, i16, i32, i1) local_unnamed_addr #8

; Function Attrs: mustprogress nounwind willreturn writeonly
declare void @air.store.imageblock.mask.f32(float, float addrspace(4)*, i16, i32, i1) local_unnamed_addr #8

attributes #0 = { argmemonly mustprogress nofree nosync nounwind willreturn writeonly "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="32" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #1 = { mustprogress nofree nosync nounwind readnone willreturn }
attributes #2 = { mustprogress nofree nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="128" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #3 = { mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="128" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #4 = { mustprogress nofree nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="32" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #5 = { mustprogress nounwind willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="64" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #6 = { mustprogress nofree norecurse nosync nounwind readnone willreturn "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="32" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #7 = { mustprogress nofree nounwind readonly willreturn }
attributes #8 = { mustprogress nounwind willreturn writeonly }
attributes #9 = { nounwind readnone willreturn }
attributes #10 = { nounwind readonly willreturn }
attributes #11 = { nounwind willreturn writeonly }

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5, !6, !7, !8}
!air.kernel = !{!9, !16, !19, !22, !26, !28}
!air.compile_options = !{!32, !33, !34}
!llvm.ident = !{!35}
!air.version = !{!36}
!air.language_version = !{!37}
!air.source_file_name = !{!38}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 26, i32 5]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"frame-pointer", i32 2}
!3 = !{i32 7, !"air.max_device_buffers", i32 31}
!4 = !{i32 7, !"air.max_constant_buffers", i32 31}
!5 = !{i32 7, !"air.max_threadgroup_buffers", i32 31}
!6 = !{i32 7, !"air.max_textures", i32 128}
!7 = !{i32 7, !"air.max_read_write_textures", i32 8}
!8 = !{i32 7, !"air.max_samplers", i32 16}
!9 = !{void (%"struct.metal::_imageblock_base", float addrspace(1)*, <2 x i16>)* @probe_p22k_ib_size, !10, !11}
!10 = !{}
!11 = !{!12, !14, !15}
!12 = !{i32 0, !"air.imageblock", !"implicit", !"air.struct_type_info", !13, !"air.arg_type_align_size", i32 16, !"air.arg_type_name", !"imageblock<FooImp, layout_implicit>", !"air.arg_name", !"__ib"}
!13 = !{i32 0, i32 16, i32 0, !"float4", !"a", !"air.render_target", i32 0, i32 16, i32 16, i32 0, !"int4", !"b", !"air.render_target", i32 1}
!14 = !{i32 1, !"air.buffer", !"air.location_index", i32 0, i32 1, !"air.read_write", !"air.address_space", i32 1, !"air.arg_type_size", i32 4, !"air.arg_type_align_size", i32 4, !"air.arg_type_name", !"float", !"air.arg_name", !"__out"}
!15 = !{i32 2, !"air.thread_position_in_threadgroup", !"air.arg_type_name", !"ushort2", !"air.arg_name", !"__lid"}
!16 = !{void (%"struct.metal::_imageblock_base", <4 x float> addrspace(1)*, <2 x i16>)* @probe_p22k_ib_iread, !10, !17}
!17 = !{!12, !18, !15}
!18 = !{i32 1, !"air.buffer", !"air.location_index", i32 0, i32 1, !"air.read_write", !"air.address_space", i32 1, !"air.arg_type_size", i32 16, !"air.arg_type_align_size", i32 16, !"air.arg_type_name", !"float4", !"air.arg_name", !"__out"}
!19 = !{void (%"struct.metal::_imageblock_base", <4 x float> addrspace(1)*, <2 x i16>)* @probe_p22k_ib_iwrite, !10, !20}
!20 = !{!12, !21, !15}
!21 = !{i32 1, !"air.buffer", !"air.location_index", i32 0, i32 1, !"air.read_write", !"air.address_space", i32 1, !"air.arg_type_size", i32 16, !"air.arg_type_align_size", i32 16, !"air.arg_type_name", !"float4", !"air.arg_name", !"__in"}
!22 = !{void (%"struct.metal::_imageblock_base", <4 x float> addrspace(1)*, <2 x i16>)* @probe_p22k_ib_eread, !10, !23}
!23 = !{!24, !18, !15}
!24 = !{i32 0, !"air.imageblock", !"explicit", !"air.imageblock_data_size", i32 16, !"air.struct_type_info", !25, !"air.arg_type_align_size", i32 8, !"air.arg_type_name", !"imageblock<FooExp, layout_explicit>", !"air.arg_name", !"__ib"}
!25 = !{i32 0, i32 8, i32 0, !"half4", !"a", i32 8, i32 4, i32 0, !"int", !"b", i32 12, i32 4, i32 0, !"float", !"c"}
!26 = !{void (%"struct.metal::_imageblock_base", <4 x float> addrspace(1)*, <2 x i16>)* @probe_p22k_ib_ewrite, !10, !27}
!27 = !{!24, !21, !15}
!28 = !{void (%"struct.metal::_imageblock_base", %struct._texture_2d_t addrspace(1)*, <2 x i16>)* @probe_p22k_ib_slice, !10, !29}
!29 = !{!12, !30, !31}
!30 = !{i32 1, !"air.texture", !"air.location_index", i32 0, i32 1, !"air.write", !"air.arg_type_name", !"texture2d<float, write>", !"air.arg_name", !"__t", !"air.arg_unused"}
!31 = !{i32 2, !"air.thread_position_in_threadgroup", !"air.arg_type_name", !"ushort2", !"air.arg_name", !"__lid", !"air.arg_unused"}
!32 = !{!"air.compile.denorms_disable"}
!33 = !{!"air.compile.fast_math_enable"}
!34 = !{!"air.compile.framebuffer_fetch_enable"}
!35 = !{!"Apple metal version 32023.883 (metalfe-32023.883)"}
!36 = !{i32 2, i32 8, i32 0}
!37 = !{!"Metal", i32 4, i32 0, i32 0}
!38 = !{!"/Users/runner/metal_probe/p22/P22K/probe.metal"}
!39 = !{!40, !40, i64 0}
!40 = !{!"float", !41, i64 0}
!41 = !{!"omnipotent char", !42, i64 0}
!42 = !{!"Simple C++ TBAA"}
!43 = !{!44}
!44 = distinct !{!44, !45, !"air-alias-scope-arg(1)"}
!45 = distinct !{!45, !"air-alias-scopes(probe_p22k_ib_size)"}
!46 = !{!41, !41, i64 0}
!47 = !{!48}
!48 = distinct !{!48, !49, !"air-alias-scope-arg(1)"}
!49 = distinct !{!49, !"air-alias-scopes(probe_p22k_ib_iread)"}
!50 = !{!51}
!51 = distinct !{!51, !52, !"air-alias-scope-arg(1)"}
!52 = distinct !{!52, !"air-alias-scopes(probe_p22k_ib_iwrite)"}
!53 = !{!54}
!54 = distinct !{!54, !55, !"air-alias-scope-arg(1)"}
!55 = distinct !{!55, !"air-alias-scopes(probe_p22k_ib_eread)"}
!56 = !{!57}
!57 = distinct !{!57, !58, !"air-alias-scope-arg(1)"}
!58 = distinct !{!58, !"air-alias-scopes(probe_p22k_ib_ewrite)"}
