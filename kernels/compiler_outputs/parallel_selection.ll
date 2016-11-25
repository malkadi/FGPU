; ModuleID = 'parallel_selection.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind
define void @ParallelSelection(i32* nocapture readonly %in, i32* nocapture %out) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !21
  %arrayidx = getelementptr inbounds i32, i32* %in, i32 %add.i
  %3 = load i32, i32* %arrayidx, align 4, !tbaa !22
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %j.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %pos.0 = phi i32 [ 0, %entry ], [ %add, %do.body ]
  %arrayidx2 = getelementptr inbounds i32, i32* %in, i32 %j.0
  %4 = load i32, i32* %arrayidx2, align 4, !tbaa !22
  %cmp = icmp slt i32 %4, %3
  %cmp3 = icmp eq i32 %4, %3
  %cmp4 = icmp slt i32 %j.0, %add.i
  %cmp4. = and i1 %cmp4, %cmp3
  %5 = or i1 %cmp, %cmp4.
  %lor.ext = zext i1 %5 to i32
  %add = add nsw i32 %lor.ext, %pos.0
  %inc = add nuw nsw i32 %j.0, 1
  %cmp7 = icmp eq i32 %inc, %2
  br i1 %cmp7, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %add.lcssa = phi i32 [ %add, %do.body ]
  %arrayidx8 = getelementptr inbounds i32, i32* %out, i32 %add.lcssa
  store i32 %3, i32* %arrayidx8, align 4, !tbaa !22
  ret void
}

; Function Attrs: nounwind
define void @ParallelSelection_half(i16* nocapture readonly %in, i16* nocapture %out) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !21
  %arrayidx = getelementptr inbounds i16, i16* %in, i32 %add.i
  %3 = load i16, i16* %arrayidx, align 2, !tbaa !26
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %j.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %pos.0 = phi i32 [ 0, %entry ], [ %add, %do.body ]
  %arrayidx2 = getelementptr inbounds i16, i16* %in, i32 %j.0
  %4 = load i16, i16* %arrayidx2, align 2, !tbaa !26
  %cmp = icmp slt i16 %4, %3
  %cmp5 = icmp eq i16 %4, %3
  %cmp7 = icmp slt i32 %j.0, %add.i
  %cmp7. = and i1 %cmp7, %cmp5
  %5 = or i1 %cmp, %cmp7.
  %lor.ext = zext i1 %5 to i32
  %add = add nsw i32 %lor.ext, %pos.0
  %inc = add nuw nsw i32 %j.0, 1
  %cmp13 = icmp eq i32 %inc, %2
  br i1 %cmp13, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %add.lcssa = phi i32 [ %add, %do.body ]
  %arrayidx16 = getelementptr inbounds i16, i16* %out, i32 %add.lcssa
  store i16 %3, i16* %arrayidx16, align 2, !tbaa !26
  ret void
}

; Function Attrs: nounwind
define void @ParallelSelection_half_improved(<2 x i16>* nocapture readonly %in, i16* nocapture %out) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !21
  %arrayidx = getelementptr inbounds <2 x i16>, <2 x i16>* %in, i32 0, i32 %add.i
  %3 = load i16, i16* %arrayidx, align 2, !tbaa !26
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %j.0 = phi i32 [ 0, %entry ], [ %inc35, %do.body ]
  %pos.0 = phi i32 [ 0, %entry ], [ %add34, %do.body ]
  %shr = ashr exact i32 %j.0, 1
  %arrayidx2 = getelementptr inbounds <2 x i16>, <2 x i16>* %in, i32 %shr
  %4 = load <2 x i16>, <2 x i16>* %arrayidx2, align 4, !tbaa !28
  %5 = extractelement <2 x i16> %4, i32 0
  %cmp = icmp slt i16 %5, %3
  %cmp8 = icmp eq i16 %5, %3
  %cmp10 = icmp slt i32 %j.0, %add.i
  %cmp10. = and i1 %cmp10, %cmp8
  %6 = or i1 %cmp, %cmp10.
  %lor.ext = zext i1 %6 to i32
  %add = add nsw i32 %lor.ext, %pos.0
  %7 = extractelement <2 x i16> %4, i32 1
  %cmp17 = icmp slt i16 %7, %3
  %cmp20 = icmp eq i16 %7, %3
  %inc = or i32 %j.0, 1
  %cmp23 = icmp slt i32 %inc, %add.i
  %8 = and i1 %cmp23, %cmp20
  %9 = or i1 %cmp17, %8
  %lor.ext33 = zext i1 %9 to i32
  %add34 = add nsw i32 %add, %lor.ext33
  %inc35 = add nuw nsw i32 %j.0, 2
  %cmp36 = icmp eq i32 %inc35, %2
  br i1 %cmp36, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %add34.lcssa = phi i32 [ %add34, %do.body ]
  %arrayidx39 = getelementptr inbounds i16, i16* %out, i32 %add34.lcssa
  store i16 %3, i16* %arrayidx39, align 2, !tbaa !26
  ret void
}

; Function Attrs: nounwind
define void @ParallelSelection_byte_improved(<4 x i8>* nocapture readonly %in, i8* nocapture %out) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !21
  %arrayidx = getelementptr inbounds <4 x i8>, <4 x i8>* %in, i32 0, i32 %add.i
  %3 = load i8, i8* %arrayidx, align 1, !tbaa !28
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %j.0 = phi i32 [ 0, %entry ], [ %inc75, %do.body ]
  %pos.0 = phi i32 [ 0, %entry ], [ %add74, %do.body ]
  %shr = ashr exact i32 %j.0, 2
  %arrayidx2 = getelementptr inbounds <4 x i8>, <4 x i8>* %in, i32 %shr
  %4 = load <4 x i8>, <4 x i8>* %arrayidx2, align 4, !tbaa !28
  %5 = extractelement <4 x i8> %4, i32 0
  %cmp = icmp slt i8 %5, %3
  %cmp8 = icmp eq i8 %5, %3
  %cmp10 = icmp slt i32 %j.0, %add.i
  %cmp10. = and i1 %cmp10, %cmp8
  %6 = or i1 %cmp, %cmp10.
  %lor.ext = zext i1 %6 to i32
  %add = add nsw i32 %lor.ext, %pos.0
  %7 = extractelement <4 x i8> %4, i32 1
  %cmp17 = icmp slt i8 %7, %3
  %cmp20 = icmp eq i8 %7, %3
  %inc = or i32 %j.0, 1
  %cmp23 = icmp slt i32 %inc, %add.i
  %8 = and i1 %cmp23, %cmp20
  %9 = or i1 %cmp17, %8
  %lor.ext33 = zext i1 %9 to i32
  %add34 = add nsw i32 %add, %lor.ext33
  %10 = extractelement <4 x i8> %4, i32 2
  %cmp37 = icmp slt i8 %10, %3
  %cmp40 = icmp eq i8 %10, %3
  %inc35 = or i32 %j.0, 2
  %cmp43 = icmp slt i32 %inc35, %add.i
  %11 = and i1 %cmp43, %cmp40
  %12 = or i1 %cmp37, %11
  %lor.ext53 = zext i1 %12 to i32
  %add54 = add nsw i32 %add34, %lor.ext53
  %13 = extractelement <4 x i8> %4, i32 3
  %cmp57 = icmp slt i8 %13, %3
  %cmp60 = icmp eq i8 %13, %3
  %inc55 = or i32 %j.0, 3
  %cmp63 = icmp slt i32 %inc55, %add.i
  %14 = and i1 %cmp63, %cmp60
  %15 = or i1 %cmp57, %14
  %lor.ext73 = zext i1 %15 to i32
  %add74 = add nsw i32 %add54, %lor.ext73
  %inc75 = add nuw nsw i32 %j.0, 4
  %cmp76 = icmp eq i32 %inc75, %2
  br i1 %cmp76, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %add74.lcssa = phi i32 [ %add74, %do.body ]
  %arrayidx79 = getelementptr inbounds i8, i8* %out, i32 %add74.lcssa
  store i8 %3, i8* %arrayidx79, align 1, !tbaa !28
  ret void
}

; Function Attrs: nounwind
define void @ParallelSelection_byte(i8* nocapture readonly %in, i8* nocapture %out) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !21
  %arrayidx = getelementptr inbounds i8, i8* %in, i32 %add.i
  %3 = load i8, i8* %arrayidx, align 1, !tbaa !28
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %j.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %pos.0 = phi i32 [ 0, %entry ], [ %add, %do.body ]
  %arrayidx2 = getelementptr inbounds i8, i8* %in, i32 %j.0
  %4 = load i8, i8* %arrayidx2, align 1, !tbaa !28
  %cmp = icmp slt i8 %4, %3
  %cmp5 = icmp eq i8 %4, %3
  %cmp7 = icmp slt i32 %j.0, %add.i
  %cmp7. = and i1 %cmp7, %cmp5
  %5 = or i1 %cmp, %cmp7.
  %lor.ext = zext i1 %5 to i32
  %add = add nsw i32 %lor.ext, %pos.0
  %inc = add nuw nsw i32 %j.0, 1
  %cmp13 = icmp eq i32 %inc, %2
  br i1 %cmp13, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %add.lcssa = phi i32 [ %add, %do.body ]
  %arrayidx16 = getelementptr inbounds i8, i8* %out, i32 %add.lcssa
  store i8 %3, i8* %arrayidx16, align 1, !tbaa !28
  ret void
}

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }

!opencl.kernels = !{!0, !6, !9, !12, !15}
!llvm.ident = !{!18}

!0 = !{void (i32*, i32*)* @ParallelSelection, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"int*", !"int*"}
!4 = !{!"kernel_arg_base_type", !"int*", !"int*"}
!5 = !{!"kernel_arg_type_qual", !"", !""}
!6 = !{void (i16*, i16*)* @ParallelSelection_half, !1, !2, !7, !8, !5}
!7 = !{!"kernel_arg_type", !"short*", !"short*"}
!8 = !{!"kernel_arg_base_type", !"short*", !"short*"}
!9 = !{void (<2 x i16>*, i16*)* @ParallelSelection_half_improved, !1, !2, !10, !11, !5}
!10 = !{!"kernel_arg_type", !"short2*", !"short*"}
!11 = !{!"kernel_arg_base_type", !"short __attribute__((ext_vector_type(2)))*", !"short*"}
!12 = !{void (<4 x i8>*, i8*)* @ParallelSelection_byte_improved, !1, !2, !13, !14, !5}
!13 = !{!"kernel_arg_type", !"char4*", !"char*"}
!14 = !{!"kernel_arg_base_type", !"char __attribute__((ext_vector_type(4)))*", !"char*"}
!15 = !{void (i8*, i8*)* @ParallelSelection_byte, !1, !2, !16, !17, !5}
!16 = !{!"kernel_arg_type", !"char*", !"char*"}
!17 = !{!"kernel_arg_base_type", !"char*", !"char*"}
!18 = !{!"clang version 3.7.0 (tags/RELEASE_371/final)"}
!19 = !{i32 14396}
!20 = !{i32 14536}
!21 = !{i32 14175}
!22 = !{!23, !23, i64 0}
!23 = !{!"int", !24, i64 0}
!24 = !{!"omnipotent char", !25, i64 0}
!25 = !{!"Simple C/C++ TBAA"}
!26 = !{!27, !27, i64 0}
!27 = !{!"short", !24, i64 0}
!28 = !{!24, !24, i64 0}
