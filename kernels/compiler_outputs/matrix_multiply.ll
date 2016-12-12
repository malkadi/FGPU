; ModuleID = 'matrix_multiply.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind
define void @matrix_multiply(i32* nocapture readonly %in1, i32* nocapture readonly %in2, i32* nocapture %out) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 1) #1, !srcloc !19
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 1) #1, !srcloc !20
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %3 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %add.i.25 = add nsw i32 %3, %2
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !21
  %mul = mul nsw i32 %4, %add.i
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %res.0 = phi i32 [ 0, %entry ], [ %add7, %do.body ]
  %add = add nsw i32 %i.0, %mul
  %arrayidx = getelementptr inbounds i32, i32* %in1, i32 %add
  %5 = load i32, i32* %arrayidx, align 4, !tbaa !22
  %mul3 = mul nsw i32 %i.0, %4
  %add4 = add nsw i32 %mul3, %add.i.25
  %arrayidx5 = getelementptr inbounds i32, i32* %in2, i32 %add4
  %6 = load i32, i32* %arrayidx5, align 4, !tbaa !22
  %mul6 = mul nsw i32 %6, %5
  %add7 = add nsw i32 %mul6, %res.0
  %inc = add nuw nsw i32 %i.0, 1
  %cmp = icmp eq i32 %inc, %4
  br i1 %cmp, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %add7.lcssa = phi i32 [ %add7, %do.body ]
  %add9 = add nsw i32 %mul, %add.i.25
  %arrayidx10 = getelementptr inbounds i32, i32* %out, i32 %add9
  store i32 %add7.lcssa, i32* %arrayidx10, align 4, !tbaa !22
  ret void
}

; Function Attrs: nounwind
define void @matrix_multiply_half(i16* nocapture readonly %in1, i16* nocapture readonly %in2, i16* nocapture %out) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 1) #1, !srcloc !19
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 1) #1, !srcloc !20
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %3 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %add.i.28 = add nsw i32 %3, %2
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !21
  %mul = mul nsw i32 %4, %add.i
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %res.0 = phi i32 [ 0, %entry ], [ %add8, %do.body ]
  %add = add nsw i32 %i.0, %mul
  %arrayidx = getelementptr inbounds i16, i16* %in1, i32 %add
  %5 = load i16, i16* %arrayidx, align 2, !tbaa !26
  %conv = sext i16 %5 to i32
  %mul3 = mul nsw i32 %i.0, %4
  %add4 = add nsw i32 %mul3, %add.i.28
  %arrayidx5 = getelementptr inbounds i16, i16* %in2, i32 %add4
  %6 = load i16, i16* %arrayidx5, align 2, !tbaa !26
  %conv6 = sext i16 %6 to i32
  %mul7 = mul nsw i32 %conv6, %conv
  %add8 = add nsw i32 %mul7, %res.0
  %inc = add nuw nsw i32 %i.0, 1
  %cmp = icmp eq i32 %inc, %4
  br i1 %cmp, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %add8.lcssa = phi i32 [ %add8, %do.body ]
  %conv10 = trunc i32 %add8.lcssa to i16
  %add12 = add nsw i32 %mul, %add.i.28
  %arrayidx13 = getelementptr inbounds i16, i16* %out, i32 %add12
  store i16 %conv10, i16* %arrayidx13, align 2, !tbaa !26
  ret void
}

; Function Attrs: nounwind
define void @matrix_multiply_half_improved(<2 x i16>* nocapture readonly %in1, i16* nocapture readonly %in2, i16* nocapture %out) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 1) #1, !srcloc !19
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 1) #1, !srcloc !20
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %3 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %add.i.52 = add nsw i32 %3, %2
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !21
  %mul = mul nsw i32 %4, %add.i
  %div = sdiv i32 %mul, 2
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc20, %do.body ]
  %k.0 = phi i32 [ 0, %entry ], [ %inc21, %do.body ]
  %res.0 = phi i32 [ 0, %entry ], [ %add19, %do.body ]
  %add = add nsw i32 %div, %k.0
  %arrayidx = getelementptr inbounds <2 x i16>, <2 x i16>* %in1, i32 %add
  %5 = load <2 x i16>, <2 x i16>* %arrayidx, align 4
  %6 = extractelement <2 x i16> %5, i32 0
  %conv = sext i16 %6 to i32
  %mul3 = mul nsw i32 %i.0, %4
  %add4 = add nsw i32 %mul3, %add.i.52
  %arrayidx5 = getelementptr inbounds i16, i16* %in2, i32 %add4
  %7 = load i16, i16* %arrayidx5, align 2, !tbaa !26
  %conv6 = sext i16 %7 to i32
  %mul7 = mul nsw i32 %conv, %conv6
  %add8 = add nsw i32 %mul7, %res.0
  %inc = or i32 %i.0, 1
  %8 = extractelement <2 x i16> %5, i32 1
  %conv13 = sext i16 %8 to i32
  %mul14 = mul nsw i32 %inc, %4
  %add15 = add nsw i32 %mul14, %add.i.52
  %arrayidx16 = getelementptr inbounds i16, i16* %in2, i32 %add15
  %9 = load i16, i16* %arrayidx16, align 2, !tbaa !26
  %conv17 = sext i16 %9 to i32
  %mul18 = mul nsw i32 %conv17, %conv13
  %add19 = add nsw i32 %add8, %mul18
  %inc20 = add nuw nsw i32 %i.0, 2
  %inc21 = add nuw nsw i32 %k.0, 1
  %cmp = icmp eq i32 %inc20, %4
  br i1 %cmp, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %add19.lcssa = phi i32 [ %add19, %do.body ]
  %conv23 = trunc i32 %add19.lcssa to i16
  %add25 = add nsw i32 %mul, %add.i.52
  %arrayidx26 = getelementptr inbounds i16, i16* %out, i32 %add25
  store i16 %conv23, i16* %arrayidx26, align 2, !tbaa !26
  ret void
}

; Function Attrs: nounwind
define void @matrix_multiply_byte(i8* nocapture readonly %in1, i8* nocapture readonly %in2, i8* nocapture %out) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 1) #1, !srcloc !19
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 1) #1, !srcloc !20
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %3 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %add.i.28 = add nsw i32 %3, %2
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !21
  %mul = mul nsw i32 %4, %add.i
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %res.0 = phi i32 [ 0, %entry ], [ %add8, %do.body ]
  %add = add nsw i32 %i.0, %mul
  %arrayidx = getelementptr inbounds i8, i8* %in1, i32 %add
  %5 = load i8, i8* %arrayidx, align 1, !tbaa !28
  %conv = sext i8 %5 to i32
  %mul3 = mul nsw i32 %i.0, %4
  %add4 = add nsw i32 %mul3, %add.i.28
  %arrayidx5 = getelementptr inbounds i8, i8* %in2, i32 %add4
  %6 = load i8, i8* %arrayidx5, align 1, !tbaa !28
  %conv6 = sext i8 %6 to i32
  %mul7 = mul nsw i32 %conv6, %conv
  %add8 = add nsw i32 %mul7, %res.0
  %inc = add nuw nsw i32 %i.0, 1
  %cmp = icmp eq i32 %inc, %4
  br i1 %cmp, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %add8.lcssa = phi i32 [ %add8, %do.body ]
  %conv10 = trunc i32 %add8.lcssa to i8
  %add12 = add nsw i32 %mul, %add.i.28
  %arrayidx13 = getelementptr inbounds i8, i8* %out, i32 %add12
  store i8 %conv10, i8* %arrayidx13, align 1, !tbaa !28
  ret void
}

; Function Attrs: nounwind
define void @matrix_multiply_byte_improved(<4 x i8>* nocapture readonly %in1, i8* nocapture readonly %in2, i8* nocapture %out) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 1) #1, !srcloc !19
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 1) #1, !srcloc !20
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %3 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %add.i.96 = add nsw i32 %3, %2
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !21
  %mul = mul nsw i32 %4, %add.i
  %div = sdiv i32 %mul, 4
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc44, %do.body ]
  %k.0 = phi i32 [ 0, %entry ], [ %inc45, %do.body ]
  %res.0 = phi i32 [ 0, %entry ], [ %add43, %do.body ]
  %add = add nsw i32 %div, %k.0
  %arrayidx = getelementptr inbounds <4 x i8>, <4 x i8>* %in1, i32 %add
  %5 = load <4 x i8>, <4 x i8>* %arrayidx, align 4
  %6 = extractelement <4 x i8> %5, i32 0
  %conv = sext i8 %6 to i32
  %mul3 = mul nsw i32 %i.0, %4
  %add4 = add nsw i32 %mul3, %add.i.96
  %arrayidx5 = getelementptr inbounds i8, i8* %in2, i32 %add4
  %7 = load i8, i8* %arrayidx5, align 1, !tbaa !28
  %conv6 = sext i8 %7 to i32
  %mul7 = mul nsw i32 %conv, %conv6
  %add8 = add nsw i32 %mul7, %res.0
  %inc = or i32 %i.0, 1
  %8 = extractelement <4 x i8> %5, i32 1
  %conv13 = sext i8 %8 to i32
  %mul14 = mul nsw i32 %inc, %4
  %add15 = add nsw i32 %mul14, %add.i.96
  %arrayidx16 = getelementptr inbounds i8, i8* %in2, i32 %add15
  %9 = load i8, i8* %arrayidx16, align 1, !tbaa !28
  %conv17 = sext i8 %9 to i32
  %mul18 = mul nsw i32 %conv17, %conv13
  %add19 = add nsw i32 %add8, %mul18
  %inc20 = or i32 %i.0, 2
  %10 = extractelement <4 x i8> %5, i32 2
  %conv25 = sext i8 %10 to i32
  %mul26 = mul nsw i32 %inc20, %4
  %add27 = add nsw i32 %mul26, %add.i.96
  %arrayidx28 = getelementptr inbounds i8, i8* %in2, i32 %add27
  %11 = load i8, i8* %arrayidx28, align 1, !tbaa !28
  %conv29 = sext i8 %11 to i32
  %mul30 = mul nsw i32 %conv29, %conv25
  %add31 = add nsw i32 %add19, %mul30
  %inc32 = or i32 %i.0, 3
  %12 = extractelement <4 x i8> %5, i32 3
  %conv37 = sext i8 %12 to i32
  %mul38 = mul nsw i32 %inc32, %4
  %add39 = add nsw i32 %mul38, %add.i.96
  %arrayidx40 = getelementptr inbounds i8, i8* %in2, i32 %add39
  %13 = load i8, i8* %arrayidx40, align 1, !tbaa !28
  %conv41 = sext i8 %13 to i32
  %mul42 = mul nsw i32 %conv41, %conv37
  %add43 = add nsw i32 %add31, %mul42
  %inc44 = add nuw nsw i32 %i.0, 4
  %inc45 = add nuw nsw i32 %k.0, 1
  %cmp = icmp eq i32 %inc44, %4
  br i1 %cmp, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %add43.lcssa = phi i32 [ %add43, %do.body ]
  %conv47 = trunc i32 %add43.lcssa to i8
  %add49 = add nsw i32 %mul, %add.i.96
  %arrayidx50 = getelementptr inbounds i8, i8* %out, i32 %add49
  store i8 %conv47, i8* %arrayidx50, align 1, !tbaa !28
  ret void
}

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }

!opencl.kernels = !{!0, !6, !9, !12, !15}
!llvm.ident = !{!18}

!0 = !{void (i32*, i32*, i32*)* @matrix_multiply, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"int*", !"int*", !"int*"}
!4 = !{!"kernel_arg_base_type", !"int*", !"int*", !"int*"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !""}
!6 = !{void (i16*, i16*, i16*)* @matrix_multiply_half, !1, !2, !7, !8, !5}
!7 = !{!"kernel_arg_type", !"short*", !"short*", !"short*"}
!8 = !{!"kernel_arg_base_type", !"short*", !"short*", !"short*"}
!9 = !{void (<2 x i16>*, i16*, i16*)* @matrix_multiply_half_improved, !1, !2, !10, !11, !5}
!10 = !{!"kernel_arg_type", !"short2*", !"short*", !"short*"}
!11 = !{!"kernel_arg_base_type", !"short __attribute__((ext_vector_type(2)))*", !"short*", !"short*"}
!12 = !{void (i8*, i8*, i8*)* @matrix_multiply_byte, !1, !2, !13, !14, !5}
!13 = !{!"kernel_arg_type", !"char*", !"char*", !"char*"}
!14 = !{!"kernel_arg_base_type", !"char*", !"char*", !"char*"}
!15 = !{void (<4 x i8>*, i8*, i8*)* @matrix_multiply_byte_improved, !1, !2, !16, !17, !5}
!16 = !{!"kernel_arg_type", !"char4*", !"char*", !"char*"}
!17 = !{!"kernel_arg_base_type", !"char __attribute__((ext_vector_type(4)))*", !"char*", !"char*"}
!18 = !{!"clang version 3.7.0 (tags/RELEASE_371/final)"}
!19 = !{i32 13329}
!20 = !{i32 13469}
!21 = !{i32 13108}
!22 = !{!23, !23, i64 0}
!23 = !{!"int", !24, i64 0}
!24 = !{!"omnipotent char", !25, i64 0}
!25 = !{!"Simple C/C++ TBAA"}
!26 = !{!27, !27, i64 0}
!27 = !{!"short", !24, i64 0}
!28 = !{!24, !24, i64 0}
