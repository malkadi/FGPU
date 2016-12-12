; ModuleID = 'div.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind readnone
define i32 @__udivsi3(i32 signext %a, i32 signext %b) #0 {
entry:
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %h.0 = phi i32 [ %a, %entry ], [ %cond5, %do.body ]
  %l.0 = phi i32 [ 0, %entry ], [ %cond, %do.body ]
  %add = add i32 %l.0, %h.0
  %div = lshr i32 %add, 1
  %mul = mul i32 %div, %b
  %cmp = icmp ugt i32 %mul, %a
  %cond = select i1 %cmp, i32 %l.0, i32 %div
  %cond5 = select i1 %cmp, i32 %div, i32 %h.0
  %sub = sub i32 %cond5, %cond
  %cmp6 = icmp ugt i32 %sub, 1
  br i1 %cmp6, label %do.body, label %do.end

do.end:                                           ; preds = %do.body
  %cond.lcssa = phi i32 [ %cond, %do.body ]
  ret i32 %cond.lcssa
}

; Function Attrs: nounwind readnone
define i32 @__divsi3(i32 signext %a, i32 signext %b) #0 {
entry:
  %cmp = icmp slt i32 %a, 0
  %sub = sub nsw i32 0, %a
  %cond = select i1 %cmp, i32 %sub, i32 %a
  %cmp1 = icmp slt i32 %b, 0
  %sub3 = sub nsw i32 0, %b
  %cond6 = select i1 %cmp1, i32 %sub3, i32 %b
  %0 = and i32 %b, %a
  %1 = icmp slt i32 %0, 0
  %2 = or i32 %b, %a
  %3 = icmp sgt i32 %2, -1
  %4 = or i1 %1, %3
  %div = udiv i32 %cond, %cond6
  %sub13 = sub i32 0, %div
  %cond15 = select i1 %4, i32 %div, i32 %sub13
  ret i32 %cond15
}

; Function Attrs: nounwind
define void @div_int(i32* nocapture readonly %in, i32* nocapture %out, i32 signext %val) #1 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !7
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !8
  %add.i = add nsw i32 %1, %0
  %arrayidx = getelementptr inbounds i32, i32* %in, i32 %add.i
  %2 = load i32, i32* %arrayidx, align 4, !tbaa !9
  %div = sdiv i32 %2, %val
  %arrayidx1 = getelementptr inbounds i32, i32* %out, i32 %add.i
  store i32 %div, i32* %arrayidx1, align 4, !tbaa !9
  ret void
}

attributes #0 = { nounwind readnone "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (i32*, i32*, i32)* @div_int, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"int*", !"int*", !"int"}
!4 = !{!"kernel_arg_base_type", !"int*", !"int*", !"int"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !""}
!6 = !{!"clang version 3.7.0 (tags/RELEASE_371/final)"}
!7 = !{i32 11993}
!8 = !{i32 12133}
!9 = !{!10, !10, i64 0}
!10 = !{!"int", !11, i64 0}
!11 = !{!"omnipotent char", !12, i64 0}
!12 = !{!"Simple C/C++ TBAA"}
