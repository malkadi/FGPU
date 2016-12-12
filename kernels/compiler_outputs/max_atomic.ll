; ModuleID = 'max_atomic.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind
define void @max_atomic(i32* nocapture readonly %in, i32* %out, i32 signext %reduce_factor) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !21
  %arrayidx = getelementptr inbounds i32, i32* %in, i32 %add.i
  %3 = load i32, i32* %arrayidx, align 4, !tbaa !22
  %cmp.23 = icmp eq i32 %reduce_factor, 1
  br i1 %cmp.23, label %for.end, label %for.body.preheader

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.body:                                         ; preds = %for.body.preheader, %for.body
  %add.i.pn = phi i32 [ %index.026, %for.body ], [ %add.i, %for.body.preheader ]
  %max_val.025 = phi i32 [ %.max_val.0, %for.body ], [ %3, %for.body.preheader ]
  %i.024 = phi i32 [ %inc, %for.body ], [ 1, %for.body.preheader ]
  %index.026 = add i32 %add.i.pn, %2
  %arrayidx2 = getelementptr inbounds i32, i32* %in, i32 %index.026
  %4 = load i32, i32* %arrayidx2, align 4, !tbaa !22
  %cmp3 = icmp slt i32 %max_val.025, %4
  %.max_val.0 = select i1 %cmp3, i32 %4, i32 %max_val.025
  %inc = add nuw nsw i32 %i.024, 1
  %cmp = icmp eq i32 %inc, %reduce_factor
  br i1 %cmp, label %for.end.loopexit, label %for.body

for.end.loopexit:                                 ; preds = %for.body
  %.max_val.0.lcssa = phi i32 [ %.max_val.0, %for.body ]
  br label %for.end

for.end:                                          ; preds = %for.end.loopexit, %entry
  %max_val.0.lcssa = phi i32 [ %3, %entry ], [ %.max_val.0.lcssa, %for.end.loopexit ]
  %5 = tail call i32 asm sideeffect "amax $0, $1, r0", "=r,r,0,~{$1}"(i32* %out, i32 %max_val.0.lcssa) #1, !srcloc !26
  ret void
}

; Function Attrs: nounwind
define void @max_half_atomic(i16* nocapture readonly %in, i16* %out, i32 signext %reduce_factor) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !21
  %arrayidx = getelementptr inbounds i16, i16* %in, i32 %add.i
  %3 = load i16, i16* %arrayidx, align 2, !tbaa !27
  %conv = sext i16 %3 to i32
  %cmp.27 = icmp eq i32 %reduce_factor, 1
  br i1 %cmp.27, label %for.end, label %for.body.preheader

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.body:                                         ; preds = %for.body.preheader, %for.body
  %add.i.pn = phi i32 [ %index.030, %for.body ], [ %add.i, %for.body.preheader ]
  %max_val.029 = phi i32 [ %conv4.max_val.0, %for.body ], [ %conv, %for.body.preheader ]
  %i.028 = phi i32 [ %inc, %for.body ], [ 1, %for.body.preheader ]
  %index.030 = add i32 %add.i.pn, %2
  %arrayidx3 = getelementptr inbounds i16, i16* %in, i32 %index.030
  %4 = load i16, i16* %arrayidx3, align 2, !tbaa !27
  %conv4 = sext i16 %4 to i32
  %cmp5 = icmp slt i32 %max_val.029, %conv4
  %conv4.max_val.0 = select i1 %cmp5, i32 %conv4, i32 %max_val.029
  %inc = add nuw nsw i32 %i.028, 1
  %cmp = icmp eq i32 %inc, %reduce_factor
  br i1 %cmp, label %for.end.loopexit, label %for.body

for.end.loopexit:                                 ; preds = %for.body
  %conv4.max_val.0.lcssa = phi i32 [ %conv4.max_val.0, %for.body ]
  br label %for.end

for.end:                                          ; preds = %for.end.loopexit, %entry
  %max_val.0.lcssa = phi i32 [ %conv, %entry ], [ %conv4.max_val.0.lcssa, %for.end.loopexit ]
  %5 = bitcast i16* %out to i32*
  %6 = tail call i32 asm sideeffect "amax $0, $1, r0", "=r,r,0,~{$1}"(i32* %5, i32 %max_val.0.lcssa) #1, !srcloc !26
  ret void
}

; Function Attrs: nounwind
define void @max_half_improved_atomic(<2 x i16>* nocapture readonly %in, i16* %out, i32 signext %reduce_factor) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !21
  %arrayidx = getelementptr inbounds <2 x i16>, <2 x i16>* %in, i32 %add.i
  %3 = load <2 x i16>, <2 x i16>* %arrayidx, align 4, !tbaa !29
  %4 = extractelement <2 x i16> %3, i32 0
  %5 = extractelement <2 x i16> %3, i32 1
  %cmp = icmp slt i16 %5, %4
  %.sink = select i1 %cmp, i16 %4, i16 %5
  %conv = sext i16 %.sink to i32
  %div = lshr i32 %reduce_factor, 1
  %cmp7.49 = icmp ugt i32 %reduce_factor, 3
  br i1 %cmp7.49, label %for.body.preheader, label %for.end

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.052 = phi i32 [ %inc, %for.body ], [ 1, %for.body.preheader ]
  %max_val.051 = phi i32 [ %cond25, %for.body ], [ %conv, %for.body.preheader ]
  %begin.050 = phi i32 [ %add, %for.body ], [ %add.i, %for.body.preheader ]
  %add = add i32 %begin.050, %2
  %arrayidx9 = getelementptr inbounds <2 x i16>, <2 x i16>* %in, i32 %add
  %6 = load <2 x i16>, <2 x i16>* %arrayidx9, align 4, !tbaa !29
  %7 = extractelement <2 x i16> %6, i32 0
  %conv10 = sext i16 %7 to i32
  %cmp11 = icmp slt i32 %conv10, %max_val.051
  %max_val.0.conv10 = select i1 %cmp11, i32 %max_val.051, i32 %conv10
  %8 = extractelement <2 x i16> %6, i32 1
  %conv18 = sext i16 %8 to i32
  %cmp19 = icmp slt i32 %conv18, %max_val.0.conv10
  %cond25 = select i1 %cmp19, i32 %max_val.0.conv10, i32 %conv18
  %inc = add nuw nsw i32 %i.052, 1
  %cmp7 = icmp ult i32 %inc, %div
  br i1 %cmp7, label %for.body, label %for.end.loopexit

for.end.loopexit:                                 ; preds = %for.body
  %cond25.lcssa = phi i32 [ %cond25, %for.body ]
  br label %for.end

for.end:                                          ; preds = %for.end.loopexit, %entry
  %max_val.0.lcssa = phi i32 [ %conv, %entry ], [ %cond25.lcssa, %for.end.loopexit ]
  %9 = bitcast i16* %out to i32*
  %10 = tail call i32 asm sideeffect "amax $0, $1, r0", "=r,r,0,~{$1}"(i32* %9, i32 %max_val.0.lcssa) #1, !srcloc !26
  ret void
}

; Function Attrs: nounwind
define void @max_byte_atomic(i8* nocapture readonly %in, i8* %out, i32 signext %reduce_factor) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !21
  %arrayidx = getelementptr inbounds i8, i8* %in, i32 %add.i
  %3 = load i8, i8* %arrayidx, align 1, !tbaa !29
  %conv = sext i8 %3 to i32
  %cmp.27 = icmp eq i32 %reduce_factor, 1
  br i1 %cmp.27, label %for.end, label %for.body.preheader

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.body:                                         ; preds = %for.body.preheader, %for.body
  %add.i.pn = phi i32 [ %index.030, %for.body ], [ %add.i, %for.body.preheader ]
  %max_val.029 = phi i32 [ %conv4.max_val.0, %for.body ], [ %conv, %for.body.preheader ]
  %i.028 = phi i32 [ %inc, %for.body ], [ 1, %for.body.preheader ]
  %index.030 = add i32 %add.i.pn, %2
  %arrayidx3 = getelementptr inbounds i8, i8* %in, i32 %index.030
  %4 = load i8, i8* %arrayidx3, align 1, !tbaa !29
  %conv4 = sext i8 %4 to i32
  %cmp5 = icmp slt i32 %max_val.029, %conv4
  %conv4.max_val.0 = select i1 %cmp5, i32 %conv4, i32 %max_val.029
  %inc = add nuw nsw i32 %i.028, 1
  %cmp = icmp eq i32 %inc, %reduce_factor
  br i1 %cmp, label %for.end.loopexit, label %for.body

for.end.loopexit:                                 ; preds = %for.body
  %conv4.max_val.0.lcssa = phi i32 [ %conv4.max_val.0, %for.body ]
  br label %for.end

for.end:                                          ; preds = %for.end.loopexit, %entry
  %max_val.0.lcssa = phi i32 [ %conv, %entry ], [ %conv4.max_val.0.lcssa, %for.end.loopexit ]
  %5 = bitcast i8* %out to i32*
  %6 = tail call i32 asm sideeffect "amax $0, $1, r0", "=r,r,0,~{$1}"(i32* %5, i32 %max_val.0.lcssa) #1, !srcloc !26
  ret void
}

; Function Attrs: nounwind
define void @max_byte_improved_atomic(<4 x i8>* nocapture readonly %in, i8* %out, i32 signext %reduce_factor) #0 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !21
  %arrayidx = getelementptr inbounds <4 x i8>, <4 x i8>* %in, i32 %add.i
  %3 = load <4 x i8>, <4 x i8>* %arrayidx, align 4, !tbaa !29
  %4 = extractelement <4 x i8> %3, i32 0
  %5 = extractelement <4 x i8> %3, i32 1
  %cmp = icmp slt i8 %5, %4
  %.sink = select i1 %cmp, i8 %4, i8 %5
  %conv = sext i8 %.sink to i32
  %6 = extractelement <4 x i8> %3, i32 2
  %conv6 = sext i8 %6 to i32
  %cmp7 = icmp slt i32 %conv6, %conv
  %conv.conv6 = select i1 %cmp7, i32 %conv, i32 %conv6
  %7 = extractelement <4 x i8> %3, i32 3
  %conv14 = sext i8 %7 to i32
  %cmp15 = icmp slt i32 %conv14, %conv.conv6
  %cond21 = select i1 %cmp15, i32 %conv.conv6, i32 %conv14
  %div = lshr i32 %reduce_factor, 2
  %cmp23.97 = icmp ugt i32 %reduce_factor, 7
  br i1 %cmp23.97, label %for.body.preheader, label %for.end

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.0100 = phi i32 [ %inc, %for.body ], [ 1, %for.body.preheader ]
  %max_val.099 = phi i32 [ %cond57, %for.body ], [ %cond21, %for.body.preheader ]
  %begin.098 = phi i32 [ %add, %for.body ], [ %add.i, %for.body.preheader ]
  %add = add i32 %begin.098, %2
  %arrayidx25 = getelementptr inbounds <4 x i8>, <4 x i8>* %in, i32 %add
  %8 = load <4 x i8>, <4 x i8>* %arrayidx25, align 4, !tbaa !29
  %9 = extractelement <4 x i8> %8, i32 0
  %conv26 = sext i8 %9 to i32
  %cmp27 = icmp slt i32 %conv26, %max_val.099
  %max_val.0.conv26 = select i1 %cmp27, i32 %max_val.099, i32 %conv26
  %10 = extractelement <4 x i8> %8, i32 1
  %conv34 = sext i8 %10 to i32
  %cmp35 = icmp slt i32 %conv34, %max_val.0.conv26
  %cond41 = select i1 %cmp35, i32 %max_val.0.conv26, i32 %conv34
  %11 = extractelement <4 x i8> %8, i32 2
  %conv42 = sext i8 %11 to i32
  %cmp43 = icmp slt i32 %conv42, %cond41
  %cond41.conv42 = select i1 %cmp43, i32 %cond41, i32 %conv42
  %12 = extractelement <4 x i8> %8, i32 3
  %conv50 = sext i8 %12 to i32
  %cmp51 = icmp slt i32 %conv50, %cond41.conv42
  %cond57 = select i1 %cmp51, i32 %cond41.conv42, i32 %conv50
  %inc = add nuw nsw i32 %i.0100, 1
  %cmp23 = icmp ult i32 %inc, %div
  br i1 %cmp23, label %for.body, label %for.end.loopexit

for.end.loopexit:                                 ; preds = %for.body
  %cond57.lcssa = phi i32 [ %cond57, %for.body ]
  br label %for.end

for.end:                                          ; preds = %for.end.loopexit, %entry
  %max_val.0.lcssa = phi i32 [ %cond21, %entry ], [ %cond57.lcssa, %for.end.loopexit ]
  %13 = bitcast i8* %out to i32*
  %14 = tail call i32 asm sideeffect "amax $0, $1, r0", "=r,r,0,~{$1}"(i32* %13, i32 %max_val.0.lcssa) #1, !srcloc !26
  ret void
}

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }

!opencl.kernels = !{!0, !6, !9, !12, !15}
!llvm.ident = !{!18}

!0 = !{void (i32*, i32*, i32)* @max_atomic, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"int*", !"int*", !"uint"}
!4 = !{!"kernel_arg_base_type", !"int*", !"int*", !"uint"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !""}
!6 = !{void (i16*, i16*, i32)* @max_half_atomic, !1, !2, !7, !8, !5}
!7 = !{!"kernel_arg_type", !"short*", !"short*", !"uint"}
!8 = !{!"kernel_arg_base_type", !"short*", !"short*", !"uint"}
!9 = !{void (<2 x i16>*, i16*, i32)* @max_half_improved_atomic, !1, !2, !10, !11, !5}
!10 = !{!"kernel_arg_type", !"short2*", !"short*", !"uint"}
!11 = !{!"kernel_arg_base_type", !"short __attribute__((ext_vector_type(2)))*", !"short*", !"uint"}
!12 = !{void (i8*, i8*, i32)* @max_byte_atomic, !1, !2, !13, !14, !5}
!13 = !{!"kernel_arg_type", !"char*", !"char*", !"uint"}
!14 = !{!"kernel_arg_base_type", !"char*", !"char*", !"uint"}
!15 = !{void (<4 x i8>*, i8*, i32)* @max_byte_improved_atomic, !1, !2, !16, !17, !5}
!16 = !{!"kernel_arg_type", !"char4*", !"char*", !"uint"}
!17 = !{!"kernel_arg_base_type", !"char __attribute__((ext_vector_type(4)))*", !"char*", !"uint"}
!18 = !{!"clang version 3.7.0 (tags/RELEASE_371/final)"}
!19 = !{i32 13775}
!20 = !{i32 13915}
!21 = !{i32 13554}
!22 = !{!23, !23, i64 0}
!23 = !{!"int", !24, i64 0}
!24 = !{!"omnipotent char", !25, i64 0}
!25 = !{!"Simple C/C++ TBAA"}
!26 = !{i32 14384}
!27 = !{!28, !28, i64 0}
!28 = !{!"short", !24, i64 0}
!29 = !{!24, !24, i64 0}
