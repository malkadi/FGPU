; ModuleID = 'parallel_selection.cl'
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

; Function Attrs: nounwind
define void @ParallelSelection(i32* nocapture readonly %in, i32* nocapture %out) #1 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !22
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !23
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !24
  %arrayidx = getelementptr inbounds i32, i32* %in, i32 %add.i
  %3 = load i32, i32* %arrayidx, align 4, !tbaa !25
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %j.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %pos.0 = phi i32 [ 0, %entry ], [ %add, %do.body ]
  %arrayidx2 = getelementptr inbounds i32, i32* %in, i32 %j.0
  %4 = load i32, i32* %arrayidx2, align 4, !tbaa !25
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
  store i32 %3, i32* %arrayidx8, align 4, !tbaa !25
  ret void
}

; Function Attrs: nounwind
define void @ParallelSelection_half(i16* nocapture readonly %in, i16* nocapture %out) #1 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !22
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !23
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !24
  %arrayidx = getelementptr inbounds i16, i16* %in, i32 %add.i
  %3 = load i16, i16* %arrayidx, align 2, !tbaa !29
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %j.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %pos.0 = phi i32 [ 0, %entry ], [ %add, %do.body ]
  %arrayidx2 = getelementptr inbounds i16, i16* %in, i32 %j.0
  %4 = load i16, i16* %arrayidx2, align 2, !tbaa !29
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
  store i16 %3, i16* %arrayidx16, align 2, !tbaa !29
  ret void
}

; Function Attrs: nounwind
define void @ParallelSelection_half_improved(<2 x i16>* nocapture readonly %in, i16* nocapture %out) #1 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !22
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !23
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !24
  %arrayidx = getelementptr inbounds <2 x i16>, <2 x i16>* %in, i32 0, i32 %add.i
  %3 = load i16, i16* %arrayidx, align 2, !tbaa !29
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %j.0 = phi i32 [ 0, %entry ], [ %inc35, %do.body ]
  %pos.0 = phi i32 [ 0, %entry ], [ %add34, %do.body ]
  %shr = ashr exact i32 %j.0, 1
  %arrayidx2 = getelementptr inbounds <2 x i16>, <2 x i16>* %in, i32 %shr
  %4 = load <2 x i16>, <2 x i16>* %arrayidx2, align 4, !tbaa !31
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
  store i16 %3, i16* %arrayidx39, align 2, !tbaa !29
  ret void
}

; Function Attrs: nounwind
define void @ParallelSelection_byte_improved(<4 x i8>* nocapture readonly %in, i8* nocapture %out) #1 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !22
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !23
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !24
  %arrayidx = getelementptr inbounds <4 x i8>, <4 x i8>* %in, i32 0, i32 %add.i
  %3 = load i8, i8* %arrayidx, align 1, !tbaa !31
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %j.0 = phi i32 [ 0, %entry ], [ %inc75, %do.body ]
  %pos.0 = phi i32 [ 0, %entry ], [ %add74, %do.body ]
  %shr = lshr exact i32 %j.0, 2
  %arrayidx2 = getelementptr inbounds <4 x i8>, <4 x i8>* %in, i32 %shr
  %4 = load <4 x i8>, <4 x i8>* %arrayidx2, align 4, !tbaa !31
  %5 = extractelement <4 x i8> %4, i32 0
  %cmp = icmp ult i8 %5, %3
  %cmp8 = icmp eq i8 %5, %3
  %cmp10 = icmp ult i32 %j.0, %add.i
  %cmp10. = and i1 %cmp10, %cmp8
  %6 = or i1 %cmp, %cmp10.
  %lor.ext = zext i1 %6 to i32
  %add = add i32 %lor.ext, %pos.0
  %7 = extractelement <4 x i8> %4, i32 1
  %cmp17 = icmp ult i8 %7, %3
  %cmp20 = icmp eq i8 %7, %3
  %inc = or i32 %j.0, 1
  %cmp23 = icmp ult i32 %inc, %add.i
  %8 = and i1 %cmp23, %cmp20
  %9 = or i1 %cmp17, %8
  %lor.ext33 = zext i1 %9 to i32
  %add34 = add i32 %add, %lor.ext33
  %10 = extractelement <4 x i8> %4, i32 2
  %cmp37 = icmp ult i8 %10, %3
  %cmp40 = icmp eq i8 %10, %3
  %inc35 = or i32 %j.0, 2
  %cmp43 = icmp ult i32 %inc35, %add.i
  %11 = and i1 %cmp43, %cmp40
  %12 = or i1 %cmp37, %11
  %lor.ext53 = zext i1 %12 to i32
  %add54 = add i32 %add34, %lor.ext53
  %13 = extractelement <4 x i8> %4, i32 3
  %cmp57 = icmp ult i8 %13, %3
  %cmp60 = icmp eq i8 %13, %3
  %inc55 = or i32 %j.0, 3
  %cmp63 = icmp ult i32 %inc55, %add.i
  %14 = and i1 %cmp63, %cmp60
  %15 = or i1 %cmp57, %14
  %lor.ext73 = zext i1 %15 to i32
  %add74 = add i32 %add54, %lor.ext73
  %inc75 = add i32 %j.0, 4
  %cmp76 = icmp eq i32 %inc75, %2
  br i1 %cmp76, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %add74.lcssa = phi i32 [ %add74, %do.body ]
  %arrayidx79 = getelementptr inbounds i8, i8* %out, i32 %add74.lcssa
  store i8 %3, i8* %arrayidx79, align 1, !tbaa !31
  ret void
}

; Function Attrs: nounwind
define void @ParallelSelection_byte(i8* nocapture readonly %in, i8* nocapture %out) #1 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !22
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !23
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !24
  %arrayidx = getelementptr inbounds i8, i8* %in, i32 %add.i
  %3 = load i8, i8* %arrayidx, align 1, !tbaa !31
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %j.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %pos.0 = phi i32 [ 0, %entry ], [ %add, %do.body ]
  %arrayidx2 = getelementptr inbounds i8, i8* %in, i32 %j.0
  %4 = load i8, i8* %arrayidx2, align 1, !tbaa !31
  %cmp = icmp ult i8 %4, %3
  %cmp5 = icmp eq i8 %4, %3
  %cmp7 = icmp ult i32 %j.0, %add.i
  %cmp7. = and i1 %cmp7, %cmp5
  %5 = or i1 %cmp, %cmp7.
  %lor.ext = zext i1 %5 to i32
  %add = add i32 %lor.ext, %pos.0
  %inc = add i32 %j.0, 1
  %cmp13 = icmp eq i32 %inc, %2
  br i1 %cmp13, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %add.lcssa = phi i32 [ %add, %do.body ]
  %arrayidx16 = getelementptr inbounds i8, i8* %out, i32 %add.lcssa
  store i8 %3, i8* %arrayidx16, align 1, !tbaa !31
  ret void
}

; Function Attrs: nounwind
define void @ParallelSelection_float(float* nocapture readonly %in, float* nocapture %out) #1 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !22
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !23
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #2, !srcloc !24
  %arrayidx = getelementptr inbounds float, float* %in, i32 %add.i
  %3 = load float, float* %arrayidx, align 4, !tbaa !32
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %j.0 = phi i32 [ 0, %entry ], [ %inc, %do.body ]
  %pos.0 = phi i32 [ 0, %entry ], [ %add, %do.body ]
  %arrayidx2 = getelementptr inbounds float, float* %in, i32 %j.0
  %4 = load float, float* %arrayidx2, align 4, !tbaa !32
  %cmp = fcmp olt float %4, %3
  %cmp3 = fcmp oeq float %4, %3
  %cmp4 = icmp slt i32 %j.0, %add.i
  %5 = and i1 %cmp4, %cmp3
  %6 = or i1 %cmp, %5
  %lor.ext = zext i1 %6 to i32
  %add = add nsw i32 %lor.ext, %pos.0
  %inc = add nuw nsw i32 %j.0, 1
  %cmp7 = icmp eq i32 %inc, %2
  br i1 %cmp7, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %add.lcssa = phi i32 [ %add, %do.body ]
  %arrayidx8 = getelementptr inbounds float, float* %out, i32 %add.lcssa
  store float %3, float* %arrayidx8, align 4, !tbaa !32
  ret void
}

attributes #0 = { nounwind readnone "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !6, !9, !12, !15, !18}
!llvm.ident = !{!21}

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
!13 = !{!"kernel_arg_type", !"uchar4*", !"uchar*"}
!14 = !{!"kernel_arg_base_type", !"uchar __attribute__((ext_vector_type(4)))*", !"uchar*"}
!15 = !{void (i8*, i8*)* @ParallelSelection_byte, !1, !2, !16, !17, !5}
!16 = !{!"kernel_arg_type", !"uchar*", !"uchar*"}
!17 = !{!"kernel_arg_base_type", !"uchar*", !"uchar*"}
!18 = !{void (float*, float*)* @ParallelSelection_float, !1, !2, !19, !20, !5}
!19 = !{!"kernel_arg_type", !"float*", !"float*"}
!20 = !{!"kernel_arg_base_type", !"float*", !"float*"}
!21 = !{!"clang version 3.7.0 (tags/RELEASE_371/final)"}
!22 = !{i32 14990}
!23 = !{i32 15130}
!24 = !{i32 14769}
!25 = !{!26, !26, i64 0}
!26 = !{!"int", !27, i64 0}
!27 = !{!"omnipotent char", !28, i64 0}
!28 = !{!"Simple C/C++ TBAA"}
!29 = !{!30, !30, i64 0}
!30 = !{!"short", !27, i64 0}
!31 = !{!27, !27, i64 0}
!32 = !{!33, !33, i64 0}
!33 = !{!"float", !27, i64 0}
