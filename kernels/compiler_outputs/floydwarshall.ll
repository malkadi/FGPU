; ModuleID = 'floydwarshall.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind readnone
define i32 @__eqsf2(float %a, float %b) #0 {
entry:
  %0 = bitcast float %a to i32
  %1 = bitcast float %b to i32
  %and.i = and i32 %0, 2147483647
  %and2.i = and i32 %1, 2147483647
  %cmp.i = icmp slt i32 %0, %1
  %cond.i = select i1 %cmp.i, i32 -1, i32 1
  %cmp3.i = icmp sgt i32 %0, %1
  %cond4.i = select i1 %cmp3.i, i32 -1, i32 1
  %and5.i = and i32 %1, %0
  %cmp6.i = icmp sgt i32 %and5.i, -1
  %cond7.i = select i1 %cmp6.i, i32 %cond.i, i32 %cond4.i
  %cmp8.i = icmp eq i32 %0, %1
  %or.i = or i32 %and2.i, %and.i
  %cmp13.i = icmp eq i32 %or.i, 0
  %2 = or i1 %cmp8.i, %cmp13.i
  %cond17.i = select i1 %2, i32 0, i32 %cond7.i
  %cmp18.i = icmp ugt i32 %and.i, 2139095040
  %cmp19.i = icmp ugt i32 %and2.i, 2139095040
  %3 = or i1 %cmp18.i, %cmp19.i
  %cond23.i = select i1 %3, i32 1, i32 %cond17.i
  ret i32 %cond23.i
}

; Function Attrs: nounwind readnone
define i32 @__nesf2(float %a, float %b) #0 {
entry:
  %0 = bitcast float %a to i32
  %1 = bitcast float %b to i32
  %and.i = and i32 %0, 2147483647
  %and2.i = and i32 %1, 2147483647
  %cmp.i = icmp slt i32 %0, %1
  %cond.i = select i1 %cmp.i, i32 -1, i32 1
  %cmp3.i = icmp sgt i32 %0, %1
  %cond4.i = select i1 %cmp3.i, i32 -1, i32 1
  %and5.i = and i32 %1, %0
  %cmp6.i = icmp sgt i32 %and5.i, -1
  %cond7.i = select i1 %cmp6.i, i32 %cond.i, i32 %cond4.i
  %cmp8.i = icmp eq i32 %0, %1
  %or.i = or i32 %and2.i, %and.i
  %cmp13.i = icmp eq i32 %or.i, 0
  %2 = or i1 %cmp8.i, %cmp13.i
  %cond17.i = select i1 %2, i32 0, i32 %cond7.i
  %cmp18.i = icmp ugt i32 %and.i, 2139095040
  %cmp19.i = icmp ugt i32 %and2.i, 2139095040
  %3 = or i1 %cmp18.i, %cmp19.i
  %cond23.i = select i1 %3, i32 1, i32 %cond17.i
  ret i32 %cond23.i
}

; Function Attrs: nounwind readnone
define i32 @__lesf2(float %a, float %b) #0 {
entry:
  %0 = bitcast float %a to i32
  %1 = bitcast float %b to i32
  %and.i = and i32 %0, 2147483647
  %and2.i = and i32 %1, 2147483647
  %cmp.i = icmp slt i32 %0, %1
  %cond.i = select i1 %cmp.i, i32 -1, i32 1
  %cmp3.i = icmp sgt i32 %0, %1
  %cond4.i = select i1 %cmp3.i, i32 -1, i32 1
  %and5.i = and i32 %1, %0
  %cmp6.i = icmp sgt i32 %and5.i, -1
  %cond7.i = select i1 %cmp6.i, i32 %cond.i, i32 %cond4.i
  %cmp8.i = icmp eq i32 %0, %1
  %or.i = or i32 %and2.i, %and.i
  %cmp13.i = icmp eq i32 %or.i, 0
  %2 = or i1 %cmp8.i, %cmp13.i
  %cond17.i = select i1 %2, i32 0, i32 %cond7.i
  %cmp18.i = icmp ugt i32 %and.i, 2139095040
  %cmp19.i = icmp ugt i32 %and2.i, 2139095040
  %3 = or i1 %cmp18.i, %cmp19.i
  %cond23.i = select i1 %3, i32 1, i32 %cond17.i
  ret i32 %cond23.i
}

; Function Attrs: nounwind readnone
define i32 @__ltsf2(float %a, float %b) #0 {
entry:
  %0 = bitcast float %a to i32
  %1 = bitcast float %b to i32
  %and.i = and i32 %0, 2147483647
  %and2.i = and i32 %1, 2147483647
  %cmp.i = icmp slt i32 %0, %1
  %cond.i = select i1 %cmp.i, i32 -1, i32 1
  %cmp3.i = icmp sgt i32 %0, %1
  %cond4.i = select i1 %cmp3.i, i32 -1, i32 1
  %and5.i = and i32 %1, %0
  %cmp6.i = icmp sgt i32 %and5.i, -1
  %cond7.i = select i1 %cmp6.i, i32 %cond.i, i32 %cond4.i
  %cmp8.i = icmp eq i32 %0, %1
  %or.i = or i32 %and2.i, %and.i
  %cmp13.i = icmp eq i32 %or.i, 0
  %2 = or i1 %cmp8.i, %cmp13.i
  %cond17.i = select i1 %2, i32 0, i32 %cond7.i
  %cmp18.i = icmp ugt i32 %and.i, 2139095040
  %cmp19.i = icmp ugt i32 %and2.i, 2139095040
  %3 = or i1 %cmp18.i, %cmp19.i
  %cond23.i = select i1 %3, i32 1, i32 %cond17.i
  ret i32 %cond23.i
}

; Function Attrs: nounwind readnone
define i32 @__gesf2(float %a, float %b) #0 {
entry:
  %0 = bitcast float %a to i32
  %1 = bitcast float %b to i32
  %and.i = and i32 %0, 2147483647
  %and2.i = and i32 %1, 2147483647
  %cmp.i = icmp slt i32 %0, %1
  %cond.i = select i1 %cmp.i, i32 -1, i32 1
  %cmp3.i = icmp sgt i32 %0, %1
  %cond4.i = select i1 %cmp3.i, i32 -1, i32 1
  %and5.i = and i32 %1, %0
  %cmp6.i = icmp sgt i32 %and5.i, -1
  %cond7.i = select i1 %cmp6.i, i32 %cond.i, i32 %cond4.i
  %cmp8.i = icmp eq i32 %0, %1
  %or.i = or i32 %and2.i, %and.i
  %cmp13.i = icmp eq i32 %or.i, 0
  %2 = or i1 %cmp8.i, %cmp13.i
  %cond17.i = select i1 %2, i32 0, i32 %cond7.i
  %cmp18.i = icmp ugt i32 %and.i, 2139095040
  %cmp19.i = icmp ugt i32 %and2.i, 2139095040
  %3 = or i1 %cmp18.i, %cmp19.i
  %cond23.i = select i1 %3, i32 -1, i32 %cond17.i
  ret i32 %cond23.i
}

; Function Attrs: nounwind readnone
define i32 @__gtsf2(float %a, float %b) #0 {
entry:
  %0 = bitcast float %a to i32
  %1 = bitcast float %b to i32
  %and.i = and i32 %0, 2147483647
  %and2.i = and i32 %1, 2147483647
  %cmp.i = icmp slt i32 %0, %1
  %cond.i = select i1 %cmp.i, i32 -1, i32 1
  %cmp3.i = icmp sgt i32 %0, %1
  %cond4.i = select i1 %cmp3.i, i32 -1, i32 1
  %and5.i = and i32 %1, %0
  %cmp6.i = icmp sgt i32 %and5.i, -1
  %cond7.i = select i1 %cmp6.i, i32 %cond.i, i32 %cond4.i
  %cmp8.i = icmp eq i32 %0, %1
  %or.i = or i32 %and2.i, %and.i
  %cmp13.i = icmp eq i32 %or.i, 0
  %2 = or i1 %cmp8.i, %cmp13.i
  %cond17.i = select i1 %2, i32 0, i32 %cond7.i
  %cmp18.i = icmp ugt i32 %and.i, 2139095040
  %cmp19.i = icmp ugt i32 %and2.i, 2139095040
  %3 = or i1 %cmp18.i, %cmp19.i
  %cond23.i = select i1 %3, i32 -1, i32 %cond17.i
  ret i32 %cond23.i
}

; Function Attrs: nounwind readnone
define i32 @__unordsf2(float %a, float %b) #0 {
entry:
  %0 = bitcast float %a to i32
  %and = and i32 %0, 2147483647
  %1 = bitcast float %b to i32
  %and2 = and i32 %1, 2147483647
  %cmp = icmp ugt i32 %and, 2139095040
  %cmp3 = icmp ugt i32 %and2, 2139095040
  %2 = or i1 %cmp, %cmp3
  %lor.ext = zext i1 %2 to i32
  ret i32 %lor.ext
}

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
define void @floydWarshallPass(float* nocapture %mat, i32 signext %pass) #1 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !7
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !8
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 1) #3, !srcloc !7
  %3 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 1) #3, !srcloc !8
  %add.i.30 = add nsw i32 %3, %2
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !9
  %mul = mul i32 %add.i.30, %4
  %add = add i32 %mul, %add.i
  %arrayidx = getelementptr inbounds float, float* %mat, i32 %add
  %5 = load float, float* %arrayidx, align 4, !tbaa !10
  %add4 = add i32 %mul, %pass
  %arrayidx5 = getelementptr inbounds float, float* %mat, i32 %add4
  %6 = load float, float* %arrayidx5, align 4, !tbaa !10
  %mul6 = mul i32 %4, %pass
  %add7 = add i32 %mul6, %add.i
  %arrayidx8 = getelementptr inbounds float, float* %mat, i32 %add7
  %7 = load float, float* %arrayidx8, align 4, !tbaa !10
  %add9 = fadd float %6, %7
  %cmp = fcmp olt float %add9, %5
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  store float %add9, float* %arrayidx, align 4, !tbaa !10
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @llvm.ctlz.i32(i32, i1) #2

attributes #0 = { nounwind readnone "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (float*, i32)* @floydWarshallPass, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float*", !"uint"}
!4 = !{!"kernel_arg_base_type", !"float*", !"uint"}
!5 = !{!"kernel_arg_type_qual", !"", !""}
!6 = !{!"clang version 3.7.0 (tags/RELEASE_371/final)"}
!7 = !{i32 11799}
!8 = !{i32 11939}
!9 = !{i32 11578}
!10 = !{!11, !11, i64 0}
!11 = !{!"float", !12, i64 0}
!12 = !{!"omnipotent char", !13, i64 0}
!13 = !{!"Simple C/C++ TBAA"}
