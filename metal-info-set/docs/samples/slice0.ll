source_filename = "/System/Library/PrivateFrameworks/GPUCompiler.framework/Versions/32023/Libraries/lib/clang/32023.883/lib/darwin/libtracepoint_rt_osx.metallib"
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-n8:16:32"
target triple = "air64_v23-apple-macosx11.0.0"

%"struct.(anonymous namespace)::VertexTraceBuffer" = type { %"struct.(anonymous namespace)::TraceBuffer", i32, i32, i32, [1 x i32] }
%"struct.(anonymous namespace)::TraceBuffer" = type { %"struct.metal::_atomic.4238", i32, %"struct.metal::_atomic.4238" }
%"struct.metal::_atomic.4238" = type { i32 }

@_ZL9thread_id = internal thread_local unnamed_addr global i32 0, align 4
@air.dyld_flat_table = hidden global [1 x ptr] [ptr @__tracepoint_get_trace_buffer], section "air.dyld_flat_table"
@llvm.used = appending global [1 x ptr] [ptr @air.dyld_flat_table], section "llvm.metadata"

; Function Attrs: convergent noinline nounwind optsize
define void @_Z24kernel_thread_tracepointPU11MTLconstantKjjDv3_j(ptr addrspace(2) nocapture readonly %0, i32 %1, <3 x i32> %2) local_unnamed_addr #0 {
  %4 = tail call ptr addrspace(1) @__tracepoint_get_trace_buffer() #8
  %5 = getelementptr inbounds i8, ptr addrspace(1) %4, i64 16
  %6 = bitcast ptr addrspace(1) %5 to ptr addrspace(1)
  %7 = load <3 x i32>, ptr addrspace(1) %6, align 16, !tbaa !15
  %8 = icmp ule <3 x i32> %7, %2
  %9 = tail call i1 @air.all.v3i1(<3 x i1> %8) #2
  br i1 %9, label %10, label %16

10:                                               ; preds = %3
  %11 = getelementptr inbounds i8, ptr addrspace(1) %4, i64 32
  %12 = bitcast ptr addrspace(1) %11 to ptr addrspace(1)
  %13 = load <3 x i32>, ptr addrspace(1) %12, align 16, !tbaa !15
  %14 = icmp uge <3 x i32> %13, %2
  %15 = tail call i1 @air.all.v3i1(<3 x i1> %14) #2
  br i1 %15, label %17, label %16

16:                                               ; preds = %10, %3
  store i32 0, ptr @_ZL9thread_id, align 4, !tbaa !18
  br label %49

17:                                               ; preds = %10
  %18 = bitcast ptr addrspace(1) %4 to ptr addrspace(1)
  %19 = tail call i32 @air.atomic.global.add.u.i32(ptr addrspace(1) nocapture %18, i32 1, i32 0, i32 2, i1 true) #3
  store i32 %19, ptr @_ZL9thread_id, align 4, !tbaa !18
  %20 = icmp eq i32 %19, 0
  br i1 %20, label %49, label %21

21:                                               ; preds = %17
  %22 = getelementptr inbounds i8, ptr addrspace(1) %4, i64 8
  %23 = bitcast ptr addrspace(1) %22 to ptr addrspace(1)
  %24 = tail call i32 @air.atomic.global.add.u.i32(ptr addrspace(1) nocapture %23, i32 24, i32 0, i32 2, i1 true) #3
  %25 = add i32 %24, 24
  %26 = icmp ugt i32 %25, 1073741823
  %27 = select i1 %26, i32 24, i32 0
  %28 = tail call i32 @air.atomic.global.sub.u.i32(ptr addrspace(1) nocapture %23, i32 %27, i32 0, i32 2, i1 true) #3
  %29 = getelementptr inbounds i8, ptr addrspace(1) %4, i64 4
  %30 = bitcast ptr addrspace(1) %29 to ptr addrspace(1)
  %31 = load i32, ptr addrspace(1) %30, align 4, !tbaa !20
  %32 = icmp uge i32 %25, %31
  %33 = zext i32 %24 to i64
  %34 = getelementptr inbounds i8, ptr addrspace(1) %4, i64 %33
  %35 = icmp eq ptr addrspace(1) %34, null
  %36 = select i1 %32, i1 true, i1 %35
  br i1 %36, label %37, label %38

37:                                               ; preds = %21
  store i32 0, ptr @_ZL9thread_id, align 4, !tbaa !18
  br label %49

38:                                               ; preds = %21
  %39 = bitcast ptr addrspace(1) %34 to ptr addrspace(1)
  %40 = load i32, ptr @_ZL9thread_id, align 4
  store i32 %40, ptr addrspace(1) %39, align 4
  %41 = getelementptr inbounds i8, ptr addrspace(1) %34, i64 4
  %42 = load i32, ptr addrspace(2) %0, align 4, !tbaa !18
  %43 = shl i32 %42, 24
  %44 = and i32 %1, 16777215
  %45 = or i32 %43, %44
  %46 = bitcast ptr addrspace(1) %41 to ptr addrspace(1)
  store i32 %45, ptr addrspace(1) %46, align 4
  %47 = getelementptr inbounds i8, ptr addrspace(1) %34, i64 8
  %48 = bitcast ptr addrspace(1) %47 to ptr addrspace(1)
  store <3 x i32> %2, ptr addrspace(1) %48, align 4
  br label %49

49:                                               ; preds = %38, %37, %17, %16
  ret void
}

; Function Attrs: convergent optsize
declare ptr addrspace(1) @__tracepoint_get_trace_buffer() local_unnamed_addr #1

; Function Attrs: nounwind memory(none)
declare i1 @air.all.v3i1(<3 x i1>) local_unnamed_addr #2

; Function Attrs: nounwind
declare i32 @air.atomic.global.add.u.i32(ptr addrspace(1) nocapture, i32, i32, i32, i1) local_unnamed_addr #3

; Function Attrs: nounwind
declare i32 @air.atomic.global.sub.u.i32(ptr addrspace(1) nocapture, i32, i32, i32, i1) local_unnamed_addr #3

; Function Attrs: convergent noinline nounwind optsize
define void @_Z24vertex_thread_tracepointPU11MTLconstantKjjjjj(ptr addrspace(2) nocapture readonly %0, i32 %1, i32 %2, i32 %3, i32 %4) local_unnamed_addr #4 {
  %6 = tail call ptr addrspace(1) @__tracepoint_get_trace_buffer() #8
  %7 = bitcast ptr addrspace(1) %6 to ptr addrspace(1)
  %8 = getelementptr inbounds i8, ptr addrspace(1) %6, i64 16
  %9 = bitcast ptr addrspace(1) %8 to ptr addrspace(1)
  %10 = load i32, ptr addrspace(1) %9, align 4, !tbaa !23
  %11 = icmp eq i32 %10, %4
  br i1 %11, label %12, label %31

12:                                               ; preds = %5
  %13 = getelementptr inbounds i8, ptr addrspace(1) %6, i64 12
  %14 = bitcast ptr addrspace(1) %13 to ptr addrspace(1)
  %15 = load i32, ptr addrspace(1) %14, align 4, !tbaa !25
  %16 = icmp eq i32 %15, %3
  br i1 %16, label %17, label %31

17:                                               ; preds = %12
  %18 = getelementptr inbounds i8, ptr addrspace(1) %6, i64 20
  %19 = bitcast ptr addrspace(1) %18 to ptr addrspace(1)
  %20 = load i32, ptr addrspace(1) %19, align 4, !tbaa !26
  %21 = icmp eq i32 %20, 0
  br i1 %21, label %31, label %25

22:                                               ; preds = %25
  %23 = add i32 %26, 1
  %24 = icmp eq i32 %23, %20
  br i1 %24, label %31, label %25, !llvm.loop !27

25:                                               ; preds = %22, %17
  %26 = phi i32 [ %23, %22 ], [ 0, %17 ]
  %27 = zext i32 %26 to i64
  %28 = getelementptr inbounds %"struct.(anonymous namespace)::VertexTraceBuffer", ptr addrspace(1) %7, i64 0, i32 4, i64 %27
  %29 = load i32, ptr addrspace(1) %28, align 4, !tbaa !18
  %30 = icmp eq i32 %29, %2
  br i1 %30, label %32, label %22

31:                                               ; preds = %22, %17, %12, %5
  store i32 0, ptr @_ZL9thread_id, align 4, !tbaa !18
  br label %64

32:                                               ; preds = %25
  %33 = bitcast ptr addrspace(1) %6 to ptr addrspace(1)
  %34 = tail call i32 @air.atomic.global.add.u.i32(ptr addrspace(1) nocapture %33, i32 1, i32 0, i32 2, i1 true) #3
  store i32 %34, ptr @_ZL9thread_id, align 4, !tbaa !18
  %35 = icmp eq i32 %34, 0
  br i1 %35, label %64, label %36

36:                                               ; preds = %32
  %37 = getelementptr inbounds i8, ptr addrspace(1) %6, i64 8
  %38 = bitcast ptr addrspace(1) %37 to ptr addrspace(1)
  %39 = tail call i32 @air.atomic.global.add.u.i32(ptr addrspace(1) nocapture %38, i32 12, i32 0, i32 2, i1 true) #3
  %40 = add i32 %39, 12
  %41 = icmp ugt i32 %40, 1073741823
  %42 = select i1 %41, i32 12, i32 0
  %43 = tail call i32 @air.atomic.global.sub.u.i32(ptr addrspace(1) nocapture %38, i32 %42, i32 0, i32 2, i1 true) #3
  %44 = getelementptr inbounds i8, ptr addrspace(1) %6, i64 4
  %45 = bitcast ptr addrspace(1) %44 to ptr addrspace(1)
  %46 = load i32, ptr addrspace(1) %45, align 4, !tbaa !20
  %47 = icmp uge i32 %40, %46
  %48 = zext i32 %39 to i64
  %49 = getelementptr inbounds i8, ptr addrspace(1) %6, i64 %48
  %50 = icmp eq ptr addrspace(1) %49, null
  %51 = select i1 %47, i1 true, i1 %50
  br i1 %51, label %52, label %53

52:                                               ; preds = %36
  store i32 0, ptr @_ZL9thread_id, align 4, !tbaa !18
  br label %64

53:                                               ; preds = %36
  %54 = bitcast ptr addrspace(1) %49 to ptr addrspace(1)
  %55 = load i32, ptr @_ZL9thread_id, align 4
  store i32 %55, ptr addrspace(1) %54, align 4
  %56 = getelementptr inbounds i8, ptr addrspace(1) %49, i64 4
  %57 = load i32, ptr addrspace(2) %0, align 4, !tbaa !18
  %58 = shl i32 %57, 24
  %59 = and i32 %1, 16777215
  %60 = or i32 %58, %59
  %61 = bitcast ptr addrspace(1) %56 to ptr addrspace(1)
  store i32 %60, ptr addrspace(1) %61, align 4
  %62 = getelementptr inbounds i8, ptr addrspace(1) %49, i64 8
  %63 = bitcast ptr addrspace(1) %62 to ptr addrspace(1)
  store i32 %2, ptr addrspace(1) %63, align 4
  br label %64

64:                                               ; preds = %53, %52, %32, %31
  ret void
}

; Function Attrs: convergent noinline nounwind optsize
define void @_Z26fragment_thread_tracepointPU11MTLconstantKjjDv4_fjj(ptr addrspace(2) nocapture readonly %0, i32 %1, <4 x float> %2, i32 %3, i32 %4) local_unnamed_addr #5 {
  %6 = tail call ptr addrspace(1) @__tracepoint_get_trace_buffer() #8
  %7 = getelementptr inbounds i8, ptr addrspace(1) %6, i64 56
  %8 = bitcast ptr addrspace(1) %7 to ptr addrspace(1)
  %9 = load i32, ptr addrspace(1) %8, align 8, !tbaa !29
  %10 = icmp eq i32 %9, %4
  br i1 %10, label %11, label %33

11:                                               ; preds = %5
  %12 = getelementptr inbounds i8, ptr addrspace(1) %6, i64 16
  %13 = bitcast ptr addrspace(1) %12 to ptr addrspace(1)
  %14 = load <4 x float>, ptr addrspace(1) %13, align 16, !tbaa !15
  %15 = fcmp fast ole <4 x float> %14, %2
  %16 = tail call i1 @air.all.v4i1(<4 x i1> %15) #2
  br i1 %16, label %17, label %33

17:                                               ; preds = %11
  %18 = getelementptr inbounds i8, ptr addrspace(1) %6, i64 32
  %19 = bitcast ptr addrspace(1) %18 to ptr addrspace(1)
  %20 = load <4 x float>, ptr addrspace(1) %19, align 16, !tbaa !15
  %21 = fcmp fast oge <4 x float> %20, %2
  %22 = tail call i1 @air.all.v4i1(<4 x i1> %21) #2
  br i1 %22, label %23, label %33

23:                                               ; preds = %17
  %24 = getelementptr inbounds i8, ptr addrspace(1) %6, i64 48
  %25 = bitcast ptr addrspace(1) %24 to ptr addrspace(1)
  %26 = load i32, ptr addrspace(1) %25, align 16, !tbaa !18
  %27 = icmp ugt i32 %26, %3
  br i1 %27, label %33, label %28

28:                                               ; preds = %23
  %29 = getelementptr inbounds i8, ptr addrspace(1) %6, i64 52
  %30 = bitcast ptr addrspace(1) %29 to ptr addrspace(1)
  %31 = load i32, ptr addrspace(1) %30, align 4, !tbaa !18
  %32 = icmp ult i32 %31, %3
  br i1 %32, label %33, label %34

33:                                               ; preds = %28, %23, %17, %11, %5
  store i32 0, ptr @_ZL9thread_id, align 4, !tbaa !18
  br label %68

34:                                               ; preds = %28
  %35 = bitcast ptr addrspace(1) %6 to ptr addrspace(1)
  %36 = tail call i32 @air.atomic.global.add.u.i32(ptr addrspace(1) nocapture %35, i32 1, i32 0, i32 2, i1 true) #3
  store i32 %36, ptr @_ZL9thread_id, align 4, !tbaa !18
  %37 = icmp eq i32 %36, 0
  br i1 %37, label %68, label %38

38:                                               ; preds = %34
  %39 = getelementptr inbounds i8, ptr addrspace(1) %6, i64 8
  %40 = bitcast ptr addrspace(1) %39 to ptr addrspace(1)
  %41 = tail call i32 @air.atomic.global.add.u.i32(ptr addrspace(1) nocapture %40, i32 28, i32 0, i32 2, i1 true) #3
  %42 = add i32 %41, 28
  %43 = icmp ugt i32 %42, 1073741823
  %44 = select i1 %43, i32 28, i32 0
  %45 = tail call i32 @air.atomic.global.sub.u.i32(ptr addrspace(1) nocapture %40, i32 %44, i32 0, i32 2, i1 true) #3
  %46 = getelementptr inbounds i8, ptr addrspace(1) %6, i64 4
  %47 = bitcast ptr addrspace(1) %46 to ptr addrspace(1)
  %48 = load i32, ptr addrspace(1) %47, align 4, !tbaa !20
  %49 = icmp uge i32 %42, %48
  %50 = zext i32 %41 to i64
  %51 = getelementptr inbounds i8, ptr addrspace(1) %6, i64 %50
  %52 = icmp eq ptr addrspace(1) %51, null
  %53 = select i1 %49, i1 true, i1 %52
  br i1 %53, label %54, label %55

54:                                               ; preds = %38
  store i32 0, ptr @_ZL9thread_id, align 4, !tbaa !18
  br label %68

55:                                               ; preds = %38
  %56 = bitcast ptr addrspace(1) %51 to ptr addrspace(1)
  %57 = load i32, ptr @_ZL9thread_id, align 4
  store i32 %57, ptr addrspace(1) %56, align 4
  %58 = getelementptr inbounds i8, ptr addrspace(1) %51, i64 4
  %59 = load i32, ptr addrspace(2) %0, align 4, !tbaa !18
  %60 = shl i32 %59, 24
  %61 = and i32 %1, 16777215
  %62 = or i32 %60, %61
  %63 = bitcast ptr addrspace(1) %58 to ptr addrspace(1)
  store i32 %62, ptr addrspace(1) %63, align 4
  %64 = getelementptr inbounds i8, ptr addrspace(1) %51, i64 8
  %65 = bitcast ptr addrspace(1) %64 to ptr addrspace(1)
  store <4 x float> %2, ptr addrspace(1) %65, align 4
  %66 = getelementptr inbounds i8, ptr addrspace(1) %51, i64 24
  %67 = bitcast ptr addrspace(1) %66 to ptr addrspace(1)
  store i32 %3, ptr addrspace(1) %67, align 4
  br label %68

68:                                               ; preds = %55, %54, %34, %33
  ret void
}

; Function Attrs: nounwind memory(none)
declare i1 @air.all.v4i1(<4 x i1>) local_unnamed_addr #2

; Function Attrs: convergent noinline nounwind optsize
define void @_Z41post_tesselation_vertex_thread_tracepointPU11MTLconstantKjjjjDv3_fj(ptr addrspace(2) nocapture readonly %0, i32 %1, i32 %2, i32 %3, <3 x float> %4, i32 %5) local_unnamed_addr #0 {
  %7 = tail call ptr addrspace(1) @__tracepoint_get_trace_buffer() #8
  %8 = bitcast ptr addrspace(1) %7 to ptr addrspace(1)
  %9 = getelementptr inbounds i8, ptr addrspace(1) %7, i64 16
  %10 = bitcast ptr addrspace(1) %9 to ptr addrspace(1)
  %11 = load i32, ptr addrspace(1) %10, align 4, !tbaa !31
  %12 = icmp eq i32 %11, %5
  br i1 %12, label %13, label %32

13:                                               ; preds = %6
  %14 = getelementptr inbounds i8, ptr addrspace(1) %7, i64 12
  %15 = bitcast ptr addrspace(1) %14 to ptr addrspace(1)
  %16 = load i32, ptr addrspace(1) %15, align 4, !tbaa !33
  %17 = icmp eq i32 %16, %3
  br i1 %17, label %18, label %32

18:                                               ; preds = %13
  %19 = getelementptr inbounds i8, ptr addrspace(1) %7, i64 20
  %20 = bitcast ptr addrspace(1) %19 to ptr addrspace(1)
  %21 = load i32, ptr addrspace(1) %20, align 4, !tbaa !34
  %22 = icmp eq i32 %21, 0
  br i1 %22, label %32, label %26

23:                                               ; preds = %26
  %24 = add i32 %27, 1
  %25 = icmp eq i32 %24, %21
  br i1 %25, label %32, label %26, !llvm.loop !35

26:                                               ; preds = %23, %18
  %27 = phi i32 [ %24, %23 ], [ 0, %18 ]
  %28 = zext i32 %27 to i64
  %29 = getelementptr inbounds %"struct.(anonymous namespace)::VertexTraceBuffer", ptr addrspace(1) %8, i64 0, i32 4, i64 %28
  %30 = load i32, ptr addrspace(1) %29, align 4, !tbaa !18
  %31 = icmp eq i32 %30, %2
  br i1 %31, label %33, label %23

32:                                               ; preds = %23, %18, %13, %6
  store i32 0, ptr @_ZL9thread_id, align 4, !tbaa !18
  br label %67

33:                                               ; preds = %26
  %34 = bitcast ptr addrspace(1) %7 to ptr addrspace(1)
  %35 = tail call i32 @air.atomic.global.add.u.i32(ptr addrspace(1) nocapture %34, i32 1, i32 0, i32 2, i1 true) #3
  store i32 %35, ptr @_ZL9thread_id, align 4, !tbaa !18
  %36 = icmp eq i32 %35, 0
  br i1 %36, label %67, label %37

37:                                               ; preds = %33
  %38 = getelementptr inbounds i8, ptr addrspace(1) %7, i64 8
  %39 = bitcast ptr addrspace(1) %38 to ptr addrspace(1)
  %40 = tail call i32 @air.atomic.global.add.u.i32(ptr addrspace(1) nocapture %39, i32 28, i32 0, i32 2, i1 true) #3
  %41 = add i32 %40, 28
  %42 = icmp ugt i32 %41, 1073741823
  %43 = select i1 %42, i32 28, i32 0
  %44 = tail call i32 @air.atomic.global.sub.u.i32(ptr addrspace(1) nocapture %39, i32 %43, i32 0, i32 2, i1 true) #3
  %45 = getelementptr inbounds i8, ptr addrspace(1) %7, i64 4
  %46 = bitcast ptr addrspace(1) %45 to ptr addrspace(1)
  %47 = load i32, ptr addrspace(1) %46, align 4, !tbaa !20
  %48 = icmp uge i32 %41, %47
  %49 = zext i32 %40 to i64
  %50 = getelementptr inbounds i8, ptr addrspace(1) %7, i64 %49
  %51 = icmp eq ptr addrspace(1) %50, null
  %52 = select i1 %48, i1 true, i1 %51
  br i1 %52, label %53, label %54

53:                                               ; preds = %37
  store i32 0, ptr @_ZL9thread_id, align 4, !tbaa !18
  br label %67

54:                                               ; preds = %37
  %55 = bitcast ptr addrspace(1) %50 to ptr addrspace(1)
  %56 = load i32, ptr @_ZL9thread_id, align 4
  store i32 %56, ptr addrspace(1) %55, align 4
  %57 = getelementptr inbounds i8, ptr addrspace(1) %50, i64 4
  %58 = load i32, ptr addrspace(2) %0, align 4, !tbaa !18
  %59 = shl i32 %58, 24
  %60 = and i32 %1, 16777215
  %61 = or i32 %59, %60
  %62 = bitcast ptr addrspace(1) %57 to ptr addrspace(1)
  store i32 %61, ptr addrspace(1) %62, align 4
  %63 = getelementptr inbounds i8, ptr addrspace(1) %50, i64 8
  %64 = bitcast ptr addrspace(1) %63 to ptr addrspace(1)
  store i32 %2, ptr addrspace(1) %64, align 4
  %65 = getelementptr inbounds i8, ptr addrspace(1) %50, i64 12
  %66 = bitcast ptr addrspace(1) %65 to ptr addrspace(1)
  store <3 x float> %4, ptr addrspace(1) %66, align 4
  br label %67

67:                                               ; preds = %54, %53, %33, %32
  ret void
}

; Function Attrs: convergent noinline nounwind optsize
define void @_Z24object_thread_tracepointPU11MTLconstantKjjDv3_j(ptr addrspace(2) nocapture readonly %0, i32 %1, <3 x i32> %2) local_unnamed_addr #0 {
  %4 = tail call ptr addrspace(1) @__tracepoint_get_trace_buffer() #8
  %5 = getelementptr inbounds i8, ptr addrspace(1) %4, i64 16
  %6 = bitcast ptr addrspace(1) %5 to ptr addrspace(1)
  %7 = load <3 x i32>, ptr addrspace(1) %6, align 16, !tbaa !15
  %8 = icmp ule <3 x i32> %7, %2
  %9 = tail call i1 @air.all.v3i1(<3 x i1> %8) #2
  br i1 %9, label %10, label %16

10:                                               ; preds = %3
  %11 = getelementptr inbounds i8, ptr addrspace(1) %4, i64 32
  %12 = bitcast ptr addrspace(1) %11 to ptr addrspace(1)
  %13 = load <3 x i32>, ptr addrspace(1) %12, align 16, !tbaa !15
  %14 = icmp uge <3 x i32> %13, %2
  %15 = tail call i1 @air.all.v3i1(<3 x i1> %14) #2
  br i1 %15, label %17, label %16

16:                                               ; preds = %10, %3
  store i32 0, ptr @_ZL9thread_id, align 4, !tbaa !18
  br label %49

17:                                               ; preds = %10
  %18 = bitcast ptr addrspace(1) %4 to ptr addrspace(1)
  %19 = tail call i32 @air.atomic.global.add.u.i32(ptr addrspace(1) nocapture %18, i32 1, i32 0, i32 2, i1 true) #3
  store i32 %19, ptr @_ZL9thread_id, align 4, !tbaa !18
  %20 = icmp eq i32 %19, 0
  br i1 %20, label %49, label %21

21:                                               ; preds = %17
  %22 = getelementptr inbounds i8, ptr addrspace(1) %4, i64 8
  %23 = bitcast ptr addrspace(1) %22 to ptr addrspace(1)
  %24 = tail call i32 @air.atomic.global.add.u.i32(ptr addrspace(1) nocapture %23, i32 24, i32 0, i32 2, i1 true) #3
  %25 = add i32 %24, 24
  %26 = icmp ugt i32 %25, 1073741823
  %27 = select i1 %26, i32 24, i32 0
  %28 = tail call i32 @air.atomic.global.sub.u.i32(ptr addrspace(1) nocapture %23, i32 %27, i32 0, i32 2, i1 true) #3
  %29 = getelementptr inbounds i8, ptr addrspace(1) %4, i64 4
  %30 = bitcast ptr addrspace(1) %29 to ptr addrspace(1)
  %31 = load i32, ptr addrspace(1) %30, align 4, !tbaa !20
  %32 = icmp uge i32 %25, %31
  %33 = zext i32 %24 to i64
  %34 = getelementptr inbounds i8, ptr addrspace(1) %4, i64 %33
  %35 = icmp eq ptr addrspace(1) %34, null
  %36 = select i1 %32, i1 true, i1 %35
  br i1 %36, label %37, label %38

37:                                               ; preds = %21
  store i32 0, ptr @_ZL9thread_id, align 4, !tbaa !18
  br label %49

38:                                               ; preds = %21
  %39 = bitcast ptr addrspace(1) %34 to ptr addrspace(1)
  %40 = load i32, ptr @_ZL9thread_id, align 4
  store i32 %40, ptr addrspace(1) %39, align 4
  %41 = getelementptr inbounds i8, ptr addrspace(1) %34, i64 4
  %42 = load i32, ptr addrspace(2) %0, align 4, !tbaa !18
  %43 = shl i32 %42, 24
  %44 = and i32 %1, 16777215
  %45 = or i32 %43, %44
  %46 = bitcast ptr addrspace(1) %41 to ptr addrspace(1)
  store i32 %45, ptr addrspace(1) %46, align 4
  %47 = getelementptr inbounds i8, ptr addrspace(1) %34, i64 8
  %48 = bitcast ptr addrspace(1) %47 to ptr addrspace(1)
  store <3 x i32> %2, ptr addrspace(1) %48, align 4
  br label %49

49:                                               ; preds = %38, %37, %17, %16
  ret void
}

; Function Attrs: convergent noinline nounwind optsize
define void @_Z22mesh_thread_tracepointPU11MTLconstantKjjDv3_jS1_j(ptr addrspace(2) nocapture readonly %0, i32 %1, <3 x i32> %2, <3 x i32> %3, i32 %4) local_unnamed_addr #0 {
  %6 = tail call ptr addrspace(1) @__tracepoint_get_trace_buffer() #8
  %7 = getelementptr inbounds i8, ptr addrspace(1) %6, i64 48
  %8 = bitcast ptr addrspace(1) %7 to ptr addrspace(1)
  %9 = load <3 x i32>, ptr addrspace(1) %8, align 16, !tbaa !15
  %10 = icmp ne <3 x i32> %9, %3
  %11 = tail call i1 @air.any.v3i1(<3 x i1> %10) #2
  br i1 %11, label %29, label %12

12:                                               ; preds = %5
  %13 = getelementptr inbounds i8, ptr addrspace(1) %6, i64 64
  %14 = bitcast ptr addrspace(1) %13 to ptr addrspace(1)
  %15 = load i32, ptr addrspace(1) %14, align 16, !tbaa !36
  %16 = icmp eq i32 %15, %4
  br i1 %16, label %17, label %29

17:                                               ; preds = %12
  %18 = getelementptr inbounds i8, ptr addrspace(1) %6, i64 16
  %19 = bitcast ptr addrspace(1) %18 to ptr addrspace(1)
  %20 = load <3 x i32>, ptr addrspace(1) %19, align 16, !tbaa !15
  %21 = icmp ule <3 x i32> %20, %2
  %22 = tail call i1 @air.all.v3i1(<3 x i1> %21) #2
  br i1 %22, label %23, label %29

23:                                               ; preds = %17
  %24 = getelementptr inbounds i8, ptr addrspace(1) %6, i64 32
  %25 = bitcast ptr addrspace(1) %24 to ptr addrspace(1)
  %26 = load <3 x i32>, ptr addrspace(1) %25, align 16, !tbaa !15
  %27 = icmp uge <3 x i32> %26, %2
  %28 = tail call i1 @air.all.v3i1(<3 x i1> %27) #2
  br i1 %28, label %30, label %29

29:                                               ; preds = %23, %17, %12, %5
  store i32 0, ptr @_ZL9thread_id, align 4, !tbaa !18
  br label %62

30:                                               ; preds = %23
  %31 = bitcast ptr addrspace(1) %6 to ptr addrspace(1)
  %32 = tail call i32 @air.atomic.global.add.u.i32(ptr addrspace(1) nocapture %31, i32 1, i32 0, i32 2, i1 true) #3
  store i32 %32, ptr @_ZL9thread_id, align 4, !tbaa !18
  %33 = icmp eq i32 %32, 0
  br i1 %33, label %62, label %34

34:                                               ; preds = %30
  %35 = getelementptr inbounds i8, ptr addrspace(1) %6, i64 8
  %36 = bitcast ptr addrspace(1) %35 to ptr addrspace(1)
  %37 = tail call i32 @air.atomic.global.add.u.i32(ptr addrspace(1) nocapture %36, i32 24, i32 0, i32 2, i1 true) #3
  %38 = add i32 %37, 24
  %39 = icmp ugt i32 %38, 1073741823
  %40 = select i1 %39, i32 24, i32 0
  %41 = tail call i32 @air.atomic.global.sub.u.i32(ptr addrspace(1) nocapture %36, i32 %40, i32 0, i32 2, i1 true) #3
  %42 = getelementptr inbounds i8, ptr addrspace(1) %6, i64 4
  %43 = bitcast ptr addrspace(1) %42 to ptr addrspace(1)
  %44 = load i32, ptr addrspace(1) %43, align 4, !tbaa !20
  %45 = icmp uge i32 %38, %44
  %46 = zext i32 %37 to i64
  %47 = getelementptr inbounds i8, ptr addrspace(1) %6, i64 %46
  %48 = icmp eq ptr addrspace(1) %47, null
  %49 = select i1 %45, i1 true, i1 %48
  br i1 %49, label %50, label %51

50:                                               ; preds = %34
  store i32 0, ptr @_ZL9thread_id, align 4, !tbaa !18
  br label %62

51:                                               ; preds = %34
  %52 = bitcast ptr addrspace(1) %47 to ptr addrspace(1)
  %53 = load i32, ptr @_ZL9thread_id, align 4
  store i32 %53, ptr addrspace(1) %52, align 4
  %54 = getelementptr inbounds i8, ptr addrspace(1) %47, i64 4
  %55 = load i32, ptr addrspace(2) %0, align 4, !tbaa !18
  %56 = shl i32 %55, 24
  %57 = and i32 %1, 16777215
  %58 = or i32 %56, %57
  %59 = bitcast ptr addrspace(1) %54 to ptr addrspace(1)
  store i32 %58, ptr addrspace(1) %59, align 4
  %60 = getelementptr inbounds i8, ptr addrspace(1) %47, i64 8
  %61 = bitcast ptr addrspace(1) %60 to ptr addrspace(1)
  store <3 x i32> %2, ptr addrspace(1) %61, align 4
  br label %62

62:                                               ; preds = %51, %50, %30, %29
  ret void
}

; Function Attrs: nounwind memory(none)
declare i1 @air.any.v3i1(<3 x i1>) local_unnamed_addr #2

; Function Attrs: convergent nounwind optsize
define ptr addrspace(1) @__tracepoint_impl(ptr addrspace(2) nocapture readonly %0, i32 %1, i32 %2) local_unnamed_addr #6 {
  %4 = load i32, ptr @_ZL9thread_id, align 4, !tbaa !18
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %35, label %6

6:                                                ; preds = %3
  %7 = tail call ptr addrspace(1) @__tracepoint_get_trace_buffer() #8
  %8 = add i32 %2, 11
  %9 = and i32 %8, -4
  %10 = getelementptr inbounds i8, ptr addrspace(1) %7, i64 8
  %11 = bitcast ptr addrspace(1) %10 to ptr addrspace(1)
  %12 = tail call i32 @air.atomic.global.add.u.i32(ptr addrspace(1) nocapture %11, i32 %9, i32 0, i32 2, i1 true) #3
  %13 = add i32 %12, %9
  %14 = icmp ugt i32 %13, 1073741823
  %15 = select i1 %14, i32 %9, i32 0
  %16 = tail call i32 @air.atomic.global.sub.u.i32(ptr addrspace(1) nocapture %11, i32 %15, i32 0, i32 2, i1 true) #3
  %17 = getelementptr inbounds i8, ptr addrspace(1) %7, i64 4
  %18 = bitcast ptr addrspace(1) %17 to ptr addrspace(1)
  %19 = load i32, ptr addrspace(1) %18, align 4, !tbaa !20
  %20 = icmp uge i32 %13, %19
  %21 = zext i32 %12 to i64
  %22 = getelementptr inbounds i8, ptr addrspace(1) %7, i64 %21
  %23 = icmp eq ptr addrspace(1) %22, null
  %24 = select i1 %20, i1 true, i1 %23
  br i1 %24, label %35, label %25

25:                                               ; preds = %6
  %26 = bitcast ptr addrspace(1) %22 to ptr addrspace(1)
  %27 = load i32, ptr @_ZL9thread_id, align 4
  store i32 %27, ptr addrspace(1) %26, align 4
  %28 = getelementptr inbounds i8, ptr addrspace(1) %22, i64 4
  %29 = load i32, ptr addrspace(2) %0, align 4, !tbaa !18
  %30 = shl i32 %29, 24
  %31 = and i32 %1, 16777215
  %32 = or i32 %30, %31
  %33 = bitcast ptr addrspace(1) %28 to ptr addrspace(1)
  store i32 %32, ptr addrspace(1) %33, align 4
  %34 = getelementptr inbounds i8, ptr addrspace(1) %22, i64 8
  br label %35

35:                                               ; preds = %25, %6, %3
  %36 = phi ptr addrspace(1) [ null, %3 ], [ %34, %25 ], [ null, %6 ]
  ret ptr addrspace(1) %36
}

; Function Attrs: convergent noinline nounwind optsize
define void @__tracepoint_waypoint(ptr addrspace(2) nocapture readonly %0, i32 %1) local_unnamed_addr #4 {
  %3 = load i32, ptr @_ZL9thread_id, align 4, !tbaa !18
  %4 = icmp eq i32 %3, 0
  br i1 %4, label %31, label %5

5:                                                ; preds = %2
  %6 = tail call ptr addrspace(1) @__tracepoint_get_trace_buffer() #8
  %7 = getelementptr inbounds i8, ptr addrspace(1) %6, i64 8
  %8 = bitcast ptr addrspace(1) %7 to ptr addrspace(1)
  %9 = tail call i32 @air.atomic.global.add.u.i32(ptr addrspace(1) nocapture %8, i32 8, i32 0, i32 2, i1 true) #3
  %10 = add i32 %9, 8
  %11 = icmp ugt i32 %10, 1073741823
  %12 = select i1 %11, i32 8, i32 0
  %13 = tail call i32 @air.atomic.global.sub.u.i32(ptr addrspace(1) nocapture %8, i32 %12, i32 0, i32 2, i1 true) #3
  %14 = getelementptr inbounds i8, ptr addrspace(1) %6, i64 4
  %15 = bitcast ptr addrspace(1) %14 to ptr addrspace(1)
  %16 = load i32, ptr addrspace(1) %15, align 4, !tbaa !20
  %17 = icmp uge i32 %10, %16
  %18 = zext i32 %9 to i64
  %19 = getelementptr inbounds i8, ptr addrspace(1) %6, i64 %18
  %20 = icmp eq ptr addrspace(1) %19, null
  %21 = select i1 %17, i1 true, i1 %20
  br i1 %21, label %31, label %22

22:                                               ; preds = %5
  %23 = bitcast ptr addrspace(1) %19 to ptr addrspace(1)
  %24 = load i32, ptr @_ZL9thread_id, align 4
  store i32 %24, ptr addrspace(1) %23, align 4
  %25 = getelementptr inbounds i8, ptr addrspace(1) %19, i64 4
  %26 = load i32, ptr addrspace(2) %0, align 4, !tbaa !18
  %27 = shl i32 %26, 24
  %28 = and i32 %1, 16777215
  %29 = or i32 %27, %28
  %30 = bitcast ptr addrspace(1) %25 to ptr addrspace(1)
  store i32 %29, ptr addrspace(1) %30, align 4
  br label %31

31:                                               ; preds = %22, %5, %2
  ret void
}

; Function Attrs: convergent noinline nounwind optsize
define void @__tracepoint_variable.p0i8(ptr addrspace(2) nocapture readonly %0, i32 %1, ptr %2) local_unnamed_addr #4 {
  %4 = load i32, ptr @_ZL9thread_id, align 4, !tbaa !18
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %34, label %6

6:                                                ; preds = %3
  %7 = tail call ptr addrspace(1) @__tracepoint_get_trace_buffer() #8
  %8 = getelementptr inbounds i8, ptr addrspace(1) %7, i64 8
  %9 = bitcast ptr addrspace(1) %8 to ptr addrspace(1)
  %10 = tail call i32 @air.atomic.global.add.u.i32(ptr addrspace(1) nocapture %9, i32 16, i32 0, i32 2, i1 true) #3
  %11 = add i32 %10, 16
  %12 = icmp ugt i32 %11, 1073741823
  %13 = select i1 %12, i32 16, i32 0
  %14 = tail call i32 @air.atomic.global.sub.u.i32(ptr addrspace(1) nocapture %9, i32 %13, i32 0, i32 2, i1 true) #3
  %15 = getelementptr inbounds i8, ptr addrspace(1) %7, i64 4
  %16 = bitcast ptr addrspace(1) %15 to ptr addrspace(1)
  %17 = load i32, ptr addrspace(1) %16, align 4, !tbaa !20
  %18 = icmp uge i32 %11, %17
  %19 = zext i32 %10 to i64
  %20 = getelementptr inbounds i8, ptr addrspace(1) %7, i64 %19
  %21 = icmp eq ptr addrspace(1) %20, null
  %22 = select i1 %18, i1 true, i1 %21
  br i1 %22, label %34, label %23

23:                                               ; preds = %6
  %24 = bitcast ptr addrspace(1) %20 to ptr addrspace(1)
  %25 = load i32, ptr @_ZL9thread_id, align 4
  store i32 %25, ptr addrspace(1) %24, align 4
  %26 = getelementptr inbounds i8, ptr addrspace(1) %20, i64 4
  %27 = load i32, ptr addrspace(2) %0, align 4, !tbaa !18
  %28 = shl i32 %27, 24
  %29 = and i32 %1, 16777215
  %30 = or i32 %28, %29
  %31 = bitcast ptr addrspace(1) %26 to ptr addrspace(1)
  store i32 %30, ptr addrspace(1) %31, align 4
  %32 = getelementptr inbounds i8, ptr addrspace(1) %20, i64 8
  %33 = bitcast ptr addrspace(1) %32 to ptr addrspace(1)
  store ptr %2, ptr addrspace(1) %33, align 4
  br label %34

34:                                               ; preds = %23, %6, %3
  ret void
}

; Function Attrs: convergent noinline nounwind optsize
define void @__tracepoint_variable.p2i8(ptr addrspace(2) nocapture readonly %0, i32 %1, ptr addrspace(2) %2) local_unnamed_addr #4 {
  %4 = load i32, ptr @_ZL9thread_id, align 4, !tbaa !18
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %34, label %6

6:                                                ; preds = %3
  %7 = tail call ptr addrspace(1) @__tracepoint_get_trace_buffer() #8
  %8 = getelementptr inbounds i8, ptr addrspace(1) %7, i64 8
  %9 = bitcast ptr addrspace(1) %8 to ptr addrspace(1)
  %10 = tail call i32 @air.atomic.global.add.u.i32(ptr addrspace(1) nocapture %9, i32 16, i32 0, i32 2, i1 true) #3
  %11 = add i32 %10, 16
  %12 = icmp ugt i32 %11, 1073741823
  %13 = select i1 %12, i32 16, i32 0
  %14 = tail call i32 @air.atomic.global.sub.u.i32(ptr addrspace(1) nocapture %9, i32 %13, i32 0, i32 2, i1 true) #3
  %15 = getelementptr inbounds i8, ptr addrspace(1) %7, i64 4
  %16 = bitcast ptr addrspace(1) %15 to ptr addrspace(1)
  %17 = load i32, ptr addrspace(1) %16, align 4, !tbaa !20
  %18 = icmp uge i32 %11, %17
  %19 = zext i32 %10 to i64
  %20 = getelementptr inbounds i8, ptr addrspace(1) %7, i64 %19
  %21 = icmp eq ptr addrspace(1) %20, null
  %22 = select i1 %18, i1 true, i1 %21
  br i1 %22, label %34, label %23

23:                                               ; preds = %6
  %24 = bitcast ptr addrspace(1) %20 to ptr addrspace(1)
  %25 = load i32, ptr @_ZL9thread_id, align 4
  store i32 %25, ptr addrspace(1) %24, align 4
  %26 = getelementptr inbounds i8, ptr addrspace(1) %20, i64 4
  %27 = load i32, ptr addrspace(2) %0, align 4, !tbaa !18
  %28 = shl i32 %27, 24
  %29 = and i32 %1, 16777215
  %30 = or i32 %28, %29
  %31 = bitcast ptr addrspace(1) %26 to ptr addrspace(1)
  store i32 %30, ptr addrspace(1) %31, align 4
  %32 = getelementptr inbounds i8, ptr addrspace(1) %20, i64 8
  %33 = bitcast ptr addrspace(1) %32 to ptr addrspace(1)
  store ptr addrspace(2) %2, ptr addrspace(1) %33, align 4
  br label %34

34:                                               ; preds = %23, %6, %3
  ret void
}

; Function Attrs: convergent noinline nounwind optsize
define void @__tracepoint_variable.p3i8(ptr addrspace(2) nocapture readonly %0, i32 %1, ptr addrspace(3) %2) local_unnamed_addr #4 {
  %4 = load i32, ptr @_ZL9thread_id, align 4, !tbaa !18
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %34, label %6

6:                                                ; preds = %3
  %7 = tail call ptr addrspace(1) @__tracepoint_get_trace_buffer() #8
  %8 = getelementptr inbounds i8, ptr addrspace(1) %7, i64 8
  %9 = bitcast ptr addrspace(1) %8 to ptr addrspace(1)
  %10 = tail call i32 @air.atomic.global.add.u.i32(ptr addrspace(1) nocapture %9, i32 16, i32 0, i32 2, i1 true) #3
  %11 = add i32 %10, 16
  %12 = icmp ugt i32 %11, 1073741823
  %13 = select i1 %12, i32 16, i32 0
  %14 = tail call i32 @air.atomic.global.sub.u.i32(ptr addrspace(1) nocapture %9, i32 %13, i32 0, i32 2, i1 true) #3
  %15 = getelementptr inbounds i8, ptr addrspace(1) %7, i64 4
  %16 = bitcast ptr addrspace(1) %15 to ptr addrspace(1)
  %17 = load i32, ptr addrspace(1) %16, align 4, !tbaa !20
  %18 = icmp uge i32 %11, %17
  %19 = zext i32 %10 to i64
  %20 = getelementptr inbounds i8, ptr addrspace(1) %7, i64 %19
  %21 = icmp eq ptr addrspace(1) %20, null
  %22 = select i1 %18, i1 true, i1 %21
  br i1 %22, label %34, label %23

23:                                               ; preds = %6
  %24 = bitcast ptr addrspace(1) %20 to ptr addrspace(1)
  %25 = load i32, ptr @_ZL9thread_id, align 4
  store i32 %25, ptr addrspace(1) %24, align 4
  %26 = getelementptr inbounds i8, ptr addrspace(1) %20, i64 4
  %27 = load i32, ptr addrspace(2) %0, align 4, !tbaa !18
  %28 = shl i32 %27, 24
  %29 = and i32 %1, 16777215
  %30 = or i32 %28, %29
  %31 = bitcast ptr addrspace(1) %26 to ptr addrspace(1)
  store i32 %30, ptr addrspace(1) %31, align 4
  %32 = getelementptr inbounds i8, ptr addrspace(1) %20, i64 8
  %33 = bitcast ptr addrspace(1) %32 to ptr addrspace(1)
  store ptr addrspace(3) %2, ptr addrspace(1) %33, align 4
  br label %34

34:                                               ; preds = %23, %6, %3
  ret void
}

; Function Attrs: convergent noinline nounwind optsize
define void @__tracepoint_data.p0i8(ptr addrspace(2) nocapture readonly %0, i32 %1, ptr %2, i32 %3) local_unnamed_addr #4 {
  %5 = load i32, ptr @_ZL9thread_id, align 4, !tbaa !18
  %6 = icmp eq i32 %5, 0
  br i1 %6, label %39, label %7

7:                                                ; preds = %4
  %8 = tail call ptr addrspace(1) @__tracepoint_get_trace_buffer() #8
  %9 = add i32 %3, 19
  %10 = and i32 %9, -4
  %11 = getelementptr inbounds i8, ptr addrspace(1) %8, i64 8
  %12 = bitcast ptr addrspace(1) %11 to ptr addrspace(1)
  %13 = tail call i32 @air.atomic.global.add.u.i32(ptr addrspace(1) nocapture %12, i32 %10, i32 0, i32 2, i1 true) #3
  %14 = add i32 %13, %10
  %15 = icmp ugt i32 %14, 1073741823
  %16 = select i1 %15, i32 %10, i32 0
  %17 = tail call i32 @air.atomic.global.sub.u.i32(ptr addrspace(1) nocapture %12, i32 %16, i32 0, i32 2, i1 true) #3
  %18 = getelementptr inbounds i8, ptr addrspace(1) %8, i64 4
  %19 = bitcast ptr addrspace(1) %18 to ptr addrspace(1)
  %20 = load i32, ptr addrspace(1) %19, align 4, !tbaa !20
  %21 = icmp uge i32 %14, %20
  %22 = zext i32 %13 to i64
  %23 = getelementptr inbounds i8, ptr addrspace(1) %8, i64 %22
  %24 = icmp eq ptr addrspace(1) %23, null
  %25 = select i1 %21, i1 true, i1 %24
  br i1 %25, label %39, label %26

26:                                               ; preds = %7
  %27 = bitcast ptr addrspace(1) %23 to ptr addrspace(1)
  %28 = load i32, ptr @_ZL9thread_id, align 4
  store i32 %28, ptr addrspace(1) %27, align 4
  %29 = getelementptr inbounds i8, ptr addrspace(1) %23, i64 4
  %30 = load i32, ptr addrspace(2) %0, align 4, !tbaa !18
  %31 = shl i32 %30, 24
  %32 = and i32 %1, 16777215
  %33 = or i32 %31, %32
  %34 = bitcast ptr addrspace(1) %29 to ptr addrspace(1)
  store i32 %33, ptr addrspace(1) %34, align 4
  %35 = getelementptr inbounds i8, ptr addrspace(1) %23, i64 8
  %36 = bitcast ptr addrspace(1) %35 to ptr addrspace(1)
  store ptr %2, ptr addrspace(1) %36, align 4
  %37 = getelementptr inbounds i8, ptr addrspace(1) %23, i64 16
  %38 = zext i32 %3 to i64
  tail call void @llvm.memcpy.p1.p0.i64(ptr addrspace(1) align 4 %37, ptr align 1 %2, i64 %38, i1 false)
  br label %39

39:                                               ; preds = %26, %7, %4
  ret void
}

; Function Attrs: convergent noinline nounwind optsize
define void @__tracepoint_data.p1i8(ptr addrspace(2) nocapture readonly %0, i32 %1, ptr addrspace(1) %2, i32 %3) local_unnamed_addr #4 {
  %5 = load i32, ptr @_ZL9thread_id, align 4, !tbaa !18
  %6 = icmp eq i32 %5, 0
  br i1 %6, label %39, label %7

7:                                                ; preds = %4
  %8 = tail call ptr addrspace(1) @__tracepoint_get_trace_buffer() #8
  %9 = add i32 %3, 19
  %10 = and i32 %9, -4
  %11 = getelementptr inbounds i8, ptr addrspace(1) %8, i64 8
  %12 = bitcast ptr addrspace(1) %11 to ptr addrspace(1)
  %13 = tail call i32 @air.atomic.global.add.u.i32(ptr addrspace(1) nocapture %12, i32 %10, i32 0, i32 2, i1 true) #3
  %14 = add i32 %13, %10
  %15 = icmp ugt i32 %14, 1073741823
  %16 = select i1 %15, i32 %10, i32 0
  %17 = tail call i32 @air.atomic.global.sub.u.i32(ptr addrspace(1) nocapture %12, i32 %16, i32 0, i32 2, i1 true) #3
  %18 = getelementptr inbounds i8, ptr addrspace(1) %8, i64 4
  %19 = bitcast ptr addrspace(1) %18 to ptr addrspace(1)
  %20 = load i32, ptr addrspace(1) %19, align 4, !tbaa !20
  %21 = icmp uge i32 %14, %20
  %22 = zext i32 %13 to i64
  %23 = getelementptr inbounds i8, ptr addrspace(1) %8, i64 %22
  %24 = icmp eq ptr addrspace(1) %23, null
  %25 = select i1 %21, i1 true, i1 %24
  br i1 %25, label %39, label %26

26:                                               ; preds = %7
  %27 = bitcast ptr addrspace(1) %23 to ptr addrspace(1)
  %28 = load i32, ptr @_ZL9thread_id, align 4
  store i32 %28, ptr addrspace(1) %27, align 4
  %29 = getelementptr inbounds i8, ptr addrspace(1) %23, i64 4
  %30 = load i32, ptr addrspace(2) %0, align 4, !tbaa !18
  %31 = shl i32 %30, 24
  %32 = and i32 %1, 16777215
  %33 = or i32 %31, %32
  %34 = bitcast ptr addrspace(1) %29 to ptr addrspace(1)
  store i32 %33, ptr addrspace(1) %34, align 4
  %35 = getelementptr inbounds i8, ptr addrspace(1) %23, i64 8
  %36 = bitcast ptr addrspace(1) %35 to ptr addrspace(1)
  store ptr addrspace(1) %2, ptr addrspace(1) %36, align 4
  %37 = getelementptr inbounds i8, ptr addrspace(1) %23, i64 16
  %38 = zext i32 %3 to i64
  tail call void @llvm.memcpy.p1.p1.i64(ptr addrspace(1) align 4 %37, ptr addrspace(1) align 1 %2, i64 %38, i1 false)
  br label %39

39:                                               ; preds = %26, %7, %4
  ret void
}

; Function Attrs: convergent noinline nounwind optsize
define void @__tracepoint_data.p2i8(ptr addrspace(2) nocapture readonly %0, i32 %1, ptr addrspace(2) %2, i32 %3) local_unnamed_addr #4 {
  %5 = load i32, ptr @_ZL9thread_id, align 4, !tbaa !18
  %6 = icmp eq i32 %5, 0
  br i1 %6, label %39, label %7

7:                                                ; preds = %4
  %8 = tail call ptr addrspace(1) @__tracepoint_get_trace_buffer() #8
  %9 = add i32 %3, 19
  %10 = and i32 %9, -4
  %11 = getelementptr inbounds i8, ptr addrspace(1) %8, i64 8
  %12 = bitcast ptr addrspace(1) %11 to ptr addrspace(1)
  %13 = tail call i32 @air.atomic.global.add.u.i32(ptr addrspace(1) nocapture %12, i32 %10, i32 0, i32 2, i1 true) #3
  %14 = add i32 %13, %10
  %15 = icmp ugt i32 %14, 1073741823
  %16 = select i1 %15, i32 %10, i32 0
  %17 = tail call i32 @air.atomic.global.sub.u.i32(ptr addrspace(1) nocapture %12, i32 %16, i32 0, i32 2, i1 true) #3
  %18 = getelementptr inbounds i8, ptr addrspace(1) %8, i64 4
  %19 = bitcast ptr addrspace(1) %18 to ptr addrspace(1)
  %20 = load i32, ptr addrspace(1) %19, align 4, !tbaa !20
  %21 = icmp uge i32 %14, %20
  %22 = zext i32 %13 to i64
  %23 = getelementptr inbounds i8, ptr addrspace(1) %8, i64 %22
  %24 = icmp eq ptr addrspace(1) %23, null
  %25 = select i1 %21, i1 true, i1 %24
  br i1 %25, label %39, label %26

26:                                               ; preds = %7
  %27 = bitcast ptr addrspace(1) %23 to ptr addrspace(1)
  %28 = load i32, ptr @_ZL9thread_id, align 4
  store i32 %28, ptr addrspace(1) %27, align 4
  %29 = getelementptr inbounds i8, ptr addrspace(1) %23, i64 4
  %30 = load i32, ptr addrspace(2) %0, align 4, !tbaa !18
  %31 = shl i32 %30, 24
  %32 = and i32 %1, 16777215
  %33 = or i32 %31, %32
  %34 = bitcast ptr addrspace(1) %29 to ptr addrspace(1)
  store i32 %33, ptr addrspace(1) %34, align 4
  %35 = getelementptr inbounds i8, ptr addrspace(1) %23, i64 8
  %36 = bitcast ptr addrspace(1) %35 to ptr addrspace(1)
  store ptr addrspace(2) %2, ptr addrspace(1) %36, align 4
  %37 = getelementptr inbounds i8, ptr addrspace(1) %23, i64 16
  %38 = zext i32 %3 to i64
  tail call void @llvm.memcpy.p1.p2.i64(ptr addrspace(1) align 4 %37, ptr addrspace(2) align 1 %2, i64 %38, i1 false)
  br label %39

39:                                               ; preds = %26, %7, %4
  ret void
}

; Function Attrs: convergent noinline nounwind optsize
define void @__tracepoint_data.p3i8(ptr addrspace(2) nocapture readonly %0, i32 %1, ptr addrspace(3) %2, i32 %3) local_unnamed_addr #4 {
  %5 = load i32, ptr @_ZL9thread_id, align 4, !tbaa !18
  %6 = icmp eq i32 %5, 0
  br i1 %6, label %39, label %7

7:                                                ; preds = %4
  %8 = tail call ptr addrspace(1) @__tracepoint_get_trace_buffer() #8
  %9 = add i32 %3, 19
  %10 = and i32 %9, -4
  %11 = getelementptr inbounds i8, ptr addrspace(1) %8, i64 8
  %12 = bitcast ptr addrspace(1) %11 to ptr addrspace(1)
  %13 = tail call i32 @air.atomic.global.add.u.i32(ptr addrspace(1) nocapture %12, i32 %10, i32 0, i32 2, i1 true) #3
  %14 = add i32 %13, %10
  %15 = icmp ugt i32 %14, 1073741823
  %16 = select i1 %15, i32 %10, i32 0
  %17 = tail call i32 @air.atomic.global.sub.u.i32(ptr addrspace(1) nocapture %12, i32 %16, i32 0, i32 2, i1 true) #3
  %18 = getelementptr inbounds i8, ptr addrspace(1) %8, i64 4
  %19 = bitcast ptr addrspace(1) %18 to ptr addrspace(1)
  %20 = load i32, ptr addrspace(1) %19, align 4, !tbaa !20
  %21 = icmp uge i32 %14, %20
  %22 = zext i32 %13 to i64
  %23 = getelementptr inbounds i8, ptr addrspace(1) %8, i64 %22
  %24 = icmp eq ptr addrspace(1) %23, null
  %25 = select i1 %21, i1 true, i1 %24
  br i1 %25, label %39, label %26

26:                                               ; preds = %7
  %27 = bitcast ptr addrspace(1) %23 to ptr addrspace(1)
  %28 = load i32, ptr @_ZL9thread_id, align 4
  store i32 %28, ptr addrspace(1) %27, align 4
  %29 = getelementptr inbounds i8, ptr addrspace(1) %23, i64 4
  %30 = load i32, ptr addrspace(2) %0, align 4, !tbaa !18
  %31 = shl i32 %30, 24
  %32 = and i32 %1, 16777215
  %33 = or i32 %31, %32
  %34 = bitcast ptr addrspace(1) %29 to ptr addrspace(1)
  store i32 %33, ptr addrspace(1) %34, align 4
  %35 = getelementptr inbounds i8, ptr addrspace(1) %23, i64 8
  %36 = bitcast ptr addrspace(1) %35 to ptr addrspace(1)
  store ptr addrspace(3) %2, ptr addrspace(1) %36, align 4
  %37 = getelementptr inbounds i8, ptr addrspace(1) %23, i64 16
  %38 = zext i32 %3 to i64
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) align 4 %37, ptr addrspace(3) align 1 %2, i64 %38, i1 false)
  br label %39

39:                                               ; preds = %26, %7, %4
  ret void
}

; Function Attrs: convergent noinline nounwind optsize
define void @__tracepoint_data_value.p0i8.i64(ptr addrspace(2) nocapture readonly %0, i32 %1, ptr %2, i64 %3) local_unnamed_addr #4 {
  %5 = load i32, ptr @_ZL9thread_id, align 4, !tbaa !18
  %6 = icmp eq i32 %5, 0
  br i1 %6, label %37, label %7

7:                                                ; preds = %4
  %8 = tail call ptr addrspace(1) @__tracepoint_get_trace_buffer() #8
  %9 = getelementptr inbounds i8, ptr addrspace(1) %8, i64 8
  %10 = bitcast ptr addrspace(1) %9 to ptr addrspace(1)
  %11 = tail call i32 @air.atomic.global.add.u.i32(ptr addrspace(1) nocapture %10, i32 24, i32 0, i32 2, i1 true) #3
  %12 = add i32 %11, 24
  %13 = icmp ugt i32 %12, 1073741823
  %14 = select i1 %13, i32 24, i32 0
  %15 = tail call i32 @air.atomic.global.sub.u.i32(ptr addrspace(1) nocapture %10, i32 %14, i32 0, i32 2, i1 true) #3
  %16 = getelementptr inbounds i8, ptr addrspace(1) %8, i64 4
  %17 = bitcast ptr addrspace(1) %16 to ptr addrspace(1)
  %18 = load i32, ptr addrspace(1) %17, align 4, !tbaa !20
  %19 = icmp uge i32 %12, %18
  %20 = zext i32 %11 to i64
  %21 = getelementptr inbounds i8, ptr addrspace(1) %8, i64 %20
  %22 = icmp eq ptr addrspace(1) %21, null
  %23 = select i1 %19, i1 true, i1 %22
  br i1 %23, label %37, label %24

24:                                               ; preds = %7
  %25 = bitcast ptr addrspace(1) %21 to ptr addrspace(1)
  %26 = load i32, ptr @_ZL9thread_id, align 4
  store i32 %26, ptr addrspace(1) %25, align 4
  %27 = getelementptr inbounds i8, ptr addrspace(1) %21, i64 4
  %28 = load i32, ptr addrspace(2) %0, align 4, !tbaa !18
  %29 = shl i32 %28, 24
  %30 = and i32 %1, 16777215
  %31 = or i32 %29, %30
  %32 = bitcast ptr addrspace(1) %27 to ptr addrspace(1)
  store i32 %31, ptr addrspace(1) %32, align 4
  %33 = getelementptr inbounds i8, ptr addrspace(1) %21, i64 8
  %34 = bitcast ptr addrspace(1) %33 to ptr addrspace(1)
  store ptr %2, ptr addrspace(1) %34, align 4
  %35 = getelementptr inbounds i8, ptr addrspace(1) %21, i64 16
  %36 = bitcast ptr addrspace(1) %35 to ptr addrspace(1)
  store i64 %3, ptr addrspace(1) %36, align 4
  br label %37

37:                                               ; preds = %24, %7, %4
  ret void
}

; Function Attrs: convergent noinline nounwind optsize
define void @__tracepoint_data_value.p1i8.i64(ptr addrspace(2) nocapture readonly %0, i32 %1, ptr addrspace(1) %2, i64 %3) local_unnamed_addr #4 {
  %5 = load i32, ptr @_ZL9thread_id, align 4, !tbaa !18
  %6 = icmp eq i32 %5, 0
  br i1 %6, label %37, label %7

7:                                                ; preds = %4
  %8 = tail call ptr addrspace(1) @__tracepoint_get_trace_buffer() #8
  %9 = getelementptr inbounds i8, ptr addrspace(1) %8, i64 8
  %10 = bitcast ptr addrspace(1) %9 to ptr addrspace(1)
  %11 = tail call i32 @air.atomic.global.add.u.i32(ptr addrspace(1) nocapture %10, i32 24, i32 0, i32 2, i1 true) #3
  %12 = add i32 %11, 24
  %13 = icmp ugt i32 %12, 1073741823
  %14 = select i1 %13, i32 24, i32 0
  %15 = tail call i32 @air.atomic.global.sub.u.i32(ptr addrspace(1) nocapture %10, i32 %14, i32 0, i32 2, i1 true) #3
  %16 = getelementptr inbounds i8, ptr addrspace(1) %8, i64 4
  %17 = bitcast ptr addrspace(1) %16 to ptr addrspace(1)
  %18 = load i32, ptr addrspace(1) %17, align 4, !tbaa !20
  %19 = icmp uge i32 %12, %18
  %20 = zext i32 %11 to i64
  %21 = getelementptr inbounds i8, ptr addrspace(1) %8, i64 %20
  %22 = icmp eq ptr addrspace(1) %21, null
  %23 = select i1 %19, i1 true, i1 %22
  br i1 %23, label %37, label %24

24:                                               ; preds = %7
  %25 = bitcast ptr addrspace(1) %21 to ptr addrspace(1)
  %26 = load i32, ptr @_ZL9thread_id, align 4
  store i32 %26, ptr addrspace(1) %25, align 4
  %27 = getelementptr inbounds i8, ptr addrspace(1) %21, i64 4
  %28 = load i32, ptr addrspace(2) %0, align 4, !tbaa !18
  %29 = shl i32 %28, 24
  %30 = and i32 %1, 16777215
  %31 = or i32 %29, %30
  %32 = bitcast ptr addrspace(1) %27 to ptr addrspace(1)
  store i32 %31, ptr addrspace(1) %32, align 4
  %33 = getelementptr inbounds i8, ptr addrspace(1) %21, i64 8
  %34 = bitcast ptr addrspace(1) %33 to ptr addrspace(1)
  store ptr addrspace(1) %2, ptr addrspace(1) %34, align 4
  %35 = getelementptr inbounds i8, ptr addrspace(1) %21, i64 16
  %36 = bitcast ptr addrspace(1) %35 to ptr addrspace(1)
  store i64 %3, ptr addrspace(1) %36, align 4
  br label %37

37:                                               ; preds = %24, %7, %4
  ret void
}

; Function Attrs: convergent noinline nounwind optsize
define void @__tracepoint_data_value.p2i8.i64(ptr addrspace(2) nocapture readonly %0, i32 %1, ptr addrspace(2) %2, i64 %3) local_unnamed_addr #4 {
  %5 = load i32, ptr @_ZL9thread_id, align 4, !tbaa !18
  %6 = icmp eq i32 %5, 0
  br i1 %6, label %37, label %7

7:                                                ; preds = %4
  %8 = tail call ptr addrspace(1) @__tracepoint_get_trace_buffer() #8
  %9 = getelementptr inbounds i8, ptr addrspace(1) %8, i64 8
  %10 = bitcast ptr addrspace(1) %9 to ptr addrspace(1)
  %11 = tail call i32 @air.atomic.global.add.u.i32(ptr addrspace(1) nocapture %10, i32 24, i32 0, i32 2, i1 true) #3
  %12 = add i32 %11, 24
  %13 = icmp ugt i32 %12, 1073741823
  %14 = select i1 %13, i32 24, i32 0
  %15 = tail call i32 @air.atomic.global.sub.u.i32(ptr addrspace(1) nocapture %10, i32 %14, i32 0, i32 2, i1 true) #3
  %16 = getelementptr inbounds i8, ptr addrspace(1) %8, i64 4
  %17 = bitcast ptr addrspace(1) %16 to ptr addrspace(1)
  %18 = load i32, ptr addrspace(1) %17, align 4, !tbaa !20
  %19 = icmp uge i32 %12, %18
  %20 = zext i32 %11 to i64
  %21 = getelementptr inbounds i8, ptr addrspace(1) %8, i64 %20
  %22 = icmp eq ptr addrspace(1) %21, null
  %23 = select i1 %19, i1 true, i1 %22
  br i1 %23, label %37, label %24

24:                                               ; preds = %7
  %25 = bitcast ptr addrspace(1) %21 to ptr addrspace(1)
  %26 = load i32, ptr @_ZL9thread_id, align 4
  store i32 %26, ptr addrspace(1) %25, align 4
  %27 = getelementptr inbounds i8, ptr addrspace(1) %21, i64 4
  %28 = load i32, ptr addrspace(2) %0, align 4, !tbaa !18
  %29 = shl i32 %28, 24
  %30 = and i32 %1, 16777215
  %31 = or i32 %29, %30
  %32 = bitcast ptr addrspace(1) %27 to ptr addrspace(1)
  store i32 %31, ptr addrspace(1) %32, align 4
  %33 = getelementptr inbounds i8, ptr addrspace(1) %21, i64 8
  %34 = bitcast ptr addrspace(1) %33 to ptr addrspace(1)
  store ptr addrspace(2) %2, ptr addrspace(1) %34, align 4
  %35 = getelementptr inbounds i8, ptr addrspace(1) %21, i64 16
  %36 = bitcast ptr addrspace(1) %35 to ptr addrspace(1)
  store i64 %3, ptr addrspace(1) %36, align 4
  br label %37

37:                                               ; preds = %24, %7, %4
  ret void
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p1.p0.i64(ptr addrspace(1) noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #7

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p1.p1.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(1) noalias nocapture readonly, i64, i1 immarg) #7

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p1.p2.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(2) noalias nocapture readonly, i64, i1 immarg) #7

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #7

attributes #0 = { convergent noinline nounwind optsize "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="96" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #1 = { convergent optsize "approx-func-fp-math"="true" "frame-pointer"="all" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #2 = { nounwind memory(none) }
attributes #3 = { nounwind }
attributes #4 = { convergent noinline nounwind optsize "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #5 = { convergent noinline nounwind optsize "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="128" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #6 = { convergent nounwind optsize "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="true" }
attributes #7 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #8 = { convergent nobuiltin nounwind optsize "no-builtins" }

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5, !6, !7}
!air.version = !{!8}
!air.compile_options = !{!9, !10, !11}
!llvm.ident = !{!12}
!air.language_version = !{!13}
!air.source_file_name = !{!14}

!0 = !{i32 7, !"air.max_device_buffers", i32 31}
!1 = !{i32 7, !"air.max_constant_buffers", i32 31}
!2 = !{i32 7, !"air.max_threadgroup_buffers", i32 31}
!3 = !{i32 7, !"air.max_textures", i32 128}
!4 = !{i32 7, !"air.max_read_write_textures", i32 8}
!5 = !{i32 7, !"air.max_samplers", i32 16}
!6 = !{i32 1, !"wchar_size", i32 4}
!7 = !{i32 8, !"PIC Level", i32 2}
!8 = !{i32 2, i32 3, i32 0}
!9 = !{!"air.compile.denorms_disable"}
!10 = !{!"air.compile.fast_math_enable"}
!11 = !{!"air.compile.framebuffer_fetch_enable"}
!12 = !{!"Apple metal version 32023.883 (metalfe-32023.883)"}
!13 = !{!"Metal", i32 2, i32 3, i32 0}
!14 = !{!"/AppleInternal/Library/BuildRoots/4~CNlHugDNtO_m7KjkKLmRk5uZxVDqkJ9-kVFTx8Y/Library/Caches/com.apple.xbs/TemporaryDirectory.rtt6Ki/Sources/GPUCompiler/clang/runtime/compiler-rt-extra/lib/tracepoint-rt/tracepoint.metal"}
!15 = !{!16, !16, i64 0}
!16 = !{!"omnipotent char", !17, i64 0}
!17 = !{!"Simple C++ TBAA"}
!18 = !{!19, !19, i64 0}
!19 = !{!"int", !16, i64 0}
!20 = !{!21, !19, i64 4}
!21 = !{!"_ZTSN12_GLOBAL__N_111TraceBufferE", !22, i64 0, !19, i64 4, !22, i64 8}
!22 = !{!"_ZTSN5metal7_atomicIjvEE", !19, i64 0}
!23 = !{!24, !19, i64 16}
!24 = !{!"_ZTSN12_GLOBAL__N_117VertexTraceBufferE", !19, i64 12, !19, i64 16, !19, i64 20, !16, i64 24}
!25 = !{!24, !19, i64 12}
!26 = !{!24, !19, i64 20}
!27 = distinct !{!27, !28}
!28 = !{!"llvm.loop.mustprogress"}
!29 = !{!30, !19, i64 56}
!30 = !{!"_ZTSN12_GLOBAL__N_119FragmentTraceBufferE", !16, i64 16, !16, i64 48, !19, i64 56}
!31 = !{!32, !19, i64 16}
!32 = !{!"_ZTSN12_GLOBAL__N_132PostTesselationVertexTraceBufferE", !19, i64 12, !19, i64 16, !19, i64 20, !16, i64 24}
!33 = !{!32, !19, i64 12}
!34 = !{!32, !19, i64 20}
!35 = distinct !{!35, !28}
!36 = !{!37, !19, i64 64}
!37 = !{!"_ZTSN12_GLOBAL__N_115MeshTraceBufferE", !16, i64 16, !16, i64 48, !19, i64 64}
