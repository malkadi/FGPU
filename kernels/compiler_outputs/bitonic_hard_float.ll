; ModuleID = 'bitonic_hard_float.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind
define void @bitonicSort_hard_float(float* nocapture %a, i32 signext %stage, i32 signext %passOfStage, i32 signext %direction) #0 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !7
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !8
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
  %15 = load float, float* %14, align 4, !tbaa !9
  %16 = getelementptr inbounds float, float* %a, i32 %13
  %17 = load float, float* %16, align 4, !tbaa !9
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
  store float %27, float* %14, align 4, !tbaa !9
  store float %28, float* %16, align 4, !tbaa !9
  ret void
}

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (float*, i32, i32, i32)* @bitonicSort_hard_float, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float*", !"uint", !"uint", !"uint"}
!4 = !{!"kernel_arg_base_type", !"float*", !"uint", !"uint", !"uint"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !"", !""}
!6 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
!7 = !{i32 12447}
!8 = !{i32 12587}
!9 = !{!10, !10, i64 0}
!10 = !{!"float", !11, i64 0}
!11 = !{!"omnipotent char", !12, i64 0}
!12 = !{!"Simple C/C++ TBAA"}
