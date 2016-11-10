; ModuleID = 'fir.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind
define void @fir(i32* nocapture readonly %in, i32* nocapture readonly %coeff, i32* nocapture %out, i32 signext %filter_len) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %add.i = add nsw i32 %1, %0
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %acc.0 = phi i32 [ 0, %entry ], [ %add2, %do.body ]
  %add = add nsw i32 %i.0, %add.i
  %arrayidx = getelementptr inbounds i32, i32* %in, i32 %add
  %2 = load i32, i32* %arrayidx, align 4, !tbaa !21
  %arrayidx1 = getelementptr inbounds i32, i32* %coeff, i32 %i.0
  %3 = load i32, i32* %arrayidx1, align 4, !tbaa !21
  %mul = mul nsw i32 %3, %2
  %add2 = add nsw i32 %mul, %acc.0
  %inc = add nuw nsw i32 %i.0, 1
  %cmp = icmp eq i32 %inc, %filter_len
  br i1 %cmp, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %add2.lcssa = phi i32 [ %add2, %do.body ]
  %arrayidx3 = getelementptr inbounds i32, i32* %out, i32 %add.i
  store i32 %add2.lcssa, i32* %arrayidx3, align 4, !tbaa !21
  ret void
}

; Function Attrs: nounwind
define void @fir_half(i16* nocapture readonly %in, i16* nocapture readonly %coeff, i16* nocapture %out, i32 signext %filter_len) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %add.i = add nsw i32 %1, %0
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %acc.0 = phi i32 [ 0, %entry ], [ %add3, %do.body ]
  %add = add nsw i32 %i.0, %add.i
  %arrayidx = getelementptr inbounds i16, i16* %in, i32 %add
  %2 = load i16, i16* %arrayidx, align 2, !tbaa !25
  %conv = sext i16 %2 to i32
  %arrayidx1 = getelementptr inbounds i16, i16* %coeff, i32 %i.0
  %3 = load i16, i16* %arrayidx1, align 2, !tbaa !25
  %conv2 = sext i16 %3 to i32
  %mul = mul nsw i32 %conv2, %conv
  %add3 = add nsw i32 %mul, %acc.0
  %inc = add nuw nsw i32 %i.0, 1
  %cmp = icmp eq i32 %inc, %filter_len
  br i1 %cmp, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %add3.lcssa = phi i32 [ %add3, %do.body ]
  %conv5 = trunc i32 %add3.lcssa to i16
  %arrayidx6 = getelementptr inbounds i16, i16* %out, i32 %add.i
  store i16 %conv5, i16* %arrayidx6, align 2, !tbaa !25
  ret void
}

; Function Attrs: nounwind
define void @fir_half_improved(<2 x i16>* nocapture readonly %in, <2 x i16>* nocapture readonly %coeff, <2 x i16>* nocapture %out, i32 signext %filter_len) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %add.i = add nsw i32 %1, %0
  %div = sdiv i32 %filter_len, 2
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %acc1.0 = phi i32 [ 0, %entry ], [ %add10, %do.body ]
  %acc2.0 = phi i32 [ 0, %entry ], [ %add25, %do.body ]
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %add = add i32 %i.0, %add.i
  %arrayidx = getelementptr inbounds <2 x i16>, <2 x i16>* %in, i32 %add
  %2 = load <2 x i16>, <2 x i16>* %arrayidx, align 4
  %3 = extractelement <2 x i16> %2, i32 0
  %conv = sext i16 %3 to i32
  %arrayidx1 = getelementptr inbounds <2 x i16>, <2 x i16>* %coeff, i32 %i.0
  %4 = load <2 x i16>, <2 x i16>* %arrayidx1, align 4
  %5 = extractelement <2 x i16> %4, i32 0
  %conv2 = sext i16 %5 to i32
  %mul = mul nsw i32 %conv2, %conv
  %add3 = add nsw i32 %mul, %acc1.0
  %6 = extractelement <2 x i16> %2, i32 1
  %conv6 = sext i16 %6 to i32
  %7 = extractelement <2 x i16> %4, i32 1
  %conv8 = sext i16 %7 to i32
  %mul9 = mul nsw i32 %conv8, %conv6
  %add10 = add nsw i32 %add3, %mul9
  %mul16 = mul nsw i32 %conv2, %conv6
  %add17 = add nsw i32 %mul16, %acc2.0
  %add19 = add i32 %add, 1
  %arrayidx20 = getelementptr inbounds <2 x i16>, <2 x i16>* %in, i32 %add19
  %8 = load <2 x i16>, <2 x i16>* %arrayidx20, align 4
  %9 = extractelement <2 x i16> %8, i32 0
  %conv21 = sext i16 %9 to i32
  %mul24 = mul nsw i32 %conv21, %conv8
  %add25 = add nsw i32 %add17, %mul24
  %inc = add nuw nsw i32 %i.0, 1
  %cmp = icmp slt i32 %inc, %div
  br i1 %cmp, label %do.body, label %do.end

do.end:                                           ; preds = %do.body
  %add25.lcssa = phi i32 [ %add25, %do.body ]
  %add10.lcssa = phi i32 [ %add10, %do.body ]
  %conv27 = trunc i32 %add10.lcssa to i16
  %10 = insertelement <2 x i16> undef, i16 %conv27, i32 0
  %conv28 = trunc i32 %add25.lcssa to i16
  %11 = insertelement <2 x i16> %10, i16 %conv28, i32 1
  %arrayidx29 = getelementptr inbounds <2 x i16>, <2 x i16>* %out, i32 %add.i
  store <2 x i16> %11, <2 x i16>* %arrayidx29, align 4, !tbaa !27
  ret void
}

; Function Attrs: nounwind
define void @fir_byte(i8* nocapture readonly %in, i8* nocapture readonly %coeff, i8* nocapture %out, i32 signext %filter_len) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %add.i = add nsw i32 %1, %0
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %acc.0 = phi i32 [ 0, %entry ], [ %add3, %do.body ]
  %add = add nsw i32 %i.0, %add.i
  %arrayidx = getelementptr inbounds i8, i8* %in, i32 %add
  %2 = load i8, i8* %arrayidx, align 1, !tbaa !27
  %conv = sext i8 %2 to i32
  %arrayidx1 = getelementptr inbounds i8, i8* %coeff, i32 %i.0
  %3 = load i8, i8* %arrayidx1, align 1, !tbaa !27
  %conv2 = sext i8 %3 to i32
  %mul = mul nsw i32 %conv2, %conv
  %add3 = add nsw i32 %mul, %acc.0
  %inc = add nuw nsw i32 %i.0, 1
  %cmp = icmp eq i32 %inc, %filter_len
  br i1 %cmp, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %add3.lcssa = phi i32 [ %add3, %do.body ]
  %conv5 = trunc i32 %add3.lcssa to i8
  %arrayidx6 = getelementptr inbounds i8, i8* %out, i32 %add.i
  store i8 %conv5, i8* %arrayidx6, align 1, !tbaa !27
  ret void
}

; Function Attrs: nounwind
define void @fir_byte_improved(<4 x i8>* nocapture readonly %in, <4 x i8>* nocapture readonly %coeff, <4 x i8>* nocapture %out, i32 signext %filter_len) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %add.i = add nsw i32 %1, %0
  %div = sdiv i32 %filter_len, 4
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %acc1.0 = phi i32 [ 0, %entry ], [ %add24, %do.body ]
  %acc2.0 = phi i32 [ 0, %entry ], [ %add53, %do.body ]
  %acc3.0 = phi i32 [ 0, %entry ], [ %add83, %do.body ]
  %acc4.0 = phi i32 [ 0, %entry ], [ %add114, %do.body ]
  %add = add nsw i32 %i.0, %add.i
  %arrayidx = getelementptr inbounds <4 x i8>, <4 x i8>* %in, i32 %add
  %2 = load <4 x i8>, <4 x i8>* %arrayidx, align 4
  %3 = extractelement <4 x i8> %2, i32 0
  %conv = sext i8 %3 to i32
  %arrayidx1 = getelementptr inbounds <4 x i8>, <4 x i8>* %coeff, i32 %i.0
  %4 = load <4 x i8>, <4 x i8>* %arrayidx1, align 4
  %5 = extractelement <4 x i8> %4, i32 0
  %conv2 = sext i8 %5 to i32
  %mul = mul nsw i32 %conv2, %conv
  %add3 = add nsw i32 %mul, %acc1.0
  %6 = extractelement <4 x i8> %2, i32 1
  %conv6 = sext i8 %6 to i32
  %7 = extractelement <4 x i8> %4, i32 1
  %conv8 = sext i8 %7 to i32
  %mul9 = mul nsw i32 %conv8, %conv6
  %add10 = add nsw i32 %add3, %mul9
  %8 = extractelement <4 x i8> %2, i32 2
  %conv13 = sext i8 %8 to i32
  %9 = extractelement <4 x i8> %4, i32 2
  %conv15 = sext i8 %9 to i32
  %mul16 = mul nsw i32 %conv15, %conv13
  %add17 = add nsw i32 %add10, %mul16
  %10 = extractelement <4 x i8> %2, i32 3
  %conv20 = sext i8 %10 to i32
  %11 = extractelement <4 x i8> %4, i32 3
  %conv22 = sext i8 %11 to i32
  %mul23 = mul nsw i32 %conv22, %conv20
  %add24 = add nsw i32 %add17, %mul23
  %mul30 = mul nsw i32 %conv2, %conv6
  %add31 = add nsw i32 %mul30, %acc2.0
  %mul37 = mul nsw i32 %conv8, %conv13
  %add38 = add nsw i32 %add31, %mul37
  %mul44 = mul nsw i32 %conv15, %conv20
  %add45 = add nsw i32 %add38, %mul44
  %add47 = add nsw i32 %add, 1
  %arrayidx48 = getelementptr inbounds <4 x i8>, <4 x i8>* %in, i32 %add47
  %12 = load <4 x i8>, <4 x i8>* %arrayidx48, align 4
  %13 = extractelement <4 x i8> %12, i32 0
  %conv49 = sext i8 %13 to i32
  %mul52 = mul nsw i32 %conv49, %conv22
  %add53 = add nsw i32 %add45, %mul52
  %mul59 = mul nsw i32 %conv2, %conv13
  %add60 = add nsw i32 %mul59, %acc3.0
  %mul66 = mul nsw i32 %conv8, %conv20
  %add67 = add nsw i32 %add60, %mul66
  %mul74 = mul nsw i32 %conv49, %conv15
  %add75 = add nsw i32 %add67, %mul74
  %14 = extractelement <4 x i8> %12, i32 1
  %conv79 = sext i8 %14 to i32
  %mul82 = mul nsw i32 %conv79, %conv22
  %add83 = add nsw i32 %add75, %mul82
  %mul89 = mul nsw i32 %conv2, %conv20
  %add90 = add nsw i32 %mul89, %acc4.0
  %mul97 = mul nsw i32 %conv49, %conv8
  %add98 = add nsw i32 %add90, %mul97
  %mul105 = mul nsw i32 %conv79, %conv15
  %add106 = add nsw i32 %add98, %mul105
  %15 = extractelement <4 x i8> %12, i32 2
  %conv110 = sext i8 %15 to i32
  %mul113 = mul nsw i32 %conv110, %conv22
  %add114 = add nsw i32 %add106, %mul113
  %inc = add nuw nsw i32 %i.0, 1
  %cmp = icmp eq i32 %inc, %div
  br i1 %cmp, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %add114.lcssa = phi i32 [ %add114, %do.body ]
  %add83.lcssa = phi i32 [ %add83, %do.body ]
  %add53.lcssa = phi i32 [ %add53, %do.body ]
  %add24.lcssa = phi i32 [ %add24, %do.body ]
  %conv116 = trunc i32 %add24.lcssa to i8
  %arrayidx117 = getelementptr inbounds <4 x i8>, <4 x i8>* %out, i32 %add.i
  %16 = insertelement <4 x i8> undef, i8 %conv116, i32 0
  %conv118 = trunc i32 %add53.lcssa to i8
  %17 = insertelement <4 x i8> %16, i8 %conv118, i32 1
  %conv120 = trunc i32 %add83.lcssa to i8
  %18 = insertelement <4 x i8> %17, i8 %conv120, i32 2
  %conv122 = trunc i32 %add114.lcssa to i8
  %19 = insertelement <4 x i8> %18, i8 %conv122, i32 3
  store <4 x i8> %19, <4 x i8>* %arrayidx117, align 4
  ret void
}

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }

!opencl.kernels = !{!0, !6, !9, !12, !15}
!llvm.ident = !{!18}

!0 = !{void (i32*, i32*, i32*, i32)* @fir, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"int*", !"int*", !"int*", !"int"}
!4 = !{!"kernel_arg_base_type", !"int*", !"int*", !"int*", !"int"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !"", !""}
!6 = !{void (i16*, i16*, i16*, i32)* @fir_half, !1, !2, !7, !8, !5}
!7 = !{!"kernel_arg_type", !"short*", !"short*", !"short*", !"int"}
!8 = !{!"kernel_arg_base_type", !"short*", !"short*", !"short*", !"int"}
!9 = !{void (<2 x i16>*, <2 x i16>*, <2 x i16>*, i32)* @fir_half_improved, !1, !2, !10, !11, !5}
!10 = !{!"kernel_arg_type", !"short2*", !"short2*", !"short2*", !"int"}
!11 = !{!"kernel_arg_base_type", !"short __attribute__((ext_vector_type(2)))*", !"short __attribute__((ext_vector_type(2)))*", !"short __attribute__((ext_vector_type(2)))*", !"int"}
!12 = !{void (i8*, i8*, i8*, i32)* @fir_byte, !1, !2, !13, !14, !5}
!13 = !{!"kernel_arg_type", !"char*", !"char*", !"char*", !"int"}
!14 = !{!"kernel_arg_base_type", !"char*", !"char*", !"char*", !"int"}
!15 = !{void (<4 x i8>*, <4 x i8>*, <4 x i8>*, i32)* @fir_byte_improved, !1, !2, !16, !17, !5}
!16 = !{!"kernel_arg_type", !"char4*", !"char4*", !"char4*", !"int"}
!17 = !{!"kernel_arg_base_type", !"char __attribute__((ext_vector_type(4)))*", !"char __attribute__((ext_vector_type(4)))*", !"char __attribute__((ext_vector_type(4)))*", !"int"}
!18 = !{!"clang version 3.7.0 (tags/RELEASE_371/final)"}
!19 = !{i32 13686}
!20 = !{i32 13826}
!21 = !{!22, !22, i64 0}
!22 = !{!"int", !23, i64 0}
!23 = !{!"omnipotent char", !24, i64 0}
!24 = !{!"Simple C/C++ TBAA"}
!25 = !{!26, !26, i64 0}
!26 = !{!"short", !23, i64 0}
!27 = !{!23, !23, i64 0}
