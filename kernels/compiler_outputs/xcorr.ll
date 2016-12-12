; ModuleID = 'xcorr.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind
define void @xcorr(i32* nocapture readonly %in1, i32* nocapture readonly %in2, i32* nocapture %out) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !21
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !22
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %res.0 = phi i32 [ 0, %entry ], [ %add3, %do.body ]
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %arrayidx = getelementptr inbounds i32, i32* %in1, i32 %i.0
  %3 = load i32, i32* %arrayidx, align 4, !tbaa !23
  %add = add nsw i32 %i.0, %add.i
  %arrayidx2 = getelementptr inbounds i32, i32* %in2, i32 %add
  %4 = load i32, i32* %arrayidx2, align 4, !tbaa !23
  %mul = mul nsw i32 %4, %3
  %add3 = add nsw i32 %mul, %res.0
  %inc = add nuw nsw i32 %i.0, 1
  %cmp = icmp eq i32 %inc, %2
  br i1 %cmp, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %add3.lcssa = phi i32 [ %add3, %do.body ]
  %arrayidx4 = getelementptr inbounds i32, i32* %out, i32 %add.i
  store i32 %add3.lcssa, i32* %arrayidx4, align 4, !tbaa !23
  ret void
}

; Function Attrs: nounwind
define void @xcorr_improved(i32* nocapture readonly %in1, i32* nocapture readonly %in2, i32* nocapture %out) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !21
  %add.i = add nsw i32 %1, %0
  %shl = shl i32 %add.i, 2
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !22
  %shl2 = shl i32 %2, 2
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %res1.0 = phi i32 [ 0, %entry ], [ %add4, %do.body ]
  %res2.0 = phi i32 [ 0, %entry ], [ %add10, %do.body ]
  %res3.0 = phi i32 [ 0, %entry ], [ %add16, %do.body ]
  %res4.0 = phi i32 [ 0, %entry ], [ %add22, %do.body ]
  %arrayidx = getelementptr inbounds i32, i32* %in1, i32 %i.0
  %3 = load i32, i32* %arrayidx, align 4, !tbaa !23
  %add = add nsw i32 %i.0, %shl
  %arrayidx3 = getelementptr inbounds i32, i32* %in2, i32 %add
  %4 = load i32, i32* %arrayidx3, align 4, !tbaa !23
  %mul = mul nsw i32 %4, %3
  %add4 = add nsw i32 %mul, %res1.0
  %add7 = add nsw i32 %add, 1
  %arrayidx8 = getelementptr inbounds i32, i32* %in2, i32 %add7
  %5 = load i32, i32* %arrayidx8, align 4, !tbaa !23
  %mul9 = mul nsw i32 %5, %3
  %add10 = add nsw i32 %mul9, %res2.0
  %add13 = add nsw i32 %add, 2
  %arrayidx14 = getelementptr inbounds i32, i32* %in2, i32 %add13
  %6 = load i32, i32* %arrayidx14, align 4, !tbaa !23
  %mul15 = mul nsw i32 %6, %3
  %add16 = add nsw i32 %mul15, %res3.0
  %add19 = add nsw i32 %add, 3
  %arrayidx20 = getelementptr inbounds i32, i32* %in2, i32 %add19
  %7 = load i32, i32* %arrayidx20, align 4, !tbaa !23
  %mul21 = mul nsw i32 %7, %3
  %add22 = add nsw i32 %mul21, %res4.0
  %inc = add nuw nsw i32 %i.0, 1
  %cmp = icmp eq i32 %inc, %shl2
  br i1 %cmp, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %add22.lcssa = phi i32 [ %add22, %do.body ]
  %add16.lcssa = phi i32 [ %add16, %do.body ]
  %add10.lcssa = phi i32 [ %add10, %do.body ]
  %add4.lcssa = phi i32 [ %add4, %do.body ]
  %arrayidx23 = getelementptr inbounds i32, i32* %out, i32 %shl
  store i32 %add4.lcssa, i32* %arrayidx23, align 4, !tbaa !23
  %add24 = or i32 %shl, 1
  %arrayidx25 = getelementptr inbounds i32, i32* %out, i32 %add24
  store i32 %add10.lcssa, i32* %arrayidx25, align 4, !tbaa !23
  %add26 = or i32 %shl, 2
  %arrayidx27 = getelementptr inbounds i32, i32* %out, i32 %add26
  store i32 %add16.lcssa, i32* %arrayidx27, align 4, !tbaa !23
  %add28 = or i32 %shl, 3
  %arrayidx29 = getelementptr inbounds i32, i32* %out, i32 %add28
  store i32 %add22.lcssa, i32* %arrayidx29, align 4, !tbaa !23
  ret void
}

; Function Attrs: nounwind
define void @xcorr_half(i16* nocapture readonly %in1, i16* nocapture readonly %in2, i16* nocapture %out) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !21
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !22
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %res.0 = phi i32 [ 0, %entry ], [ %add4, %do.body ]
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %arrayidx = getelementptr inbounds i16, i16* %in1, i32 %i.0
  %3 = load i16, i16* %arrayidx, align 2, !tbaa !27
  %conv = sext i16 %3 to i32
  %add = add nsw i32 %i.0, %add.i
  %arrayidx2 = getelementptr inbounds i16, i16* %in2, i32 %add
  %4 = load i16, i16* %arrayidx2, align 2, !tbaa !27
  %conv3 = sext i16 %4 to i32
  %mul = mul nsw i32 %conv3, %conv
  %add4 = add nsw i32 %mul, %res.0
  %inc = add nuw nsw i32 %i.0, 1
  %cmp = icmp eq i32 %inc, %2
  br i1 %cmp, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %add4.lcssa = phi i32 [ %add4, %do.body ]
  %conv6 = trunc i32 %add4.lcssa to i16
  %arrayidx7 = getelementptr inbounds i16, i16* %out, i32 %add.i
  store i16 %conv6, i16* %arrayidx7, align 2, !tbaa !27
  ret void
}

; Function Attrs: nounwind
define void @xcorr_half_improved(<2 x i16>* nocapture readonly %in1, <2 x i16>* nocapture readonly %in2, <2 x i16>* nocapture %out) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !21
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !22
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %res1.0 = phi i32 [ 0, %entry ], [ %add11, %do.body ]
  %res2.0 = phi i32 [ 0, %entry ], [ %add26, %do.body ]
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %arrayidx = getelementptr inbounds <2 x i16>, <2 x i16>* %in1, i32 %i.0
  %3 = load <2 x i16>, <2 x i16>* %arrayidx, align 4
  %4 = extractelement <2 x i16> %3, i32 0
  %conv = sext i16 %4 to i32
  %add = add nsw i32 %i.0, %add.i
  %arrayidx2 = getelementptr inbounds <2 x i16>, <2 x i16>* %in2, i32 %add
  %5 = load <2 x i16>, <2 x i16>* %arrayidx2, align 4
  %6 = extractelement <2 x i16> %5, i32 0
  %conv3 = sext i16 %6 to i32
  %mul = mul nsw i32 %conv3, %conv
  %add4 = add nsw i32 %mul, %res1.0
  %7 = extractelement <2 x i16> %3, i32 1
  %conv6 = sext i16 %7 to i32
  %8 = extractelement <2 x i16> %5, i32 1
  %conv9 = sext i16 %8 to i32
  %mul10 = mul nsw i32 %conv9, %conv6
  %add11 = add nsw i32 %add4, %mul10
  %mul17 = mul nsw i32 %conv9, %conv
  %add18 = add nsw i32 %mul17, %res2.0
  %add22 = add nsw i32 %add, 1
  %arrayidx23 = getelementptr inbounds <2 x i16>, <2 x i16>* %in2, i32 %add22
  %9 = load <2 x i16>, <2 x i16>* %arrayidx23, align 4
  %10 = extractelement <2 x i16> %9, i32 0
  %conv24 = sext i16 %10 to i32
  %mul25 = mul nsw i32 %conv24, %conv6
  %add26 = add nsw i32 %add18, %mul25
  %inc = add nuw nsw i32 %i.0, 1
  %cmp = icmp eq i32 %inc, %2
  br i1 %cmp, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %add26.lcssa = phi i32 [ %add26, %do.body ]
  %add11.lcssa = phi i32 [ %add11, %do.body ]
  %conv28 = trunc i32 %add11.lcssa to i16
  %arrayidx29 = getelementptr inbounds <2 x i16>, <2 x i16>* %out, i32 %add.i
  %11 = insertelement <2 x i16> undef, i16 %conv28, i32 0
  %conv30 = trunc i32 %add26.lcssa to i16
  %12 = insertelement <2 x i16> %11, i16 %conv30, i32 1
  store <2 x i16> %12, <2 x i16>* %arrayidx29, align 4
  ret void
}

; Function Attrs: nounwind
define void @xcorr_byte(i8* nocapture readonly %in1, i8* nocapture readonly %in2, i8* nocapture %out) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !21
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !22
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %res.0 = phi i32 [ 0, %entry ], [ %add4, %do.body ]
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %arrayidx = getelementptr inbounds i8, i8* %in1, i32 %i.0
  %3 = load i8, i8* %arrayidx, align 1, !tbaa !29
  %conv = sext i8 %3 to i32
  %add = add nsw i32 %i.0, %add.i
  %arrayidx2 = getelementptr inbounds i8, i8* %in2, i32 %add
  %4 = load i8, i8* %arrayidx2, align 1, !tbaa !29
  %conv3 = sext i8 %4 to i32
  %mul = mul nsw i32 %conv3, %conv
  %add4 = add nsw i32 %mul, %res.0
  %inc = add nuw nsw i32 %i.0, 1
  %cmp = icmp eq i32 %inc, %2
  br i1 %cmp, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %add4.lcssa = phi i32 [ %add4, %do.body ]
  %conv6 = trunc i32 %add4.lcssa to i8
  %arrayidx7 = getelementptr inbounds i8, i8* %out, i32 %add.i
  store i8 %conv6, i8* %arrayidx7, align 1, !tbaa !29
  ret void
}

; Function Attrs: nounwind
define void @xcorr_byte_improved(<4 x i8>* nocapture readonly %in1, <4 x i8>* nocapture readonly %in2, <4 x i8>* nocapture %out) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !21
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !22
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %res1.0 = phi i32 [ 0, %entry ], [ %add25, %do.body ]
  %res2.0 = phi i32 [ 0, %entry ], [ %add54, %do.body ]
  %res3.0 = phi i32 [ 0, %entry ], [ %add84, %do.body ]
  %res4.0 = phi i32 [ 0, %entry ], [ %add115, %do.body ]
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %arrayidx = getelementptr inbounds <4 x i8>, <4 x i8>* %in1, i32 %i.0
  %3 = load <4 x i8>, <4 x i8>* %arrayidx, align 4
  %4 = extractelement <4 x i8> %3, i32 0
  %conv = sext i8 %4 to i32
  %add = add nsw i32 %i.0, %add.i
  %arrayidx2 = getelementptr inbounds <4 x i8>, <4 x i8>* %in2, i32 %add
  %5 = load <4 x i8>, <4 x i8>* %arrayidx2, align 4
  %6 = extractelement <4 x i8> %5, i32 0
  %conv3 = sext i8 %6 to i32
  %mul = mul nsw i32 %conv3, %conv
  %add4 = add nsw i32 %mul, %res1.0
  %7 = extractelement <4 x i8> %3, i32 1
  %conv6 = sext i8 %7 to i32
  %8 = extractelement <4 x i8> %5, i32 1
  %conv9 = sext i8 %8 to i32
  %mul10 = mul nsw i32 %conv9, %conv6
  %add11 = add nsw i32 %add4, %mul10
  %9 = extractelement <4 x i8> %3, i32 2
  %conv13 = sext i8 %9 to i32
  %10 = extractelement <4 x i8> %5, i32 2
  %conv16 = sext i8 %10 to i32
  %mul17 = mul nsw i32 %conv16, %conv13
  %add18 = add nsw i32 %add11, %mul17
  %11 = extractelement <4 x i8> %3, i32 3
  %conv20 = sext i8 %11 to i32
  %12 = extractelement <4 x i8> %5, i32 3
  %conv23 = sext i8 %12 to i32
  %mul24 = mul nsw i32 %conv23, %conv20
  %add25 = add nsw i32 %add18, %mul24
  %mul31 = mul nsw i32 %conv9, %conv
  %add32 = add nsw i32 %mul31, %res2.0
  %mul38 = mul nsw i32 %conv16, %conv6
  %add39 = add nsw i32 %add32, %mul38
  %mul45 = mul nsw i32 %conv23, %conv13
  %add46 = add nsw i32 %add39, %mul45
  %add50 = add nsw i32 %add, 1
  %arrayidx51 = getelementptr inbounds <4 x i8>, <4 x i8>* %in2, i32 %add50
  %13 = load <4 x i8>, <4 x i8>* %arrayidx51, align 4
  %14 = extractelement <4 x i8> %13, i32 0
  %conv52 = sext i8 %14 to i32
  %mul53 = mul nsw i32 %conv52, %conv20
  %add54 = add nsw i32 %add46, %mul53
  %mul60 = mul nsw i32 %conv16, %conv
  %add61 = add nsw i32 %mul60, %res3.0
  %mul67 = mul nsw i32 %conv23, %conv6
  %add68 = add nsw i32 %add61, %mul67
  %mul75 = mul nsw i32 %conv52, %conv13
  %add76 = add nsw i32 %add68, %mul75
  %15 = extractelement <4 x i8> %13, i32 1
  %conv82 = sext i8 %15 to i32
  %mul83 = mul nsw i32 %conv82, %conv20
  %add84 = add nsw i32 %add76, %mul83
  %mul90 = mul nsw i32 %conv23, %conv
  %add91 = add nsw i32 %mul90, %res4.0
  %mul98 = mul nsw i32 %conv52, %conv6
  %add99 = add nsw i32 %add91, %mul98
  %mul106 = mul nsw i32 %conv82, %conv13
  %add107 = add nsw i32 %add99, %mul106
  %16 = extractelement <4 x i8> %13, i32 2
  %conv113 = sext i8 %16 to i32
  %mul114 = mul nsw i32 %conv113, %conv20
  %add115 = add nsw i32 %add107, %mul114
  %inc = add nuw nsw i32 %i.0, 1
  %cmp = icmp eq i32 %inc, %2
  br i1 %cmp, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %add115.lcssa = phi i32 [ %add115, %do.body ]
  %add84.lcssa = phi i32 [ %add84, %do.body ]
  %add54.lcssa = phi i32 [ %add54, %do.body ]
  %add25.lcssa = phi i32 [ %add25, %do.body ]
  %conv117 = trunc i32 %add25.lcssa to i8
  %arrayidx118 = getelementptr inbounds <4 x i8>, <4 x i8>* %out, i32 %add.i
  %17 = insertelement <4 x i8> undef, i8 %conv117, i32 0
  %conv119 = trunc i32 %add54.lcssa to i8
  %18 = insertelement <4 x i8> %17, i8 %conv119, i32 1
  %conv121 = trunc i32 %add84.lcssa to i8
  %19 = insertelement <4 x i8> %18, i8 %conv121, i32 2
  %conv123 = trunc i32 %add115.lcssa to i8
  %20 = insertelement <4 x i8> %19, i8 %conv123, i32 3
  store <4 x i8> %20, <4 x i8>* %arrayidx118, align 4
  ret void
}

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }

!opencl.kernels = !{!0, !6, !7, !10, !13, !16}
!llvm.ident = !{!19}

!0 = !{void (i32*, i32*, i32*)* @xcorr, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"int*", !"int*", !"int*"}
!4 = !{!"kernel_arg_base_type", !"int*", !"int*", !"int*"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !""}
!6 = !{void (i32*, i32*, i32*)* @xcorr_improved, !1, !2, !3, !4, !5}
!7 = !{void (i16*, i16*, i16*)* @xcorr_half, !1, !2, !8, !9, !5}
!8 = !{!"kernel_arg_type", !"short*", !"short*", !"short*"}
!9 = !{!"kernel_arg_base_type", !"short*", !"short*", !"short*"}
!10 = !{void (<2 x i16>*, <2 x i16>*, <2 x i16>*)* @xcorr_half_improved, !1, !2, !11, !12, !5}
!11 = !{!"kernel_arg_type", !"short2*", !"short2*", !"short2*"}
!12 = !{!"kernel_arg_base_type", !"short __attribute__((ext_vector_type(2)))*", !"short __attribute__((ext_vector_type(2)))*", !"short __attribute__((ext_vector_type(2)))*"}
!13 = !{void (i8*, i8*, i8*)* @xcorr_byte, !1, !2, !14, !15, !5}
!14 = !{!"kernel_arg_type", !"char*", !"char*", !"char*"}
!15 = !{!"kernel_arg_base_type", !"char*", !"char*", !"char*"}
!16 = !{void (<4 x i8>*, <4 x i8>*, <4 x i8>*)* @xcorr_byte_improved, !1, !2, !17, !18, !5}
!17 = !{!"kernel_arg_type", !"char4*", !"char4*", !"char4*"}
!18 = !{!"kernel_arg_base_type", !"char __attribute__((ext_vector_type(4)))*", !"char __attribute__((ext_vector_type(4)))*", !"char __attribute__((ext_vector_type(4)))*"}
!19 = !{!"clang version 3.7.0 (tags/RELEASE_371/final)"}
!20 = !{i32 14149}
!21 = !{i32 14289}
!22 = !{i32 13928}
!23 = !{!24, !24, i64 0}
!24 = !{!"int", !25, i64 0}
!25 = !{!"omnipotent char", !26, i64 0}
!26 = !{!"Simple C/C++ TBAA"}
!27 = !{!28, !28, i64 0}
!28 = !{!"short", !25, i64 0}
!29 = !{!25, !25, i64 0}
