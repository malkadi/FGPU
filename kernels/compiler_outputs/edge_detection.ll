; ModuleID = 'edge_detection.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind
define void @compass_edge_detection(i32* nocapture readonly %in, i32* nocapture %amplitude, i32* nocapture %angle) #0 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 1) #3, !srcloc !13
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 1) #3, !srcloc !14
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !13
  %5 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !14
  %6 = add nsw i32 %5, %4
  %7 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !15
  %8 = icmp eq i32 %3, 0
  %9 = zext i1 %8 to i32
  %10 = icmp eq i32 %6, 0
  %11 = zext i1 %10 to i32
  %12 = or i32 %11, %9
  %13 = add i32 %7, -2
  %14 = icmp ugt i32 %3, %13
  %15 = zext i1 %14 to i32
  %16 = or i32 %12, %15
  %17 = icmp ugt i32 %6, %13
  %18 = zext i1 %17 to i32
  %19 = or i32 %16, %18
  %20 = icmp eq i32 %19, 0
  br i1 %20, label %21, label %87

; <label>:21                                      ; preds = %0
  %22 = add i32 %3, -1
  %23 = mul i32 %7, %22
  %24 = add i32 %23, %6
  %25 = add i32 %24, -1
  %26 = getelementptr inbounds i32, i32* %in, i32 %25
  %27 = load i32, i32* %26, align 4, !tbaa !16
  %28 = getelementptr inbounds i32, i32* %in, i32 %24
  %29 = load i32, i32* %28, align 4, !tbaa !16
  %30 = add i32 %24, 1
  %31 = getelementptr inbounds i32, i32* %in, i32 %30
  %32 = load i32, i32* %31, align 4, !tbaa !16
  %33 = mul i32 %7, %3
  %34 = add i32 %33, %6
  %35 = add i32 %34, -1
  %36 = getelementptr inbounds i32, i32* %in, i32 %35
  %37 = load i32, i32* %36, align 4, !tbaa !16
  %38 = add i32 %34, 1
  %39 = getelementptr inbounds i32, i32* %in, i32 %38
  %40 = load i32, i32* %39, align 4, !tbaa !16
  %41 = add i32 %3, 1
  %42 = mul i32 %7, %41
  %43 = add i32 %42, %6
  %44 = add i32 %43, -1
  %45 = getelementptr inbounds i32, i32* %in, i32 %44
  %46 = load i32, i32* %45, align 4, !tbaa !16
  %47 = getelementptr inbounds i32, i32* %in, i32 %43
  %48 = load i32, i32* %47, align 4, !tbaa !16
  %49 = add i32 %43, 1
  %50 = getelementptr inbounds i32, i32* %in, i32 %49
  %51 = load i32, i32* %50, align 4, !tbaa !16
  %tmp = sub i32 %40, %37
  %tmp1 = shl i32 %tmp, 1
  %52 = sub i32 %32, %27
  %53 = sub i32 %52, %46
  %54 = add i32 %53, %51
  %55 = add i32 %54, %tmp1
  %tmp3 = sub i32 %51, %27
  %tmp4 = shl i32 %tmp3, 1
  %sum = add i32 %37, %29
  %56 = sub i32 %40, %sum
  %57 = add i32 %56, %48
  %58 = add i32 %57, %tmp4
  %59 = shl i32 %29, 1
  %sum12 = add i32 %59, %27
  %sum13 = add i32 %sum12, %32
  %60 = sub i32 %46, %sum13
  %61 = shl i32 %48, 1
  %62 = add i32 %60, %61
  %63 = add i32 %62, %51
  %64 = shl i32 %32, 1
  %sum14 = add i32 %64, %29
  %65 = sub i32 %37, %sum14
  %66 = sub i32 %65, %40
  %67 = shl i32 %46, 1
  %68 = add i32 %66, %67
  %69 = add i32 %68, %48
  %70 = sub nsw i32 0, %55
  %71 = sub nsw i32 0, %58
  %72 = sub nsw i32 0, %63
  %73 = sub nsw i32 0, %69
  %74 = icmp slt i32 %58, %55
  %max_val.0. = select i1 %74, i32 %55, i32 %58
  %75 = zext i1 %74 to i32
  %76 = xor i32 %75, 1
  %77 = icmp slt i32 %63, %max_val.0.
  %max_val.0..1 = select i1 %77, i32 %max_val.0., i32 %63
  %78 = icmp slt i32 %69, %max_val.0..1
  %max_val.0..2 = select i1 %78, i32 %max_val.0..1, i32 %69
  %79 = icmp sgt i32 %max_val.0..2, %70
  %max_val.0..3 = select i1 %79, i32 %max_val.0..2, i32 %70
  %80 = icmp sgt i32 %max_val.0..3, %71
  %max_val.0..4 = select i1 %80, i32 %max_val.0..3, i32 %71
  %81 = icmp sgt i32 %max_val.0..4, %72
  %max_val.0..5 = select i1 %81, i32 %max_val.0..4, i32 %72
  %82 = icmp sgt i32 %max_val.0..5, %73
  %max_val.0..6 = select i1 %82, i32 %max_val.0..5, i32 %73
  %83 = getelementptr inbounds i32, i32* %amplitude, i32 %34
  store i32 %max_val.0..6, i32* %83, align 4, !tbaa !16
  %84 = sub nsw i32 0, %76
  %.op19 = and i32 %84, 45
  %.op18 = select i1 %77, i32 %.op19, i32 90
  %.op17 = select i1 %78, i32 %.op18, i32 135
  %.op16 = select i1 %79, i32 %.op17, i32 180
  %.op15 = select i1 %80, i32 %.op16, i32 225
  %.op = select i1 %81, i32 %.op15, i32 270
  %85 = select i1 %82, i32 %.op, i32 315
  %86 = getelementptr inbounds i32, i32* %angle, i32 %34
  store i32 %85, i32* %86, align 4, !tbaa !16
  br label %87

; <label>:87                                      ; preds = %0, %21
  ret void
}

; Function Attrs: nounwind
define void @sobel(i32* nocapture readonly %in, float* nocapture %amplitude) #0 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 1) #3, !srcloc !13
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 1) #3, !srcloc !14
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !13
  %5 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !14
  %6 = add nsw i32 %5, %4
  %7 = tail call i32 asm sideeffect "size $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !15
  %8 = icmp eq i32 %3, 0
  %9 = zext i1 %8 to i32
  %10 = icmp eq i32 %6, 0
  %11 = zext i1 %10 to i32
  %12 = or i32 %11, %9
  %13 = add i32 %7, -2
  %14 = icmp ugt i32 %3, %13
  %15 = zext i1 %14 to i32
  %16 = or i32 %12, %15
  %17 = icmp ugt i32 %6, %13
  %18 = zext i1 %17 to i32
  %19 = or i32 %16, %18
  %20 = icmp eq i32 %19, 0
  br i1 %20, label %21, label %67

; <label>:21                                      ; preds = %0
  %22 = add i32 %3, -1
  %23 = mul i32 %7, %22
  %24 = add i32 %23, %6
  %25 = add i32 %24, -1
  %26 = getelementptr inbounds i32, i32* %in, i32 %25
  %27 = load i32, i32* %26, align 4, !tbaa !16
  %28 = getelementptr inbounds i32, i32* %in, i32 %24
  %29 = load i32, i32* %28, align 4, !tbaa !16
  %30 = add i32 %24, 1
  %31 = getelementptr inbounds i32, i32* %in, i32 %30
  %32 = load i32, i32* %31, align 4, !tbaa !16
  %33 = mul i32 %7, %3
  %34 = add i32 %33, %6
  %35 = add i32 %34, -1
  %36 = getelementptr inbounds i32, i32* %in, i32 %35
  %37 = load i32, i32* %36, align 4, !tbaa !16
  %38 = add i32 %34, 1
  %39 = getelementptr inbounds i32, i32* %in, i32 %38
  %40 = load i32, i32* %39, align 4, !tbaa !16
  %41 = add i32 %3, 1
  %42 = mul i32 %7, %41
  %43 = add i32 %42, %6
  %44 = add i32 %43, -1
  %45 = getelementptr inbounds i32, i32* %in, i32 %44
  %46 = load i32, i32* %45, align 4, !tbaa !16
  %47 = getelementptr inbounds i32, i32* %in, i32 %43
  %48 = load i32, i32* %47, align 4, !tbaa !16
  %49 = add i32 %43, 1
  %50 = getelementptr inbounds i32, i32* %in, i32 %49
  %51 = load i32, i32* %50, align 4, !tbaa !16
  %tmp = sub i32 %40, %37
  %tmp1 = shl i32 %tmp, 1
  %52 = sub i32 %32, %27
  %53 = sub i32 %52, %46
  %54 = add i32 %53, %51
  %55 = add i32 %54, %tmp1
  %56 = uitofp i32 %55 to float
  %57 = shl i32 %29, 1
  %sum = add i32 %57, %27
  %sum4 = add i32 %sum, %32
  %58 = sub i32 %46, %sum4
  %59 = shl i32 %48, 1
  %60 = add i32 %58, %59
  %61 = add i32 %60, %51
  %62 = uitofp i32 %61 to float
  %63 = fmul float %62, %62
  %64 = tail call float @llvm.fmuladd.f32(float %56, float %56, float %63)
  %65 = tail call float @sqrtf(float %64) #2
  %66 = getelementptr inbounds float, float* %amplitude, i32 %34
  store float %65, float* %66, align 4, !tbaa !20
  br label %67

; <label>:67                                      ; preds = %0, %21
  ret void
}

; Function Attrs: nounwind readnone
declare float @sqrtf(float) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!opencl.kernels = !{!0, !6}
!llvm.ident = !{!12}

!0 = !{void (i32*, i32*, i32*)* @compass_edge_detection, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"uint*", !"uint*", !"uint*"}
!4 = !{!"kernel_arg_base_type", !"uint*", !"uint*", !"uint*"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !""}
!6 = !{void (i32*, float*)* @sobel, !7, !8, !9, !10, !11}
!7 = !{!"kernel_arg_addr_space", i32 0, i32 0}
!8 = !{!"kernel_arg_access_qual", !"none", !"none"}
!9 = !{!"kernel_arg_type", !"uint*", !"float*"}
!10 = !{!"kernel_arg_base_type", !"uint*", !"float*"}
!11 = !{!"kernel_arg_type_qual", !"", !""}
!12 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
!13 = !{i32 13708}
!14 = !{i32 13848}
!15 = !{i32 13487}
!16 = !{!17, !17, i64 0}
!17 = !{!"int", !18, i64 0}
!18 = !{!"omnipotent char", !19, i64 0}
!19 = !{!"Simple C/C++ TBAA"}
!20 = !{!21, !21, i64 0}
!21 = !{!"float", !18, i64 0}
