; ModuleID = 'matrix_multiply_hard_float.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind
define void @matrix_multiply_hard_float(float* nocapture readonly %in1, float* nocapture readonly %in2, float* nocapture %out) #0 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 1) #1, !srcloc !7
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 1) #1, !srcloc !8
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !7
  %5 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !8
  %6 = add nsw i32 %5, %4
  %7 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !9
  %8 = mul nsw i32 %7, %3
  br label %9

; <label>:9                                       ; preds = %9, %0
  %i.0 = phi i32 [ 0, %0 ], [ %19, %9 ]
  %res.0 = phi float [ 0.000000e+00, %0 ], [ %18, %9 ]
  %10 = add nsw i32 %i.0, %8
  %11 = getelementptr inbounds float, float* %in1, i32 %10
  %12 = load float, float* %11, align 4, !tbaa !10
  %13 = mul nsw i32 %i.0, %7
  %14 = add nsw i32 %13, %6
  %15 = getelementptr inbounds float, float* %in2, i32 %14
  %16 = load float, float* %15, align 4, !tbaa !10
  %17 = fmul float %12, %16
  %18 = fadd float %res.0, %17
  %19 = add nuw nsw i32 %i.0, 1
  %20 = icmp eq i32 %19, %7
  br i1 %20, label %21, label %9

; <label>:21                                      ; preds = %9
  %.lcssa = phi float [ %18, %9 ]
  %22 = add nsw i32 %8, %6
  %23 = getelementptr inbounds float, float* %out, i32 %22
  store float %.lcssa, float* %23, align 4, !tbaa !10
  ret void
}

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (float*, float*, float*)* @matrix_multiply_hard_float, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float*", !"float*", !"float*"}
!4 = !{!"kernel_arg_base_type", !"float*", !"float*", !"float*"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !""}
!6 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
!7 = !{i32 11735}
!8 = !{i32 11875}
!9 = !{i32 11514}
!10 = !{!11, !11, i64 0}
!11 = !{!"float", !12, i64 0}
!12 = !{!"omnipotent char", !13, i64 0}
!13 = !{!"Simple C/C++ TBAA"}
