; ModuleID = 'parallel_selection_hard_float.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind
define void @ParallelSelection_hard_float(float* nocapture readonly %in, float* nocapture %out) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !7
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !8
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !9
  %arrayidx = getelementptr inbounds float, float* %in, i32 %add.i
  %3 = load float, float* %arrayidx, align 4, !tbaa !10
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %j.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %pos.0 = phi i32 [ 0, %entry ], [ %add, %do.body ]
  %arrayidx2 = getelementptr inbounds float, float* %in, i32 %j.0
  %4 = load float, float* %arrayidx2, align 4, !tbaa !10
  %cmp = fcmp olt float %4, %3
  %cmp3 = fcmp oeq float %4, %3
  %cmp4 = icmp slt i32 %j.0, %add.i
  %5 = and i1 %cmp4, %cmp3
  %6 = or i1 %cmp, %5
  %lor.ext = zext i1 %6 to i32
  %add = add nsw i32 %lor.ext, %pos.0
  %inc = add nuw nsw i32 %j.0, 1
  %cmp7 = icmp eq i32 %inc, %2
  br i1 %cmp7, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %add.lcssa = phi i32 [ %add, %do.body ]
  %arrayidx8 = getelementptr inbounds float, float* %out, i32 %add.lcssa
  store float %3, float* %arrayidx8, align 4, !tbaa !10
  ret void
}

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (float*, float*)* @ParallelSelection_hard_float, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float*", !"float*"}
!4 = !{!"kernel_arg_base_type", !"float*", !"float*"}
!5 = !{!"kernel_arg_type_qual", !"", !""}
!6 = !{!"clang version 3.7.0 (tags/RELEASE_371/final)"}
!7 = !{i32 11885}
!8 = !{i32 12025}
!9 = !{i32 11664}
!10 = !{!11, !11, i64 0}
!11 = !{!"float", !12, i64 0}
!12 = !{!"omnipotent char", !13, i64 0}
!13 = !{!"Simple C/C++ TBAA"}
