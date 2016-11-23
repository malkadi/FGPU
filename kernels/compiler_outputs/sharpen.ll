; ModuleID = 'sharpen.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind
define void @sharpen5x5(i32* nocapture readonly %in, i32* nocapture %out) #0 {
entry:
  %p = alloca [5 x [5 x i32]], align 4
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 1) #1, !srcloc !7
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 1) #1, !srcloc !8
  %2 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !7
  %3 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !8
  %add.i.131 = add nsw i32 %3, %2
  %4 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !9
  %5 = bitcast [5 x [5 x i32]]* %p to i8*
  call void @llvm.lifetime.start(i64 100, i8* %5) #1
  %6 = add i32 %1, %0
  %7 = add i32 %6, -2
  %8 = mul i32 %4, %7
  %9 = add i32 %add.i.131, %8
  %10 = add i32 %9, -2
  %scevgep = getelementptr [5 x [5 x i32]], [5 x [5 x i32]]* %p, i32 0, i32 0, i32 0
  %scevgep161 = bitcast [5 x [5 x i32]]* %p to i8*
  %scevgep162 = getelementptr i32, i32* %in, i32 %10
  %scevgep162163 = bitcast i32* %scevgep162 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i32(i8* %scevgep161, i8* %scevgep162163, i32 20, i32 4, i1 false)
  %scevgep.1 = getelementptr [5 x [5 x i32]], [5 x [5 x i32]]* %p, i32 0, i32 1, i32 0
  %scevgep161.1 = bitcast i32* %scevgep.1 to i8*
  %11 = add i32 %10, %4
  %scevgep162.1 = getelementptr i32, i32* %in, i32 %11
  %scevgep162163.1 = bitcast i32* %scevgep162.1 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i32(i8* %scevgep161.1, i8* %scevgep162163.1, i32 20, i32 4, i1 false)
  %scevgep.2 = getelementptr [5 x [5 x i32]], [5 x [5 x i32]]* %p, i32 0, i32 2, i32 0
  %scevgep161.2 = bitcast i32* %scevgep.2 to i8*
  %12 = shl i32 %4, 1
  %13 = add i32 %10, %12
  %scevgep162.2 = getelementptr i32, i32* %in, i32 %13
  %scevgep162163.2 = bitcast i32* %scevgep162.2 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i32(i8* %scevgep161.2, i8* %scevgep162163.2, i32 20, i32 4, i1 false)
  %scevgep.3 = getelementptr [5 x [5 x i32]], [5 x [5 x i32]]* %p, i32 0, i32 3, i32 0
  %scevgep161.3 = bitcast i32* %scevgep.3 to i8*
  %14 = mul i32 %4, 3
  %15 = add i32 %10, %14
  %scevgep162.3 = getelementptr i32, i32* %in, i32 %15
  %scevgep162163.3 = bitcast i32* %scevgep162.3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i32(i8* %scevgep161.3, i8* %scevgep162163.3, i32 20, i32 4, i1 false)
  %scevgep.4 = getelementptr [5 x [5 x i32]], [5 x [5 x i32]]* %p, i32 0, i32 4, i32 0
  %scevgep161.4 = bitcast i32* %scevgep.4 to i8*
  %16 = shl i32 %4, 2
  %17 = add i32 %10, %16
  %scevgep162.4 = getelementptr i32, i32* %in, i32 %17
  %scevgep162163.4 = bitcast i32* %scevgep162.4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i32(i8* %scevgep161.4, i8* %scevgep162163.4, i32 20, i32 4, i1 false)
  %18 = load i32, i32* %scevgep, align 4, !tbaa !10
  %arrayidx18 = getelementptr inbounds [5 x [5 x i32]], [5 x [5 x i32]]* %p, i32 0, i32 0, i32 1
  %19 = load i32, i32* %arrayidx18, align 4, !tbaa !10
  %arrayidx22 = getelementptr inbounds [5 x [5 x i32]], [5 x [5 x i32]]* %p, i32 0, i32 0, i32 2
  %20 = load i32, i32* %arrayidx22, align 4, !tbaa !10
  %arrayidx26 = getelementptr inbounds [5 x [5 x i32]], [5 x [5 x i32]]* %p, i32 0, i32 0, i32 3
  %21 = load i32, i32* %arrayidx26, align 4, !tbaa !10
  %arrayidx30 = getelementptr inbounds [5 x [5 x i32]], [5 x [5 x i32]]* %p, i32 0, i32 0, i32 4
  %22 = load i32, i32* %arrayidx30, align 4, !tbaa !10
  %23 = load i32, i32* %scevgep.1, align 4, !tbaa !10
  %arrayidx38 = getelementptr inbounds [5 x [5 x i32]], [5 x [5 x i32]]* %p, i32 0, i32 1, i32 1
  %24 = load i32, i32* %arrayidx38, align 4, !tbaa !10
  %arrayidx42 = getelementptr inbounds [5 x [5 x i32]], [5 x [5 x i32]]* %p, i32 0, i32 1, i32 2
  %25 = load i32, i32* %arrayidx42, align 4, !tbaa !10
  %arrayidx46 = getelementptr inbounds [5 x [5 x i32]], [5 x [5 x i32]]* %p, i32 0, i32 1, i32 3
  %26 = load i32, i32* %arrayidx46, align 4, !tbaa !10
  %arrayidx50 = getelementptr inbounds [5 x [5 x i32]], [5 x [5 x i32]]* %p, i32 0, i32 1, i32 4
  %27 = load i32, i32* %arrayidx50, align 4, !tbaa !10
  %28 = load i32, i32* %scevgep.2, align 4, !tbaa !10
  %arrayidx58 = getelementptr inbounds [5 x [5 x i32]], [5 x [5 x i32]]* %p, i32 0, i32 2, i32 1
  %29 = load i32, i32* %arrayidx58, align 4, !tbaa !10
  %arrayidx62 = getelementptr inbounds [5 x [5 x i32]], [5 x [5 x i32]]* %p, i32 0, i32 2, i32 2
  %30 = load i32, i32* %arrayidx62, align 4, !tbaa !10
  %mul63 = shl i32 %30, 3
  %arrayidx66 = getelementptr inbounds [5 x [5 x i32]], [5 x [5 x i32]]* %p, i32 0, i32 2, i32 3
  %31 = load i32, i32* %arrayidx66, align 4, !tbaa !10
  %arrayidx70 = getelementptr inbounds [5 x [5 x i32]], [5 x [5 x i32]]* %p, i32 0, i32 2, i32 4
  %32 = load i32, i32* %arrayidx70, align 4, !tbaa !10
  %33 = load i32, i32* %scevgep.3, align 4, !tbaa !10
  %arrayidx78 = getelementptr inbounds [5 x [5 x i32]], [5 x [5 x i32]]* %p, i32 0, i32 3, i32 1
  %34 = load i32, i32* %arrayidx78, align 4, !tbaa !10
  %arrayidx82 = getelementptr inbounds [5 x [5 x i32]], [5 x [5 x i32]]* %p, i32 0, i32 3, i32 2
  %35 = load i32, i32* %arrayidx82, align 4, !tbaa !10
  %arrayidx86 = getelementptr inbounds [5 x [5 x i32]], [5 x [5 x i32]]* %p, i32 0, i32 3, i32 3
  %36 = load i32, i32* %arrayidx86, align 4, !tbaa !10
  %arrayidx90 = getelementptr inbounds [5 x [5 x i32]], [5 x [5 x i32]]* %p, i32 0, i32 3, i32 4
  %37 = load i32, i32* %arrayidx90, align 4, !tbaa !10
  %38 = load i32, i32* %scevgep.4, align 4, !tbaa !10
  %arrayidx98 = getelementptr inbounds [5 x [5 x i32]], [5 x [5 x i32]]* %p, i32 0, i32 4, i32 1
  %39 = load i32, i32* %arrayidx98, align 4, !tbaa !10
  %arrayidx102 = getelementptr inbounds [5 x [5 x i32]], [5 x [5 x i32]]* %p, i32 0, i32 4, i32 2
  %40 = load i32, i32* %arrayidx102, align 4, !tbaa !10
  %arrayidx106 = getelementptr inbounds [5 x [5 x i32]], [5 x [5 x i32]]* %p, i32 0, i32 4, i32 3
  %41 = load i32, i32* %arrayidx106, align 4, !tbaa !10
  %arrayidx110 = getelementptr inbounds [5 x [5 x i32]], [5 x [5 x i32]]* %p, i32 0, i32 4, i32 4
  %42 = load i32, i32* %arrayidx110, align 4, !tbaa !10
  %tmp = add i32 %25, %24
  %tmp146 = add i32 %tmp, %26
  %tmp147 = add i32 %tmp146, %29
  %tmp148 = add i32 %tmp147, %31
  %tmp149 = add i32 %tmp148, %34
  %tmp150 = add i32 %tmp149, %35
  %tmp151 = add i32 %tmp150, %36
  %tmp152 = shl i32 %tmp151, 1
  %sum = add i32 %19, %18
  %sum155 = add i32 %sum, %20
  %sum156 = add i32 %sum155, %21
  %sum157 = add i32 %sum156, %22
  %sum158 = add i32 %sum157, %23
  %sum159 = add i32 %sum158, %27
  %sum160 = add i32 %sum159, %28
  %add76 = sub i32 %mul63, %sum160
  %add80 = sub i32 %add76, %32
  %add84 = sub i32 %add80, %33
  %add88 = sub i32 %add84, %37
  %sub92 = sub i32 %add88, %38
  %add96 = sub i32 %sub92, %39
  %sub100 = sub i32 %add96, %40
  %sub104 = sub i32 %sub100, %41
  %sub108 = sub i32 %sub104, %42
  %sub112 = add i32 %sub108, %tmp152
  %div = lshr i32 %sub112, 3
  %mul113 = mul i32 %4, %6
  %add114 = add i32 %mul113, %add.i.131
  %arrayidx115 = getelementptr inbounds i32, i32* %out, i32 %add114
  store i32 %div, i32* %arrayidx115, align 4, !tbaa !10
  call void @llvm.lifetime.end(i64 100, i8* %5) #1
  ret void
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i32(i8* nocapture, i8* nocapture readonly, i32, i32, i1) #1

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (i32*, i32*)* @sharpen5x5, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"uint*", !"uint*"}
!4 = !{!"kernel_arg_base_type", !"uint*", !"uint*"}
!5 = !{!"kernel_arg_type_qual", !"", !""}
!6 = !{!"clang version 3.7.0 (tags/RELEASE_371/final)"}
!7 = !{i32 13035}
!8 = !{i32 13175}
!9 = !{i32 12814}
!10 = !{!11, !11, i64 0}
!11 = !{!"int", !12, i64 0}
!12 = !{!"omnipotent char", !13, i64 0}
!13 = !{!"Simple C/C++ TBAA"}
