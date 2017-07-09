; ModuleID = 'sum_power_hard_float.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind
define void @sum_power_hard_float(float* nocapture readonly %in, float* nocapture %out, i32 signext %reduce_factor, float %mean) #0 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !13
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !14
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !15
  br label %5

; <label>:5                                       ; preds = %5, %0
  %begin.0 = phi i32 [ %3, %0 ], [ %12, %5 ]
  %i.0 = phi i32 [ 0, %0 ], [ %11, %5 ]
  %sum.0 = phi float [ 0.000000e+00, %0 ], [ %10, %5 ]
  %6 = getelementptr inbounds float, float* %in, i32 %begin.0
  %7 = load float, float* %6, align 4, !tbaa !16
  %8 = fsub float %7, %mean
  %9 = fmul float %8, %8
  %10 = fadd float %sum.0, %9
  %11 = add nuw nsw i32 %i.0, 1
  %12 = add i32 %begin.0, %4
  %13 = icmp eq i32 %11, %reduce_factor
  br i1 %13, label %14, label %5

; <label>:14                                      ; preds = %5
  %.lcssa = phi float [ %10, %5 ]
  %15 = getelementptr inbounds float, float* %out, i32 %3
  store float %.lcssa, float* %15, align 4, !tbaa !16
  ret void
}

; Function Attrs: nounwind
define void @sum_hard_float(float* nocapture readonly %in, float* nocapture %out, i32 signext %reduce_factor) #0 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !13
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !14
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !15
  br label %5

; <label>:5                                       ; preds = %5, %0
  %begin.0 = phi i32 [ %3, %0 ], [ %10, %5 ]
  %i.0 = phi i32 [ 0, %0 ], [ %9, %5 ]
  %sum.0 = phi float [ 0.000000e+00, %0 ], [ %8, %5 ]
  %6 = getelementptr inbounds float, float* %in, i32 %begin.0
  %7 = load float, float* %6, align 4, !tbaa !16
  %8 = fadd float %sum.0, %7
  %9 = add nuw nsw i32 %i.0, 1
  %10 = add i32 %begin.0, %4
  %11 = icmp eq i32 %9, %reduce_factor
  br i1 %11, label %12, label %5

; <label>:12                                      ; preds = %5
  %.lcssa = phi float [ %8, %5 ]
  %13 = getelementptr inbounds float, float* %out, i32 %3
  store float %.lcssa, float* %13, align 4, !tbaa !16
  ret void
}

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }

!opencl.kernels = !{!0, !6}
!llvm.ident = !{!12}

!0 = !{void (float*, float*, i32, float)* @sum_power_hard_float, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float*", !"float*", !"uint", !"float"}
!4 = !{!"kernel_arg_base_type", !"float*", !"float*", !"uint", !"float"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !"", !""}
!6 = !{void (float*, float*, i32)* @sum_hard_float, !7, !8, !9, !10, !11}
!7 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0}
!8 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!9 = !{!"kernel_arg_type", !"float*", !"float*", !"uint"}
!10 = !{!"kernel_arg_base_type", !"float*", !"float*", !"uint"}
!11 = !{!"kernel_arg_type_qual", !"", !"", !""}
!12 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
!13 = !{i32 12069}
!14 = !{i32 12209}
!15 = !{i32 11848}
!16 = !{!17, !17, i64 0}
!17 = !{!"float", !18, i64 0}
!18 = !{!"omnipotent char", !19, i64 0}
!19 = !{!"Simple C/C++ TBAA"}
