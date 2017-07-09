; ModuleID = 'floydwarshall.cl'
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
define void @floydWarshallPass(float* nocapture %mat, i32 signext %pass) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !7
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !8
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 1) #3, !srcloc !7
  %5 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 1) #3, !srcloc !8
  %6 = add nsw i32 %5, %4
  %7 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !9
  %8 = mul i32 %6, %7
  %9 = add i32 %8, %3
  %10 = getelementptr inbounds float, float* %mat, i32 %9
  %11 = load float, float* %10, align 4, !tbaa !10
  %12 = add i32 %8, %pass
  %13 = getelementptr inbounds float, float* %mat, i32 %12
  %14 = load float, float* %13, align 4, !tbaa !10
  %15 = mul i32 %7, %pass
  %16 = add i32 %15, %3
  %17 = getelementptr inbounds float, float* %mat, i32 %16
  %18 = load float, float* %17, align 4, !tbaa !10
  %19 = fadd float %14, %18
  %20 = fcmp olt float %19, %11
  br i1 %20, label %21, label %22

; <label>:21                                      ; preds = %0
  store float %19, float* %10, align 4, !tbaa !10
  br label %22

; <label>:22                                      ; preds = %21, %0
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

!0 = !{void (float*, i32)* @floydWarshallPass, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float*", !"uint"}
!4 = !{!"kernel_arg_base_type", !"float*", !"uint"}
!5 = !{!"kernel_arg_type_qual", !"", !""}
!6 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
!7 = !{i32 11799}
!8 = !{i32 11939}
!9 = !{i32 11578}
!10 = !{!11, !11, i64 0}
!11 = !{!"float", !12, i64 0}
!12 = !{!"omnipotent char", !13, i64 0}
!13 = !{!"Simple C/C++ TBAA"}
