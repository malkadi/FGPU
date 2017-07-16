; ModuleID = 'xcorr_hard_float.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind
define void @xcorr_float_hard_float(float* nocapture readonly %in1, float* nocapture readonly %in2, float* nocapture %out) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !7
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !8
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !9
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %res.0 = phi float [ 0.000000e+00, %entry ], [ %add3, %do.body ]
  %arrayidx = getelementptr inbounds float, float* %in1, i32 %i.0
  %3 = load float, float* %arrayidx, align 4, !tbaa !10
  %add = add nsw i32 %i.0, %add.i
  %arrayidx2 = getelementptr inbounds float, float* %in2, i32 %add
  %4 = load float, float* %arrayidx2, align 4, !tbaa !10
  %mul = fmul float %3, %4
  %add3 = fadd float %res.0, %mul
  %inc = add nuw nsw i32 %i.0, 1
  %cmp = icmp eq i32 %inc, %2
  br i1 %cmp, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %add3.lcssa = phi float [ %add3, %do.body ]
  %arrayidx4 = getelementptr inbounds float, float* %out, i32 %add.i
  store float %add3.lcssa, float* %arrayidx4, align 4, !tbaa !10
  ret void
}

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (float*, float*, float*)* @xcorr_float_hard_float, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float*", !"float*", !"float*"}
!4 = !{!"kernel_arg_base_type", !"float*", !"float*", !"float*"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !""}
!6 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
!7 = !{i32 11682}
!8 = !{i32 11822}
!9 = !{i32 11461}
!10 = !{!11, !11, i64 0}
!11 = !{!"float", !12, i64 0}
!12 = !{!"omnipotent char", !13, i64 0}
!13 = !{!"Simple C/C++ TBAA"}
