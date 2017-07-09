; ModuleID = 'sum.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind readnone
define float @__addsf3(float %a, float %b) #0 {
  %1 = bitcast float %a to i32
  %2 = bitcast float %b to i32
  %3 = and i32 %1, 2147483647
  %4 = and i32 %2, 2147483647
  %5 = add nsw i32 %3, -1
  %6 = icmp ugt i32 %5, 2139095038
  %7 = add nsw i32 %4, -1
  %8 = icmp ugt i32 %7, 2139095038
  %or.cond = or i1 %6, %8
  br i1 %or.cond, label %9, label %28

; <label>:9                                       ; preds = %0
  %10 = icmp ugt i32 %3, 2139095040
  %11 = icmp ugt i32 %4, 2139095040
  %12 = or i1 %10, %11
  %13 = icmp eq i32 %3, 2139095040
  %14 = xor i32 %2, %1
  %15 = icmp eq i32 %14, -2147483648
  %16 = and i1 %13, %15
  %17 = or i1 %12, %16
  %brmerge = or i1 %13, %12
  %.mux = select i1 %17, float 0x7FF8000000000000, float %a
  br i1 %brmerge, label %.thread, label %18

; <label>:18                                      ; preds = %9
  %19 = icmp eq i32 %4, 2139095040
  br i1 %19, label %.thread, label %20

; <label>:20                                      ; preds = %18
  %21 = icmp eq i32 %3, 0
  %22 = icmp ne i32 %4, 0
  br i1 %21, label %23, label %27

; <label>:23                                      ; preds = %20
  br i1 %22, label %.thread, label %24

; <label>:24                                      ; preds = %23
  %25 = and i32 %2, %1
  %26 = bitcast i32 %25 to float
  br label %.thread

; <label>:27                                      ; preds = %20
  br i1 %22, label %28, label %.thread

; <label>:28                                      ; preds = %0, %27
  %29 = icmp ugt i32 %4, %3
  %30 = select i1 %29, i32 %1, i32 %2
  %31 = select i1 %29, i32 %2, i32 %1
  %32 = lshr i32 %31, 23
  %33 = and i32 %32, 255
  %34 = lshr i32 %30, 23
  %35 = and i32 %34, 255
  %36 = and i32 %31, 8388607
  %37 = and i32 %30, 8388607
  %38 = icmp eq i32 %33, 0
  br i1 %38, label %39, label %45

; <label>:39                                      ; preds = %28
  %40 = tail call i32 @llvm.ctlz.i32(i32 %36, i1 false) #3
  %41 = add nuw nsw i32 %40, 24
  %42 = and i32 %41, 31
  %43 = shl i32 %36, %42
  %44 = sub nsw i32 9, %40
  br label %45

; <label>:45                                      ; preds = %39, %28
  %aSignificand.0 = phi i32 [ %43, %39 ], [ %36, %28 ]
  %aExponent.0 = phi i32 [ %44, %39 ], [ %33, %28 ]
  %46 = icmp eq i32 %35, 0
  br i1 %46, label %47, label %53

; <label>:47                                      ; preds = %45
  %48 = tail call i32 @llvm.ctlz.i32(i32 %37, i1 false) #3
  %49 = add nuw nsw i32 %48, 24
  %50 = and i32 %49, 31
  %51 = shl i32 %37, %50
  %52 = sub nsw i32 9, %48
  br label %53

; <label>:53                                      ; preds = %47, %45
  %bSignificand.0 = phi i32 [ %51, %47 ], [ %37, %45 ]
  %bExponent.0 = phi i32 [ %52, %47 ], [ %35, %45 ]
  %54 = and i32 %31, -2147483648
  %55 = xor i32 %31, %30
  %56 = icmp slt i32 %55, 0
  %57 = shl i32 %aSignificand.0, 3
  %58 = or i32 %57, 67108864
  %59 = shl i32 %bSignificand.0, 3
  %60 = or i32 %59, 67108864
  %61 = sub nsw i32 %aExponent.0, %bExponent.0
  %62 = icmp eq i32 %aExponent.0, %bExponent.0
  br i1 %62, label %74, label %63

; <label>:63                                      ; preds = %53
  %64 = icmp ult i32 %61, 32
  br i1 %64, label %65, label %74

; <label>:65                                      ; preds = %63
  %66 = sub nsw i32 0, %61
  %67 = and i32 %66, 31
  %68 = shl i32 %60, %67
  %69 = icmp ne i32 %68, 0
  %70 = and i32 %61, 31
  %71 = lshr i32 %60, %70
  %72 = zext i1 %69 to i32
  %73 = or i32 %72, %71
  br label %74

; <label>:74                                      ; preds = %63, %53, %65
  %bSignificand.1 = phi i32 [ %60, %53 ], [ %73, %65 ], [ 1, %63 ]
  br i1 %56, label %75, label %86

; <label>:75                                      ; preds = %74
  %76 = sub i32 %58, %bSignificand.1
  %77 = icmp eq i32 %58, %bSignificand.1
  br i1 %77, label %.thread, label %78

; <label>:78                                      ; preds = %75
  %79 = icmp ult i32 %76, 67108864
  br i1 %79, label %80, label %95

; <label>:80                                      ; preds = %78
  %81 = tail call i32 @llvm.ctlz.i32(i32 %76, i1 false) #3
  %82 = add nsw i32 %81, -5
  %83 = and i32 %82, 31
  %84 = shl i32 %76, %83
  %85 = sub nsw i32 %aExponent.0, %82
  br label %95

; <label>:86                                      ; preds = %74
  %87 = add i32 %bSignificand.1, %58
  %88 = and i32 %87, 134217728
  %89 = icmp eq i32 %88, 0
  br i1 %89, label %95, label %90

; <label>:90                                      ; preds = %86
  %fold = add i32 %bSignificand.1, %57
  %91 = and i32 %fold, 1
  %92 = lshr i32 %87, 1
  %93 = or i32 %92, %91
  %94 = add nsw i32 %aExponent.0, 1
  br label %95

; <label>:95                                      ; preds = %86, %90, %78, %80
  %aSignificand.1 = phi i32 [ %84, %80 ], [ %76, %78 ], [ %87, %86 ], [ %93, %90 ]
  %aExponent.1 = phi i32 [ %85, %80 ], [ %aExponent.0, %78 ], [ %aExponent.0, %86 ], [ %94, %90 ]
  %96 = icmp sgt i32 %aExponent.1, 254
  br i1 %96, label %97, label %100

; <label>:97                                      ; preds = %95
  %98 = or i32 %54, 2139095040
  %99 = bitcast i32 %98 to float
  br label %.thread

; <label>:100                                     ; preds = %95
  %101 = icmp slt i32 %aExponent.1, 1
  br i1 %101, label %102, label %112

; <label>:102                                     ; preds = %100
  %103 = sub nsw i32 1, %aExponent.1
  %104 = sub nsw i32 0, %103
  %105 = and i32 %104, 31
  %106 = shl i32 %aSignificand.1, %105
  %107 = icmp ne i32 %106, 0
  %108 = and i32 %103, 31
  %109 = lshr i32 %aSignificand.1, %108
  %110 = zext i1 %107 to i32
  %111 = or i32 %110, %109
  br label %112

; <label>:112                                     ; preds = %102, %100
  %aSignificand.2 = phi i32 [ %111, %102 ], [ %aSignificand.1, %100 ]
  %aExponent.2 = phi i32 [ 0, %102 ], [ %aExponent.1, %100 ]
  %113 = and i32 %aSignificand.2, 7
  %114 = lshr i32 %aSignificand.2, 3
  %115 = and i32 %114, 8388607
  %116 = shl i32 %aExponent.2, 23
  %117 = or i32 %116, %54
  %118 = or i32 %117, %115
  %119 = icmp ugt i32 %113, 4
  %120 = zext i1 %119 to i32
  %.6 = add i32 %118, %120
  %121 = icmp eq i32 %113, 4
  %122 = and i32 %.6, 1
  %123 = select i1 %121, i32 %122, i32 0
  %result.1 = add i32 %123, %.6
  %124 = bitcast i32 %result.1 to float
  br label %.thread

.thread:                                          ; preds = %9, %23, %18, %24, %97, %112, %75, %27
  %.2 = phi float [ %a, %27 ], [ %99, %97 ], [ %124, %112 ], [ 0.000000e+00, %75 ], [ %.mux, %9 ], [ %b, %23 ], [ %b, %18 ], [ %26, %24 ]
  ret float %.2
}

; Function Attrs: nounwind
define void @sum_atomic_word(i32* nocapture readonly %in, i32* %out, i32 signext %reduce_factor) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !27
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !28
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !29
  br label %5

; <label>:5                                       ; preds = %5, %0
  %begin.0 = phi i32 [ %3, %0 ], [ %10, %5 ]
  %i.0 = phi i32 [ 0, %0 ], [ %9, %5 ]
  %sum.0 = phi i32 [ 0, %0 ], [ %8, %5 ]
  %6 = getelementptr inbounds i32, i32* %in, i32 %begin.0
  %7 = load i32, i32* %6, align 4, !tbaa !30
  %8 = add nsw i32 %7, %sum.0
  %9 = add nuw nsw i32 %i.0, 1
  %10 = add i32 %begin.0, %4
  %11 = icmp eq i32 %9, %reduce_factor
  br i1 %11, label %12, label %5

; <label>:12                                      ; preds = %5
  %.lcssa = phi i32 [ %8, %5 ]
  %13 = tail call i32 asm sideeffect "aadd $0, $1, r0", "=r,r,0,~{$1}"(i32* %out, i32 %.lcssa) #3, !srcloc !34
  ret void
}

; Function Attrs: nounwind
define void @sum_half_atomic(i16* nocapture readonly %in, i16* %out, i32 signext %reduce_factor) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !27
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !28
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !29
  br label %5

; <label>:5                                       ; preds = %5, %0
  %begin.0 = phi i32 [ %3, %0 ], [ %11, %5 ]
  %i.0 = phi i32 [ 0, %0 ], [ %10, %5 ]
  %sum.0 = phi i32 [ 0, %0 ], [ %9, %5 ]
  %6 = getelementptr inbounds i16, i16* %in, i32 %begin.0
  %7 = load i16, i16* %6, align 2, !tbaa !35
  %8 = sext i16 %7 to i32
  %9 = add nsw i32 %8, %sum.0
  %10 = add nuw nsw i32 %i.0, 1
  %11 = add i32 %begin.0, %4
  %12 = icmp eq i32 %10, %reduce_factor
  br i1 %12, label %13, label %5

; <label>:13                                      ; preds = %5
  %.lcssa = phi i32 [ %9, %5 ]
  %14 = bitcast i16* %out to i32*
  %15 = tail call i32 asm sideeffect "aadd $0, $1, r0", "=r,r,0,~{$1}"(i32* %14, i32 %.lcssa) #3, !srcloc !34
  ret void
}

; Function Attrs: nounwind
define void @sum_half_improved_atomic(<2 x i16>* nocapture readonly %in, i16* %out, i32 signext %reduce_factor) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !27
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !28
  %3 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !29
  %4 = lshr i32 %reduce_factor, 1
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %0
  %6 = add nsw i32 %2, %1
  br label %7

; <label>:7                                       ; preds = %7, %.lr.ph
  %sum.03 = phi i32 [ 0, %.lr.ph ], [ %15, %7 ]
  %i.02 = phi i32 [ 0, %.lr.ph ], [ %17, %7 ]
  %begin.01 = phi i32 [ %6, %.lr.ph ], [ %16, %7 ]
  %8 = getelementptr inbounds <2 x i16>, <2 x i16>* %in, i32 %begin.01
  %9 = load <2 x i16>, <2 x i16>* %8, align 4
  %10 = extractelement <2 x i16> %9, i32 0
  %11 = sext i16 %10 to i32
  %12 = add nsw i32 %11, %sum.03
  %13 = extractelement <2 x i16> %9, i32 1
  %14 = sext i16 %13 to i32
  %15 = add nsw i32 %12, %14
  %16 = add i32 %begin.01, %3
  %17 = add nuw nsw i32 %i.02, 1
  %exitcond = icmp eq i32 %17, %4
  br i1 %exitcond, label %._crit_edge.loopexit, label %7

._crit_edge.loopexit:                             ; preds = %7
  %.lcssa = phi i32 [ %15, %7 ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  %sum.0.lcssa = phi i32 [ 0, %0 ], [ %.lcssa, %._crit_edge.loopexit ]
  %18 = bitcast i16* %out to i32*
  %19 = tail call i32 asm sideeffect "aadd $0, $1, r0", "=r,r,0,~{$1}"(i32* %18, i32 %sum.0.lcssa) #3, !srcloc !34
  ret void
}

; Function Attrs: nounwind
define void @sum_byte_atomic(i8* nocapture readonly %in, i8* %out, i32 signext %reduce_factor) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !27
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !28
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !29
  br label %5

; <label>:5                                       ; preds = %5, %0
  %begin.0 = phi i32 [ %3, %0 ], [ %11, %5 ]
  %i.0 = phi i32 [ 0, %0 ], [ %10, %5 ]
  %sum.0 = phi i32 [ 0, %0 ], [ %9, %5 ]
  %6 = getelementptr inbounds i8, i8* %in, i32 %begin.0
  %7 = load i8, i8* %6, align 1, !tbaa !37
  %8 = sext i8 %7 to i32
  %9 = add nsw i32 %8, %sum.0
  %10 = add nuw nsw i32 %i.0, 1
  %11 = add i32 %begin.0, %4
  %12 = icmp eq i32 %10, %reduce_factor
  br i1 %12, label %13, label %5

; <label>:13                                      ; preds = %5
  %.lcssa = phi i32 [ %9, %5 ]
  %14 = bitcast i8* %out to i32*
  %15 = tail call i32 asm sideeffect "aadd $0, $1, r0", "=r,r,0,~{$1}"(i32* %14, i32 %.lcssa) #3, !srcloc !34
  ret void
}

; Function Attrs: nounwind
define void @sum_byte_improved_atomic(<4 x i8>* nocapture readonly %in, i8* %out, i32 signext %reduce_factor) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !27
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !28
  %3 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !29
  %4 = lshr i32 %reduce_factor, 2
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %0
  %6 = add nsw i32 %2, %1
  br label %7

; <label>:7                                       ; preds = %7, %.lr.ph
  %sum.03 = phi i32 [ 0, %.lr.ph ], [ %21, %7 ]
  %i.02 = phi i32 [ 0, %.lr.ph ], [ %23, %7 ]
  %begin.01 = phi i32 [ %6, %.lr.ph ], [ %22, %7 ]
  %8 = getelementptr inbounds <4 x i8>, <4 x i8>* %in, i32 %begin.01
  %9 = load <4 x i8>, <4 x i8>* %8, align 4
  %10 = extractelement <4 x i8> %9, i32 0
  %11 = sext i8 %10 to i32
  %12 = add nsw i32 %11, %sum.03
  %13 = extractelement <4 x i8> %9, i32 1
  %14 = sext i8 %13 to i32
  %15 = add nsw i32 %12, %14
  %16 = extractelement <4 x i8> %9, i32 2
  %17 = sext i8 %16 to i32
  %18 = add nsw i32 %15, %17
  %19 = extractelement <4 x i8> %9, i32 3
  %20 = sext i8 %19 to i32
  %21 = add nsw i32 %18, %20
  %22 = add i32 %begin.01, %3
  %23 = add nuw nsw i32 %i.02, 1
  %exitcond = icmp eq i32 %23, %4
  br i1 %exitcond, label %._crit_edge.loopexit, label %7

._crit_edge.loopexit:                             ; preds = %7
  %.lcssa = phi i32 [ %21, %7 ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  %sum.0.lcssa = phi i32 [ 0, %0 ], [ %.lcssa, %._crit_edge.loopexit ]
  %24 = bitcast i8* %out to i32*
  %25 = tail call i32 asm sideeffect "aadd $0, $1, r0", "=r,r,0,~{$1}"(i32* %24, i32 %sum.0.lcssa) #3, !srcloc !34
  ret void
}

; Function Attrs: nounwind
define void @sum(i32* nocapture readonly %in, i32* nocapture %out, i32 signext %reduce_factor) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !27
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !28
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !29
  br label %5

; <label>:5                                       ; preds = %5, %0
  %begin.0 = phi i32 [ %3, %0 ], [ %10, %5 ]
  %i.0 = phi i32 [ 0, %0 ], [ %9, %5 ]
  %sum.0 = phi i32 [ 0, %0 ], [ %8, %5 ]
  %6 = getelementptr inbounds i32, i32* %in, i32 %begin.0
  %7 = load i32, i32* %6, align 4, !tbaa !30
  %8 = add nsw i32 %7, %sum.0
  %9 = add nuw nsw i32 %i.0, 1
  %10 = add i32 %begin.0, %4
  %11 = icmp eq i32 %9, %reduce_factor
  br i1 %11, label %12, label %5

; <label>:12                                      ; preds = %5
  %.lcssa = phi i32 [ %8, %5 ]
  %13 = getelementptr inbounds i32, i32* %out, i32 %3
  store i32 %.lcssa, i32* %13, align 4, !tbaa !30
  ret void
}

; Function Attrs: nounwind
define void @sum_half(i16* nocapture readonly %in, i16* nocapture %out, i32 signext %reduce_factor) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !27
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !28
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !29
  br label %5

; <label>:5                                       ; preds = %5, %0
  %begin.0 = phi i32 [ %3, %0 ], [ %11, %5 ]
  %i.0 = phi i32 [ 0, %0 ], [ %10, %5 ]
  %sum.0 = phi i32 [ 0, %0 ], [ %9, %5 ]
  %6 = getelementptr inbounds i16, i16* %in, i32 %begin.0
  %7 = load i16, i16* %6, align 2, !tbaa !35
  %8 = sext i16 %7 to i32
  %9 = add nsw i32 %8, %sum.0
  %10 = add nuw nsw i32 %i.0, 1
  %11 = add i32 %begin.0, %4
  %12 = icmp eq i32 %10, %reduce_factor
  br i1 %12, label %13, label %5

; <label>:13                                      ; preds = %5
  %.lcssa = phi i32 [ %9, %5 ]
  %14 = trunc i32 %.lcssa to i16
  %15 = getelementptr inbounds i16, i16* %out, i32 %3
  store i16 %14, i16* %15, align 2, !tbaa !35
  ret void
}

; Function Attrs: nounwind
define void @sum_half_improved(<2 x i16>* nocapture readonly %in, i16* nocapture %out, i32 signext %reduce_factor) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !27
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !28
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !29
  %5 = lshr i32 %reduce_factor, 1
  %6 = icmp eq i32 %5, 0
  br i1 %6, label %17, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %0
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %sum.03 = phi i32 [ %14, %.lr.ph ], [ 0, %.lr.ph.preheader ]
  %i.02 = phi i32 [ %16, %.lr.ph ], [ 0, %.lr.ph.preheader ]
  %begin.01 = phi i32 [ %15, %.lr.ph ], [ %3, %.lr.ph.preheader ]
  %7 = getelementptr inbounds <2 x i16>, <2 x i16>* %in, i32 %begin.01
  %8 = load <2 x i16>, <2 x i16>* %7, align 4
  %9 = extractelement <2 x i16> %8, i32 0
  %10 = sext i16 %9 to i32
  %11 = add nsw i32 %10, %sum.03
  %12 = extractelement <2 x i16> %8, i32 1
  %13 = sext i16 %12 to i32
  %14 = add nsw i32 %11, %13
  %15 = add i32 %begin.01, %4
  %16 = add nuw nsw i32 %i.02, 1
  %exitcond = icmp eq i32 %16, %5
  br i1 %exitcond, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph
  %.lcssa = phi i32 [ %14, %.lr.ph ]
  %phitmp = trunc i32 %.lcssa to i16
  br label %17

; <label>:17                                      ; preds = %0, %._crit_edge
  %sum.0.lcssa = phi i16 [ %phitmp, %._crit_edge ], [ 0, %0 ]
  %18 = getelementptr inbounds i16, i16* %out, i32 %3
  store i16 %sum.0.lcssa, i16* %18, align 2, !tbaa !35
  ret void
}

; Function Attrs: nounwind
define void @sum_byte(i8* nocapture readonly %in, i8* nocapture %out, i32 signext %reduce_factor) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !27
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !28
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !29
  br label %5

; <label>:5                                       ; preds = %5, %0
  %begin.0 = phi i32 [ %3, %0 ], [ %11, %5 ]
  %i.0 = phi i32 [ 0, %0 ], [ %10, %5 ]
  %sum.0 = phi i32 [ 0, %0 ], [ %9, %5 ]
  %6 = getelementptr inbounds i8, i8* %in, i32 %begin.0
  %7 = load i8, i8* %6, align 1, !tbaa !37
  %8 = sext i8 %7 to i32
  %9 = add nsw i32 %8, %sum.0
  %10 = add nuw nsw i32 %i.0, 1
  %11 = add i32 %begin.0, %4
  %12 = icmp eq i32 %10, %reduce_factor
  br i1 %12, label %13, label %5

; <label>:13                                      ; preds = %5
  %.lcssa = phi i32 [ %9, %5 ]
  %14 = trunc i32 %.lcssa to i8
  %15 = getelementptr inbounds i8, i8* %out, i32 %3
  store i8 %14, i8* %15, align 1, !tbaa !37
  ret void
}

; Function Attrs: nounwind
define void @sum_byte_improved(<4 x i8>* nocapture readonly %in, i8* nocapture %out, i32 signext %reduce_factor) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !27
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !28
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !29
  %5 = lshr i32 %reduce_factor, 2
  %6 = icmp eq i32 %5, 0
  br i1 %6, label %23, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %0
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %sum.03 = phi i32 [ %20, %.lr.ph ], [ 0, %.lr.ph.preheader ]
  %i.02 = phi i32 [ %22, %.lr.ph ], [ 0, %.lr.ph.preheader ]
  %begin.01 = phi i32 [ %21, %.lr.ph ], [ %3, %.lr.ph.preheader ]
  %7 = getelementptr inbounds <4 x i8>, <4 x i8>* %in, i32 %begin.01
  %8 = load <4 x i8>, <4 x i8>* %7, align 4
  %9 = extractelement <4 x i8> %8, i32 0
  %10 = sext i8 %9 to i32
  %11 = add nsw i32 %10, %sum.03
  %12 = extractelement <4 x i8> %8, i32 1
  %13 = sext i8 %12 to i32
  %14 = add nsw i32 %11, %13
  %15 = extractelement <4 x i8> %8, i32 2
  %16 = sext i8 %15 to i32
  %17 = add nsw i32 %14, %16
  %18 = extractelement <4 x i8> %8, i32 3
  %19 = sext i8 %18 to i32
  %20 = add nsw i32 %17, %19
  %21 = add i32 %begin.01, %4
  %22 = add nuw nsw i32 %i.02, 1
  %exitcond = icmp eq i32 %22, %5
  br i1 %exitcond, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph
  %.lcssa = phi i32 [ %20, %.lr.ph ]
  %phitmp = trunc i32 %.lcssa to i8
  br label %23

; <label>:23                                      ; preds = %0, %._crit_edge
  %sum.0.lcssa = phi i8 [ %phitmp, %._crit_edge ], [ 0, %0 ]
  %24 = getelementptr inbounds i8, i8* %out, i32 %3
  store i8 %sum.0.lcssa, i8* %24, align 1, !tbaa !37
  ret void
}

; Function Attrs: nounwind
define void @sum_float(float* nocapture readonly %in, float* nocapture %out, i32 signext %reduce_factor) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !27
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !28
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !29
  br label %5

; <label>:5                                       ; preds = %5, %0
  %begin.0 = phi i32 [ %3, %0 ], [ %10, %5 ]
  %i.0 = phi i32 [ 0, %0 ], [ %9, %5 ]
  %sum.0 = phi float [ 0.000000e+00, %0 ], [ %8, %5 ]
  %6 = getelementptr inbounds float, float* %in, i32 %begin.0
  %7 = load float, float* %6, align 4, !tbaa !38
  %8 = fadd float %sum.0, %7
  %9 = add nuw nsw i32 %i.0, 1
  %10 = add i32 %begin.0, %4
  %11 = icmp eq i32 %9, %reduce_factor
  br i1 %11, label %12, label %5

; <label>:12                                      ; preds = %5
  %.lcssa = phi float [ %8, %5 ]
  %13 = getelementptr inbounds float, float* %out, i32 %3
  store float %.lcssa, float* %13, align 4, !tbaa !38
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @llvm.ctlz.i32(i32, i1) #2

attributes #0 = { nounwind readnone "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!opencl.kernels = !{!0, !6, !9, !12, !15, !18, !19, !20, !21, !22, !23}
!llvm.ident = !{!26}

!0 = !{void (i32*, i32*, i32)* @sum_atomic_word, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"int*", !"int*", !"uint"}
!4 = !{!"kernel_arg_base_type", !"int*", !"int*", !"uint"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !""}
!6 = !{void (i16*, i16*, i32)* @sum_half_atomic, !1, !2, !7, !8, !5}
!7 = !{!"kernel_arg_type", !"short*", !"short*", !"uint"}
!8 = !{!"kernel_arg_base_type", !"short*", !"short*", !"uint"}
!9 = !{void (<2 x i16>*, i16*, i32)* @sum_half_improved_atomic, !1, !2, !10, !11, !5}
!10 = !{!"kernel_arg_type", !"short2*", !"short*", !"uint"}
!11 = !{!"kernel_arg_base_type", !"short __attribute__((ext_vector_type(2)))*", !"short*", !"uint"}
!12 = !{void (i8*, i8*, i32)* @sum_byte_atomic, !1, !2, !13, !14, !5}
!13 = !{!"kernel_arg_type", !"char*", !"char*", !"uint"}
!14 = !{!"kernel_arg_base_type", !"char*", !"char*", !"uint"}
!15 = !{void (<4 x i8>*, i8*, i32)* @sum_byte_improved_atomic, !1, !2, !16, !17, !5}
!16 = !{!"kernel_arg_type", !"char4*", !"char*", !"uint"}
!17 = !{!"kernel_arg_base_type", !"char __attribute__((ext_vector_type(4)))*", !"char*", !"uint"}
!18 = !{void (i32*, i32*, i32)* @sum, !1, !2, !3, !4, !5}
!19 = !{void (i16*, i16*, i32)* @sum_half, !1, !2, !7, !8, !5}
!20 = !{void (<2 x i16>*, i16*, i32)* @sum_half_improved, !1, !2, !10, !11, !5}
!21 = !{void (i8*, i8*, i32)* @sum_byte, !1, !2, !13, !14, !5}
!22 = !{void (<4 x i8>*, i8*, i32)* @sum_byte_improved, !1, !2, !16, !17, !5}
!23 = !{void (float*, float*, i32)* @sum_float, !1, !2, !24, !25, !5}
!24 = !{!"kernel_arg_type", !"float*", !"float*", !"uint"}
!25 = !{!"kernel_arg_base_type", !"float*", !"float*", !"uint"}
!26 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
!27 = !{i32 15174}
!28 = !{i32 15314}
!29 = !{i32 14953}
!30 = !{!31, !31, i64 0}
!31 = !{!"int", !32, i64 0}
!32 = !{!"omnipotent char", !33, i64 0}
!33 = !{!"Simple C/C++ TBAA"}
!34 = !{i32 15551}
!35 = !{!36, !36, i64 0}
!36 = !{!"short", !32, i64 0}
!37 = !{!32, !32, i64 0}
!38 = !{!39, !39, i64 0}
!39 = !{!"float", !32, i64 0}
