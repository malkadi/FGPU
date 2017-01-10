; ModuleID = 'floydwarshall_hard_float.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind
define void @floydWarshallPass_hard_float(float* nocapture %mat, i32 signext %pass) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !7
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !8
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 1) #1, !srcloc !7
  %3 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 1) #1, !srcloc !8
  %add.i.30 = add nsw i32 %3, %2
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !9
  %mul = mul i32 %add.i.30, %4
  %add = add i32 %mul, %add.i
  %arrayidx = getelementptr inbounds float, float* %mat, i32 %add
  %5 = load float, float* %arrayidx, align 4, !tbaa !10
  %add4 = add i32 %mul, %pass
  %arrayidx5 = getelementptr inbounds float, float* %mat, i32 %add4
  %6 = load float, float* %arrayidx5, align 4, !tbaa !10
  %mul6 = mul i32 %4, %pass
  %add7 = add i32 %mul6, %add.i
  %arrayidx8 = getelementptr inbounds float, float* %mat, i32 %add7
  %7 = load float, float* %arrayidx8, align 4, !tbaa !10
  %add9 = fadd float %6, %7
  %cmp = fcmp olt float %add9, %5
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  store float %add9, float* %arrayidx, align 4, !tbaa !10
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (float*, i32)* @floydWarshallPass_hard_float, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float*", !"uint"}
!4 = !{!"kernel_arg_base_type", !"float*", !"uint"}
!5 = !{!"kernel_arg_type_qual", !"", !""}
!6 = !{!"clang version 3.7.0 (tags/RELEASE_371/final)"}
!7 = !{i32 11766}
!8 = !{i32 11906}
!9 = !{i32 11545}
!10 = !{!11, !11, i64 0}
!11 = !{!"float", !12, i64 0}
!12 = !{!"omnipotent char", !13, i64 0}
!13 = !{!"Simple C/C++ TBAA"}
