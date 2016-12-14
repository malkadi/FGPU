; ModuleID = 'fft_hard_float.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind
define void @butterfly_hard(<2 x float>* nocapture %in, i32 signext %iter, <2 x float>* nocapture readonly %twiddle) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !7
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !8
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !9
  %shl.mask = and i32 %iter, 31
  %shl = shl i32 1, %shl.mask
  %mul = shl i32 %shl, 1
  %shr = lshr i32 %2, %shl.mask
  %sub = add nsw i32 %shl, -1
  %and = and i32 %add.i, %sub
  %shr3 = lshr i32 %add.i, %shl.mask
  %mul4 = mul i32 %mul, %shr3
  %add = add i32 %mul4, %and
  %add5 = add nsw i32 %add, %shl
  %mul6 = mul nsw i32 %shr, %and
  %arrayidx = getelementptr inbounds <2 x float>, <2 x float>* %in, i32 %add
  %3 = load <2 x float>, <2 x float>* %arrayidx, align 8, !tbaa !10
  %arrayidx7 = getelementptr inbounds <2 x float>, <2 x float>* %in, i32 %add5
  %4 = load <2 x float>, <2 x float>* %arrayidx7, align 8, !tbaa !10
  %5 = shufflevector <2 x float> %4, <2 x float> undef, <2 x i32> zeroinitializer
  %6 = shufflevector <2 x float> %4, <2 x float> undef, <2 x i32> <i32 1, i32 1>
  %arrayidx8 = getelementptr inbounds <2 x float>, <2 x float>* %twiddle, i32 %mul6
  %7 = load <2 x float>, <2 x float>* %arrayidx8, align 8, !tbaa !10
  %8 = extractelement <2 x float> %7, i32 1
  %sub9 = fsub float -0.000000e+00, %8
  %9 = insertelement <2 x float> undef, float %sub9, i32 0
  %10 = extractelement <2 x float> %7, i32 0
  %11 = shufflevector <2 x float> %9, <2 x float> %7, <2 x i32> <i32 0, i32 2>
  %12 = insertelement <2 x float> undef, float %8, i32 0
  %sub10 = fsub float -0.000000e+00, %10
  %13 = insertelement <2 x float> %12, float %sub10, i32 1
  %14 = tail call <2 x float> @llvm.fmuladd.v2f32(<2 x float> %5, <2 x float> %7, <2 x float> %3)
  %15 = tail call <2 x float> @llvm.fmuladd.v2f32(<2 x float> %6, <2 x float> %11, <2 x float> %14)
  %neg = fsub <2 x float> <float -0.000000e+00, float -0.000000e+00>, %5
  %16 = tail call <2 x float> @llvm.fmuladd.v2f32(<2 x float> %neg, <2 x float> %7, <2 x float> %3)
  %17 = tail call <2 x float> @llvm.fmuladd.v2f32(<2 x float> %6, <2 x float> %13, <2 x float> %16)
  store <2 x float> %15, <2 x float>* %arrayidx, align 8, !tbaa !10
  store <2 x float> %17, <2 x float>* %arrayidx7, align 8, !tbaa !10
  ret void
}

; Function Attrs: nounwind readnone
declare <2 x float> @llvm.fmuladd.v2f32(<2 x float>, <2 x float>, <2 x float>) #1

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (<2 x float>*, i32, <2 x float>*)* @butterfly_hard, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float2*", !"int", !"float2*"}
!4 = !{!"kernel_arg_base_type", !"float __attribute__((ext_vector_type(2)))*", !"int", !"float __attribute__((ext_vector_type(2)))*"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !""}
!6 = !{!"clang version 3.7.0 (tags/RELEASE_371/final)"}
!7 = !{i32 12264}
!8 = !{i32 12404}
!9 = !{i32 12043}
!10 = !{!11, !11, i64 0}
!11 = !{!"omnipotent char", !12, i64 0}
!12 = !{!"Simple C/C++ TBAA"}
