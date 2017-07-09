; ModuleID = 'fir.cl'
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

; Function Attrs: nounwind readnone
define i64 @__muldsi3(i32 signext %a, i32 signext %b) #0 {
  %1 = and i32 %a, 65535
  %2 = and i32 %b, 65535
  %3 = mul nuw i32 %2, %1
  %4 = lshr i32 %3, 16
  %5 = and i32 %3, 65535
  %6 = lshr i32 %a, 16
  %7 = mul nuw i32 %2, %6
  %8 = add i32 %4, %7
  %9 = lshr i32 %8, 16
  %10 = and i32 %8, 65535
  %11 = lshr i32 %b, 16
  %12 = mul nuw i32 %11, %1
  %13 = add i32 %10, %12
  %fold = add i32 %8, %12
  %14 = shl i32 %fold, 16
  %15 = or i32 %14, %5
  %16 = lshr i32 %13, 16
  %17 = mul nuw i32 %11, %6
  %18 = add i32 %9, %17
  %19 = add i32 %18, %16
  %20 = zext i32 %15 to i64
  %21 = zext i32 %19 to i64
  %22 = shl nuw i64 %21, 32
  %23 = or i64 %22, %20
  ret i64 %23
}

; Function Attrs: nounwind readnone
define i64 @__muldi3(i64 signext %a, i64 signext %b) #0 {
  %1 = lshr i64 %a, 32
  %2 = trunc i64 %1 to i32
  %3 = trunc i64 %a to i32
  %4 = lshr i64 %b, 32
  %5 = trunc i64 %4 to i32
  %6 = trunc i64 %b to i32
  %7 = and i32 %3, 65535
  %8 = and i32 %6, 65535
  %9 = mul nuw i32 %8, %7
  %10 = lshr i32 %9, 16
  %11 = and i32 %9, 65535
  %12 = lshr i32 %3, 16
  %13 = mul nuw i32 %8, %12
  %14 = add i32 %10, %13
  %15 = lshr i32 %14, 16
  %16 = and i32 %14, 65535
  %17 = lshr i32 %6, 16
  %18 = mul nuw i32 %17, %7
  %19 = add i32 %16, %18
  %fold.i = add i32 %14, %18
  %20 = shl i32 %fold.i, 16
  %21 = or i32 %20, %11
  %22 = lshr i32 %19, 16
  %23 = mul nuw i32 %17, %12
  %24 = zext i32 %21 to i64
  %25 = mul i32 %2, %6
  %26 = mul i32 %5, %3
  %27 = add i32 %26, %25
  %28 = add i32 %27, %23
  %29 = add i32 %28, %15
  %30 = add i32 %29, %22
  %31 = zext i32 %30 to i64
  %32 = shl nuw i64 %31, 32
  %33 = or i64 %32, %24
  ret i64 %33
}

; Function Attrs: nounwind readnone
define float @__mulsf3(float %a, float %b) #0 {
  %1 = bitcast float %a to i32
  %2 = lshr i32 %1, 23
  %3 = and i32 %2, 255
  %4 = bitcast float %b to i32
  %5 = lshr i32 %4, 23
  %6 = and i32 %5, 255
  %7 = xor i32 %4, %1
  %8 = and i32 %7, -2147483648
  %9 = and i32 %1, 8388607
  %10 = and i32 %4, 8388607
  %11 = add nsw i32 %3, -1
  %12 = icmp ugt i32 %11, 253
  %13 = add nsw i32 %6, -1
  %14 = icmp ugt i32 %13, 253
  %or.cond = or i1 %12, %14
  br i1 %or.cond, label %15, label %.thread11

; <label>:15                                      ; preds = %0
  %16 = and i32 %1, 2147483647
  %17 = and i32 %4, 2147483647
  %18 = icmp ugt i32 %16, 2139095040
  %19 = icmp ugt i32 %17, 2139095040
  %20 = or i1 %18, %19
  br i1 %20, label %.thread, label %21

; <label>:21                                      ; preds = %15
  %22 = icmp eq i32 %16, 2139095040
  %23 = icmp eq i32 %17, 2139095040
  %24 = or i1 %22, %23
  br i1 %24, label %25, label %31

; <label>:25                                      ; preds = %21
  %26 = select i1 %22, i32 %17, i32 %16
  %27 = icmp ne i32 %26, 0
  %28 = or i32 %8, 2139095040
  %29 = bitcast i32 %28 to float
  %30 = select i1 %27, float %29, float 0x7FF8000000000000
  br label %.thread

; <label>:31                                      ; preds = %21
  %32 = icmp eq i32 %16, 0
  %33 = icmp eq i32 %17, 0
  %. = or i1 %32, %33
  br i1 %., label %34, label %36

; <label>:34                                      ; preds = %31
  %35 = bitcast i32 %8 to float
  br label %.thread

; <label>:36                                      ; preds = %31
  %37 = icmp ult i32 %16, 8388608
  br i1 %37, label %38, label %44

; <label>:38                                      ; preds = %36
  %39 = tail call i32 @llvm.ctlz.i32(i32 %9, i1 false) #3
  %40 = add nuw nsw i32 %39, 24
  %41 = and i32 %40, 31
  %42 = shl i32 %9, %41
  %43 = sub nsw i32 9, %39
  br label %44

; <label>:44                                      ; preds = %38, %36
  %aSignificand.0 = phi i32 [ %42, %38 ], [ %9, %36 ]
  %scale.0 = phi i32 [ %43, %38 ], [ 0, %36 ]
  %45 = icmp ult i32 %17, 8388608
  br i1 %45, label %46, label %.thread11

; <label>:46                                      ; preds = %44
  %47 = tail call i32 @llvm.ctlz.i32(i32 %10, i1 false) #3
  %48 = add nuw nsw i32 %47, 24
  %49 = and i32 %48, 31
  %50 = shl i32 %10, %49
  %51 = add nsw i32 %scale.0, 9
  %52 = sub nsw i32 %51, %47
  br label %.thread11

.thread11:                                        ; preds = %44, %46, %0
  %aSignificand.2 = phi i32 [ %9, %0 ], [ %aSignificand.0, %46 ], [ %aSignificand.0, %44 ]
  %bSignificand.1 = phi i32 [ %10, %0 ], [ %50, %46 ], [ %10, %44 ]
  %scale.5 = phi i32 [ 0, %0 ], [ %52, %46 ], [ %scale.0, %44 ]
  %53 = or i32 %aSignificand.2, 8388608
  %54 = shl i32 %bSignificand.1, 8
  %55 = or i32 %54, -2147483648
  %56 = zext i32 %53 to i64
  %57 = zext i32 %55 to i64
  %58 = mul nuw i64 %57, %56
  %59 = lshr i64 %58, 32
  %60 = trunc i64 %59 to i32
  %61 = trunc i64 %58 to i32
  %62 = shl nuw nsw i64 %59, 1
  %63 = trunc i64 %62 to i32
  %64 = lshr i32 %61, 31
  %65 = or i32 %63, %64
  %66 = and i32 %60, 8388608
  %67 = icmp ne i32 %66, 0
  %.lobit = lshr exact i32 %66, 23
  %68 = add nsw i32 %3, -127
  %69 = add nsw i32 %68, %6
  %70 = add nsw i32 %69, %scale.5
  %71 = add i32 %70, %.lobit
  %72 = select i1 %67, i32 %60, i32 %65
  %73 = xor i32 %.lobit, 1
  %74 = shl i32 %61, %73
  %75 = icmp slt i32 %71, 1
  br i1 %75, label %76, label %92

; <label>:76                                      ; preds = %.thread11
  %77 = sub i32 1, %71
  %78 = icmp ugt i32 %77, 31
  br i1 %78, label %90, label %.thread13

.thread13:                                        ; preds = %76
  %79 = sub i32 0, %77
  %80 = and i32 %79, 31
  %81 = shl i32 %74, %80
  %82 = icmp ne i32 %81, 0
  %83 = shl i32 %72, %80
  %84 = and i32 %77, 31
  %85 = lshr i32 %74, %84
  %86 = or i32 %83, %85
  %87 = zext i1 %82 to i32
  %88 = or i32 %86, %87
  %89 = lshr i32 %72, %84
  br label %96

; <label>:90                                      ; preds = %76
  %91 = bitcast i32 %8 to float
  br label %.thread

; <label>:92                                      ; preds = %.thread11
  %93 = and i32 %72, 8388607
  %94 = shl i32 %71, 23
  %95 = or i32 %93, %94
  br label %96

; <label>:96                                      ; preds = %.thread13, %92
  %productHi.2 = phi i32 [ %95, %92 ], [ %89, %.thread13 ]
  %productLo.2 = phi i32 [ %74, %92 ], [ %88, %.thread13 ]
  %97 = or i32 %productHi.2, %8
  %98 = icmp ugt i32 %productLo.2, -2147483648
  %99 = zext i1 %98 to i32
  %100 = add i32 %99, %97
  %101 = icmp eq i32 %productLo.2, -2147483648
  %102 = and i32 %100, 1
  %103 = select i1 %101, i32 %102, i32 0
  %104 = add i32 %103, %100
  %105 = icmp sgt i32 %71, 254
  %106 = or i32 %8, 2139095040
  %107 = select i1 %105, i32 %106, i32 %104
  %108 = bitcast i32 %107 to float
  br label %.thread

.thread:                                          ; preds = %15, %34, %25, %96, %90
  %.6 = phi float [ %108, %96 ], [ %91, %90 ], [ 0x7FF8000000000000, %15 ], [ %35, %34 ], [ %30, %25 ]
  ret float %.6
}

; Function Attrs: nounwind
define void @fir_float(float* nocapture readonly %in, float* nocapture readonly %coeff, float* nocapture %out, i32 signext %filter_len) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !22
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !23
  %3 = add nsw i32 %2, %1
  br label %4

; <label>:4                                       ; preds = %4, %0
  %i.0 = phi i32 [ 0, %0 ], [ %12, %4 ]
  %acc.0 = phi float [ 0.000000e+00, %0 ], [ %11, %4 ]
  %5 = add nsw i32 %i.0, %3
  %6 = getelementptr inbounds float, float* %in, i32 %5
  %7 = load float, float* %6, align 4, !tbaa !24
  %8 = getelementptr inbounds float, float* %coeff, i32 %i.0
  %9 = load float, float* %8, align 4, !tbaa !24
  %10 = fmul float %7, %9
  %11 = fadd float %acc.0, %10
  %12 = add nuw nsw i32 %i.0, 1
  %13 = icmp eq i32 %12, %filter_len
  br i1 %13, label %14, label %4

; <label>:14                                      ; preds = %4
  %.lcssa = phi float [ %11, %4 ]
  %15 = getelementptr inbounds float, float* %out, i32 %3
  store float %.lcssa, float* %15, align 4, !tbaa !24
  ret void
}

; Function Attrs: nounwind
define void @fir(i32* nocapture readonly %in, i32* nocapture readonly %coeff, i32* nocapture %out, i32 signext %filter_len) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !22
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !23
  %3 = add nsw i32 %2, %1
  br label %4

; <label>:4                                       ; preds = %4, %0
  %i.0 = phi i32 [ 0, %0 ], [ %12, %4 ]
  %acc.0 = phi i32 [ 0, %0 ], [ %11, %4 ]
  %5 = add nsw i32 %i.0, %3
  %6 = getelementptr inbounds i32, i32* %in, i32 %5
  %7 = load i32, i32* %6, align 4, !tbaa !28
  %8 = getelementptr inbounds i32, i32* %coeff, i32 %i.0
  %9 = load i32, i32* %8, align 4, !tbaa !28
  %10 = mul nsw i32 %9, %7
  %11 = add nsw i32 %10, %acc.0
  %12 = add nuw nsw i32 %i.0, 1
  %13 = icmp eq i32 %12, %filter_len
  br i1 %13, label %14, label %4

; <label>:14                                      ; preds = %4
  %.lcssa = phi i32 [ %11, %4 ]
  %15 = getelementptr inbounds i32, i32* %out, i32 %3
  store i32 %.lcssa, i32* %15, align 4, !tbaa !28
  ret void
}

; Function Attrs: nounwind
define void @fir_half(i16* nocapture readonly %in, i16* nocapture readonly %coeff, i16* nocapture %out, i32 signext %filter_len) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !22
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !23
  %3 = add nsw i32 %2, %1
  br label %4

; <label>:4                                       ; preds = %4, %0
  %i.0 = phi i32 [ 0, %0 ], [ %14, %4 ]
  %acc.0 = phi i32 [ 0, %0 ], [ %13, %4 ]
  %5 = add nsw i32 %i.0, %3
  %6 = getelementptr inbounds i16, i16* %in, i32 %5
  %7 = load i16, i16* %6, align 2, !tbaa !30
  %8 = sext i16 %7 to i32
  %9 = getelementptr inbounds i16, i16* %coeff, i32 %i.0
  %10 = load i16, i16* %9, align 2, !tbaa !30
  %11 = sext i16 %10 to i32
  %12 = mul nsw i32 %11, %8
  %13 = add nsw i32 %12, %acc.0
  %14 = add nuw nsw i32 %i.0, 1
  %15 = icmp eq i32 %14, %filter_len
  br i1 %15, label %16, label %4

; <label>:16                                      ; preds = %4
  %.lcssa = phi i32 [ %13, %4 ]
  %17 = trunc i32 %.lcssa to i16
  %18 = getelementptr inbounds i16, i16* %out, i32 %3
  store i16 %17, i16* %18, align 2, !tbaa !30
  ret void
}

; Function Attrs: nounwind
define void @fir_half_improved(<2 x i16>* nocapture readonly %in, <2 x i16>* nocapture readonly %coeff, <2 x i16>* nocapture %out, i32 signext %filter_len) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !22
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !23
  %3 = add nsw i32 %2, %1
  %4 = sdiv i32 %filter_len, 2
  br label %5

; <label>:5                                       ; preds = %5, %0
  %acc1.0 = phi i32 [ 0, %0 ], [ %22, %5 ]
  %acc2.0 = phi i32 [ 0, %0 ], [ %31, %5 ]
  %i.0 = phi i32 [ 0, %0 ], [ %32, %5 ]
  %6 = add i32 %i.0, %3
  %7 = getelementptr inbounds <2 x i16>, <2 x i16>* %in, i32 %6
  %8 = load <2 x i16>, <2 x i16>* %7, align 4
  %9 = extractelement <2 x i16> %8, i32 0
  %10 = sext i16 %9 to i32
  %11 = getelementptr inbounds <2 x i16>, <2 x i16>* %coeff, i32 %i.0
  %12 = load <2 x i16>, <2 x i16>* %11, align 4
  %13 = extractelement <2 x i16> %12, i32 0
  %14 = sext i16 %13 to i32
  %15 = mul nsw i32 %14, %10
  %16 = add nsw i32 %15, %acc1.0
  %17 = extractelement <2 x i16> %8, i32 1
  %18 = sext i16 %17 to i32
  %19 = extractelement <2 x i16> %12, i32 1
  %20 = sext i16 %19 to i32
  %21 = mul nsw i32 %20, %18
  %22 = add nsw i32 %16, %21
  %23 = mul nsw i32 %14, %18
  %24 = add nsw i32 %23, %acc2.0
  %25 = add i32 %6, 1
  %26 = getelementptr inbounds <2 x i16>, <2 x i16>* %in, i32 %25
  %27 = load <2 x i16>, <2 x i16>* %26, align 4
  %28 = extractelement <2 x i16> %27, i32 0
  %29 = sext i16 %28 to i32
  %30 = mul nsw i32 %29, %20
  %31 = add nsw i32 %24, %30
  %32 = add nuw nsw i32 %i.0, 1
  %33 = icmp slt i32 %32, %4
  br i1 %33, label %5, label %34

; <label>:34                                      ; preds = %5
  %.lcssa6 = phi i32 [ %31, %5 ]
  %.lcssa = phi i32 [ %22, %5 ]
  %35 = trunc i32 %.lcssa to i16
  %36 = insertelement <2 x i16> undef, i16 %35, i32 0
  %37 = trunc i32 %.lcssa6 to i16
  %38 = insertelement <2 x i16> %36, i16 %37, i32 1
  %39 = getelementptr inbounds <2 x i16>, <2 x i16>* %out, i32 %3
  store <2 x i16> %38, <2 x i16>* %39, align 4, !tbaa !32
  ret void
}

; Function Attrs: nounwind
define void @fir_byte(i8* nocapture readonly %in, i8* nocapture readonly %coeff, i8* nocapture %out, i32 signext %filter_len) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !22
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !23
  %3 = add nsw i32 %2, %1
  br label %4

; <label>:4                                       ; preds = %4, %0
  %i.0 = phi i32 [ 0, %0 ], [ %14, %4 ]
  %acc.0 = phi i32 [ 0, %0 ], [ %13, %4 ]
  %5 = add nsw i32 %i.0, %3
  %6 = getelementptr inbounds i8, i8* %in, i32 %5
  %7 = load i8, i8* %6, align 1, !tbaa !32
  %8 = sext i8 %7 to i32
  %9 = getelementptr inbounds i8, i8* %coeff, i32 %i.0
  %10 = load i8, i8* %9, align 1, !tbaa !32
  %11 = sext i8 %10 to i32
  %12 = mul nsw i32 %11, %8
  %13 = add nsw i32 %12, %acc.0
  %14 = add nuw nsw i32 %i.0, 1
  %15 = icmp eq i32 %14, %filter_len
  br i1 %15, label %16, label %4

; <label>:16                                      ; preds = %4
  %.lcssa = phi i32 [ %13, %4 ]
  %17 = trunc i32 %.lcssa to i8
  %18 = getelementptr inbounds i8, i8* %out, i32 %3
  store i8 %17, i8* %18, align 1, !tbaa !32
  ret void
}

; Function Attrs: nounwind
define void @fir_byte_improved(<4 x i8>* nocapture readonly %in, <4 x i8>* nocapture readonly %coeff, <4 x i8>* nocapture %out, i32 signext %filter_len) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !22
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !23
  %3 = add nsw i32 %2, %1
  %4 = sdiv i32 %filter_len, 4
  br label %5

; <label>:5                                       ; preds = %5, %0
  %i.0 = phi i32 [ 0, %0 ], [ %68, %5 ]
  %acc1.0 = phi i32 [ 0, %0 ], [ %34, %5 ]
  %acc2.0 = phi i32 [ 0, %0 ], [ %47, %5 ]
  %acc3.0 = phi i32 [ 0, %0 ], [ %57, %5 ]
  %acc4.0 = phi i32 [ 0, %0 ], [ %67, %5 ]
  %6 = add nsw i32 %i.0, %3
  %7 = getelementptr inbounds <4 x i8>, <4 x i8>* %in, i32 %6
  %8 = load <4 x i8>, <4 x i8>* %7, align 4
  %9 = extractelement <4 x i8> %8, i32 0
  %10 = sext i8 %9 to i32
  %11 = getelementptr inbounds <4 x i8>, <4 x i8>* %coeff, i32 %i.0
  %12 = load <4 x i8>, <4 x i8>* %11, align 4
  %13 = extractelement <4 x i8> %12, i32 0
  %14 = sext i8 %13 to i32
  %15 = mul nsw i32 %14, %10
  %16 = add nsw i32 %15, %acc1.0
  %17 = extractelement <4 x i8> %8, i32 1
  %18 = sext i8 %17 to i32
  %19 = extractelement <4 x i8> %12, i32 1
  %20 = sext i8 %19 to i32
  %21 = mul nsw i32 %20, %18
  %22 = add nsw i32 %16, %21
  %23 = extractelement <4 x i8> %8, i32 2
  %24 = sext i8 %23 to i32
  %25 = extractelement <4 x i8> %12, i32 2
  %26 = sext i8 %25 to i32
  %27 = mul nsw i32 %26, %24
  %28 = add nsw i32 %22, %27
  %29 = extractelement <4 x i8> %8, i32 3
  %30 = sext i8 %29 to i32
  %31 = extractelement <4 x i8> %12, i32 3
  %32 = sext i8 %31 to i32
  %33 = mul nsw i32 %32, %30
  %34 = add nsw i32 %28, %33
  %35 = mul nsw i32 %14, %18
  %36 = add nsw i32 %35, %acc2.0
  %37 = mul nsw i32 %20, %24
  %38 = add nsw i32 %36, %37
  %39 = mul nsw i32 %26, %30
  %40 = add nsw i32 %38, %39
  %41 = add nsw i32 %6, 1
  %42 = getelementptr inbounds <4 x i8>, <4 x i8>* %in, i32 %41
  %43 = load <4 x i8>, <4 x i8>* %42, align 4
  %44 = extractelement <4 x i8> %43, i32 0
  %45 = sext i8 %44 to i32
  %46 = mul nsw i32 %45, %32
  %47 = add nsw i32 %40, %46
  %48 = mul nsw i32 %14, %24
  %49 = add nsw i32 %48, %acc3.0
  %50 = mul nsw i32 %20, %30
  %51 = add nsw i32 %49, %50
  %52 = mul nsw i32 %45, %26
  %53 = add nsw i32 %51, %52
  %54 = extractelement <4 x i8> %43, i32 1
  %55 = sext i8 %54 to i32
  %56 = mul nsw i32 %55, %32
  %57 = add nsw i32 %53, %56
  %58 = mul nsw i32 %14, %30
  %59 = add nsw i32 %58, %acc4.0
  %60 = mul nsw i32 %45, %20
  %61 = add nsw i32 %59, %60
  %62 = mul nsw i32 %55, %26
  %63 = add nsw i32 %61, %62
  %64 = extractelement <4 x i8> %43, i32 2
  %65 = sext i8 %64 to i32
  %66 = mul nsw i32 %65, %32
  %67 = add nsw i32 %63, %66
  %68 = add nuw nsw i32 %i.0, 1
  %69 = icmp eq i32 %68, %4
  br i1 %69, label %70, label %5

; <label>:70                                      ; preds = %5
  %.lcssa18 = phi i32 [ %67, %5 ]
  %.lcssa17 = phi i32 [ %57, %5 ]
  %.lcssa16 = phi i32 [ %47, %5 ]
  %.lcssa = phi i32 [ %34, %5 ]
  %71 = trunc i32 %.lcssa to i8
  %72 = getelementptr inbounds <4 x i8>, <4 x i8>* %out, i32 %3
  %73 = insertelement <4 x i8> undef, i8 %71, i32 0
  %74 = trunc i32 %.lcssa16 to i8
  %75 = insertelement <4 x i8> %73, i8 %74, i32 1
  %76 = trunc i32 %.lcssa17 to i8
  %77 = insertelement <4 x i8> %75, i8 %76, i32 2
  %78 = trunc i32 %.lcssa18 to i8
  %79 = insertelement <4 x i8> %77, i8 %78, i32 3
  store <4 x i8> %79, <4 x i8>* %72, align 4
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @llvm.ctlz.i32(i32, i1) #2

attributes #0 = { nounwind readnone "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!opencl.kernels = !{!0, !6, !9, !12, !15, !18}
!llvm.ident = !{!21}

!0 = !{void (float*, float*, float*, i32)* @fir_float, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float*", !"float*", !"float*", !"int"}
!4 = !{!"kernel_arg_base_type", !"float*", !"float*", !"float*", !"int"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !"", !""}
!6 = !{void (i32*, i32*, i32*, i32)* @fir, !1, !2, !7, !8, !5}
!7 = !{!"kernel_arg_type", !"int*", !"int*", !"int*", !"int"}
!8 = !{!"kernel_arg_base_type", !"int*", !"int*", !"int*", !"int"}
!9 = !{void (i16*, i16*, i16*, i32)* @fir_half, !1, !2, !10, !11, !5}
!10 = !{!"kernel_arg_type", !"short*", !"short*", !"short*", !"int"}
!11 = !{!"kernel_arg_base_type", !"short*", !"short*", !"short*", !"int"}
!12 = !{void (<2 x i16>*, <2 x i16>*, <2 x i16>*, i32)* @fir_half_improved, !1, !2, !13, !14, !5}
!13 = !{!"kernel_arg_type", !"short2*", !"short2*", !"short2*", !"int"}
!14 = !{!"kernel_arg_base_type", !"short __attribute__((ext_vector_type(2)))*", !"short __attribute__((ext_vector_type(2)))*", !"short __attribute__((ext_vector_type(2)))*", !"int"}
!15 = !{void (i8*, i8*, i8*, i32)* @fir_byte, !1, !2, !16, !17, !5}
!16 = !{!"kernel_arg_type", !"char*", !"char*", !"char*", !"int"}
!17 = !{!"kernel_arg_base_type", !"char*", !"char*", !"char*", !"int"}
!18 = !{void (<4 x i8>*, <4 x i8>*, <4 x i8>*, i32)* @fir_byte_improved, !1, !2, !19, !20, !5}
!19 = !{!"kernel_arg_type", !"char4*", !"char4*", !"char4*", !"int"}
!20 = !{!"kernel_arg_base_type", !"char __attribute__((ext_vector_type(4)))*", !"char __attribute__((ext_vector_type(4)))*", !"char __attribute__((ext_vector_type(4)))*", !"int"}
!21 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
!22 = !{i32 13908}
!23 = !{i32 14048}
!24 = !{!25, !25, i64 0}
!25 = !{!"float", !26, i64 0}
!26 = !{!"omnipotent char", !27, i64 0}
!27 = !{!"Simple C/C++ TBAA"}
!28 = !{!29, !29, i64 0}
!29 = !{!"int", !26, i64 0}
!30 = !{!31, !31, i64 0}
!31 = !{!"short", !26, i64 0}
!32 = !{!26, !26, i64 0}
