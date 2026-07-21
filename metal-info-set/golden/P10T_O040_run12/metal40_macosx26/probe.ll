; ModuleID = 'probe.metal'
source_filename = "probe.metal"
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-n8:16:32"
target triple = "air64_v28-apple-macosx26.0.0"

%"struct.metal::array" = type { [2 x i64] }
%"struct.metal::tensor" = type { %struct._tensor_t addrspace(1)* }
%struct._tensor_t = type opaque
%"struct.metal::__tensor_observer" = type { i8 }
%"struct.metal::__tensor_base" = type { i8 }
%"struct.metal::tensor.0" = type { [8 x i8] }
%"struct.metal::__tensor_base.1" = type { i8 }

@_ZN5metal25__maybe_static_array_implINS_17integral_constantIbLb0EEEiJLm4ELm8EEE11static_valsE = linkonce_odr addrspace(2) constant %"struct.metal::array" { [2 x i64] [i64 4, i64 8] }, align 8

; Function Attrs: convergent noinline nounwind optnone
define i32 @probe_p10t_extent_0() #0 {
  %1 = alloca %"struct.metal::array" addrspace(2)*, align 8
  %2 = alloca i64, align 8
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  %5 = alloca i64, align 8
  %6 = alloca %"struct.metal::tensor"*, align 8
  %7 = alloca %"struct.metal::__tensor_observer"*, align 8
  %8 = alloca i64, align 8
  %9 = alloca %"struct.metal::tensor"*, align 8
  %10 = alloca %"struct.metal::tensor", align 8
  store %"struct.metal::tensor"* %10, %"struct.metal::tensor"** %9, align 8
  %11 = load %"struct.metal::tensor"*, %"struct.metal::tensor"** %9, align 8
  store %"struct.metal::tensor"* %11, %"struct.metal::tensor"** %6, align 8
  %12 = load %"struct.metal::tensor"*, %"struct.metal::tensor"** %6, align 8
  %13 = bitcast %"struct.metal::tensor"* %12 to %"struct.metal::__tensor_base"*
  %14 = getelementptr inbounds %"struct.metal::tensor", %"struct.metal::tensor"* %12, i32 0, i32 0
  %15 = call %struct._tensor_t addrspace(1)* @air.get_null_global_tensor() #6
  store %struct._tensor_t addrspace(1)* %15, %struct._tensor_t addrspace(1)** %14, align 8
  %16 = bitcast %"struct.metal::tensor"* %10 to %"struct.metal::__tensor_observer"*
  store %"struct.metal::__tensor_observer"* %16, %"struct.metal::__tensor_observer"** %7, align 8
  store i64 0, i64* %8, align 8
  %17 = load %"struct.metal::__tensor_observer"*, %"struct.metal::__tensor_observer"** %7, align 8
  %18 = load i64, i64* %8, align 8
  store i64 %18, i64* %5, align 8
  %19 = load i64, i64* %5, align 8
  store i64 %19, i64* %4, align 8
  %20 = load i64, i64* %4, align 8
  store i64 %20, i64* %3, align 8
  %21 = load i64, i64* %3, align 8
  store %"struct.metal::array" addrspace(2)* @_ZN5metal25__maybe_static_array_implINS_17integral_constantIbLb0EEEiJLm4ELm8EEE11static_valsE, %"struct.metal::array" addrspace(2)** %1, align 8
  store i64 %21, i64* %2, align 8
  %22 = load %"struct.metal::array" addrspace(2)*, %"struct.metal::array" addrspace(2)** %1, align 8
  %23 = getelementptr inbounds %"struct.metal::array", %"struct.metal::array" addrspace(2)* %22, i32 0, i32 0
  %24 = load i64, i64* %2, align 8
  %25 = getelementptr inbounds [2 x i64], [2 x i64] addrspace(2)* %23, i64 0, i64 %24
  %26 = load i64, i64 addrspace(2)* %25, align 8
  %27 = trunc i64 %26 to i32
  ret i32 %27
}

; Function Attrs: convergent noinline nounwind optnone
define void @probe_p10t_slice_1(%"struct.metal::tensor" addrspace(1)* noundef %0) #0 {
  %2 = alloca %"struct.metal::tensor"*, align 8
  %3 = alloca %"struct.metal::tensor"*, align 8
  %4 = alloca %"struct.metal::tensor" addrspace(1)*, align 8
  %5 = alloca %"struct.metal::tensor", align 8
  store %"struct.metal::tensor" addrspace(1)* %0, %"struct.metal::tensor" addrspace(1)** %4, align 8
  store %"struct.metal::tensor"* %5, %"struct.metal::tensor"** %3, align 8
  %6 = load %"struct.metal::tensor"*, %"struct.metal::tensor"** %3, align 8
  store %"struct.metal::tensor"* %6, %"struct.metal::tensor"** %2, align 8
  %7 = load %"struct.metal::tensor"*, %"struct.metal::tensor"** %2, align 8
  %8 = bitcast %"struct.metal::tensor"* %7 to %"struct.metal::__tensor_base"*
  %9 = getelementptr inbounds %"struct.metal::tensor", %"struct.metal::tensor"* %7, i32 0, i32 0
  %10 = call %struct._tensor_t addrspace(1)* @air.get_null_global_tensor() #6
  store %struct._tensor_t addrspace(1)* %10, %struct._tensor_t addrspace(1)** %9, align 8
  %11 = load %"struct.metal::tensor" addrspace(1)*, %"struct.metal::tensor" addrspace(1)** %4, align 8
  %12 = bitcast %"struct.metal::tensor"* %5 to i8*
  %13 = bitcast %"struct.metal::tensor" addrspace(1)* %11 to i8 addrspace(1)*
  call void @llvm.memcpy.p0i8.p1i8.i64(i8* align 8 %12, i8 addrspace(1)* align 8 %13, i64 8, i1 false)
  ret void
}

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0i8.p1i8.i64(i8* noalias nocapture writeonly, i8 addrspace(1)* noalias nocapture readonly, i64, i1 immarg) #1

; Function Attrs: convergent noinline nounwind optnone
define void @probe_p10t_init_2() #0 {
  %1 = alloca %"struct.metal::tensor.0"*, align 8
  %2 = alloca %"struct.metal::tensor.0"*, align 8
  %3 = alloca %"struct.metal::tensor.0"*, align 8
  %4 = alloca %"struct.metal::tensor.0"*, align 8
  %5 = alloca %"struct.metal::tensor.0"*, align 8
  %6 = tail call i64 @_ZN5metal6tensorIU9MTLdevicefNS_7extentsIiJLm4ELm8EEEENS_13tensor_inlineEJEEE.MTL_SIZEAS()
  %7 = alloca i8, i64 %6, align 8
  %8 = bitcast i8* %7 to %"struct.metal::tensor.0"*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %7)
  store %"struct.metal::tensor.0"* %8, %"struct.metal::tensor.0"** %5, align 8
  %9 = load %"struct.metal::tensor.0"*, %"struct.metal::tensor.0"** %5, align 8
  store %"struct.metal::tensor.0"* %9, %"struct.metal::tensor.0"** %3, align 8
  %10 = load %"struct.metal::tensor.0"*, %"struct.metal::tensor.0"** %3, align 8
  %11 = bitcast %"struct.metal::tensor.0"* %10 to %"struct.metal::__tensor_base.1"*
  store %"struct.metal::tensor.0"* %10, %"struct.metal::tensor.0"** %2, align 8
  %12 = load %"struct.metal::tensor.0"*, %"struct.metal::tensor.0"** %2, align 8
  %13 = bitcast %"struct.metal::tensor.0"* %12 to i8*
  %14 = bitcast i8* %13 to %struct._tensor_t*
  call void @air.init_strided_private_tensor.i16.private(%struct._tensor_t* nocapture writeonly %14, i16 0, i8* readnone null, i8* nocapture readonly null, i8* nocapture readonly null, i8 3) #7
  store %"struct.metal::tensor.0"* %8, %"struct.metal::tensor.0"** %4, align 8
  %15 = load %"struct.metal::tensor.0"*, %"struct.metal::tensor.0"** %4, align 8
  store %"struct.metal::tensor.0"* %15, %"struct.metal::tensor.0"** %1, align 8
  %16 = load %"struct.metal::tensor.0"*, %"struct.metal::tensor.0"** %1, align 8
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %7) #9
  ret void
}

; Function Attrs: mustprogress nosync readnone speculatable willreturn
define linkonce_odr hidden i64 @_ZN5metal6tensorIU9MTLdevicefNS_7extentsIiJLm4ELm8EEEENS_13tensor_inlineEJEEE.MTL_SIZEAS() #2 {
  %1 = alloca i32, align 4
  %2 = call i64 @_ZN5metal15__tensor_detail21__tensor_safe_extentsINS_7extentsIiJLm4ELm8EEEEvE4rankEv() #10
  %3 = trunc i64 %2 to i16
  %4 = call i16 @air.get_descriptor_size_tensor(i16 %3, i16 4) #4
  %5 = zext i16 %4 to i64
  ret i64 %5
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr i64 @_ZN5metal15__tensor_detail21__tensor_safe_extentsINS_7extentsIiJLm4ELm8EEEEvE4rankEv() #3 align 2 {
  ret i64 2
}

; Function Attrs: nounwind readnone willreturn
declare i16 @air.get_descriptor_size_tensor(i16, i16) #4

; Function Attrs: argmemonly nocallback nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #5

; Function Attrs: argmemonly nocallback nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #5

; Function Attrs: convergent noinline nounwind optnone
define i32 @probe_p10t_handle_3() #0 {
  %1 = alloca %"struct.metal::array" addrspace(2)*, align 8
  %2 = alloca i64, align 8
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  %5 = alloca i64, align 8
  %6 = alloca %"struct.metal::tensor"*, align 8
  %7 = alloca %"struct.metal::__tensor_observer"*, align 8
  %8 = alloca i64, align 8
  %9 = alloca %"struct.metal::tensor"*, align 8
  %10 = alloca %"struct.metal::tensor", align 8
  store %"struct.metal::tensor"* %10, %"struct.metal::tensor"** %9, align 8
  %11 = load %"struct.metal::tensor"*, %"struct.metal::tensor"** %9, align 8
  store %"struct.metal::tensor"* %11, %"struct.metal::tensor"** %6, align 8
  %12 = load %"struct.metal::tensor"*, %"struct.metal::tensor"** %6, align 8
  %13 = bitcast %"struct.metal::tensor"* %12 to %"struct.metal::__tensor_base"*
  %14 = getelementptr inbounds %"struct.metal::tensor", %"struct.metal::tensor"* %12, i32 0, i32 0
  %15 = call %struct._tensor_t addrspace(1)* @air.get_null_global_tensor() #6
  store %struct._tensor_t addrspace(1)* %15, %struct._tensor_t addrspace(1)** %14, align 8
  %16 = bitcast %"struct.metal::tensor"* %10 to %"struct.metal::__tensor_observer"*
  store %"struct.metal::__tensor_observer"* %16, %"struct.metal::__tensor_observer"** %7, align 8
  store i64 0, i64* %8, align 8
  %17 = load %"struct.metal::__tensor_observer"*, %"struct.metal::__tensor_observer"** %7, align 8
  %18 = load i64, i64* %8, align 8
  store i64 %18, i64* %5, align 8
  %19 = load i64, i64* %5, align 8
  store i64 %19, i64* %4, align 8
  %20 = load i64, i64* %4, align 8
  store i64 %20, i64* %3, align 8
  %21 = load i64, i64* %3, align 8
  store %"struct.metal::array" addrspace(2)* @_ZN5metal25__maybe_static_array_implINS_17integral_constantIbLb0EEEiJLm4ELm8EEE11static_valsE, %"struct.metal::array" addrspace(2)** %1, align 8
  store i64 %21, i64* %2, align 8
  %22 = load %"struct.metal::array" addrspace(2)*, %"struct.metal::array" addrspace(2)** %1, align 8
  %23 = getelementptr inbounds %"struct.metal::array", %"struct.metal::array" addrspace(2)* %22, i32 0, i32 0
  %24 = load i64, i64* %2, align 8
  %25 = getelementptr inbounds [2 x i64], [2 x i64] addrspace(2)* %23, i64 0, i64 %24
  %26 = load i64, i64 addrspace(2)* %25, align 8
  %27 = trunc i64 %26 to i32
  ret i32 %27
}

; Function Attrs: convergent noinline nounwind optnone
define void @probe_p10t_descsize_4() #0 {
  %1 = alloca %"struct.metal::tensor.0"*, align 8
  %2 = alloca %"struct.metal::tensor.0"*, align 8
  %3 = alloca %"struct.metal::tensor.0"*, align 8
  %4 = alloca %"struct.metal::tensor.0"*, align 8
  %5 = alloca %"struct.metal::tensor.0"*, align 8
  %6 = tail call i64 @_ZN5metal6tensorIU9MTLdevicefNS_7extentsIiJLm4ELm8EEEENS_13tensor_inlineEJEEE.MTL_SIZEAS()
  %7 = alloca i8, i64 %6, align 8
  %8 = bitcast i8* %7 to %"struct.metal::tensor.0"*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %7)
  store %"struct.metal::tensor.0"* %8, %"struct.metal::tensor.0"** %5, align 8
  %9 = load %"struct.metal::tensor.0"*, %"struct.metal::tensor.0"** %5, align 8
  store %"struct.metal::tensor.0"* %9, %"struct.metal::tensor.0"** %3, align 8
  %10 = load %"struct.metal::tensor.0"*, %"struct.metal::tensor.0"** %3, align 8
  %11 = bitcast %"struct.metal::tensor.0"* %10 to %"struct.metal::__tensor_base.1"*
  store %"struct.metal::tensor.0"* %10, %"struct.metal::tensor.0"** %2, align 8
  %12 = load %"struct.metal::tensor.0"*, %"struct.metal::tensor.0"** %2, align 8
  %13 = bitcast %"struct.metal::tensor.0"* %12 to i8*
  %14 = bitcast i8* %13 to %struct._tensor_t*
  call void @air.init_strided_private_tensor.i16.private(%struct._tensor_t* nocapture writeonly %14, i16 0, i8* readnone null, i8* nocapture readonly null, i8* nocapture readonly null, i8 3) #7
  store %"struct.metal::tensor.0"* %8, %"struct.metal::tensor.0"** %4, align 8
  %15 = load %"struct.metal::tensor.0"*, %"struct.metal::tensor.0"** %4, align 8
  store %"struct.metal::tensor.0"* %15, %"struct.metal::tensor.0"** %1, align 8
  %16 = load %"struct.metal::tensor.0"*, %"struct.metal::tensor.0"** %1, align 8
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %7) #9
  ret void
}

; Function Attrs: convergent noinline nounwind optnone
define zeroext i1 @probe_p10t_type_h_5() #0 {
  %1 = alloca %"struct.metal::tensor"*, align 8
  %2 = alloca %"struct.metal::tensor"*, align 8
  %3 = alloca %"struct.metal::tensor"*, align 8
  %4 = alloca %"struct.metal::tensor"*, align 8
  %5 = alloca %"struct.metal::tensor", align 8
  store %"struct.metal::tensor"* %5, %"struct.metal::tensor"** %4, align 8
  %6 = load %"struct.metal::tensor"*, %"struct.metal::tensor"** %4, align 8
  store %"struct.metal::tensor"* %6, %"struct.metal::tensor"** %2, align 8
  %7 = load %"struct.metal::tensor"*, %"struct.metal::tensor"** %2, align 8
  %8 = bitcast %"struct.metal::tensor"* %7 to %"struct.metal::__tensor_base"*
  %9 = getelementptr inbounds %"struct.metal::tensor", %"struct.metal::tensor"* %7, i32 0, i32 0
  %10 = call %struct._tensor_t addrspace(1)* @air.get_null_global_tensor() #6
  store %struct._tensor_t addrspace(1)* %10, %struct._tensor_t addrspace(1)** %9, align 8
  store %"struct.metal::tensor"* %5, %"struct.metal::tensor"** %3, align 8
  %11 = load %"struct.metal::tensor"*, %"struct.metal::tensor"** %3, align 8
  store %"struct.metal::tensor"* %11, %"struct.metal::tensor"** %1, align 8
  %12 = load %"struct.metal::tensor"*, %"struct.metal::tensor"** %1, align 8
  %13 = getelementptr inbounds %"struct.metal::tensor", %"struct.metal::tensor"* %12, i32 0, i32 0
  %14 = load %struct._tensor_t addrspace(1)*, %struct._tensor_t addrspace(1)** %13, align 8
  %15 = call i1 @air.is_null_global_tensor(%struct._tensor_t addrspace(1)* nocapture readonly %14) #8
  ret i1 %15
}

; Function Attrs: convergent noinline nounwind optnone
define zeroext i1 @probe_p10t_type_th_6() #0 {
  %1 = alloca %"struct.metal::tensor"*, align 8
  %2 = alloca %"struct.metal::tensor"*, align 8
  %3 = alloca %"struct.metal::tensor"*, align 8
  %4 = alloca %"struct.metal::tensor"*, align 8
  %5 = alloca %"struct.metal::tensor", align 8
  store %"struct.metal::tensor"* %5, %"struct.metal::tensor"** %4, align 8
  %6 = load %"struct.metal::tensor"*, %"struct.metal::tensor"** %4, align 8
  store %"struct.metal::tensor"* %6, %"struct.metal::tensor"** %2, align 8
  %7 = load %"struct.metal::tensor"*, %"struct.metal::tensor"** %2, align 8
  %8 = bitcast %"struct.metal::tensor"* %7 to %"struct.metal::__tensor_base"*
  %9 = getelementptr inbounds %"struct.metal::tensor", %"struct.metal::tensor"* %7, i32 0, i32 0
  %10 = call %struct._tensor_t addrspace(1)* @air.get_null_global_tensor() #6
  store %struct._tensor_t addrspace(1)* %10, %struct._tensor_t addrspace(1)** %9, align 8
  store %"struct.metal::tensor"* %5, %"struct.metal::tensor"** %3, align 8
  %11 = load %"struct.metal::tensor"*, %"struct.metal::tensor"** %3, align 8
  store %"struct.metal::tensor"* %11, %"struct.metal::tensor"** %1, align 8
  %12 = load %"struct.metal::tensor"*, %"struct.metal::tensor"** %1, align 8
  %13 = getelementptr inbounds %"struct.metal::tensor", %"struct.metal::tensor"* %12, i32 0, i32 0
  %14 = load %struct._tensor_t addrspace(1)*, %struct._tensor_t addrspace(1)** %13, align 8
  %15 = call i1 @air.is_null_global_tensor(%struct._tensor_t addrspace(1)* nocapture readonly %14) #8
  ret i1 %15
}

; Function Attrs: inaccessiblememonly nounwind readonly willreturn
declare %struct._tensor_t addrspace(1)* @air.get_null_global_tensor() #6

; Function Attrs: argmemonly nounwind willreturn
declare void @air.init_strided_private_tensor.i16.private(%struct._tensor_t* nocapture writeonly, i16, i8* readnone, i8* nocapture readonly, i8* nocapture readonly, i8) #7

; Function Attrs: argmemonly nounwind readonly willreturn
declare i1 @air.is_null_global_tensor(%struct._tensor_t addrspace(1)* nocapture readonly) #8

attributes #0 = { convergent noinline nounwind optnone "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #1 = { argmemonly nofree nounwind willreturn }
attributes #2 = { mustprogress nosync readnone speculatable willreturn "deferred-static-alloca-size" }
attributes #3 = { convergent mustprogress noinline nounwind optnone "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #4 = { nounwind readnone willreturn }
attributes #5 = { argmemonly nocallback nofree nosync nounwind willreturn }
attributes #6 = { inaccessiblememonly nounwind readonly willreturn }
attributes #7 = { argmemonly nounwind willreturn }
attributes #8 = { argmemonly nounwind readonly willreturn }
attributes #9 = { nounwind }
attributes #10 = { convergent nobuiltin "no-builtins" }

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
!15 = !{!"/Users/runner/metal_probe/p12/P10T_O0/probe.metal"}
