; ModuleID = 'max.cl'
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
define void @max_float(float* nocapture readonly %in, float* nocapture %out, i32 signext %reduce_factor) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !27
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !28
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !29
  %5 = getelementptr inbounds float, float* %in, i32 %3
  %6 = load float, float* %5, align 4, !tbaa !30
  br label %7

; <label>:7                                       ; preds = %7, %0
  %i.0 = phi i32 [ 1, %0 ], [ %13, %7 ]
  %begin.0 = phi i32 [ %3, %0 ], [ %8, %7 ]
  %max_val.0 = phi float [ %6, %0 ], [ %12, %7 ]
  %8 = add i32 %begin.0, %4
  %9 = getelementptr inbounds float, float* %in, i32 %8
  %10 = load float, float* %9, align 4, !tbaa !30
  %11 = fcmp olt float %10, %max_val.0
  %12 = select i1 %11, float %max_val.0, float %10
  %13 = add nuw nsw i32 %i.0, 1
  %14 = icmp eq i32 %13, %reduce_factor
  br i1 %14, label %15, label %7

; <label>:15                                      ; preds = %7
  %.lcssa = phi float [ %12, %7 ]
  %16 = getelementptr inbounds float, float* %out, i32 %3
  store float %.lcssa, float* %16, align 4, !tbaa !30
  ret void
}

; Function Attrs: nounwind
define void @max_word(i32* nocapture readonly %in, i32* nocapture %out, i32 signext %reduce_factor) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !27
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !28
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !29
  %5 = getelementptr inbounds i32, i32* %in, i32 %3
  %6 = load i32, i32* %5, align 4, !tbaa !34
  br label %7

; <label>:7                                       ; preds = %7, %0
  %i.0 = phi i32 [ 1, %0 ], [ %13, %7 ]
  %begin.0 = phi i32 [ %3, %0 ], [ %8, %7 ]
  %max_val.0 = phi i32 [ %6, %0 ], [ %12, %7 ]
  %8 = add i32 %begin.0, %4
  %9 = getelementptr inbounds i32, i32* %in, i32 %8
  %10 = load i32, i32* %9, align 4, !tbaa !34
  %11 = icmp slt i32 %10, %max_val.0
  %12 = select i1 %11, i32 %max_val.0, i32 %10
  %13 = add nuw nsw i32 %i.0, 1
  %14 = icmp eq i32 %13, %reduce_factor
  br i1 %14, label %15, label %7

; <label>:15                                      ; preds = %7
  %.lcssa = phi i32 [ %12, %7 ]
  %16 = getelementptr inbounds i32, i32* %out, i32 %3
  store i32 %.lcssa, i32* %16, align 4, !tbaa !34
  ret void
}

; Function Attrs: nounwind
define void @max_half(i16* nocapture readonly %in, i16* nocapture %out, i32 signext %reduce_factor) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !27
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !28
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !29
  %5 = getelementptr inbounds i16, i16* %in, i32 %3
  %6 = load i16, i16* %5, align 2, !tbaa !36
  %7 = sext i16 %6 to i32
  br label %8

; <label>:8                                       ; preds = %8, %0
  %i.0 = phi i32 [ 1, %0 ], [ %15, %8 ]
  %begin.0 = phi i32 [ %3, %0 ], [ %9, %8 ]
  %max_val.0 = phi i32 [ %7, %0 ], [ %14, %8 ]
  %9 = add i32 %begin.0, %4
  %10 = getelementptr inbounds i16, i16* %in, i32 %9
  %11 = load i16, i16* %10, align 2, !tbaa !36
  %12 = sext i16 %11 to i32
  %13 = icmp slt i32 %12, %max_val.0
  %14 = select i1 %13, i32 %max_val.0, i32 %12
  %15 = add nuw nsw i32 %i.0, 1
  %16 = icmp eq i32 %15, %reduce_factor
  br i1 %16, label %17, label %8

; <label>:17                                      ; preds = %8
  %.lcssa = phi i32 [ %14, %8 ]
  %18 = trunc i32 %.lcssa to i16
  %19 = getelementptr inbounds i16, i16* %out, i32 %3
  store i16 %18, i16* %19, align 2, !tbaa !36
  ret void
}

; Function Attrs: nounwind
define void @max_half_improved(<2 x i16>* nocapture readonly %in, i16* nocapture %out, i32 signext %reduce_factor) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !27
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !28
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !29
  %5 = getelementptr inbounds <2 x i16>, <2 x i16>* %in, i32 %3
  %6 = load <2 x i16>, <2 x i16>* %5, align 4, !tbaa !38
  %7 = extractelement <2 x i16> %6, i32 0
  %8 = extractelement <2 x i16> %6, i32 1
  %9 = icmp slt i16 %8, %7
  %.sink = select i1 %9, i16 %7, i16 %8
  %10 = sext i16 %.sink to i32
  %11 = lshr i32 %reduce_factor, 1
  %12 = icmp ugt i32 %reduce_factor, 3
  br i1 %12, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %0
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %i.03 = phi i32 [ %23, %.lr.ph ], [ 1, %.lr.ph.preheader ]
  %max_val.02 = phi i32 [ %22, %.lr.ph ], [ %10, %.lr.ph.preheader ]
  %begin.01 = phi i32 [ %13, %.lr.ph ], [ %3, %.lr.ph.preheader ]
  %13 = add i32 %begin.01, %4
  %14 = getelementptr inbounds <2 x i16>, <2 x i16>* %in, i32 %13
  %15 = load <2 x i16>, <2 x i16>* %14, align 4, !tbaa !38
  %16 = extractelement <2 x i16> %15, i32 0
  %17 = sext i16 %16 to i32
  %18 = icmp slt i32 %17, %max_val.02
  %max_val.0. = select i1 %18, i32 %max_val.02, i32 %17
  %19 = extractelement <2 x i16> %15, i32 1
  %20 = sext i16 %19 to i32
  %21 = icmp slt i32 %20, %max_val.0.
  %22 = select i1 %21, i32 %max_val.0., i32 %20
  %23 = add nuw nsw i32 %i.03, 1
  %24 = icmp ult i32 %23, %11
  br i1 %24, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.lcssa = phi i32 [ %22, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  %max_val.0.lcssa = phi i32 [ %10, %0 ], [ %.lcssa, %._crit_edge.loopexit ]
  %25 = trunc i32 %max_val.0.lcssa to i16
  %26 = getelementptr inbounds i16, i16* %out, i32 %3
  store i16 %25, i16* %26, align 2, !tbaa !36
  ret void
}

; Function Attrs: nounwind
define void @max_byte(i8* nocapture readonly %in, i8* nocapture %out, i32 signext %reduce_factor) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !27
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !28
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !29
  %5 = getelementptr inbounds i8, i8* %in, i32 %3
  %6 = load i8, i8* %5, align 1, !tbaa !38
  %7 = sext i8 %6 to i32
  br label %8

; <label>:8                                       ; preds = %8, %0
  %i.0 = phi i32 [ 1, %0 ], [ %15, %8 ]
  %begin.0 = phi i32 [ %3, %0 ], [ %9, %8 ]
  %max_val.0 = phi i32 [ %7, %0 ], [ %14, %8 ]
  %9 = add i32 %begin.0, %4
  %10 = getelementptr inbounds i8, i8* %in, i32 %9
  %11 = load i8, i8* %10, align 1, !tbaa !38
  %12 = sext i8 %11 to i32
  %13 = icmp slt i32 %12, %max_val.0
  %14 = select i1 %13, i32 %max_val.0, i32 %12
  %15 = add nuw nsw i32 %i.0, 1
  %16 = icmp eq i32 %15, %reduce_factor
  br i1 %16, label %17, label %8

; <label>:17                                      ; preds = %8
  %.lcssa = phi i32 [ %14, %8 ]
  %18 = trunc i32 %.lcssa to i8
  %19 = getelementptr inbounds i8, i8* %out, i32 %3
  store i8 %18, i8* %19, align 1, !tbaa !38
  ret void
}

; Function Attrs: nounwind
define void @max_byte_improved(<4 x i8>* nocapture readonly %in, i8* nocapture %out, i32 signext %reduce_factor) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !27
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !28
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !29
  %5 = getelementptr inbounds <4 x i8>, <4 x i8>* %in, i32 %3
  %6 = load <4 x i8>, <4 x i8>* %5, align 4, !tbaa !38
  %7 = extractelement <4 x i8> %6, i32 0
  %8 = extractelement <4 x i8> %6, i32 1
  %9 = icmp slt i8 %8, %7
  %.sink = select i1 %9, i8 %7, i8 %8
  %10 = sext i8 %.sink to i32
  %11 = extractelement <4 x i8> %6, i32 2
  %12 = sext i8 %11 to i32
  %13 = icmp slt i32 %12, %10
  %. = select i1 %13, i32 %10, i32 %12
  %14 = extractelement <4 x i8> %6, i32 3
  %15 = sext i8 %14 to i32
  %16 = icmp slt i32 %15, %.
  %17 = select i1 %16, i32 %., i32 %15
  %18 = lshr i32 %reduce_factor, 2
  %19 = icmp ugt i32 %reduce_factor, 7
  br i1 %19, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %0
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %i.04 = phi i32 [ %37, %.lr.ph ], [ 1, %.lr.ph.preheader ]
  %max_val.03 = phi i32 [ %36, %.lr.ph ], [ %17, %.lr.ph.preheader ]
  %begin.02 = phi i32 [ %20, %.lr.ph ], [ %3, %.lr.ph.preheader ]
  %20 = add i32 %begin.02, %4
  %21 = getelementptr inbounds <4 x i8>, <4 x i8>* %in, i32 %20
  %22 = load <4 x i8>, <4 x i8>* %21, align 4, !tbaa !38
  %23 = extractelement <4 x i8> %22, i32 0
  %24 = sext i8 %23 to i32
  %25 = icmp slt i32 %24, %max_val.03
  %max_val.0. = select i1 %25, i32 %max_val.03, i32 %24
  %26 = extractelement <4 x i8> %22, i32 1
  %27 = sext i8 %26 to i32
  %28 = icmp slt i32 %27, %max_val.0.
  %29 = select i1 %28, i32 %max_val.0., i32 %27
  %30 = extractelement <4 x i8> %22, i32 2
  %31 = sext i8 %30 to i32
  %32 = icmp slt i32 %31, %29
  %.1 = select i1 %32, i32 %29, i32 %31
  %33 = extractelement <4 x i8> %22, i32 3
  %34 = sext i8 %33 to i32
  %35 = icmp slt i32 %34, %.1
  %36 = select i1 %35, i32 %.1, i32 %34
  %37 = add nuw nsw i32 %i.04, 1
  %38 = icmp ult i32 %37, %18
  br i1 %38, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.lcssa = phi i32 [ %36, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  %max_val.0.lcssa = phi i32 [ %17, %0 ], [ %.lcssa, %._crit_edge.loopexit ]
  %39 = trunc i32 %max_val.0.lcssa to i8
  %40 = getelementptr inbounds i8, i8* %out, i32 %3
  store i8 %39, i8* %40, align 1, !tbaa !38
  ret void
}

; Function Attrs: nounwind
define void @max_byte_improved_atomic(<4 x i8>* nocapture readonly %in, i8* %out, i32 signext %reduce_factor) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !27
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !28
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !29
  %5 = getelementptr inbounds <4 x i8>, <4 x i8>* %in, i32 %3
  %6 = load <4 x i8>, <4 x i8>* %5, align 4, !tbaa !38
  %7 = extractelement <4 x i8> %6, i32 0
  %8 = extractelement <4 x i8> %6, i32 1
  %9 = icmp slt i8 %8, %7
  %.sink = select i1 %9, i8 %7, i8 %8
  %10 = sext i8 %.sink to i32
  %11 = extractelement <4 x i8> %6, i32 2
  %12 = sext i8 %11 to i32
  %13 = icmp slt i32 %12, %10
  %. = select i1 %13, i32 %10, i32 %12
  %14 = extractelement <4 x i8> %6, i32 3
  %15 = sext i8 %14 to i32
  %16 = icmp slt i32 %15, %.
  %17 = select i1 %16, i32 %., i32 %15
  %18 = lshr i32 %reduce_factor, 2
  %19 = icmp ugt i32 %reduce_factor, 7
  br i1 %19, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %0
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %i.04 = phi i32 [ %37, %.lr.ph ], [ 1, %.lr.ph.preheader ]
  %max_val.03 = phi i32 [ %36, %.lr.ph ], [ %17, %.lr.ph.preheader ]
  %begin.02 = phi i32 [ %20, %.lr.ph ], [ %3, %.lr.ph.preheader ]
  %20 = add i32 %begin.02, %4
  %21 = getelementptr inbounds <4 x i8>, <4 x i8>* %in, i32 %20
  %22 = load <4 x i8>, <4 x i8>* %21, align 4, !tbaa !38
  %23 = extractelement <4 x i8> %22, i32 0
  %24 = sext i8 %23 to i32
  %25 = icmp slt i32 %24, %max_val.03
  %max_val.0. = select i1 %25, i32 %max_val.03, i32 %24
  %26 = extractelement <4 x i8> %22, i32 1
  %27 = sext i8 %26 to i32
  %28 = icmp slt i32 %27, %max_val.0.
  %29 = select i1 %28, i32 %max_val.0., i32 %27
  %30 = extractelement <4 x i8> %22, i32 2
  %31 = sext i8 %30 to i32
  %32 = icmp slt i32 %31, %29
  %.1 = select i1 %32, i32 %29, i32 %31
  %33 = extractelement <4 x i8> %22, i32 3
  %34 = sext i8 %33 to i32
  %35 = icmp slt i32 %34, %.1
  %36 = select i1 %35, i32 %.1, i32 %34
  %37 = add nuw nsw i32 %i.04, 1
  %38 = icmp ult i32 %37, %18
  br i1 %38, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.lcssa = phi i32 [ %36, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  %max_val.0.lcssa = phi i32 [ %17, %0 ], [ %.lcssa, %._crit_edge.loopexit ]
  %39 = bitcast i8* %out to i32*
  %40 = tail call i32 asm sideeffect "amax $0, $1, r0", "=r,r,0,~{$1}"(i32* %39, i32 %max_val.0.lcssa) #2, !srcloc !39
  ret void
}

; Function Attrs: nounwind
define void @max_atomic(i32* nocapture readonly %in, i32* %out, i32 signext %reduce_factor) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !27
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !28
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !29
  %5 = getelementptr inbounds i32, i32* %in, i32 %3
  %6 = load i32, i32* %5, align 4, !tbaa !34
  %7 = icmp eq i32 %reduce_factor, 1
  br i1 %7, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %0
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.pn = phi i32 [ %index.04, %.lr.ph ], [ %3, %.lr.ph.preheader ]
  %max_val.03 = phi i32 [ %.max_val.0, %.lr.ph ], [ %6, %.lr.ph.preheader ]
  %i.02 = phi i32 [ %11, %.lr.ph ], [ 1, %.lr.ph.preheader ]
  %index.04 = add i32 %.pn, %4
  %8 = getelementptr inbounds i32, i32* %in, i32 %index.04
  %9 = load i32, i32* %8, align 4, !tbaa !34
  %10 = icmp slt i32 %max_val.03, %9
  %.max_val.0 = select i1 %10, i32 %9, i32 %max_val.03
  %11 = add nuw nsw i32 %i.02, 1
  %12 = icmp eq i32 %11, %reduce_factor
  br i1 %12, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.max_val.0.lcssa = phi i32 [ %.max_val.0, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  %max_val.0.lcssa = phi i32 [ %6, %0 ], [ %.max_val.0.lcssa, %._crit_edge.loopexit ]
  %13 = tail call i32 asm sideeffect "amax $0, $1, r0", "=r,r,0,~{$1}"(i32* %out, i32 %max_val.0.lcssa) #2, !srcloc !39
  ret void
}

; Function Attrs: nounwind
define void @max_half_atomic(i16* nocapture readonly %in, i16* %out, i32 signext %reduce_factor) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !27
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !28
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !29
  %5 = getelementptr inbounds i16, i16* %in, i32 %3
  %6 = load i16, i16* %5, align 2, !tbaa !36
  %7 = sext i16 %6 to i32
  %8 = icmp eq i32 %reduce_factor, 1
  br i1 %8, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %0
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.pn = phi i32 [ %index.04, %.lr.ph ], [ %3, %.lr.ph.preheader ]
  %max_val.03 = phi i32 [ %.max_val.0, %.lr.ph ], [ %7, %.lr.ph.preheader ]
  %i.02 = phi i32 [ %13, %.lr.ph ], [ 1, %.lr.ph.preheader ]
  %index.04 = add i32 %.pn, %4
  %9 = getelementptr inbounds i16, i16* %in, i32 %index.04
  %10 = load i16, i16* %9, align 2, !tbaa !36
  %11 = sext i16 %10 to i32
  %12 = icmp slt i32 %max_val.03, %11
  %.max_val.0 = select i1 %12, i32 %11, i32 %max_val.03
  %13 = add nuw nsw i32 %i.02, 1
  %14 = icmp eq i32 %13, %reduce_factor
  br i1 %14, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.max_val.0.lcssa = phi i32 [ %.max_val.0, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  %max_val.0.lcssa = phi i32 [ %7, %0 ], [ %.max_val.0.lcssa, %._crit_edge.loopexit ]
  %15 = bitcast i16* %out to i32*
  %16 = tail call i32 asm sideeffect "amax $0, $1, r0", "=r,r,0,~{$1}"(i32* %15, i32 %max_val.0.lcssa) #2, !srcloc !39
  ret void
}

; Function Attrs: nounwind
define void @max_half_improved_atomic(<2 x i16>* nocapture readonly %in, i16* %out, i32 signext %reduce_factor) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !27
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !28
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !29
  %5 = getelementptr inbounds <2 x i16>, <2 x i16>* %in, i32 %3
  %6 = load <2 x i16>, <2 x i16>* %5, align 4, !tbaa !38
  %7 = extractelement <2 x i16> %6, i32 0
  %8 = extractelement <2 x i16> %6, i32 1
  %9 = icmp slt i16 %8, %7
  %.sink = select i1 %9, i16 %7, i16 %8
  %10 = sext i16 %.sink to i32
  %11 = lshr i32 %reduce_factor, 1
  %12 = icmp ugt i32 %reduce_factor, 3
  br i1 %12, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %0
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %i.03 = phi i32 [ %23, %.lr.ph ], [ 1, %.lr.ph.preheader ]
  %max_val.02 = phi i32 [ %22, %.lr.ph ], [ %10, %.lr.ph.preheader ]
  %begin.01 = phi i32 [ %13, %.lr.ph ], [ %3, %.lr.ph.preheader ]
  %13 = add i32 %begin.01, %4
  %14 = getelementptr inbounds <2 x i16>, <2 x i16>* %in, i32 %13
  %15 = load <2 x i16>, <2 x i16>* %14, align 4, !tbaa !38
  %16 = extractelement <2 x i16> %15, i32 0
  %17 = sext i16 %16 to i32
  %18 = icmp slt i32 %17, %max_val.02
  %max_val.0. = select i1 %18, i32 %max_val.02, i32 %17
  %19 = extractelement <2 x i16> %15, i32 1
  %20 = sext i16 %19 to i32
  %21 = icmp slt i32 %20, %max_val.0.
  %22 = select i1 %21, i32 %max_val.0., i32 %20
  %23 = add nuw nsw i32 %i.03, 1
  %24 = icmp ult i32 %23, %11
  br i1 %24, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.lcssa = phi i32 [ %22, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  %max_val.0.lcssa = phi i32 [ %10, %0 ], [ %.lcssa, %._crit_edge.loopexit ]
  %25 = bitcast i16* %out to i32*
  %26 = tail call i32 asm sideeffect "amax $0, $1, r0", "=r,r,0,~{$1}"(i32* %25, i32 %max_val.0.lcssa) #2, !srcloc !39
  ret void
}

; Function Attrs: nounwind
define void @max_byte_atomic(i8* nocapture readonly %in, i8* %out, i32 signext %reduce_factor) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !27
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !28
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !29
  %5 = getelementptr inbounds i8, i8* %in, i32 %3
  %6 = load i8, i8* %5, align 1, !tbaa !38
  %7 = sext i8 %6 to i32
  %8 = icmp eq i32 %reduce_factor, 1
  br i1 %8, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %0
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.pn = phi i32 [ %index.04, %.lr.ph ], [ %3, %.lr.ph.preheader ]
  %max_val.03 = phi i32 [ %.max_val.0, %.lr.ph ], [ %7, %.lr.ph.preheader ]
  %i.02 = phi i32 [ %13, %.lr.ph ], [ 1, %.lr.ph.preheader ]
  %index.04 = add i32 %.pn, %4
  %9 = getelementptr inbounds i8, i8* %in, i32 %index.04
  %10 = load i8, i8* %9, align 1, !tbaa !38
  %11 = sext i8 %10 to i32
  %12 = icmp slt i32 %max_val.03, %11
  %.max_val.0 = select i1 %12, i32 %11, i32 %max_val.03
  %13 = add nuw nsw i32 %i.02, 1
  %14 = icmp eq i32 %13, %reduce_factor
  br i1 %14, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.max_val.0.lcssa = phi i32 [ %.max_val.0, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  %max_val.0.lcssa = phi i32 [ %7, %0 ], [ %.max_val.0.lcssa, %._crit_edge.loopexit ]
  %15 = bitcast i8* %out to i32*
  %16 = tail call i32 asm sideeffect "amax $0, $1, r0", "=r,r,0,~{$1}"(i32* %15, i32 %max_val.0.lcssa) #2, !srcloc !39
  ret void
}

attributes #0 = { nounwind readnone "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !6, !9, !12, !15, !18, !21, !22, !23, !24, !25}
!llvm.ident = !{!26}

!0 = !{void (float*, float*, i32)* @max_float, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float*", !"float*", !"uint"}
!4 = !{!"kernel_arg_base_type", !"float*", !"float*", !"uint"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !""}
!6 = !{void (i32*, i32*, i32)* @max_word, !1, !2, !7, !8, !5}
!7 = !{!"kernel_arg_type", !"int*", !"int*", !"uint"}
!8 = !{!"kernel_arg_base_type", !"int*", !"int*", !"uint"}
!9 = !{void (i16*, i16*, i32)* @max_half, !1, !2, !10, !11, !5}
!10 = !{!"kernel_arg_type", !"short*", !"short*", !"uint"}
!11 = !{!"kernel_arg_base_type", !"short*", !"short*", !"uint"}
!12 = !{void (<2 x i16>*, i16*, i32)* @max_half_improved, !1, !2, !13, !14, !5}
!13 = !{!"kernel_arg_type", !"short2*", !"short*", !"uint"}
!14 = !{!"kernel_arg_base_type", !"short __attribute__((ext_vector_type(2)))*", !"short*", !"uint"}
!15 = !{void (i8*, i8*, i32)* @max_byte, !1, !2, !16, !17, !5}
!16 = !{!"kernel_arg_type", !"char*", !"char*", !"uint"}
!17 = !{!"kernel_arg_base_type", !"char*", !"char*", !"uint"}
!18 = !{void (<4 x i8>*, i8*, i32)* @max_byte_improved, !1, !2, !19, !20, !5}
!19 = !{!"kernel_arg_type", !"char4*", !"char*", !"uint"}
!20 = !{!"kernel_arg_base_type", !"char __attribute__((ext_vector_type(4)))*", !"char*", !"uint"}
!21 = !{void (<4 x i8>*, i8*, i32)* @max_byte_improved_atomic, !1, !2, !19, !20, !5}
!22 = !{void (i32*, i32*, i32)* @max_atomic, !1, !2, !7, !8, !5}
!23 = !{void (i16*, i16*, i32)* @max_half_atomic, !1, !2, !10, !11, !5}
!24 = !{void (<2 x i16>*, i16*, i32)* @max_half_improved_atomic, !1, !2, !13, !14, !5}
!25 = !{void (i8*, i8*, i32)* @max_byte_atomic, !1, !2, !16, !17, !5}
!26 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
!27 = !{i32 16419}
!28 = !{i32 16559}
!29 = !{i32 16198}
!30 = !{!31, !31, i64 0}
!31 = !{!"float", !32, i64 0}
!32 = !{!"omnipotent char", !33, i64 0}
!33 = !{!"Simple C/C++ TBAA"}
!34 = !{!35, !35, i64 0}
!35 = !{!"int", !32, i64 0}
!36 = !{!37, !37, i64 0}
!37 = !{!"short", !32, i64 0}
!38 = !{!32, !32, i64 0}
!39 = !{i32 17028}
