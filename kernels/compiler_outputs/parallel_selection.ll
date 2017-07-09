; ModuleID = 'parallel_selection.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind readnone
define i32 @__eqsf2(float %a, float %b) #0 {
  %1 = bitcast float %a to i32
  %2 = bitcast float %b to i32
  %3 = and i32 %1, 2147483647
  %4 = and i32 %2, 2147483647
  %5 = icmp slt i32 %1, %2
  %6 = select i1 %5, i32 -1, i32 1
  %7 = icmp sgt i32 %1, %2
  %8 = select i1 %7, i32 -1, i32 1
  %9 = and i32 %2, %1
  %10 = icmp sgt i32 %9, -1
  %11 = select i1 %10, i32 %6, i32 %8
  %12 = icmp eq i32 %1, %2
  %13 = or i32 %4, %3
  %14 = icmp eq i32 %13, 0
  %15 = or i1 %12, %14
  %16 = select i1 %15, i32 0, i32 %11
  %17 = icmp ugt i32 %3, 2139095040
  %18 = icmp ugt i32 %4, 2139095040
  %19 = or i1 %17, %18
  %20 = select i1 %19, i32 1, i32 %16
  ret i32 %20
}

; Function Attrs: nounwind readnone
define i32 @__nesf2(float %a, float %b) #0 {
  %1 = bitcast float %a to i32
  %2 = bitcast float %b to i32
  %3 = and i32 %1, 2147483647
  %4 = and i32 %2, 2147483647
  %5 = icmp slt i32 %1, %2
  %6 = select i1 %5, i32 -1, i32 1
  %7 = icmp sgt i32 %1, %2
  %8 = select i1 %7, i32 -1, i32 1
  %9 = and i32 %2, %1
  %10 = icmp sgt i32 %9, -1
  %11 = select i1 %10, i32 %6, i32 %8
  %12 = icmp eq i32 %1, %2
  %13 = or i32 %4, %3
  %14 = icmp eq i32 %13, 0
  %15 = or i1 %12, %14
  %16 = select i1 %15, i32 0, i32 %11
  %17 = icmp ugt i32 %3, 2139095040
  %18 = icmp ugt i32 %4, 2139095040
  %19 = or i1 %17, %18
  %20 = select i1 %19, i32 1, i32 %16
  ret i32 %20
}

; Function Attrs: nounwind readnone
define i32 @__lesf2(float %a, float %b) #0 {
  %1 = bitcast float %a to i32
  %2 = bitcast float %b to i32
  %3 = and i32 %1, 2147483647
  %4 = and i32 %2, 2147483647
  %5 = icmp slt i32 %1, %2
  %6 = select i1 %5, i32 -1, i32 1
  %7 = icmp sgt i32 %1, %2
  %8 = select i1 %7, i32 -1, i32 1
  %9 = and i32 %2, %1
  %10 = icmp sgt i32 %9, -1
  %11 = select i1 %10, i32 %6, i32 %8
  %12 = icmp eq i32 %1, %2
  %13 = or i32 %4, %3
  %14 = icmp eq i32 %13, 0
  %15 = or i1 %12, %14
  %16 = select i1 %15, i32 0, i32 %11
  %17 = icmp ugt i32 %3, 2139095040
  %18 = icmp ugt i32 %4, 2139095040
  %19 = or i1 %17, %18
  %20 = select i1 %19, i32 1, i32 %16
  ret i32 %20
}

; Function Attrs: nounwind readnone
define i32 @__ltsf2(float %a, float %b) #0 {
  %1 = bitcast float %a to i32
  %2 = bitcast float %b to i32
  %3 = and i32 %1, 2147483647
  %4 = and i32 %2, 2147483647
  %5 = icmp slt i32 %1, %2
  %6 = select i1 %5, i32 -1, i32 1
  %7 = icmp sgt i32 %1, %2
  %8 = select i1 %7, i32 -1, i32 1
  %9 = and i32 %2, %1
  %10 = icmp sgt i32 %9, -1
  %11 = select i1 %10, i32 %6, i32 %8
  %12 = icmp eq i32 %1, %2
  %13 = or i32 %4, %3
  %14 = icmp eq i32 %13, 0
  %15 = or i1 %12, %14
  %16 = select i1 %15, i32 0, i32 %11
  %17 = icmp ugt i32 %3, 2139095040
  %18 = icmp ugt i32 %4, 2139095040
  %19 = or i1 %17, %18
  %20 = select i1 %19, i32 1, i32 %16
  ret i32 %20
}

; Function Attrs: nounwind readnone
define i32 @__gesf2(float %a, float %b) #0 {
  %1 = bitcast float %a to i32
  %2 = bitcast float %b to i32
  %3 = and i32 %1, 2147483647
  %4 = and i32 %2, 2147483647
  %5 = icmp slt i32 %1, %2
  %6 = select i1 %5, i32 -1, i32 1
  %7 = icmp sgt i32 %1, %2
  %8 = select i1 %7, i32 -1, i32 1
  %9 = and i32 %2, %1
  %10 = icmp sgt i32 %9, -1
  %11 = select i1 %10, i32 %6, i32 %8
  %12 = icmp eq i32 %1, %2
  %13 = or i32 %4, %3
  %14 = icmp eq i32 %13, 0
  %15 = or i1 %12, %14
  %16 = select i1 %15, i32 0, i32 %11
  %17 = icmp ugt i32 %3, 2139095040
  %18 = icmp ugt i32 %4, 2139095040
  %19 = or i1 %17, %18
  %20 = select i1 %19, i32 -1, i32 %16
  ret i32 %20
}

; Function Attrs: nounwind readnone
define i32 @__gtsf2(float %a, float %b) #0 {
  %1 = bitcast float %a to i32
  %2 = bitcast float %b to i32
  %3 = and i32 %1, 2147483647
  %4 = and i32 %2, 2147483647
  %5 = icmp slt i32 %1, %2
  %6 = select i1 %5, i32 -1, i32 1
  %7 = icmp sgt i32 %1, %2
  %8 = select i1 %7, i32 -1, i32 1
  %9 = and i32 %2, %1
  %10 = icmp sgt i32 %9, -1
  %11 = select i1 %10, i32 %6, i32 %8
  %12 = icmp eq i32 %1, %2
  %13 = or i32 %4, %3
  %14 = icmp eq i32 %13, 0
  %15 = or i1 %12, %14
  %16 = select i1 %15, i32 0, i32 %11
  %17 = icmp ugt i32 %3, 2139095040
  %18 = icmp ugt i32 %4, 2139095040
  %19 = or i1 %17, %18
  %20 = select i1 %19, i32 -1, i32 %16
  ret i32 %20
}

; Function Attrs: nounwind readnone
define i32 @__unordsf2(float %a, float %b) #0 {
  %1 = bitcast float %a to i32
  %2 = and i32 %1, 2147483647
  %3 = bitcast float %b to i32
  %4 = and i32 %3, 2147483647
  %5 = icmp ugt i32 %2, 2139095040
  %6 = icmp ugt i32 %4, 2139095040
  %7 = or i1 %5, %6
  %8 = zext i1 %7 to i32
  ret i32 %8
}

; Function Attrs: nounwind
define void @ParallelSelection(i32* nocapture readonly %in, i32* nocapture %out) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !22
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !23
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !24
  %5 = getelementptr inbounds i32, i32* %in, i32 %3
  %6 = load i32, i32* %5, align 4, !tbaa !25
  br label %7

; <label>:7                                       ; preds = %7, %0
  %j.0 = phi i32 [ 0, %0 ], [ %16, %7 ]
  %pos.0 = phi i32 [ 0, %0 ], [ %15, %7 ]
  %8 = getelementptr inbounds i32, i32* %in, i32 %j.0
  %9 = load i32, i32* %8, align 4, !tbaa !25
  %10 = icmp slt i32 %9, %6
  %11 = icmp eq i32 %9, %6
  %12 = icmp slt i32 %j.0, %3
  %. = and i1 %12, %11
  %13 = or i1 %10, %.
  %14 = zext i1 %13 to i32
  %15 = add nsw i32 %14, %pos.0
  %16 = add nuw nsw i32 %j.0, 1
  %17 = icmp eq i32 %16, %4
  br i1 %17, label %18, label %7

; <label>:18                                      ; preds = %7
  %.lcssa = phi i32 [ %15, %7 ]
  %19 = getelementptr inbounds i32, i32* %out, i32 %.lcssa
  store i32 %6, i32* %19, align 4, !tbaa !25
  ret void
}

; Function Attrs: nounwind
define void @ParallelSelection_half(i16* nocapture readonly %in, i16* nocapture %out) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !22
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !23
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !24
  %5 = getelementptr inbounds i16, i16* %in, i32 %3
  %6 = load i16, i16* %5, align 2, !tbaa !29
  br label %7

; <label>:7                                       ; preds = %7, %0
  %j.0 = phi i32 [ 0, %0 ], [ %16, %7 ]
  %pos.0 = phi i32 [ 0, %0 ], [ %15, %7 ]
  %8 = getelementptr inbounds i16, i16* %in, i32 %j.0
  %9 = load i16, i16* %8, align 2, !tbaa !29
  %10 = icmp slt i16 %9, %6
  %11 = icmp eq i16 %9, %6
  %12 = icmp slt i32 %j.0, %3
  %. = and i1 %12, %11
  %13 = or i1 %10, %.
  %14 = zext i1 %13 to i32
  %15 = add nsw i32 %14, %pos.0
  %16 = add nuw nsw i32 %j.0, 1
  %17 = icmp eq i32 %16, %4
  br i1 %17, label %18, label %7

; <label>:18                                      ; preds = %7
  %.lcssa = phi i32 [ %15, %7 ]
  %19 = getelementptr inbounds i16, i16* %out, i32 %.lcssa
  store i16 %6, i16* %19, align 2, !tbaa !29
  ret void
}

; Function Attrs: nounwind
define void @ParallelSelection_half_improved(<2 x i16>* nocapture readonly %in, i16* nocapture %out) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !22
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !23
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !24
  %5 = getelementptr inbounds <2 x i16>, <2 x i16>* %in, i32 0, i32 %3
  %6 = load i16, i16* %5, align 2, !tbaa !29
  br label %7

; <label>:7                                       ; preds = %7, %0
  %j.0 = phi i32 [ 0, %0 ], [ %27, %7 ]
  %pos.0 = phi i32 [ 0, %0 ], [ %26, %7 ]
  %8 = ashr exact i32 %j.0, 1
  %9 = getelementptr inbounds <2 x i16>, <2 x i16>* %in, i32 %8
  %10 = load <2 x i16>, <2 x i16>* %9, align 4, !tbaa !31
  %11 = extractelement <2 x i16> %10, i32 0
  %12 = icmp slt i16 %11, %6
  %13 = icmp eq i16 %11, %6
  %14 = icmp slt i32 %j.0, %3
  %. = and i1 %14, %13
  %15 = or i1 %12, %.
  %16 = zext i1 %15 to i32
  %17 = add nsw i32 %16, %pos.0
  %18 = extractelement <2 x i16> %10, i32 1
  %19 = icmp slt i16 %18, %6
  %20 = icmp eq i16 %18, %6
  %21 = or i32 %j.0, 1
  %22 = icmp slt i32 %21, %3
  %23 = and i1 %22, %20
  %24 = or i1 %19, %23
  %25 = zext i1 %24 to i32
  %26 = add nsw i32 %17, %25
  %27 = add nuw nsw i32 %j.0, 2
  %28 = icmp eq i32 %27, %4
  br i1 %28, label %29, label %7

; <label>:29                                      ; preds = %7
  %.lcssa = phi i32 [ %26, %7 ]
  %30 = getelementptr inbounds i16, i16* %out, i32 %.lcssa
  store i16 %6, i16* %30, align 2, !tbaa !29
  ret void
}

; Function Attrs: nounwind
define void @ParallelSelection_byte_improved(<4 x i8>* nocapture readonly %in, i8* nocapture %out) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !22
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !23
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !24
  %5 = getelementptr inbounds <4 x i8>, <4 x i8>* %in, i32 0, i32 %3
  %6 = load i8, i8* %5, align 1, !tbaa !31
  br label %7

; <label>:7                                       ; preds = %7, %0
  %j.0 = phi i32 [ 0, %0 ], [ %45, %7 ]
  %pos.0 = phi i32 [ 0, %0 ], [ %44, %7 ]
  %8 = lshr exact i32 %j.0, 2
  %9 = getelementptr inbounds <4 x i8>, <4 x i8>* %in, i32 %8
  %10 = load <4 x i8>, <4 x i8>* %9, align 4, !tbaa !31
  %11 = extractelement <4 x i8> %10, i32 0
  %12 = icmp ult i8 %11, %6
  %13 = icmp eq i8 %11, %6
  %14 = icmp ult i32 %j.0, %3
  %. = and i1 %14, %13
  %15 = or i1 %12, %.
  %16 = zext i1 %15 to i32
  %17 = add i32 %16, %pos.0
  %18 = extractelement <4 x i8> %10, i32 1
  %19 = icmp ult i8 %18, %6
  %20 = icmp eq i8 %18, %6
  %21 = or i32 %j.0, 1
  %22 = icmp ult i32 %21, %3
  %23 = and i1 %22, %20
  %24 = or i1 %19, %23
  %25 = zext i1 %24 to i32
  %26 = add i32 %17, %25
  %27 = extractelement <4 x i8> %10, i32 2
  %28 = icmp ult i8 %27, %6
  %29 = icmp eq i8 %27, %6
  %30 = or i32 %j.0, 2
  %31 = icmp ult i32 %30, %3
  %32 = and i1 %31, %29
  %33 = or i1 %28, %32
  %34 = zext i1 %33 to i32
  %35 = add i32 %26, %34
  %36 = extractelement <4 x i8> %10, i32 3
  %37 = icmp ult i8 %36, %6
  %38 = icmp eq i8 %36, %6
  %39 = or i32 %j.0, 3
  %40 = icmp ult i32 %39, %3
  %41 = and i1 %40, %38
  %42 = or i1 %37, %41
  %43 = zext i1 %42 to i32
  %44 = add i32 %35, %43
  %45 = add i32 %j.0, 4
  %46 = icmp eq i32 %45, %4
  br i1 %46, label %47, label %7

; <label>:47                                      ; preds = %7
  %.lcssa = phi i32 [ %44, %7 ]
  %48 = getelementptr inbounds i8, i8* %out, i32 %.lcssa
  store i8 %6, i8* %48, align 1, !tbaa !31
  ret void
}

; Function Attrs: nounwind
define void @ParallelSelection_byte(i8* nocapture readonly %in, i8* nocapture %out) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !22
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !23
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !24
  %5 = getelementptr inbounds i8, i8* %in, i32 %3
  %6 = load i8, i8* %5, align 1, !tbaa !31
  br label %7

; <label>:7                                       ; preds = %7, %0
  %j.0 = phi i32 [ 0, %0 ], [ %16, %7 ]
  %pos.0 = phi i32 [ 0, %0 ], [ %15, %7 ]
  %8 = getelementptr inbounds i8, i8* %in, i32 %j.0
  %9 = load i8, i8* %8, align 1, !tbaa !31
  %10 = icmp ult i8 %9, %6
  %11 = icmp eq i8 %9, %6
  %12 = icmp ult i32 %j.0, %3
  %. = and i1 %12, %11
  %13 = or i1 %10, %.
  %14 = zext i1 %13 to i32
  %15 = add i32 %14, %pos.0
  %16 = add i32 %j.0, 1
  %17 = icmp eq i32 %16, %4
  br i1 %17, label %18, label %7

; <label>:18                                      ; preds = %7
  %.lcssa = phi i32 [ %15, %7 ]
  %19 = getelementptr inbounds i8, i8* %out, i32 %.lcssa
  store i8 %6, i8* %19, align 1, !tbaa !31
  ret void
}

; Function Attrs: nounwind
define void @ParallelSelection_float(float* nocapture readonly %in, float* nocapture %out) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !22
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !23
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !24
  %5 = getelementptr inbounds float, float* %in, i32 %3
  %6 = load float, float* %5, align 4, !tbaa !32
  br label %7

; <label>:7                                       ; preds = %7, %0
  %j.0 = phi i32 [ 0, %0 ], [ %17, %7 ]
  %pos.0 = phi i32 [ 0, %0 ], [ %16, %7 ]
  %8 = getelementptr inbounds float, float* %in, i32 %j.0
  %9 = load float, float* %8, align 4, !tbaa !32
  %10 = fcmp olt float %9, %6
  %11 = fcmp oeq float %9, %6
  %12 = icmp slt i32 %j.0, %3
  %13 = and i1 %12, %11
  %14 = or i1 %10, %13
  %15 = zext i1 %14 to i32
  %16 = add nsw i32 %15, %pos.0
  %17 = add nuw nsw i32 %j.0, 1
  %18 = icmp eq i32 %17, %4
  br i1 %18, label %19, label %7

; <label>:19                                      ; preds = %7
  %.lcssa = phi i32 [ %16, %7 ]
  %20 = getelementptr inbounds float, float* %out, i32 %.lcssa
  store float %6, float* %20, align 4, !tbaa !32
  ret void
}

attributes #0 = { nounwind readnone "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !6, !9, !12, !15, !18}
!llvm.ident = !{!21}

!0 = !{void (i32*, i32*)* @ParallelSelection, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"int*", !"int*"}
!4 = !{!"kernel_arg_base_type", !"int*", !"int*"}
!5 = !{!"kernel_arg_type_qual", !"", !""}
!6 = !{void (i16*, i16*)* @ParallelSelection_half, !1, !2, !7, !8, !5}
!7 = !{!"kernel_arg_type", !"short*", !"short*"}
!8 = !{!"kernel_arg_base_type", !"short*", !"short*"}
!9 = !{void (<2 x i16>*, i16*)* @ParallelSelection_half_improved, !1, !2, !10, !11, !5}
!10 = !{!"kernel_arg_type", !"short2*", !"short*"}
!11 = !{!"kernel_arg_base_type", !"short __attribute__((ext_vector_type(2)))*", !"short*"}
!12 = !{void (<4 x i8>*, i8*)* @ParallelSelection_byte_improved, !1, !2, !13, !14, !5}
!13 = !{!"kernel_arg_type", !"uchar4*", !"uchar*"}
!14 = !{!"kernel_arg_base_type", !"uchar __attribute__((ext_vector_type(4)))*", !"uchar*"}
!15 = !{void (i8*, i8*)* @ParallelSelection_byte, !1, !2, !16, !17, !5}
!16 = !{!"kernel_arg_type", !"uchar*", !"uchar*"}
!17 = !{!"kernel_arg_base_type", !"uchar*", !"uchar*"}
!18 = !{void (float*, float*)* @ParallelSelection_float, !1, !2, !19, !20, !5}
!19 = !{!"kernel_arg_type", !"float*", !"float*"}
!20 = !{!"kernel_arg_base_type", !"float*", !"float*"}
!21 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
!22 = !{i32 14990}
!23 = !{i32 15130}
!24 = !{i32 14769}
!25 = !{!26, !26, i64 0}
!26 = !{!"int", !27, i64 0}
!27 = !{!"omnipotent char", !28, i64 0}
!28 = !{!"Simple C/C++ TBAA"}
!29 = !{!30, !30, i64 0}
!30 = !{!"short", !27, i64 0}
!31 = !{!27, !27, i64 0}
!32 = !{!33, !33, i64 0}
!33 = !{!"float", !27, i64 0}
