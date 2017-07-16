; ModuleID = 'xcorr.cl'
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

; Function Attrs: nounwind readnone
define i64 @__muldsi3(i32 signext %a, i32 signext %b) #0 {
entry:
  %and = and i32 %a, 65535
  %and1 = and i32 %b, 65535
  %mul = mul nuw i32 %and1, %and
  %shr = lshr i32 %mul, 16
  %and6 = and i32 %mul, 65535
  %shr7 = lshr i32 %a, 16
  %mul9 = mul nuw i32 %and1, %shr7
  %add = add i32 %shr, %mul9
  %shr14 = lshr i32 %add, 16
  %shr18 = and i32 %add, 65535
  %shr22 = lshr i32 %b, 16
  %mul24 = mul nuw i32 %shr22, %and
  %add25 = add i32 %shr18, %mul24
  %fold = add i32 %add, %mul24
  %shl27 = shl i32 %fold, 16
  %add30 = or i32 %shl27, %and6
  %shr31 = lshr i32 %add25, 16
  %mul37 = mul nuw i32 %shr22, %shr7
  %add34 = add i32 %shr14, %mul37
  %add40 = add i32 %add34, %shr31
  %r.sroa.8.0.insert.ext = zext i32 %add30 to i64
  %r.sroa.0.0.insert.ext = zext i32 %add40 to i64
  %r.sroa.0.0.insert.shift = shl nuw i64 %r.sroa.0.0.insert.ext, 32
  %r.sroa.0.0.insert.insert = or i64 %r.sroa.0.0.insert.shift, %r.sroa.8.0.insert.ext
  ret i64 %r.sroa.0.0.insert.insert
}

; Function Attrs: nounwind readnone
define i64 @__muldi3(i64 signext %a, i64 signext %b) #0 {
entry:
  %x.sroa.0.0.extract.shift = lshr i64 %a, 32
  %x.sroa.0.0.extract.trunc = trunc i64 %x.sroa.0.0.extract.shift to i32
  %x.sroa.4.0.extract.trunc = trunc i64 %a to i32
  %y.sroa.0.0.extract.shift = lshr i64 %b, 32
  %y.sroa.0.0.extract.trunc = trunc i64 %y.sroa.0.0.extract.shift to i32
  %y.sroa.4.0.extract.trunc = trunc i64 %b to i32
  %and.i = and i32 %x.sroa.4.0.extract.trunc, 65535
  %and1.i = and i32 %y.sroa.4.0.extract.trunc, 65535
  %mul.i = mul nuw i32 %and1.i, %and.i
  %shr.i = lshr i32 %mul.i, 16
  %and6.i = and i32 %mul.i, 65535
  %shr7.i = lshr i32 %x.sroa.4.0.extract.trunc, 16
  %mul9.i = mul nuw i32 %and1.i, %shr7.i
  %add.i = add i32 %shr.i, %mul9.i
  %shr14.i = lshr i32 %add.i, 16
  %shr18.i = and i32 %add.i, 65535
  %shr22.i = lshr i32 %y.sroa.4.0.extract.trunc, 16
  %mul24.i = mul nuw i32 %shr22.i, %and.i
  %add25.i = add i32 %shr18.i, %mul24.i
  %fold.i = add i32 %add.i, %mul24.i
  %shl27.i = shl i32 %fold.i, 16
  %add30.i = or i32 %shl27.i, %and6.i
  %shr31.i = lshr i32 %add25.i, 16
  %mul37.i = mul nuw i32 %shr22.i, %shr7.i
  %r.sroa.8.0.insert.ext.i = zext i32 %add30.i to i64
  %mul = mul i32 %x.sroa.0.0.extract.trunc, %y.sroa.4.0.extract.trunc
  %mul12 = mul i32 %y.sroa.0.0.extract.trunc, %x.sroa.4.0.extract.trunc
  %add34.i = add i32 %mul12, %mul
  %add40.i = add i32 %add34.i, %mul37.i
  %add = add i32 %add40.i, %shr14.i
  %add15 = add i32 %add, %shr31.i
  %r.sroa.0.0.insert.ext = zext i32 %add15 to i64
  %r.sroa.0.0.insert.shift = shl nuw i64 %r.sroa.0.0.insert.ext, 32
  %r.sroa.0.0.insert.insert = or i64 %r.sroa.0.0.insert.shift, %r.sroa.8.0.insert.ext.i
  ret i64 %r.sroa.0.0.insert.insert
}

; Function Attrs: nounwind readnone
define float @__mulsf3(float %a, float %b) #0 {
entry:
  %0 = bitcast float %a to i32
  %shr = lshr i32 %0, 23
  %and = and i32 %shr, 255
  %1 = bitcast float %b to i32
  %shr2 = lshr i32 %1, 23
  %and3 = and i32 %shr2, 255
  %xor = xor i32 %1, %0
  %and6 = and i32 %xor, -2147483648
  %and8 = and i32 %0, 8388607
  %and10 = and i32 %1, 8388607
  %sub = add nsw i32 %and, -1
  %cmp = icmp ugt i32 %sub, 253
  %sub11 = add nsw i32 %and3, -1
  %cmp12 = icmp ugt i32 %sub11, 253
  %or.cond = or i1 %cmp, %cmp12
  br i1 %or.cond, label %if.then, label %if.end.59

if.then:                                          ; preds = %entry
  %and14 = and i32 %0, 2147483647
  %and16 = and i32 %1, 2147483647
  %cmp17 = icmp ugt i32 %and14, 2139095040
  %cmp18 = icmp ugt i32 %and16, 2139095040
  %2 = or i1 %cmp17, %cmp18
  br i1 %2, label %cleanup.123, label %if.end

if.end:                                           ; preds = %if.then
  %cmp21 = icmp eq i32 %and14, 2139095040
  %cmp23 = icmp eq i32 %and16, 2139095040
  %3 = or i1 %cmp21, %cmp23
  br i1 %3, label %if.then.28, label %if.end.35

if.then.28:                                       ; preds = %if.end
  %cond = select i1 %cmp21, i32 %and16, i32 %and14
  %tobool29 = icmp ne i32 %cond, 0
  %or = or i32 %and6, 2139095040
  %4 = bitcast i32 %or to float
  %5 = select i1 %tobool29, float %4, float 0x7FF8000000000000
  br label %cleanup.123

if.end.35:                                        ; preds = %if.end
  %tobool36 = icmp eq i32 %and14, 0
  %lnot = icmp eq i32 %and16, 0
  %.lnot = or i1 %tobool36, %lnot
  br i1 %.lnot, label %if.then.42, label %if.end.44

if.then.42:                                       ; preds = %if.end.35
  %6 = bitcast i32 %and6 to float
  br label %cleanup.123

if.end.44:                                        ; preds = %if.end.35
  %cmp45 = icmp ult i32 %and14, 8388608
  br i1 %cmp45, label %if.then.46, label %if.end.48

if.then.46:                                       ; preds = %if.end.44
  %7 = tail call i32 @llvm.ctlz.i32(i32 %and8, i1 false) #3
  %sub.i.181 = add nuw nsw i32 %7, 24
  %shl.mask.i.182 = and i32 %sub.i.181, 31
  %shl.i.183 = shl i32 %and8, %shl.mask.i.182
  %sub2.i.184 = sub nsw i32 9, %7
  br label %if.end.48

if.end.48:                                        ; preds = %if.then.46, %if.end.44
  %aSignificand.0 = phi i32 [ %shl.i.183, %if.then.46 ], [ %and8, %if.end.44 ]
  %scale.0 = phi i32 [ %sub2.i.184, %if.then.46 ], [ 0, %if.end.44 ]
  %cmp49 = icmp ult i32 %and16, 8388608
  br i1 %cmp49, label %if.then.50, label %if.end.59

if.then.50:                                       ; preds = %if.end.48
  %8 = tail call i32 @llvm.ctlz.i32(i32 %and10, i1 false) #3
  %sub.i = add nuw nsw i32 %8, 24
  %shl.mask.i.179 = and i32 %sub.i, 31
  %shl.i.180 = shl i32 %and10, %shl.mask.i.179
  %sub2.i = add nsw i32 %scale.0, 9
  %add52 = sub nsw i32 %sub2.i, %8
  br label %if.end.59

if.end.59:                                        ; preds = %if.end.48, %if.then.50, %entry
  %aSignificand.2 = phi i32 [ %and8, %entry ], [ %aSignificand.0, %if.then.50 ], [ %aSignificand.0, %if.end.48 ]
  %bSignificand.1 = phi i32 [ %and10, %entry ], [ %shl.i.180, %if.then.50 ], [ %and10, %if.end.48 ]
  %scale.5 = phi i32 [ 0, %entry ], [ %add52, %if.then.50 ], [ %scale.0, %if.end.48 ]
  %or60 = or i32 %aSignificand.2, 8388608
  %or61 = shl i32 %bSignificand.1, 8
  %shl = or i32 %or61, -2147483648
  %conv.i.177 = zext i32 %or60 to i64
  %conv1.i = zext i32 %shl to i64
  %mul.i = mul nuw i64 %conv1.i, %conv.i.177
  %shr.i.178 = lshr i64 %mul.i, 32
  %conv2.i = trunc i64 %shr.i.178 to i32
  %conv3.i = trunc i64 %mul.i to i32
  %shl65206 = shl nuw nsw i64 %shr.i.178, 1
  %shl65 = trunc i64 %shl65206 to i32
  %shr66 = lshr i32 %conv3.i, 31
  %or67 = or i32 %shl65, %shr66
  %and70 = and i32 %conv2.i, 8388608
  %tobool71 = icmp ne i32 %and70, 0
  %and70.lobit = lshr exact i32 %and70, 23
  %add62 = add nsw i32 %and, -127
  %sub63 = add nsw i32 %add62, %and3
  %add64 = add nsw i32 %sub63, %scale.5
  %add73 = add i32 %add64, %and70.lobit
  %cond78 = select i1 %tobool71, i32 %conv2.i, i32 %or67
  %shl68 = xor i32 %and70.lobit, 1
  %cond83 = shl i32 %conv3.i, %shl68
  %cmp84 = icmp slt i32 %add73, 1
  br i1 %cmp84, label %if.then.85, label %if.else

if.then.85:                                       ; preds = %if.end.59
  %sub86 = sub i32 1, %add73
  %cmp87 = icmp ugt i32 %sub86, 31
  br i1 %cmp87, label %cleanup.91, label %cleanup.91.thread

cleanup.91.thread:                                ; preds = %if.then.85
  %9 = sub i32 0, %sub86
  %shl.mask.i = and i32 %9, 31
  %shl.i = shl i32 %cond83, %shl.mask.i
  %tobool.i = icmp ne i32 %shl.i, 0
  %shl3.i = shl i32 %cond78, %shl.mask.i
  %shr.mask.i = and i32 %sub86, 31
  %shr.i = lshr i32 %cond83, %shr.mask.i
  %or.i = or i32 %shl3.i, %shr.i
  %conv.i = zext i1 %tobool.i to i32
  %or5.i = or i32 %or.i, %conv.i
  %shr7.i = lshr i32 %cond78, %shr.mask.i
  br label %if.end.97

cleanup.91:                                       ; preds = %if.then.85
  %10 = bitcast i32 %and6 to float
  br label %cleanup.123

if.else:                                          ; preds = %if.end.59
  %and94 = and i32 %cond78, 8388607
  %shl95 = shl i32 %add73, 23
  %or96 = or i32 %and94, %shl95
  br label %if.end.97

if.end.97:                                        ; preds = %cleanup.91.thread, %if.else
  %productHi.2 = phi i32 [ %or96, %if.else ], [ %shr7.i, %cleanup.91.thread ]
  %productLo.2 = phi i32 [ %cond83, %if.else ], [ %or5.i, %cleanup.91.thread ]
  %or98 = or i32 %productHi.2, %and6
  %cmp99 = icmp ugt i32 %productLo.2, -2147483648
  %conv = zext i1 %cmp99 to i32
  %add100 = add i32 %conv, %or98
  %cmp101 = icmp eq i32 %productLo.2, -2147483648
  %and104 = and i32 %add100, 1
  %cond107 = select i1 %cmp101, i32 %and104, i32 0
  %add108 = add i32 %cond107, %add100
  %cmp109 = icmp sgt i32 %add73, 254
  %or112 = or i32 %and6, 2139095040
  %cond115 = select i1 %cmp109, i32 %or112, i32 %add108
  %11 = bitcast i32 %cond115 to float
  br label %cleanup.123

cleanup.123:                                      ; preds = %if.then, %if.then.42, %if.then.28, %if.end.97, %cleanup.91
  %retval.6 = phi float [ %11, %if.end.97 ], [ %10, %cleanup.91 ], [ 0x7FF8000000000000, %if.then ], [ %6, %if.then.42 ], [ %5, %if.then.28 ]
  ret float %retval.6
}

; Function Attrs: nounwind
define void @xcorr(i32* nocapture readonly %in1, i32* nocapture readonly %in2, i32* nocapture %out) #1 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !23
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !24
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !25
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %res.0 = phi i32 [ 0, %entry ], [ %add3, %do.body ]
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %arrayidx = getelementptr inbounds i32, i32* %in1, i32 %i.0
  %3 = load i32, i32* %arrayidx, align 4, !tbaa !26
  %add = add nsw i32 %i.0, %add.i
  %arrayidx2 = getelementptr inbounds i32, i32* %in2, i32 %add
  %4 = load i32, i32* %arrayidx2, align 4, !tbaa !26
  %mul = mul nsw i32 %4, %3
  %add3 = add nsw i32 %mul, %res.0
  %inc = add nuw nsw i32 %i.0, 1
  %cmp = icmp eq i32 %inc, %2
  br i1 %cmp, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %add3.lcssa = phi i32 [ %add3, %do.body ]
  %arrayidx4 = getelementptr inbounds i32, i32* %out, i32 %add.i
  store i32 %add3.lcssa, i32* %arrayidx4, align 4, !tbaa !26
  ret void
}

; Function Attrs: nounwind
define void @xcorr_improved(i32* nocapture readonly %in1, i32* nocapture readonly %in2, i32* nocapture %out) #1 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !23
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !24
  %add.i = add nsw i32 %1, %0
  %shl = shl i32 %add.i, 2
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !25
  %shl2 = shl i32 %2, 2
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %res1.0 = phi i32 [ 0, %entry ], [ %add4, %do.body ]
  %res2.0 = phi i32 [ 0, %entry ], [ %add10, %do.body ]
  %res3.0 = phi i32 [ 0, %entry ], [ %add16, %do.body ]
  %res4.0 = phi i32 [ 0, %entry ], [ %add22, %do.body ]
  %arrayidx = getelementptr inbounds i32, i32* %in1, i32 %i.0
  %3 = load i32, i32* %arrayidx, align 4, !tbaa !26
  %add = add nsw i32 %i.0, %shl
  %arrayidx3 = getelementptr inbounds i32, i32* %in2, i32 %add
  %4 = load i32, i32* %arrayidx3, align 4, !tbaa !26
  %mul = mul nsw i32 %4, %3
  %add4 = add nsw i32 %mul, %res1.0
  %add7 = add nsw i32 %add, 1
  %arrayidx8 = getelementptr inbounds i32, i32* %in2, i32 %add7
  %5 = load i32, i32* %arrayidx8, align 4, !tbaa !26
  %mul9 = mul nsw i32 %5, %3
  %add10 = add nsw i32 %mul9, %res2.0
  %add13 = add nsw i32 %add, 2
  %arrayidx14 = getelementptr inbounds i32, i32* %in2, i32 %add13
  %6 = load i32, i32* %arrayidx14, align 4, !tbaa !26
  %mul15 = mul nsw i32 %6, %3
  %add16 = add nsw i32 %mul15, %res3.0
  %add19 = add nsw i32 %add, 3
  %arrayidx20 = getelementptr inbounds i32, i32* %in2, i32 %add19
  %7 = load i32, i32* %arrayidx20, align 4, !tbaa !26
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
  store i32 %add4.lcssa, i32* %arrayidx23, align 4, !tbaa !26
  %add24 = or i32 %shl, 1
  %arrayidx25 = getelementptr inbounds i32, i32* %out, i32 %add24
  store i32 %add10.lcssa, i32* %arrayidx25, align 4, !tbaa !26
  %add26 = or i32 %shl, 2
  %arrayidx27 = getelementptr inbounds i32, i32* %out, i32 %add26
  store i32 %add16.lcssa, i32* %arrayidx27, align 4, !tbaa !26
  %add28 = or i32 %shl, 3
  %arrayidx29 = getelementptr inbounds i32, i32* %out, i32 %add28
  store i32 %add22.lcssa, i32* %arrayidx29, align 4, !tbaa !26
  ret void
}

; Function Attrs: nounwind
define void @xcorr_half(i16* nocapture readonly %in1, i16* nocapture readonly %in2, i16* nocapture %out) #1 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !23
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !24
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !25
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %res.0 = phi i32 [ 0, %entry ], [ %add4, %do.body ]
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %arrayidx = getelementptr inbounds i16, i16* %in1, i32 %i.0
  %3 = load i16, i16* %arrayidx, align 2, !tbaa !30
  %conv = sext i16 %3 to i32
  %add = add nsw i32 %i.0, %add.i
  %arrayidx2 = getelementptr inbounds i16, i16* %in2, i32 %add
  %4 = load i16, i16* %arrayidx2, align 2, !tbaa !30
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
  store i16 %conv6, i16* %arrayidx7, align 2, !tbaa !30
  ret void
}

; Function Attrs: nounwind
define void @xcorr_half_improved(<2 x i16>* nocapture readonly %in1, <2 x i16>* nocapture readonly %in2, <2 x i16>* nocapture %out) #1 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !23
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !24
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !25
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
define void @xcorr_byte(i8* nocapture readonly %in1, i8* nocapture readonly %in2, i8* nocapture %out) #1 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !23
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !24
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !25
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %res.0 = phi i32 [ 0, %entry ], [ %add4, %do.body ]
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %arrayidx = getelementptr inbounds i8, i8* %in1, i32 %i.0
  %3 = load i8, i8* %arrayidx, align 1, !tbaa !32
  %conv = sext i8 %3 to i32
  %add = add nsw i32 %i.0, %add.i
  %arrayidx2 = getelementptr inbounds i8, i8* %in2, i32 %add
  %4 = load i8, i8* %arrayidx2, align 1, !tbaa !32
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
  store i8 %conv6, i8* %arrayidx7, align 1, !tbaa !32
  ret void
}

; Function Attrs: nounwind
define void @xcorr_byte_improved(<4 x i8>* nocapture readonly %in1, <4 x i8>* nocapture readonly %in2, <4 x i8>* nocapture %out) #1 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !23
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !24
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !25
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

; Function Attrs: nounwind
define void @xcorr_float(float* nocapture readonly %in1, float* nocapture readonly %in2, float* nocapture %out) #1 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !23
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !24
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !25
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %res.0 = phi float [ 0.000000e+00, %entry ], [ %add3, %do.body ]
  %arrayidx = getelementptr inbounds float, float* %in1, i32 %i.0
  %3 = load float, float* %arrayidx, align 4, !tbaa !33
  %add = add nsw i32 %i.0, %add.i
  %arrayidx2 = getelementptr inbounds float, float* %in2, i32 %add
  %4 = load float, float* %arrayidx2, align 4, !tbaa !33
  %mul = fmul float %3, %4
  %add3 = fadd float %res.0, %mul
  %inc = add nuw nsw i32 %i.0, 1
  %cmp = icmp eq i32 %inc, %2
  br i1 %cmp, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %add3.lcssa = phi float [ %add3, %do.body ]
  %arrayidx4 = getelementptr inbounds float, float* %out, i32 %add.i
  store float %add3.lcssa, float* %arrayidx4, align 4, !tbaa !33
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @llvm.ctlz.i32(i32, i1) #2

attributes #0 = { nounwind readnone "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!opencl.kernels = !{!0, !6, !7, !10, !13, !16, !19}
!llvm.ident = !{!22}

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
!19 = !{void (float*, float*, float*)* @xcorr_float, !1, !2, !20, !21, !5}
!20 = !{!"kernel_arg_type", !"float*", !"float*", !"float*"}
!21 = !{!"kernel_arg_base_type", !"float*", !"float*", !"float*"}
!22 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
!23 = !{i32 14470}
!24 = !{i32 14610}
!25 = !{i32 14249}
!26 = !{!27, !27, i64 0}
!27 = !{!"int", !28, i64 0}
!28 = !{!"omnipotent char", !29, i64 0}
!29 = !{!"Simple C/C++ TBAA"}
!30 = !{!31, !31, i64 0}
!31 = !{!"short", !28, i64 0}
!32 = !{!28, !28, i64 0}
!33 = !{!34, !34, i64 0}
!34 = !{!"float", !28, i64 0}
