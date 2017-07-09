; ModuleID = 'parallel_selection_hard_float.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind
define void @ParallelSelection_hard_float(float* nocapture readonly %in, float* nocapture %out) #0 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !7
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !8
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !9
  %5 = getelementptr inbounds float, float* %in, i32 %3
  %6 = load float, float* %5, align 4, !tbaa !10
  br label %7

; <label>:7                                       ; preds = %7, %0
  %j.0 = phi i32 [ 0, %0 ], [ %17, %7 ]
  %pos.0 = phi i32 [ 0, %0 ], [ %16, %7 ]
  %8 = getelementptr inbounds float, float* %in, i32 %j.0
  %9 = load float, float* %8, align 4, !tbaa !10
  %10 = fcmp olt float %9, %6
  %11 = fcmp oeq float %9, %6
  %12 = icmp slt i32 %j.0, %3
  %13 = and i1 %12, %11
  %14 = or i1 %10, %13
  %15 = zext i1 %14 to i32
  %16 = add nsw i32 %15, %pos.0
  %17 = add nuw nsw i32 %j.0, 1
  %18 = icmp eq i32 %17, %4
  br i1 %18, label %19, label %7

; <label>:19                                      ; preds = %7
  %.lcssa = phi i32 [ %16, %7 ]
  %20 = getelementptr inbounds float, float* %out, i32 %.lcssa
  store float %6, float* %20, align 4, !tbaa !10
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
!6 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
!7 = !{i32 11885}
!8 = !{i32 12025}
!9 = !{i32 11664}
!10 = !{!11, !11, i64 0}
!11 = !{!"float", !12, i64 0}
!12 = !{!"omnipotent char", !13, i64 0}
!13 = !{!"Simple C/C++ TBAA"}
