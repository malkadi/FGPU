; ModuleID = 'ludecomposition_hard_float.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind
define void @ludecomposition_pass_hard_float(float* nocapture %mat, float* nocapture %L, i32 signext %size, i32 signext %k) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 1) #2, !srcloc !7
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 1) #2, !srcloc !8
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !7
  %3 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !8
  %add.i.67 = add nsw i32 %3, %2
  %mul = mul i32 %add.i, %size
  %add = add i32 %mul, %k
  %arrayidx = getelementptr inbounds float, float* %mat, i32 %add
  %4 = load float, float* %arrayidx, align 4, !tbaa !9
  %mul2 = mul i32 %k, %size
  %add3 = add i32 %mul2, %k
  %arrayidx4 = getelementptr inbounds float, float* %mat, i32 %add3
  %5 = load float, float* %arrayidx4, align 4, !tbaa !9
  %div = fdiv float %4, %5, !fpmath !13
  %cmp = icmp ult i32 %add.i, %size
  br i1 %cmp, label %if.then, label %if.end.31

if.then:                                          ; preds = %entry
  %cmp5 = icmp eq i32 %add.i.67, %k
  br i1 %cmp5, label %if.then.6, label %if.else

if.then.6:                                        ; preds = %if.then
  %arrayidx9 = getelementptr inbounds float, float* %L, i32 %add
  store float %div, float* %arrayidx9, align 4, !tbaa !9
  %add10 = add i32 %k, 1
  %cmp11 = icmp eq i32 %add.i, %add10
  br i1 %cmp11, label %if.then.12, label %if.end.31

if.then.12:                                       ; preds = %if.then.6
  %arrayidx15 = getelementptr inbounds float, float* %L, i32 %add3
  store float 1.000000e+00, float* %arrayidx15, align 4, !tbaa !9
  br label %if.end.31

if.else:                                          ; preds = %if.then
  %cmp16 = icmp ult i32 %add.i.67, %size
  br i1 %cmp16, label %if.then.17, label %if.end.31

if.then.17:                                       ; preds = %if.else
  %add20 = add i32 %add.i.67, %mul
  %arrayidx21 = getelementptr inbounds float, float* %mat, i32 %add20
  %6 = load float, float* %arrayidx21, align 4, !tbaa !9
  %add23 = add i32 %add.i.67, %mul2
  %arrayidx24 = getelementptr inbounds float, float* %mat, i32 %add23
  %7 = load float, float* %arrayidx24, align 4, !tbaa !9
  %neg = fsub float -0.000000e+00, %div
  %8 = tail call float @llvm.fmuladd.f32(float %neg, float %7, float %6)
  store float %8, float* %arrayidx21, align 4, !tbaa !9
  br label %if.end.31

if.end.31:                                        ; preds = %if.then.12, %if.then.6, %if.then.17, %if.else, %entry
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
!6 = !{!"clang version 3.7.0 (tags/RELEASE_371/final)"}
!7 = !{i32 12058}
!8 = !{i32 12198}
!9 = !{!10, !10, i64 0}
!10 = !{!"float", !11, i64 0}
!11 = !{!"omnipotent char", !12, i64 0}
!12 = !{!"Simple C/C++ TBAA"}
!13 = !{float 2.500000e+00}
