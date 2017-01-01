; ModuleID = 'max_hard_float.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind
define void @max_hard_float(float* nocapture readonly %in, float* nocapture %out, i32 signext %reduce_factor) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !7
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !8
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !9
  %arrayidx = getelementptr inbounds float, float* %in, i32 %add.i
  %3 = load float, float* %arrayidx, align 4, !tbaa !10
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %i.0 = phi i32 [ 1, %entry ], [ %inc, %do.body ]
  %begin.0 = phi i32 [ %add.i, %entry ], [ %add, %do.body ]
  %max_val.0 = phi float [ %3, %entry ], [ %cond, %do.body ]
  %add = add i32 %begin.0, %2
  %arrayidx3 = getelementptr inbounds float, float* %in, i32 %add
  %4 = load float, float* %arrayidx3, align 4, !tbaa !10
  %cmp = fcmp olt float %4, %max_val.0
  %cond = select i1 %cmp, float %max_val.0, float %4
  %inc = add nuw nsw i32 %i.0, 1
  %cmp4 = icmp eq i32 %inc, %reduce_factor
  br i1 %cmp4, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %cond.lcssa = phi float [ %cond, %do.body ]
  %arrayidx5 = getelementptr inbounds float, float* %out, i32 %add.i
  store float %cond.lcssa, float* %arrayidx5, align 4, !tbaa !10
  ret void
}

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (float*, float*, i32)* @max_hard_float, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float*", !"float*", !"uint"}
!4 = !{!"kernel_arg_base_type", !"float*", !"float*", !"uint"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !""}
!6 = !{!"clang version 3.7.0 (tags/RELEASE_371/final)"}
!7 = !{i32 11771}
!8 = !{i32 11911}
!9 = !{i32 11550}
!10 = !{!11, !11, i64 0}
!11 = !{!"float", !12, i64 0}
!12 = !{!"omnipotent char", !13, i64 0}
!13 = !{!"Simple C/C++ TBAA"}
