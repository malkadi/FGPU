; ModuleID = 'vec_add.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind readnone
define float @__addsf3(float %a, float %b) #0 {
entry:
  %0 = bitcast float %a to i32
  %1 = bitcast float %b to i32
  %and = and i32 %0, 2147483647
  %and2 = and i32 %1, 2147483647
  %sub = add nsw i32 %and, -1
  %cmp = icmp ugt i32 %sub, 2139095038
  %sub3 = add nsw i32 %and2, -1
  %cmp4 = icmp ugt i32 %sub3, 2139095038
  %or.cond = or i1 %cmp, %cmp4
  br i1 %or.cond, label %if.then, label %if.end.31

if.then:                                          ; preds = %entry
  %cmp5 = icmp ugt i32 %and, 2139095040
  %cmp6 = icmp ugt i32 %and2, 2139095040
  %2 = or i1 %cmp5, %cmp6
  %cmp7 = icmp eq i32 %and, 2139095040
  %xor = xor i32 %1, %0
  %cmp10 = icmp eq i32 %xor, -2147483648
  %3 = and i1 %cmp7, %cmp10
  %or234 = or i1 %2, %3
  %brmerge = or i1 %cmp7, %2
  %.mux = select i1 %or234, float 0x7FF8000000000000, float %a
  br i1 %brmerge, label %cleanup.163, label %if.end.15

if.end.15:                                        ; preds = %if.then
  %cmp16 = icmp eq i32 %and2, 2139095040
  br i1 %cmp16, label %cleanup.163, label %if.end.18

if.end.18:                                        ; preds = %if.end.15
  %tobool19 = icmp eq i32 %and, 0
  %tobool28 = icmp ne i32 %and2, 0
  br i1 %tobool19, label %if.then.20, label %cleanup

if.then.20:                                       ; preds = %if.end.18
  br i1 %tobool28, label %cleanup.163, label %if.then.22

if.then.22:                                       ; preds = %if.then.20
  %and25 = and i32 %1, %0
  %4 = bitcast i32 %and25 to float
  br label %cleanup.163

cleanup:                                          ; preds = %if.end.18
  br i1 %tobool28, label %if.end.31, label %cleanup.163

if.end.31:                                        ; preds = %entry, %cleanup
  %cmp32 = icmp ugt i32 %and2, %and
  %cond = select i1 %cmp32, i32 %0, i32 %1
  %cond38 = select i1 %cmp32, i32 %1, i32 %0
  %shr = lshr i32 %cond38, 23
  %and39 = and i32 %shr, 255
  %shr40 = lshr i32 %cond, 23
  %and41 = and i32 %shr40, 255
  %and42 = and i32 %cond38, 8388607
  %and43 = and i32 %cond, 8388607
  %cmp44 = icmp eq i32 %and39, 0
  br i1 %cmp44, label %if.then.46, label %if.end.48

if.then.46:                                       ; preds = %if.end.31
  %5 = tail call i32 @llvm.ctlz.i32(i32 %and42, i1 false) #3
  %sub.i.235 = add nuw nsw i32 %5, 24
  %shl.mask.i.236 = and i32 %sub.i.235, 31
  %shl.i.237 = shl i32 %and42, %shl.mask.i.236
  %sub2.i.238 = sub nsw i32 9, %5
  br label %if.end.48

if.end.48:                                        ; preds = %if.then.46, %if.end.31
  %aSignificand.0 = phi i32 [ %shl.i.237, %if.then.46 ], [ %and42, %if.end.31 ]
  %aExponent.0 = phi i32 [ %sub2.i.238, %if.then.46 ], [ %and39, %if.end.31 ]
  %cmp49 = icmp eq i32 %and41, 0
  br i1 %cmp49, label %if.then.51, label %if.end.53

if.then.51:                                       ; preds = %if.end.48
  %6 = tail call i32 @llvm.ctlz.i32(i32 %and43, i1 false) #3
  %sub.i = add nuw nsw i32 %6, 24
  %shl.mask.i = and i32 %sub.i, 31
  %shl.i = shl i32 %and43, %shl.mask.i
  %sub2.i = sub nsw i32 9, %6
  br label %if.end.53

if.end.53:                                        ; preds = %if.then.51, %if.end.48
  %bSignificand.0 = phi i32 [ %shl.i, %if.then.51 ], [ %and43, %if.end.48 ]
  %bExponent.0 = phi i32 [ %sub2.i, %if.then.51 ], [ %and41, %if.end.48 ]
  %and54 = and i32 %cond38, -2147483648
  %xor55 = xor i32 %cond38, %cond
  %tobool57 = icmp slt i32 %xor55, 0
  %or58 = shl i32 %aSignificand.0, 3
  %shl = or i32 %or58, 67108864
  %or59 = shl i32 %bSignificand.0, 3
  %shl60 = or i32 %or59, 67108864
  %sub61 = sub nsw i32 %aExponent.0, %bExponent.0
  %tobool62 = icmp eq i32 %aExponent.0, %bExponent.0
  br i1 %tobool62, label %if.end.77, label %if.then.63

if.then.63:                                       ; preds = %if.end.53
  %cmp64 = icmp ult i32 %sub61, 32
  br i1 %cmp64, label %if.then.66, label %if.end.77

if.then.66:                                       ; preds = %if.then.63
  %7 = sub nsw i32 0, %sub61
  %shl.mask = and i32 %7, 31
  %shl68 = shl i32 %shl60, %shl.mask
  %tobool69 = icmp ne i32 %shl68, 0
  %shr.mask = and i32 %sub61, 31
  %shr71 = lshr i32 %shl60, %shr.mask
  %conv73 = zext i1 %tobool69 to i32
  %or74 = or i32 %conv73, %shr71
  br label %if.end.77

if.end.77:                                        ; preds = %if.then.63, %if.end.53, %if.then.66
  %bSignificand.1 = phi i32 [ %shl60, %if.end.53 ], [ %or74, %if.then.66 ], [ 1, %if.then.63 ]
  br i1 %tobool57, label %if.then.79, label %if.else.96

if.then.79:                                       ; preds = %if.end.77
  %sub80 = sub i32 %shl, %bSignificand.1
  %cmp81 = icmp eq i32 %shl, %bSignificand.1
  br i1 %cmp81, label %cleanup.163, label %if.end.85

if.end.85:                                        ; preds = %if.then.79
  %cmp86 = icmp ult i32 %sub80, 67108864
  br i1 %cmp86, label %if.then.88, label %if.end.110

if.then.88:                                       ; preds = %if.end.85
  %8 = tail call i32 @llvm.ctlz.i32(i32 %sub80, i1 false) #3
  %sub91 = add nsw i32 %8, -5
  %shl.mask92 = and i32 %sub91, 31
  %shl93 = shl i32 %sub80, %shl.mask92
  %sub94 = sub nsw i32 %aExponent.0, %sub91
  br label %if.end.110

if.else.96:                                       ; preds = %if.end.77
  %add = add i32 %bSignificand.1, %shl
  %and97 = and i32 %add, 134217728
  %tobool98 = icmp eq i32 %and97, 0
  br i1 %tobool98, label %if.end.110, label %if.then.99

if.then.99:                                       ; preds = %if.else.96
  %fold = add i32 %bSignificand.1, %or58
  %and101 = and i32 %fold, 1
  %shr104 = lshr i32 %add, 1
  %or107 = or i32 %shr104, %and101
  %add108 = add nsw i32 %aExponent.0, 1
  br label %if.end.110

if.end.110:                                       ; preds = %if.else.96, %if.then.99, %if.end.85, %if.then.88
  %aSignificand.1 = phi i32 [ %shl93, %if.then.88 ], [ %sub80, %if.end.85 ], [ %add, %if.else.96 ], [ %or107, %if.then.99 ]
  %aExponent.1 = phi i32 [ %sub94, %if.then.88 ], [ %aExponent.0, %if.end.85 ], [ %aExponent.0, %if.else.96 ], [ %add108, %if.then.99 ]
  %cmp111 = icmp sgt i32 %aExponent.1, 254
  br i1 %cmp111, label %if.then.113, label %if.end.116

if.then.113:                                      ; preds = %if.end.110
  %or114 = or i32 %and54, 2139095040
  %9 = bitcast i32 %or114 to float
  br label %cleanup.163

if.end.116:                                       ; preds = %if.end.110
  %cmp117 = icmp slt i32 %aExponent.1, 1
  br i1 %cmp117, label %if.then.119, label %if.end.133

if.then.119:                                      ; preds = %if.end.116
  %sub121 = sub nsw i32 1, %aExponent.1
  %10 = sub nsw i32 0, %sub121
  %shl.mask124 = and i32 %10, 31
  %shl125 = shl i32 %aSignificand.1, %shl.mask124
  %tobool126 = icmp ne i32 %shl125, 0
  %shr.mask128 = and i32 %sub121, 31
  %shr129 = lshr i32 %aSignificand.1, %shr.mask128
  %conv131 = zext i1 %tobool126 to i32
  %or132 = or i32 %conv131, %shr129
  br label %if.end.133

if.end.133:                                       ; preds = %if.then.119, %if.end.116
  %aSignificand.2 = phi i32 [ %or132, %if.then.119 ], [ %aSignificand.1, %if.end.116 ]
  %aExponent.2 = phi i32 [ 0, %if.then.119 ], [ %aExponent.1, %if.end.116 ]
  %and134 = and i32 %aSignificand.2, 7
  %shr135 = lshr i32 %aSignificand.2, 3
  %and136 = and i32 %shr135, 8388607
  %shl137 = shl i32 %aExponent.2, 23
  %or138 = or i32 %shl137, %and54
  %or139 = or i32 %or138, %and136
  %cmp140 = icmp ugt i32 %and134, 4
  %inc = zext i1 %cmp140 to i32
  %inc.or139 = add i32 %or139, %inc
  %cmp144 = icmp eq i32 %and134, 4
  %and147 = and i32 %inc.or139, 1
  %add148 = select i1 %cmp144, i32 %and147, i32 0
  %result.1 = add i32 %add148, %inc.or139
  %11 = bitcast i32 %result.1 to float
  br label %cleanup.163

cleanup.163:                                      ; preds = %if.then, %if.then.20, %if.end.15, %if.then.22, %if.then.113, %if.end.133, %if.then.79, %cleanup
  %retval.2 = phi float [ %a, %cleanup ], [ %9, %if.then.113 ], [ %11, %if.end.133 ], [ 0.000000e+00, %if.then.79 ], [ %.mux, %if.then ], [ %b, %if.then.20 ], [ %b, %if.end.15 ], [ %4, %if.then.22 ]
  ret float %retval.2
}

; Function Attrs: nounwind
define void @vec_add(i32* nocapture readonly %in1, i32* nocapture readonly %in2, i32* nocapture %out) #1 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !22
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !23
  %add.i = add nsw i32 %1, %0
  %arrayidx = getelementptr inbounds i32, i32* %in1, i32 %add.i
  %2 = load i32, i32* %arrayidx, align 4, !tbaa !24
  %arrayidx1 = getelementptr inbounds i32, i32* %in2, i32 %add.i
  %3 = load i32, i32* %arrayidx1, align 4, !tbaa !24
  %add = add nsw i32 %3, %2
  %arrayidx2 = getelementptr inbounds i32, i32* %out, i32 %add.i
  store i32 %add, i32* %arrayidx2, align 4, !tbaa !24
  ret void
}

; Function Attrs: nounwind
define void @vec_add_half(i16* nocapture readonly %in1, i16* nocapture readonly %in2, i16* nocapture %out) #1 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !22
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !23
  %add.i = add nsw i32 %1, %0
  %arrayidx = getelementptr inbounds i16, i16* %in1, i32 %add.i
  %2 = load i16, i16* %arrayidx, align 2, !tbaa !28
  %conv.8 = zext i16 %2 to i32
  %arrayidx1 = getelementptr inbounds i16, i16* %in2, i32 %add.i
  %3 = load i16, i16* %arrayidx1, align 2, !tbaa !28
  %conv2.9 = zext i16 %3 to i32
  %add = add nuw nsw i32 %conv2.9, %conv.8
  %conv3 = trunc i32 %add to i16
  %arrayidx4 = getelementptr inbounds i16, i16* %out, i32 %add.i
  store i16 %conv3, i16* %arrayidx4, align 2, !tbaa !28
  ret void
}

; Function Attrs: nounwind
define void @vec_add_half_improved(<2 x i16>* nocapture readonly %in1, <2 x i16>* nocapture readonly %in2, <2 x i16>* nocapture %out) #1 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !22
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !23
  %add.i = add nsw i32 %1, %0
  %arrayidx = getelementptr inbounds <2 x i16>, <2 x i16>* %in1, i32 %add.i
  %2 = load <2 x i16>, <2 x i16>* %arrayidx, align 4, !tbaa !30
  %arrayidx1 = getelementptr inbounds <2 x i16>, <2 x i16>* %in2, i32 %add.i
  %3 = load <2 x i16>, <2 x i16>* %arrayidx1, align 4, !tbaa !30
  %add = add <2 x i16> %3, %2
  %arrayidx2 = getelementptr inbounds <2 x i16>, <2 x i16>* %out, i32 %add.i
  store <2 x i16> %add, <2 x i16>* %arrayidx2, align 4, !tbaa !30
  ret void
}

; Function Attrs: nounwind
define void @vec_add_byte(i8* nocapture readonly %in1, i8* nocapture readonly %in2, i8* nocapture %out) #1 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !22
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !23
  %add.i = add nsw i32 %1, %0
  %arrayidx = getelementptr inbounds i8, i8* %in1, i32 %add.i
  %2 = load i8, i8* %arrayidx, align 1, !tbaa !30
  %conv.8 = zext i8 %2 to i32
  %arrayidx1 = getelementptr inbounds i8, i8* %in2, i32 %add.i
  %3 = load i8, i8* %arrayidx1, align 1, !tbaa !30
  %conv2.9 = zext i8 %3 to i32
  %add = add nuw nsw i32 %conv2.9, %conv.8
  %conv3 = trunc i32 %add to i8
  %arrayidx4 = getelementptr inbounds i8, i8* %out, i32 %add.i
  store i8 %conv3, i8* %arrayidx4, align 1, !tbaa !30
  ret void
}

; Function Attrs: nounwind
define void @vec_add_byte_improved(<4 x i8>* nocapture readonly %in1, <4 x i8>* nocapture readonly %in2, <4 x i8>* nocapture %out) #1 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !22
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !23
  %add.i = add nsw i32 %1, %0
  %arrayidx = getelementptr inbounds <4 x i8>, <4 x i8>* %in1, i32 %add.i
  %2 = load <4 x i8>, <4 x i8>* %arrayidx, align 4, !tbaa !30
  %arrayidx1 = getelementptr inbounds <4 x i8>, <4 x i8>* %in2, i32 %add.i
  %3 = load <4 x i8>, <4 x i8>* %arrayidx1, align 4, !tbaa !30
  %add = add <4 x i8> %3, %2
  %arrayidx2 = getelementptr inbounds <4 x i8>, <4 x i8>* %out, i32 %add.i
  store <4 x i8> %add, <4 x i8>* %arrayidx2, align 4, !tbaa !30
  ret void
}

; Function Attrs: nounwind
define void @add_float(float* nocapture readonly %in1, float* nocapture readonly %in2, float* nocapture %out) #1 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !22
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !23
  %add.i = add nsw i32 %1, %0
  %arrayidx = getelementptr inbounds float, float* %in1, i32 %add.i
  %2 = load float, float* %arrayidx, align 4, !tbaa !31
  %arrayidx1 = getelementptr inbounds float, float* %in2, i32 %add.i
  %3 = load float, float* %arrayidx1, align 4, !tbaa !31
  %add = fadd float %2, %3
  %arrayidx2 = getelementptr inbounds float, float* %out, i32 %add.i
  store float %add, float* %arrayidx2, align 4, !tbaa !31
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @llvm.ctlz.i32(i32, i1) #2

attributes #0 = { nounwind readnone "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!opencl.kernels = !{!0, !6, !9, !12, !15, !18}
!llvm.ident = !{!21}

!0 = !{void (i32*, i32*, i32*)* @vec_add, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"int*", !"int*", !"int*"}
!4 = !{!"kernel_arg_base_type", !"int*", !"int*", !"int*"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !""}
!6 = !{void (i16*, i16*, i16*)* @vec_add_half, !1, !2, !7, !8, !5}
!7 = !{!"kernel_arg_type", !"short*", !"short*", !"short*"}
!8 = !{!"kernel_arg_base_type", !"short*", !"short*", !"short*"}
!9 = !{void (<2 x i16>*, <2 x i16>*, <2 x i16>*)* @vec_add_half_improved, !1, !2, !10, !11, !5}
!10 = !{!"kernel_arg_type", !"short2*", !"short2*", !"short2*"}
!11 = !{!"kernel_arg_base_type", !"short __attribute__((ext_vector_type(2)))*", !"short __attribute__((ext_vector_type(2)))*", !"short __attribute__((ext_vector_type(2)))*"}
!12 = !{void (i8*, i8*, i8*)* @vec_add_byte, !1, !2, !13, !14, !5}
!13 = !{!"kernel_arg_type", !"char*", !"char*", !"char*"}
!14 = !{!"kernel_arg_base_type", !"char*", !"char*", !"char*"}
!15 = !{void (<4 x i8>*, <4 x i8>*, <4 x i8>*)* @vec_add_byte_improved, !1, !2, !16, !17, !5}
!16 = !{!"kernel_arg_type", !"char4*", !"char4*", !"char4*"}
!17 = !{!"kernel_arg_base_type", !"char __attribute__((ext_vector_type(4)))*", !"char __attribute__((ext_vector_type(4)))*", !"char __attribute__((ext_vector_type(4)))*"}
!18 = !{void (float*, float*, float*)* @add_float, !1, !2, !19, !20, !5}
!19 = !{!"kernel_arg_type", !"float*", !"float*", !"float*"}
!20 = !{!"kernel_arg_base_type", !"float*", !"float*", !"float*"}
!21 = !{!"clang version 3.7.0 (tags/RELEASE_371/final)"}
!22 = !{i32 12426}
!23 = !{i32 12566}
!24 = !{!25, !25, i64 0}
!25 = !{!"int", !26, i64 0}
!26 = !{!"omnipotent char", !27, i64 0}
!27 = !{!"Simple C/C++ TBAA"}
!28 = !{!29, !29, i64 0}
!29 = !{!"short", !26, i64 0}
!30 = !{!26, !26, i64 0}
!31 = !{!32, !32, i64 0}
!32 = !{!"float", !26, i64 0}
