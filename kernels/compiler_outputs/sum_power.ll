; ModuleID = 'sum_power.cl'
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

; Function Attrs: nounwind readnone
define float @__subsf3(float %a, float %b) #0 {
  %1 = bitcast float %b to i32
  %2 = xor i32 %1, -2147483648
  %3 = bitcast i32 %2 to float
  %4 = bitcast float %a to i32
  %5 = and i32 %4, 2147483647
  %6 = and i32 %1, 2147483647
  %7 = add nsw i32 %5, -1
  %8 = icmp ugt i32 %7, 2139095038
  %9 = add nsw i32 %6, -1
  %10 = icmp ugt i32 %9, 2139095038
  %or.cond = or i1 %8, %10
  br i1 %or.cond, label %11, label %30

; <label>:11                                      ; preds = %0
  %12 = icmp ugt i32 %5, 2139095040
  %13 = icmp ugt i32 %6, 2139095040
  %14 = or i1 %12, %13
  %15 = icmp eq i32 %5, 2139095040
  %16 = xor i32 %2, %4
  %17 = icmp eq i32 %16, -2147483648
  %18 = and i1 %15, %17
  %19 = or i1 %14, %18
  %brmerge = or i1 %15, %14
  %.mux = select i1 %19, float 0x7FF8000000000000, float %a
  br i1 %brmerge, label %.thread, label %20

; <label>:20                                      ; preds = %11
  %21 = icmp eq i32 %6, 2139095040
  br i1 %21, label %.thread, label %22

; <label>:22                                      ; preds = %20
  %23 = icmp eq i32 %5, 0
  %24 = icmp ne i32 %6, 0
  br i1 %23, label %25, label %29

; <label>:25                                      ; preds = %22
  br i1 %24, label %.thread, label %26

; <label>:26                                      ; preds = %25
  %27 = and i32 %2, %4
  %28 = bitcast i32 %27 to float
  br label %.thread

; <label>:29                                      ; preds = %22
  br i1 %24, label %30, label %.thread

; <label>:30                                      ; preds = %0, %29
  %31 = icmp ugt i32 %6, %5
  %32 = select i1 %31, i32 %4, i32 %2
  %33 = select i1 %31, i32 %2, i32 %4
  %34 = lshr i32 %33, 23
  %35 = and i32 %34, 255
  %36 = lshr i32 %32, 23
  %37 = and i32 %36, 255
  %38 = and i32 %33, 8388607
  %39 = and i32 %32, 8388607
  %40 = icmp eq i32 %35, 0
  br i1 %40, label %41, label %47

; <label>:41                                      ; preds = %30
  %42 = tail call i32 @llvm.ctlz.i32(i32 %38, i1 false) #3
  %43 = add nuw nsw i32 %42, 24
  %44 = and i32 %43, 31
  %45 = shl i32 %38, %44
  %46 = sub nsw i32 9, %42
  br label %47

; <label>:47                                      ; preds = %41, %30
  %aSignificand.0 = phi i32 [ %45, %41 ], [ %38, %30 ]
  %aExponent.0 = phi i32 [ %46, %41 ], [ %35, %30 ]
  %48 = icmp eq i32 %37, 0
  br i1 %48, label %49, label %55

; <label>:49                                      ; preds = %47
  %50 = tail call i32 @llvm.ctlz.i32(i32 %39, i1 false) #3
  %51 = add nuw nsw i32 %50, 24
  %52 = and i32 %51, 31
  %53 = shl i32 %39, %52
  %54 = sub nsw i32 9, %50
  br label %55

; <label>:55                                      ; preds = %49, %47
  %bSignificand.0 = phi i32 [ %53, %49 ], [ %39, %47 ]
  %bExponent.0 = phi i32 [ %54, %49 ], [ %37, %47 ]
  %56 = and i32 %33, -2147483648
  %57 = xor i32 %33, %32
  %58 = icmp slt i32 %57, 0
  %59 = shl i32 %aSignificand.0, 3
  %60 = or i32 %59, 67108864
  %61 = shl i32 %bSignificand.0, 3
  %62 = or i32 %61, 67108864
  %63 = sub nsw i32 %aExponent.0, %bExponent.0
  %64 = icmp eq i32 %aExponent.0, %bExponent.0
  br i1 %64, label %76, label %65

; <label>:65                                      ; preds = %55
  %66 = icmp ult i32 %63, 32
  br i1 %66, label %67, label %76

; <label>:67                                      ; preds = %65
  %68 = sub nsw i32 0, %63
  %69 = and i32 %68, 31
  %70 = shl i32 %62, %69
  %71 = icmp ne i32 %70, 0
  %72 = and i32 %63, 31
  %73 = lshr i32 %62, %72
  %74 = zext i1 %71 to i32
  %75 = or i32 %74, %73
  br label %76

; <label>:76                                      ; preds = %65, %55, %67
  %bSignificand.1 = phi i32 [ %62, %55 ], [ %75, %67 ], [ 1, %65 ]
  br i1 %58, label %77, label %88

; <label>:77                                      ; preds = %76
  %78 = sub i32 %60, %bSignificand.1
  %79 = icmp eq i32 %60, %bSignificand.1
  br i1 %79, label %.thread, label %80

; <label>:80                                      ; preds = %77
  %81 = icmp ult i32 %78, 67108864
  br i1 %81, label %82, label %97

; <label>:82                                      ; preds = %80
  %83 = tail call i32 @llvm.ctlz.i32(i32 %78, i1 false) #3
  %84 = add nsw i32 %83, -5
  %85 = and i32 %84, 31
  %86 = shl i32 %78, %85
  %87 = sub nsw i32 %aExponent.0, %84
  br label %97

; <label>:88                                      ; preds = %76
  %89 = add i32 %bSignificand.1, %60
  %90 = and i32 %89, 134217728
  %91 = icmp eq i32 %90, 0
  br i1 %91, label %97, label %92

; <label>:92                                      ; preds = %88
  %fold = add i32 %bSignificand.1, %59
  %93 = and i32 %fold, 1
  %94 = lshr i32 %89, 1
  %95 = or i32 %94, %93
  %96 = add nsw i32 %aExponent.0, 1
  br label %97

; <label>:97                                      ; preds = %88, %92, %80, %82
  %aSignificand.1 = phi i32 [ %86, %82 ], [ %78, %80 ], [ %89, %88 ], [ %95, %92 ]
  %aExponent.1 = phi i32 [ %87, %82 ], [ %aExponent.0, %80 ], [ %aExponent.0, %88 ], [ %96, %92 ]
  %98 = icmp sgt i32 %aExponent.1, 254
  br i1 %98, label %99, label %102

; <label>:99                                      ; preds = %97
  %100 = or i32 %56, 2139095040
  %101 = bitcast i32 %100 to float
  br label %.thread

; <label>:102                                     ; preds = %97
  %103 = icmp slt i32 %aExponent.1, 1
  br i1 %103, label %104, label %114

; <label>:104                                     ; preds = %102
  %105 = sub nsw i32 1, %aExponent.1
  %106 = sub nsw i32 0, %105
  %107 = and i32 %106, 31
  %108 = shl i32 %aSignificand.1, %107
  %109 = icmp ne i32 %108, 0
  %110 = and i32 %105, 31
  %111 = lshr i32 %aSignificand.1, %110
  %112 = zext i1 %109 to i32
  %113 = or i32 %112, %111
  br label %114

; <label>:114                                     ; preds = %104, %102
  %aSignificand.2 = phi i32 [ %113, %104 ], [ %aSignificand.1, %102 ]
  %aExponent.2 = phi i32 [ 0, %104 ], [ %aExponent.1, %102 ]
  %115 = and i32 %aSignificand.2, 7
  %116 = lshr i32 %aSignificand.2, 3
  %117 = and i32 %116, 8388607
  %118 = shl i32 %aExponent.2, 23
  %119 = or i32 %118, %56
  %120 = or i32 %119, %117
  %121 = icmp ugt i32 %115, 4
  %122 = zext i1 %121 to i32
  %.6 = add i32 %120, %122
  %123 = icmp eq i32 %115, 4
  %124 = and i32 %.6, 1
  %125 = select i1 %123, i32 %124, i32 0
  %result.1 = add i32 %125, %.6
  %126 = bitcast i32 %result.1 to float
  br label %.thread

.thread:                                          ; preds = %11, %25, %20, %26, %99, %114, %77, %29
  %.2 = phi float [ %a, %29 ], [ %101, %99 ], [ %126, %114 ], [ 0.000000e+00, %77 ], [ %.mux, %11 ], [ %3, %25 ], [ %3, %20 ], [ %28, %26 ]
  ret float %.2
}

; Function Attrs: nounwind
define void @sum_power_float(float* nocapture readonly %in, float* nocapture %out, i32 signext %reduce_factor, float %mean) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !20
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !21
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !22
  br label %5

; <label>:5                                       ; preds = %5, %0
  %begin.0 = phi i32 [ %3, %0 ], [ %12, %5 ]
  %i.0 = phi i32 [ 0, %0 ], [ %11, %5 ]
  %sum.0 = phi float [ 0.000000e+00, %0 ], [ %10, %5 ]
  %6 = getelementptr inbounds float, float* %in, i32 %begin.0
  %7 = load float, float* %6, align 4, !tbaa !23
  %8 = fsub float %7, %mean
  %9 = fmul float %8, %8
  %10 = fadd float %sum.0, %9
  %11 = add nuw nsw i32 %i.0, 1
  %12 = add i32 %begin.0, %4
  %13 = icmp eq i32 %11, %reduce_factor
  br i1 %13, label %14, label %5

; <label>:14                                      ; preds = %5
  %.lcssa = phi float [ %10, %5 ]
  %15 = getelementptr inbounds float, float* %out, i32 %3
  store float %.lcssa, float* %15, align 4, !tbaa !23
  ret void
}

; Function Attrs: nounwind
define void @sum_float(float* nocapture readonly %in, float* nocapture %out, i32 signext %reduce_factor) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !20
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !21
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !22
  br label %5

; <label>:5                                       ; preds = %5, %0
  %begin.0 = phi i32 [ %3, %0 ], [ %10, %5 ]
  %i.0 = phi i32 [ 0, %0 ], [ %9, %5 ]
  %sum.0 = phi float [ 0.000000e+00, %0 ], [ %8, %5 ]
  %6 = getelementptr inbounds float, float* %in, i32 %begin.0
  %7 = load float, float* %6, align 4, !tbaa !23
  %8 = fadd float %sum.0, %7
  %9 = add nuw nsw i32 %i.0, 1
  %10 = add i32 %begin.0, %4
  %11 = icmp eq i32 %9, %reduce_factor
  br i1 %11, label %12, label %5

; <label>:12                                      ; preds = %5
  %.lcssa = phi float [ %8, %5 ]
  %13 = getelementptr inbounds float, float* %out, i32 %3
  store float %.lcssa, float* %13, align 4, !tbaa !23
  ret void
}

; Function Attrs: nounwind
define void @sum_power(i32* nocapture readonly %in, i32* nocapture %out, i32 signext %reduce_factor, i32 signext %mean) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !20
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !21
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !22
  br label %5

; <label>:5                                       ; preds = %5, %0
  %begin.0 = phi i32 [ %3, %0 ], [ %12, %5 ]
  %i.0 = phi i32 [ 0, %0 ], [ %11, %5 ]
  %sum.0 = phi i32 [ 0, %0 ], [ %10, %5 ]
  %6 = getelementptr inbounds i32, i32* %in, i32 %begin.0
  %7 = load i32, i32* %6, align 4, !tbaa !27
  %8 = sub nsw i32 %7, %mean
  %9 = mul nsw i32 %8, %8
  %10 = add nsw i32 %9, %sum.0
  %11 = add nuw nsw i32 %i.0, 1
  %12 = add i32 %begin.0, %4
  %13 = icmp eq i32 %11, %reduce_factor
  br i1 %13, label %14, label %5

; <label>:14                                      ; preds = %5
  %.lcssa = phi i32 [ %10, %5 ]
  %15 = getelementptr inbounds i32, i32* %out, i32 %3
  store i32 %.lcssa, i32* %15, align 4, !tbaa !27
  ret void
}

; Function Attrs: nounwind
define void @sum_power_atomic(i32* nocapture readonly %in, i32* %out, i32 signext %reduce_factor) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !20
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !21
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !22
  br label %5

; <label>:5                                       ; preds = %5, %0
  %begin.0 = phi i32 [ %3, %0 ], [ %12, %5 ]
  %i.0 = phi i32 [ 0, %0 ], [ %11, %5 ]
  %sum.0 = phi i32 [ 0, %0 ], [ %10, %5 ]
  %6 = getelementptr inbounds i32, i32* %in, i32 %begin.0
  %7 = load i32, i32* %6, align 4, !tbaa !27
  %8 = add nsw i32 %7, -100
  %9 = mul nsw i32 %8, %8
  %10 = add nsw i32 %9, %sum.0
  %11 = add nuw nsw i32 %i.0, 1
  %12 = add i32 %begin.0, %4
  %13 = icmp eq i32 %11, %reduce_factor
  br i1 %13, label %14, label %5

; <label>:14                                      ; preds = %5
  %.lcssa = phi i32 [ %10, %5 ]
  %15 = tail call i32 asm sideeffect "aadd $0, $1, r0", "=r,r,0,~{$1}"(i32* %out, i32 %.lcssa) #3, !srcloc !29
  ret void
}

; Function Attrs: nounwind
define void @sum(i32* nocapture readonly %in, i32* nocapture %out, i32 signext %reduce_factor) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !20
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !21
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !22
  br label %5

; <label>:5                                       ; preds = %5, %0
  %begin.0 = phi i32 [ %3, %0 ], [ %10, %5 ]
  %i.0 = phi i32 [ 0, %0 ], [ %9, %5 ]
  %sum.0 = phi i32 [ 0, %0 ], [ %8, %5 ]
  %6 = getelementptr inbounds i32, i32* %in, i32 %begin.0
  %7 = load i32, i32* %6, align 4, !tbaa !27
  %8 = add nsw i32 %7, %sum.0
  %9 = add nuw nsw i32 %i.0, 1
  %10 = add i32 %begin.0, %4
  %11 = icmp eq i32 %9, %reduce_factor
  br i1 %11, label %12, label %5

; <label>:12                                      ; preds = %5
  %.lcssa = phi i32 [ %8, %5 ]
  %13 = getelementptr inbounds i32, i32* %out, i32 %3
  store i32 %.lcssa, i32* %13, align 4, !tbaa !27
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @llvm.ctlz.i32(i32, i1) #2

attributes #0 = { nounwind readnone "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!opencl.kernels = !{!0, !6, !12, !15, !18}
!llvm.ident = !{!19}

!0 = !{void (float*, float*, i32, float)* @sum_power_float, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float*", !"float*", !"uint", !"float"}
!4 = !{!"kernel_arg_base_type", !"float*", !"float*", !"uint", !"float"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !"", !""}
!6 = !{void (float*, float*, i32)* @sum_float, !7, !8, !9, !10, !11}
!7 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0}
!8 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!9 = !{!"kernel_arg_type", !"float*", !"float*", !"uint"}
!10 = !{!"kernel_arg_base_type", !"float*", !"float*", !"uint"}
!11 = !{!"kernel_arg_type_qual", !"", !"", !""}
!12 = !{void (i32*, i32*, i32, i32)* @sum_power, !1, !2, !13, !14, !5}
!13 = !{!"kernel_arg_type", !"int*", !"int*", !"uint", !"int"}
!14 = !{!"kernel_arg_base_type", !"int*", !"int*", !"uint", !"int"}
!15 = !{void (i32*, i32*, i32)* @sum_power_atomic, !7, !8, !16, !17, !11}
!16 = !{!"kernel_arg_type", !"int*", !"int*", !"uint"}
!17 = !{!"kernel_arg_base_type", !"int*", !"int*", !"uint"}
!18 = !{void (i32*, i32*, i32)* @sum, !7, !8, !16, !17, !11}
!19 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
!20 = !{i32 13102}
!21 = !{i32 13242}
!22 = !{i32 12881}
!23 = !{!24, !24, i64 0}
!24 = !{!"float", !25, i64 0}
!25 = !{!"omnipotent char", !26, i64 0}
!26 = !{!"Simple C/C++ TBAA"}
!27 = !{!28, !28, i64 0}
!28 = !{!"int", !25, i64 0}
!29 = !{i32 13479}
