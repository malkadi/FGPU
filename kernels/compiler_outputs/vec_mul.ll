; ModuleID = 'vec_mul.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind
define void @vec_mul(i32* nocapture readonly %in1, i32* nocapture readonly %in2, i32* nocapture %out) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %add.i = add nsw i32 %1, %0
  %arrayidx = getelementptr inbounds i32, i32* %in1, i32 %add.i
  %2 = load i32, i32* %arrayidx, align 4, !tbaa !21
  %arrayidx1 = getelementptr inbounds i32, i32* %in2, i32 %add.i
  %3 = load i32, i32* %arrayidx1, align 4, !tbaa !21
  %mul = mul nsw i32 %3, %2
  %arrayidx2 = getelementptr inbounds i32, i32* %out, i32 %add.i
  store i32 %mul, i32* %arrayidx2, align 4, !tbaa !21
  ret void
}

; Function Attrs: nounwind
define void @vec_mul_half(i16* nocapture readonly %in1, i16* nocapture readonly %in2, i16* nocapture %out) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %add.i = add nsw i32 %1, %0
  %arrayidx = getelementptr inbounds i16, i16* %in1, i32 %add.i
  %2 = load i16, i16* %arrayidx, align 2, !tbaa !25
  %conv = sext i16 %2 to i32
  %arrayidx1 = getelementptr inbounds i16, i16* %in2, i32 %add.i
  %3 = load i16, i16* %arrayidx1, align 2, !tbaa !25
  %conv2 = sext i16 %3 to i32
  %mul = mul nsw i32 %conv2, %conv
  %conv3 = trunc i32 %mul to i16
  %arrayidx4 = getelementptr inbounds i16, i16* %out, i32 %add.i
  store i16 %conv3, i16* %arrayidx4, align 2, !tbaa !25
  ret void
}

; Function Attrs: nounwind
define void @vec_mul_half_improved(<2 x i16>* nocapture readonly %in1, <2 x i16>* nocapture readonly %in2, <2 x i16>* nocapture %out) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %add.i = add nsw i32 %1, %0
  %arrayidx = getelementptr inbounds <2 x i16>, <2 x i16>* %in1, i32 %add.i
  %2 = load <2 x i16>, <2 x i16>* %arrayidx, align 4, !tbaa !27
  %arrayidx1 = getelementptr inbounds <2 x i16>, <2 x i16>* %in2, i32 %add.i
  %3 = load <2 x i16>, <2 x i16>* %arrayidx1, align 4, !tbaa !27
  %mul = mul <2 x i16> %3, %2
  %arrayidx2 = getelementptr inbounds <2 x i16>, <2 x i16>* %out, i32 %add.i
  store <2 x i16> %mul, <2 x i16>* %arrayidx2, align 4, !tbaa !27
  ret void
}

; Function Attrs: nounwind
define void @vec_mul_byte(i8* nocapture readonly %in1, i8* nocapture readonly %in2, i8* nocapture %out) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %add.i = add nsw i32 %1, %0
  %arrayidx = getelementptr inbounds i8, i8* %in1, i32 %add.i
  %2 = load i8, i8* %arrayidx, align 1, !tbaa !27
  %conv = sext i8 %2 to i32
  %arrayidx1 = getelementptr inbounds i8, i8* %in2, i32 %add.i
  %3 = load i8, i8* %arrayidx1, align 1, !tbaa !27
  %conv2 = sext i8 %3 to i32
  %mul = mul nsw i32 %conv2, %conv
  %conv3 = trunc i32 %mul to i8
  %arrayidx4 = getelementptr inbounds i8, i8* %out, i32 %add.i
  store i8 %conv3, i8* %arrayidx4, align 1, !tbaa !27
  ret void
}

; Function Attrs: nounwind
define void @vec_mul_byte_improved(<4 x i8>* nocapture readonly %in1, <4 x i8>* nocapture readonly %in2, <4 x i8>* nocapture %out) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %add.i = add nsw i32 %1, %0
  %arrayidx = getelementptr inbounds <4 x i8>, <4 x i8>* %in1, i32 %add.i
  %2 = load <4 x i8>, <4 x i8>* %arrayidx, align 4, !tbaa !27
  %arrayidx1 = getelementptr inbounds <4 x i8>, <4 x i8>* %in2, i32 %add.i
  %3 = load <4 x i8>, <4 x i8>* %arrayidx1, align 4, !tbaa !27
  %mul = mul <4 x i8> %3, %2
  %arrayidx2 = getelementptr inbounds <4 x i8>, <4 x i8>* %out, i32 %add.i
  store <4 x i8> %mul, <4 x i8>* %arrayidx2, align 4, !tbaa !27
  ret void
}

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }

!opencl.kernels = !{!0, !6, !9, !12, !15}
!llvm.ident = !{!18}

!0 = !{void (i32*, i32*, i32*)* @vec_mul, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"int*", !"int*", !"int*"}
!4 = !{!"kernel_arg_base_type", !"int*", !"int*", !"int*"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !""}
!6 = !{void (i16*, i16*, i16*)* @vec_mul_half, !1, !2, !7, !8, !5}
!7 = !{!"kernel_arg_type", !"short*", !"short*", !"short*"}
!8 = !{!"kernel_arg_base_type", !"short*", !"short*", !"short*"}
!9 = !{void (<2 x i16>*, <2 x i16>*, <2 x i16>*)* @vec_mul_half_improved, !1, !2, !10, !11, !5}
!10 = !{!"kernel_arg_type", !"short2*", !"short2*", !"short2*"}
!11 = !{!"kernel_arg_base_type", !"short __attribute__((ext_vector_type(2)))*", !"short __attribute__((ext_vector_type(2)))*", !"short __attribute__((ext_vector_type(2)))*"}
!12 = !{void (i8*, i8*, i8*)* @vec_mul_byte, !1, !2, !13, !14, !5}
!13 = !{!"kernel_arg_type", !"char*", !"char*", !"char*"}
!14 = !{!"kernel_arg_base_type", !"char*", !"char*", !"char*"}
!15 = !{void (<4 x i8>*, <4 x i8>*, <4 x i8>*)* @vec_mul_byte_improved, !1, !2, !16, !17, !5}
!16 = !{!"kernel_arg_type", !"char4*", !"char4*", !"char4*"}
!17 = !{!"kernel_arg_base_type", !"char __attribute__((ext_vector_type(4)))*", !"char __attribute__((ext_vector_type(4)))*", !"char __attribute__((ext_vector_type(4)))*"}
!18 = !{!"clang version 3.7.0 (tags/RELEASE_371/final)"}
!19 = !{i32 12248}
!20 = !{i32 12388}
!21 = !{!22, !22, i64 0}
!22 = !{!"int", !23, i64 0}
!23 = !{!"omnipotent char", !24, i64 0}
!24 = !{!"Simple C/C++ TBAA"}
!25 = !{!26, !26, i64 0}
!26 = !{!"short", !23, i64 0}
!27 = !{!23, !23, i64 0}
