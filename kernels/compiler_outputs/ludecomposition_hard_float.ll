; ModuleID = 'ludecomposition_hard_float.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind
define void @ludecomposition_pass_hard_float(float* nocapture %mat, float* nocapture %L, i32 signext %size, i32 signext %k) #0 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 1) #2, !srcloc !7
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 1) #2, !srcloc !8
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !7
  %5 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !8
  %6 = add nsw i32 %5, %4
  %7 = mul i32 %3, %size
  %8 = add i32 %7, %k
  %9 = getelementptr inbounds float, float* %mat, i32 %8
  %10 = load float, float* %9, align 4, !tbaa !9
  %11 = mul i32 %k, %size
  %12 = add i32 %11, %k
  %13 = getelementptr inbounds float, float* %mat, i32 %12
  %14 = load float, float* %13, align 4, !tbaa !9
  %15 = fdiv float %10, %14, !fpmath !13
  %16 = add i32 %6, %7
  %17 = getelementptr inbounds float, float* %mat, i32 %16
  %18 = load float, float* %17, align 4, !tbaa !9
  %19 = add i32 %6, %11
  %20 = getelementptr inbounds float, float* %mat, i32 %19
  %21 = load float, float* %20, align 4, !tbaa !9
  %22 = fsub float -0.000000e+00, %15
  %23 = tail call float @llvm.fmuladd.f32(float %22, float %21, float %18)
  %24 = icmp ult i32 %3, %size
  br i1 %24, label %25, label %36

; <label>:25                                      ; preds = %0
  %26 = icmp eq i32 %6, %k
  br i1 %26, label %27, label %33

; <label>:27                                      ; preds = %25
  %28 = getelementptr inbounds float, float* %L, i32 %8
  store float %15, float* %28, align 4, !tbaa !9
  %29 = add i32 %k, 1
  %30 = icmp eq i32 %3, %29
  br i1 %30, label %31, label %36

; <label>:31                                      ; preds = %27
  %32 = getelementptr inbounds float, float* %L, i32 %12
  store float 1.000000e+00, float* %32, align 4, !tbaa !9
  br label %36

; <label>:33                                      ; preds = %25
  %34 = icmp ult i32 %6, %size
  br i1 %34, label %35, label %36

; <label>:35                                      ; preds = %33
  store float %23, float* %17, align 4, !tbaa !9
  br label %36

; <label>:36                                      ; preds = %31, %27, %35, %33, %0
  ret void
}

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #1

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (float*, float*, i32, i32)* @ludecomposition_pass_hard_float, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float*", !"float*", !"uint", !"uint"}
!4 = !{!"kernel_arg_base_type", !"float*", !"float*", !"uint", !"uint"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !"", !""}
!6 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
!7 = !{i32 12054}
!8 = !{i32 12194}
!9 = !{!10, !10, i64 0}
!10 = !{!"float", !11, i64 0}
!11 = !{!"omnipotent char", !12, i64 0}
!12 = !{!"Simple C/C++ TBAA"}
!13 = !{float 2.500000e+00}
