; ModuleID = 'nbody.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind
define void @nbody_iter(<4 x float>* nocapture readonly %pos, <4 x float>* nocapture readonly %vel, float %deltaTime, float %epsSqr, <4 x float>* nocapture %newPosition, <4 x float>* nocapture %newVelocity) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !7
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !8
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !9
  %arrayidx = getelementptr inbounds <4 x float>, <4 x float>* %pos, i32 %add.i
  %3 = load <4 x float>, <4 x float>* %arrayidx, align 16, !tbaa !10
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %acc.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %15, %do.body ]
  %arrayidx2 = getelementptr inbounds <4 x float>, <4 x float>* %pos, i32 %i.0
  %4 = load <4 x float>, <4 x float>* %arrayidx2, align 16, !tbaa !10
  %5 = fsub <4 x float> %4, %3
  %6 = extractelement <4 x float> %5, i32 0
  %7 = extractelement <4 x float> %5, i32 1
  %mul3 = fmul float %7, %7
  %8 = tail call float @llvm.fmuladd.f32(float %6, float %6, float %mul3)
  %9 = extractelement <4 x float> %5, i32 2
  %10 = tail call float @llvm.fmuladd.f32(float %9, float %9, float %8)
  %add = fadd float %10, %epsSqr
  %call4 = tail call float @sqrtf(float %add) #1
  %div = fdiv float 1.000000e+00, %call4, !fpmath !13
  %mul = fmul float %div, %div
  %mul5 = fmul float %div, %mul
  %11 = extractelement <4 x float> %4, i32 3
  %mul6 = fmul float %11, %mul5
  %splat.splatinsert = insertelement <3 x float> undef, float %mul6, i32 0
  %splat.splat = shufflevector <3 x float> %splat.splatinsert, <3 x float> undef, <3 x i32> zeroinitializer
  %12 = shufflevector <4 x float> %5, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %mul7 = fmul <3 x float> %12, %splat.splat
  %13 = shufflevector <4 x float> %acc.0, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %add8 = fadd <3 x float> %13, %mul7
  %14 = shufflevector <3 x float> %add8, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %15 = shufflevector <4 x float> %acc.0, <4 x float> %14, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  %inc = add nuw i32 %i.0, 1
  %cmp = icmp ult i32 %inc, %2
  br i1 %cmp, label %do.body, label %do.end

do.end:                                           ; preds = %do.body
  %.lcssa = phi <4 x float> [ %15, %do.body ]
  %16 = shufflevector <4 x float> %3, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %arrayidx9 = getelementptr inbounds <4 x float>, <4 x float>* %vel, i32 %add.i
  %17 = load <4 x float>, <4 x float>* %arrayidx9, align 16, !tbaa !10
  %18 = shufflevector <4 x float> %17, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %splat.splatinsert10 = insertelement <3 x float> undef, float %deltaTime, i32 0
  %splat.splat11 = shufflevector <3 x float> %splat.splatinsert10, <3 x float> undef, <3 x i32> zeroinitializer
  %19 = tail call <3 x float> @llvm.fmuladd.v3f32(<3 x float> %18, <3 x float> %splat.splat11, <3 x float> %16)
  %20 = shufflevector <4 x float> %.lcssa, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %mul13 = fmul <3 x float> %20, <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>
  %mul16 = fmul <3 x float> %splat.splat11, %mul13
  %21 = tail call <3 x float> @llvm.fmuladd.v3f32(<3 x float> %mul16, <3 x float> %splat.splat11, <3 x float> %19)
  %22 = shufflevector <3 x float> %21, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %23 = tail call <3 x float> @llvm.fmuladd.v3f32(<3 x float> %20, <3 x float> %splat.splat11, <3 x float> %18)
  %24 = shufflevector <3 x float> %23, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %arrayidx23 = getelementptr inbounds <4 x float>, <4 x float>* %newPosition, i32 %add.i
  store <4 x float> %22, <4 x float>* %arrayidx23, align 16, !tbaa !10
  %arrayidx24 = getelementptr inbounds <4 x float>, <4 x float>* %newVelocity, i32 %add.i
  store <4 x float> %24, <4 x float>* %arrayidx24, align 16, !tbaa !10
  ret void
}

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: nounwind readnone
declare float @sqrtf(float) #2

; Function Attrs: nounwind readnone
declare <3 x float> @llvm.fmuladd.v3f32(<3 x float>, <3 x float>, <3 x float>) #1

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { nounwind readnone "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (<4 x float>*, <4 x float>*, float, float, <4 x float>*, <4 x float>*)* @nbody_iter, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0, i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float4*", !"float4*", !"float", !"float", !"float4*", !"float4*"}
!4 = !{!"kernel_arg_base_type", !"float __attribute__((ext_vector_type(4)))*", !"float __attribute__((ext_vector_type(4)))*", !"float", !"float", !"float __attribute__((ext_vector_type(4)))*", !"float __attribute__((ext_vector_type(4)))*"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !"", !"", !"", !""}
!6 = !{!"clang version 3.7.0 (tags/RELEASE_371/final)"}
!7 = !{i32 12493}
!8 = !{i32 12633}
!9 = !{i32 12272}
!10 = !{!11, !11, i64 0}
!11 = !{!"omnipotent char", !12, i64 0}
!12 = !{!"Simple C/C++ TBAA"}
!13 = !{float 2.500000e+00}
