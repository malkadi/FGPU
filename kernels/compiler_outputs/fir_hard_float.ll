; ModuleID = 'fir_hard_float.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind
define void @fir_hard_float(float* nocapture readonly %in, float* nocapture readonly %coeff, float* nocapture %out, i32 signext %filter_len) #0 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !7
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !8
  %3 = add nsw i32 %2, %1
  br label %4

; <label>:4                                       ; preds = %4, %0
  %i.0 = phi i32 [ 0, %0 ], [ %12, %4 ]
  %acc.0 = phi float [ 0.000000e+00, %0 ], [ %11, %4 ]
  %5 = add nsw i32 %i.0, %3
  %6 = getelementptr inbounds float, float* %in, i32 %5
  %7 = load float, float* %6, align 4, !tbaa !9
  %8 = getelementptr inbounds float, float* %coeff, i32 %i.0
  %9 = load float, float* %8, align 4, !tbaa !9
  %10 = fmul float %7, %9
  %11 = fadd float %acc.0, %10
  %12 = add nuw nsw i32 %i.0, 1
  %13 = icmp eq i32 %12, %filter_len
  br i1 %13, label %14, label %4

; <label>:14                                      ; preds = %4
  %.lcssa = phi float [ %11, %4 ]
  %15 = getelementptr inbounds float, float* %out, i32 %3
  store float %.lcssa, float* %15, align 4, !tbaa !9
  ret void
}

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (float*, float*, float*, i32)* @fir_hard_float, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float*", !"float*", !"float*", !"int"}
!4 = !{!"kernel_arg_base_type", !"float*", !"float*", !"float*", !"int"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !"", !""}
!6 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
!7 = !{i32 11663}
!8 = !{i32 11803}
!9 = !{!10, !10, i64 0}
!10 = !{!"float", !11, i64 0}
!11 = !{!"omnipotent char", !12, i64 0}
!12 = !{!"Simple C/C++ TBAA"}
