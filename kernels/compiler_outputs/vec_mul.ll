; ModuleID = 'vec_mul.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

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
define void @vec_mul(i32* nocapture readonly %in1, i32* nocapture readonly %in2, i32* nocapture %out) #1 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !7
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !8
  %add.i = add nsw i32 %1, %0
  %arrayidx = getelementptr inbounds i32, i32* %in1, i32 %add.i
  %2 = load i32, i32* %arrayidx, align 4, !tbaa !9
  %arrayidx1 = getelementptr inbounds i32, i32* %in2, i32 %add.i
  %3 = load i32, i32* %arrayidx1, align 4, !tbaa !9
  %mul = mul nsw i32 %3, %2
  %arrayidx2 = getelementptr inbounds i32, i32* %out, i32 %add.i
  store i32 %mul, i32* %arrayidx2, align 4, !tbaa !9
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

!0 = !{void (i32*, i32*, i32*)* @vec_mul, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"int*", !"int*", !"int*"}
!4 = !{!"kernel_arg_base_type", !"int*", !"int*", !"int*"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !""}
!6 = !{!"clang version 3.7.0 (tags/RELEASE_371/final)"}
!7 = !{i32 12486}
!8 = !{i32 12626}
!9 = !{!10, !10, i64 0}
!10 = !{!"int", !11, i64 0}
!11 = !{!"omnipotent char", !12, i64 0}
!12 = !{!"Simple C/C++ TBAA"}
