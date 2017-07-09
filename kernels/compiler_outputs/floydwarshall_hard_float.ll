; ModuleID = 'floydwarshall_hard_float.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind
define void @floydWarshallPass_hard_float(float* nocapture %mat, i32 signext %pass) #0 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !7
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !8
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 1) #1, !srcloc !7
  %5 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 1) #1, !srcloc !8
  %6 = add nsw i32 %5, %4
  %7 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !9
  %8 = mul i32 %6, %7
  %9 = add i32 %8, %3
  %10 = getelementptr inbounds float, float* %mat, i32 %9
  %11 = load float, float* %10, align 4, !tbaa !10
  %12 = add i32 %8, %pass
  %13 = getelementptr inbounds float, float* %mat, i32 %12
  %14 = load float, float* %13, align 4, !tbaa !10
  %15 = mul i32 %7, %pass
  %16 = add i32 %15, %3
  %17 = getelementptr inbounds float, float* %mat, i32 %16
  %18 = load float, float* %17, align 4, !tbaa !10
  %19 = fadd float %14, %18
  %20 = fcmp olt float %19, %11
  br i1 %20, label %21, label %22

; <label>:21                                      ; preds = %0
  store float %19, float* %10, align 4, !tbaa !10
  br label %22

; <label>:22                                      ; preds = %21, %0
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
!6 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
!7 = !{i32 11766}
!8 = !{i32 11906}
!9 = !{i32 11545}
!10 = !{!11, !11, i64 0}
!11 = !{!"float", !12, i64 0}
!12 = !{!"omnipotent char", !13, i64 0}
!13 = !{!"Simple C/C++ TBAA"}
