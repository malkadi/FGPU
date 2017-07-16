; ModuleID = 'bitonic_hard_float.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind
define void @bitonicSort_hard_float(float* nocapture %a, i32 signext %stage, i32 signext %passOfStage, i32 signext %direction) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !7
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !8
  %add.i = add nsw i32 %1, %0
  %sub = sub i32 %stage, %passOfStage
  %shl.mask = and i32 %sub, 31
  %shl = shl i32 1, %shl.mask
  %mul = shl i32 %shl, 1
  %2 = add i32 %shl, -1
  %rem = and i32 %add.i, %2
  %div = lshr i32 %add.i, %shl.mask
  %mul1 = mul i32 %mul, %div
  %add = add i32 %mul1, %rem
  %add2 = add i32 %add, %shl
  %arrayidx = getelementptr inbounds float, float* %a, i32 %add
  %3 = load float, float* %arrayidx, align 4, !tbaa !9
  %arrayidx3 = getelementptr inbounds float, float* %a, i32 %add2
  %4 = load float, float* %arrayidx3, align 4, !tbaa !9
  %shl.mask4 = and i32 %stage, 31
  %5 = shl i32 1, %shl.mask4
  %rem762 = and i32 %add.i, %5
  %cmp = icmp eq i32 %rem762, 0
  %sub8 = sub i32 1, %direction
  %direction.sub8 = select i1 %cmp, i32 %direction, i32 %sub8
  %cmp9 = fcmp ogt float %3, %4
  %cond = select i1 %cmp9, float %3, float %4
  %cond14 = select i1 %cmp9, float %4, float %3
  %tobool15 = icmp ne i32 %direction.sub8, 0
  %cond19 = select i1 %tobool15, float %cond14, float %cond
  %cond24 = select i1 %tobool15, float %cond, float %cond14
  store float %cond19, float* %arrayidx, align 4, !tbaa !9
  store float %cond24, float* %arrayidx3, align 4, !tbaa !9
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
