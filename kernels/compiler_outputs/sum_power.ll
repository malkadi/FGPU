; ModuleID = 'sum_power.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind
define void @sum_power(i32* nocapture readonly %in, i32* nocapture %out, i32 signext %reduce_factor, i32 signext %mean) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !14
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !15
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !16
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %begin.0 = phi i32 [ %add.i, %entry ], [ %add4, %do.body ]
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %sum.0 = phi i32 [ 0, %entry ], [ %add, %do.body ]
  %arrayidx = getelementptr inbounds i32, i32* %in, i32 %begin.0
  %3 = load i32, i32* %arrayidx, align 4, !tbaa !17
  %sub = sub nsw i32 %3, %mean
  %mul = mul nsw i32 %sub, %sub
  %add = add nsw i32 %mul, %sum.0
  %inc = add nuw nsw i32 %i.0, 1
  %add4 = add i32 %begin.0, %2
  %cmp = icmp eq i32 %inc, %reduce_factor
  br i1 %cmp, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %add.lcssa = phi i32 [ %add, %do.body ]
  %arrayidx5 = getelementptr inbounds i32, i32* %out, i32 %add.i
  store i32 %add.lcssa, i32* %arrayidx5, align 4, !tbaa !17
  ret void
}

; Function Attrs: nounwind
define void @sum_power_atomic(i32* nocapture readonly %in, i32* %out, i32 signext %reduce_factor) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !14
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !15
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !16
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %begin.0 = phi i32 [ %add.i, %entry ], [ %add4, %do.body ]
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %sum.0 = phi i32 [ 0, %entry ], [ %add, %do.body ]
  %arrayidx = getelementptr inbounds i32, i32* %in, i32 %begin.0
  %3 = load i32, i32* %arrayidx, align 4, !tbaa !17
  %sub = add nsw i32 %3, -100
  %mul = mul nsw i32 %sub, %sub
  %add = add nsw i32 %mul, %sum.0
  %inc = add nuw nsw i32 %i.0, 1
  %add4 = add i32 %begin.0, %2
  %cmp = icmp eq i32 %inc, %reduce_factor
  br i1 %cmp, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %add.lcssa = phi i32 [ %add, %do.body ]
  %4 = tail call i32 asm sideeffect "aadd $0, $1, r0", "=r,r,0,~{$1}"(i32* %out, i32 %add.lcssa) #1, !srcloc !21
  ret void
}

; Function Attrs: nounwind
define void @sum(i32* nocapture readonly %in, i32* nocapture %out, i32 signext %reduce_factor) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !14
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !15
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !16
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %begin.0 = phi i32 [ %add.i, %entry ], [ %add2, %do.body ]
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %sum.0 = phi i32 [ 0, %entry ], [ %add, %do.body ]
  %arrayidx = getelementptr inbounds i32, i32* %in, i32 %begin.0
  %3 = load i32, i32* %arrayidx, align 4, !tbaa !17
  %add = add nsw i32 %3, %sum.0
  %inc = add nuw nsw i32 %i.0, 1
  %add2 = add i32 %begin.0, %2
  %cmp = icmp eq i32 %inc, %reduce_factor
  br i1 %cmp, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %add.lcssa = phi i32 [ %add, %do.body ]
  %arrayidx3 = getelementptr inbounds i32, i32* %out, i32 %add.i
  store i32 %add.lcssa, i32* %arrayidx3, align 4, !tbaa !17
  ret void
}

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }

!opencl.kernels = !{!0, !6, !12}
!llvm.ident = !{!13}

!0 = !{void (i32*, i32*, i32, i32)* @sum_power, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"int*", !"int*", !"uint", !"int"}
!4 = !{!"kernel_arg_base_type", !"int*", !"int*", !"uint", !"int"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !"", !""}
!6 = !{void (i32*, i32*, i32)* @sum_power_atomic, !7, !8, !9, !10, !11}
!7 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0}
!8 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!9 = !{!"kernel_arg_type", !"int*", !"int*", !"uint"}
!10 = !{!"kernel_arg_base_type", !"int*", !"int*", !"uint"}
!11 = !{!"kernel_arg_type_qual", !"", !"", !""}
!12 = !{void (i32*, i32*, i32)* @sum, !7, !8, !9, !10, !11}
!13 = !{!"clang version 3.7.0 (tags/RELEASE_371/final)"}
!14 = !{i32 12376}
!15 = !{i32 12516}
!16 = !{i32 12155}
!17 = !{!18, !18, i64 0}
!18 = !{!"int", !19, i64 0}
!19 = !{!"omnipotent char", !20, i64 0}
!20 = !{!"Simple C/C++ TBAA"}
!21 = !{i32 12753}
