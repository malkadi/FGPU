; ModuleID = 'fft_hard_float.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind
define void @butterfly_hard_float(<2 x float>* nocapture %in, i32 signext %iter, <2 x float>* nocapture readonly %twiddle) #0 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !7
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !8
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !9
  %5 = and i32 %iter, 31
  %6 = shl i32 1, %5
  %7 = shl i32 %6, 1
  %8 = lshr i32 %4, %5
  %9 = add nsw i32 %6, -1
  %10 = and i32 %3, %9
  %11 = lshr i32 %3, %5
  %12 = mul i32 %7, %11
  %13 = add i32 %12, %10
  %14 = add nsw i32 %13, %6
  %15 = mul nsw i32 %8, %10
  %16 = getelementptr inbounds <2 x float>, <2 x float>* %in, i32 %13
  %17 = load <2 x float>, <2 x float>* %16, align 8, !tbaa !10
  %18 = getelementptr inbounds <2 x float>, <2 x float>* %in, i32 %14
  %19 = load <2 x float>, <2 x float>* %18, align 8, !tbaa !10
  %20 = shufflevector <2 x float> %19, <2 x float> undef, <2 x i32> zeroinitializer
  %21 = shufflevector <2 x float> %19, <2 x float> undef, <2 x i32> <i32 1, i32 1>
  %22 = getelementptr inbounds <2 x float>, <2 x float>* %twiddle, i32 %15
  %23 = load <2 x float>, <2 x float>* %22, align 8, !tbaa !10
  %24 = extractelement <2 x float> %23, i32 1
  %25 = fsub float -0.000000e+00, %24
  %26 = insertelement <2 x float> undef, float %25, i32 0
  %27 = extractelement <2 x float> %23, i32 0
  %28 = shufflevector <2 x float> %26, <2 x float> %23, <2 x i32> <i32 0, i32 2>
  %29 = insertelement <2 x float> undef, float %24, i32 0
  %30 = fsub float -0.000000e+00, %27
  %31 = insertelement <2 x float> %29, float %30, i32 1
  %32 = tail call <2 x float> @llvm.fmuladd.v2f32(<2 x float> %20, <2 x float> %23, <2 x float> %17)
  %33 = tail call <2 x float> @llvm.fmuladd.v2f32(<2 x float> %21, <2 x float> %28, <2 x float> %32)
  %34 = extractelement <2 x float> %19, i32 0
  %35 = fsub float -0.000000e+00, %34
  %36 = insertelement <2 x float> undef, float %35, i32 0
  %37 = insertelement <2 x float> %36, float %35, i32 1
  %38 = tail call <2 x float> @llvm.fmuladd.v2f32(<2 x float> %37, <2 x float> %23, <2 x float> %17)
  %39 = tail call <2 x float> @llvm.fmuladd.v2f32(<2 x float> %21, <2 x float> %31, <2 x float> %38)
  store <2 x float> %33, <2 x float>* %16, align 8, !tbaa !10
  store <2 x float> %39, <2 x float>* %18, align 8, !tbaa !10
  ret void
}

; Function Attrs: nounwind readnone
declare <2 x float> @llvm.fmuladd.v2f32(<2 x float>, <2 x float>, <2 x float>) #1

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (<2 x float>*, i32, <2 x float>*)* @butterfly_hard_float, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float2*", !"int", !"float2*"}
!4 = !{!"kernel_arg_base_type", !"float __attribute__((ext_vector_type(2)))*", !"int", !"float __attribute__((ext_vector_type(2)))*"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !""}
!6 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
!7 = !{i32 12538}
!8 = !{i32 12678}
!9 = !{i32 12317}
!10 = !{!11, !11, i64 0}
!11 = !{!"omnipotent char", !12, i64 0}
!12 = !{!"Simple C/C++ TBAA"}
