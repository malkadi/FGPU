; ModuleID = 'nbody.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind
define void @nbody_iter(<4 x float>* nocapture readonly %pos, <4 x float>* nocapture readonly %vel, float %deltaTime, float %epsSqr, <4 x float>* nocapture %newPosition, <4 x float>* nocapture %newVelocity) #0 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !7
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !8
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !9
  %5 = getelementptr inbounds <4 x float>, <4 x float>* %pos, i32 %3
  %6 = load <4 x float>, <4 x float>* %5, align 16, !tbaa !10
  br label %7

; <label>:7                                       ; preds = %7, %0
  %i.0 = phi i32 [ 0, %0 ], [ %32, %7 ]
  %acc.0 = phi <4 x float> [ zeroinitializer, %0 ], [ %31, %7 ]
  %8 = getelementptr inbounds <4 x float>, <4 x float>* %pos, i32 %i.0
  %9 = load <4 x float>, <4 x float>* %8, align 16, !tbaa !10
  %10 = fsub <4 x float> %9, %6
  %11 = extractelement <4 x float> %10, i32 0
  %12 = extractelement <4 x float> %10, i32 1
  %13 = fmul float %12, %12
  %14 = tail call float @llvm.fmuladd.f32(float %11, float %11, float %13)
  %15 = extractelement <4 x float> %10, i32 2
  %16 = tail call float @llvm.fmuladd.f32(float %15, float %15, float %14)
  %17 = fadd float %16, %epsSqr
  %18 = tail call float @sqrtf(float %17) #1
  %19 = fdiv float 1.000000e+00, %18, !fpmath !13
  %20 = fmul float %19, %19
  %21 = fmul float %19, %20
  %22 = extractelement <4 x float> %9, i32 3
  %23 = fmul float %22, %21
  %24 = insertelement <3 x float> undef, float %23, i32 0
  %25 = shufflevector <3 x float> %24, <3 x float> undef, <3 x i32> zeroinitializer
  %26 = shufflevector <4 x float> %10, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %27 = fmul <3 x float> %26, %25
  %28 = shufflevector <4 x float> %acc.0, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %29 = fadd <3 x float> %28, %27
  %30 = shufflevector <3 x float> %29, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %31 = shufflevector <4 x float> %acc.0, <4 x float> %30, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  %32 = add nuw i32 %i.0, 1
  %33 = icmp ult i32 %32, %4
  br i1 %33, label %7, label %34

; <label>:34                                      ; preds = %7
  %.lcssa = phi <4 x float> [ %31, %7 ]
  %35 = shufflevector <4 x float> %6, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %36 = getelementptr inbounds <4 x float>, <4 x float>* %vel, i32 %3
  %37 = load <4 x float>, <4 x float>* %36, align 16, !tbaa !10
  %38 = shufflevector <4 x float> %37, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %39 = insertelement <3 x float> undef, float %deltaTime, i32 0
  %40 = shufflevector <3 x float> %39, <3 x float> undef, <3 x i32> zeroinitializer
  %41 = tail call <3 x float> @llvm.fmuladd.v3f32(<3 x float> %38, <3 x float> %40, <3 x float> %35)
  %42 = shufflevector <4 x float> %.lcssa, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %43 = fmul <3 x float> %42, <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>
  %44 = fmul <3 x float> %40, %43
  %45 = tail call <3 x float> @llvm.fmuladd.v3f32(<3 x float> %44, <3 x float> %40, <3 x float> %41)
  %46 = shufflevector <3 x float> %45, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %47 = tail call <3 x float> @llvm.fmuladd.v3f32(<3 x float> %42, <3 x float> %40, <3 x float> %38)
  %48 = shufflevector <3 x float> %47, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %49 = getelementptr inbounds <4 x float>, <4 x float>* %newPosition, i32 %3
  store <4 x float> %46, <4 x float>* %49, align 16, !tbaa !10
  %50 = getelementptr inbounds <4 x float>, <4 x float>* %newVelocity, i32 %3
  store <4 x float> %48, <4 x float>* %50, align 16, !tbaa !10
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
!6 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
!7 = !{i32 12493}
!8 = !{i32 12633}
!9 = !{i32 12272}
!10 = !{!11, !11, i64 0}
!11 = !{!"omnipotent char", !12, i64 0}
!12 = !{!"Simple C/C++ TBAA"}
!13 = !{float 2.500000e+00}
