; ModuleID = 'vec_mul.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

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
define void @vec_mul(i32* nocapture readonly %in1, i32* nocapture readonly %in2, i32* nocapture %out) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !7
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !8
  %3 = add nsw i32 %2, %1
  %4 = getelementptr inbounds i32, i32* %in1, i32 %3
  %5 = load i32, i32* %4, align 4, !tbaa !9
  %6 = getelementptr inbounds i32, i32* %in2, i32 %3
  %7 = load i32, i32* %6, align 4, !tbaa !9
  %8 = mul nsw i32 %7, %5
  %9 = getelementptr inbounds i32, i32* %out, i32 %3
  store i32 %8, i32* %9, align 4, !tbaa !9
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @llvm.ctlz.i32(i32, i1) #2

attributes #0 = { nounwind readnone "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (i32*, i32*, i32*)* @vec_mul, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"int*", !"int*", !"int*"}
!4 = !{!"kernel_arg_base_type", !"int*", !"int*", !"int*"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !""}
!6 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
!7 = !{i32 12486}
!8 = !{i32 12626}
!9 = !{!10, !10, i64 0}
!10 = !{!"int", !11, i64 0}
!11 = !{!"omnipotent char", !12, i64 0}
!12 = !{!"Simple C/C++ TBAA"}
