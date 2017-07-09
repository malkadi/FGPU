; ModuleID = 'bitonic.cl'
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
define void @bitonicSort_float(float* nocapture %a, i32 signext %stage, i32 signext %passOfStage, i32 signext %direction) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !10
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !11
  %3 = add nsw i32 %2, %1
  %4 = sub i32 %stage, %passOfStage
  %5 = and i32 %4, 31
  %6 = shl i32 1, %5
  %7 = shl i32 %6, 1
  %8 = add i32 %6, -1
  %9 = and i32 %3, %8
  %10 = lshr i32 %3, %5
  %11 = mul i32 %7, %10
  %12 = add i32 %11, %9
  %13 = add i32 %12, %6
  %14 = getelementptr inbounds float, float* %a, i32 %12
  %15 = load float, float* %14, align 4, !tbaa !12
  %16 = getelementptr inbounds float, float* %a, i32 %13
  %17 = load float, float* %16, align 4, !tbaa !12
  %18 = and i32 %stage, 31
  %19 = shl i32 1, %18
  %20 = and i32 %3, %19
  %21 = icmp eq i32 %20, 0
  %22 = sub i32 1, %direction
  %direction. = select i1 %21, i32 %direction, i32 %22
  %23 = fcmp ogt float %15, %17
  %24 = select i1 %23, float %15, float %17
  %25 = select i1 %23, float %17, float %15
  %26 = icmp ne i32 %direction., 0
  %27 = select i1 %26, float %25, float %24
  %28 = select i1 %26, float %24, float %25
  store float %27, float* %14, align 4, !tbaa !12
  store float %28, float* %16, align 4, !tbaa !12
  ret void
}

; Function Attrs: nounwind
define void @bitonicSort(i32* nocapture %a, i32 signext %stage, i32 signext %passOfStage, i32 signext %direction) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !10
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !11
  %3 = add nsw i32 %2, %1
  %4 = sub i32 %stage, %passOfStage
  %5 = and i32 %4, 31
  %6 = shl i32 1, %5
  %7 = shl i32 %6, 1
  %8 = add i32 %6, -1
  %9 = and i32 %3, %8
  %10 = lshr i32 %3, %5
  %11 = mul i32 %7, %10
  %12 = add i32 %11, %9
  %13 = add i32 %12, %6
  %14 = getelementptr inbounds i32, i32* %a, i32 %12
  %15 = load i32, i32* %14, align 4, !tbaa !16
  %16 = getelementptr inbounds i32, i32* %a, i32 %13
  %17 = load i32, i32* %16, align 4, !tbaa !16
  %18 = and i32 %stage, 31
  %19 = shl i32 1, %18
  %20 = and i32 %3, %19
  %21 = icmp eq i32 %20, 0
  %22 = sub i32 1, %direction
  %direction. = select i1 %21, i32 %direction, i32 %22
  %23 = icmp sgt i32 %15, %17
  %24 = select i1 %23, i32 %15, i32 %17
  %25 = select i1 %23, i32 %17, i32 %15
  %26 = icmp ne i32 %direction., 0
  %27 = select i1 %26, i32 %25, i32 %24
  %28 = select i1 %26, i32 %24, i32 %25
  store i32 %27, i32* %14, align 4, !tbaa !16
  store i32 %28, i32* %16, align 4, !tbaa !16
  ret void
}

attributes #0 = { nounwind readnone "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !6}
!llvm.ident = !{!9}

!0 = !{void (float*, i32, i32, i32)* @bitonicSort_float, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float*", !"uint", !"uint", !"uint"}
!4 = !{!"kernel_arg_base_type", !"float*", !"uint", !"uint", !"uint"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !"", !""}
!6 = !{void (i32*, i32, i32, i32)* @bitonicSort, !1, !2, !7, !8, !5}
!7 = !{!"kernel_arg_type", !"int*", !"uint", !"uint", !"uint"}
!8 = !{!"kernel_arg_base_type", !"int*", !"uint", !"uint", !"uint"}
!9 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
!10 = !{i32 13493}
!11 = !{i32 13633}
!12 = !{!13, !13, i64 0}
!13 = !{!"float", !14, i64 0}
!14 = !{!"omnipotent char", !15, i64 0}
!15 = !{!"Simple C/C++ TBAA"}
!16 = !{!17, !17, i64 0}
!17 = !{!"int", !14, i64 0}
