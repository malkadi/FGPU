; ModuleID = 'compass_edge_detection.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind
define void @compass_edge_detection(i32* nocapture readonly %in, i32* nocapture %amplitude, i32* nocapture %angle) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 1) #1, !srcloc !7
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 1) #1, !srcloc !8
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !7
  %3 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !8
  %add.i.253 = add nsw i32 %3, %2
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !9
  %cmp = icmp eq i32 %add.i, 0
  %conv = zext i1 %cmp to i32
  %cmp3 = icmp eq i32 %add.i.253, 0
  %conv4 = zext i1 %cmp3 to i32
  %or = or i32 %conv4, %conv
  %sub = add i32 %4, -2
  %cmp5 = icmp ugt i32 %add.i, %sub
  %conv6 = zext i1 %cmp5 to i32
  %or7 = or i32 %or, %conv6
  %cmp9 = icmp ugt i32 %add.i.253, %sub
  %conv10 = zext i1 %cmp9 to i32
  %or11 = or i32 %or7, %conv10
  %tobool = icmp eq i32 %or11, 0
  br i1 %tobool, label %if.end, label %cleanup

if.end:                                           ; preds = %entry
  %sub13 = add i32 %add.i, -1
  %mul = mul i32 %4, %sub13
  %add = add i32 %mul, %add.i.253
  %sub14 = add i32 %add, -1
  %arrayidx = getelementptr inbounds i32, i32* %in, i32 %sub14
  %5 = load i32, i32* %arrayidx, align 4, !tbaa !10
  %arrayidx18 = getelementptr inbounds i32, i32* %in, i32 %add
  %6 = load i32, i32* %arrayidx18, align 4, !tbaa !10
  %add22 = add i32 %add, 1
  %arrayidx23 = getelementptr inbounds i32, i32* %in, i32 %add22
  %7 = load i32, i32* %arrayidx23, align 4, !tbaa !10
  %mul24 = mul i32 %4, %add.i
  %add25 = add i32 %mul24, %add.i.253
  %sub26 = add i32 %add25, -1
  %arrayidx27 = getelementptr inbounds i32, i32* %in, i32 %sub26
  %8 = load i32, i32* %arrayidx27, align 4, !tbaa !10
  %add33 = add i32 %add25, 1
  %arrayidx34 = getelementptr inbounds i32, i32* %in, i32 %add33
  %9 = load i32, i32* %arrayidx34, align 4, !tbaa !10
  %add35 = add i32 %add.i, 1
  %mul36 = mul i32 %4, %add35
  %add37 = add i32 %mul36, %add.i.253
  %sub38 = add i32 %add37, -1
  %arrayidx39 = getelementptr inbounds i32, i32* %in, i32 %sub38
  %10 = load i32, i32* %arrayidx39, align 4, !tbaa !10
  %arrayidx43 = getelementptr inbounds i32, i32* %in, i32 %add37
  %11 = load i32, i32* %arrayidx43, align 4, !tbaa !10
  %add47 = add i32 %add37, 1
  %arrayidx48 = getelementptr inbounds i32, i32* %in, i32 %add47
  %12 = load i32, i32* %arrayidx48, align 4, !tbaa !10
  %tmp = sub i32 %9, %8
  %tmp254 = shl i32 %tmp, 1
  %add55 = sub i32 %7, %5
  %add59 = sub i32 %add55, %10
  %add61 = add i32 %add59, %12
  %add65 = add i32 %add61, %tmp254
  %tmp256 = sub i32 %12, %5
  %tmp257 = shl i32 %tmp256, 1
  %sum = add i32 %8, %6
  %add77 = sub i32 %9, %sum
  %add81 = add i32 %add77, %11
  %add83 = add i32 %add81, %tmp257
  %mul86 = shl i32 %6, 1
  %sum263 = add i32 %mul86, %5
  %sum264 = add i32 %sum263, %7
  %add97 = sub i32 %10, %sum264
  %mul98 = shl i32 %11, 1
  %add99 = add i32 %add97, %mul98
  %add101 = add i32 %add99, %12
  %mul106 = shl i32 %7, 1
  %sum265 = add i32 %mul106, %6
  %add109 = sub i32 %8, %sum265
  %sub113 = sub i32 %add109, %9
  %mul114 = shl i32 %10, 1
  %add115 = add i32 %sub113, %mul114
  %add117 = add i32 %add115, %11
  %sub122 = sub nsw i32 0, %add65
  %sub125 = sub nsw i32 0, %add83
  %sub128 = sub nsw i32 0, %add101
  %sub131 = sub nsw i32 0, %add117
  %cmp137 = icmp slt i32 %add83, %add65
  %max_val.0. = select i1 %cmp137, i32 %add65, i32 %add83
  %13 = zext i1 %cmp137 to i32
  %cond146 = xor i32 %13, 1
  %cmp137.1 = icmp slt i32 %add101, %max_val.0.
  %max_val.0..1 = select i1 %cmp137.1, i32 %max_val.0., i32 %add101
  %cmp137.2 = icmp slt i32 %add117, %max_val.0..1
  %max_val.0..2 = select i1 %cmp137.2, i32 %max_val.0..1, i32 %add117
  %cmp137.3 = icmp sgt i32 %max_val.0..2, %sub122
  %max_val.0..3 = select i1 %cmp137.3, i32 %max_val.0..2, i32 %sub122
  %cmp137.4 = icmp sgt i32 %max_val.0..3, %sub125
  %max_val.0..4 = select i1 %cmp137.4, i32 %max_val.0..3, i32 %sub125
  %cmp137.5 = icmp sgt i32 %max_val.0..4, %sub128
  %max_val.0..5 = select i1 %cmp137.5, i32 %max_val.0..4, i32 %sub128
  %cmp137.6 = icmp sgt i32 %max_val.0..5, %sub131
  %max_val.0..6 = select i1 %cmp137.6, i32 %max_val.0..5, i32 %sub131
  %arrayidx149 = getelementptr inbounds i32, i32* %amplitude, i32 %add25
  store i32 %max_val.0..6, i32* %arrayidx149, align 4, !tbaa !10
  %14 = sub nsw i32 0, %cond146
  %cond146.op = and i32 %14, 45
  %cond146.1.op = select i1 %cmp137.1, i32 %cond146.op, i32 90
  %cond146.2.op = select i1 %cmp137.2, i32 %cond146.1.op, i32 135
  %cond146.3.op = select i1 %cmp137.3, i32 %cond146.2.op, i32 180
  %cond146.4.op = select i1 %cmp137.4, i32 %cond146.3.op, i32 225
  %cond146.5.op = select i1 %cmp137.5, i32 %cond146.4.op, i32 270
  %mul150 = select i1 %cmp137.6, i32 %cond146.5.op, i32 315
  %arrayidx153 = getelementptr inbounds i32, i32* %angle, i32 %add25
  store i32 %mul150, i32* %arrayidx153, align 4, !tbaa !10
  br label %cleanup

cleanup:                                          ; preds = %entry, %if.end
  ret void
}

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (i32*, i32*, i32*)* @compass_edge_detection, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"uint*", !"uint*", !"uint*"}
!4 = !{!"kernel_arg_base_type", !"uint*", !"uint*", !"uint*"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !""}
!6 = !{!"clang version 3.7.0 (tags/RELEASE_371/final)"}
!7 = !{i32 12800}
!8 = !{i32 12940}
!9 = !{i32 12579}
!10 = !{!11, !11, i64 0}
!11 = !{!"int", !12, i64 0}
!12 = !{!"omnipotent char", !13, i64 0}
!13 = !{!"Simple C/C++ TBAA"}
