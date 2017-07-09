; ModuleID = 'vec_add.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind readnone
define float @__addsf3(float %a, float %b) #0 {
  %1 = bitcast float %a to i32
  %2 = bitcast float %b to i32
  %3 = and i32 %1, 2147483647
  %4 = and i32 %2, 2147483647
  %5 = add nsw i32 %3, -1
  %6 = icmp ugt i32 %5, 2139095038
  %7 = add nsw i32 %4, -1
  %8 = icmp ugt i32 %7, 2139095038
  %or.cond = or i1 %6, %8
  br i1 %or.cond, label %9, label %28

; <label>:9                                       ; preds = %0
  %10 = icmp ugt i32 %3, 2139095040
  %11 = icmp ugt i32 %4, 2139095040
  %12 = or i1 %10, %11
  %13 = icmp eq i32 %3, 2139095040
  %14 = xor i32 %2, %1
  %15 = icmp eq i32 %14, -2147483648
  %16 = and i1 %13, %15
  %17 = or i1 %12, %16
  %brmerge = or i1 %13, %12
  %.mux = select i1 %17, float 0x7FF8000000000000, float %a
  br i1 %brmerge, label %.thread, label %18

; <label>:18                                      ; preds = %9
  %19 = icmp eq i32 %4, 2139095040
  br i1 %19, label %.thread, label %20

; <label>:20                                      ; preds = %18
  %21 = icmp eq i32 %3, 0
  %22 = icmp ne i32 %4, 0
  br i1 %21, label %23, label %27

; <label>:23                                      ; preds = %20
  br i1 %22, label %.thread, label %24

; <label>:24                                      ; preds = %23
  %25 = and i32 %2, %1
  %26 = bitcast i32 %25 to float
  br label %.thread

; <label>:27                                      ; preds = %20
  br i1 %22, label %28, label %.thread

; <label>:28                                      ; preds = %0, %27
  %29 = icmp ugt i32 %4, %3
  %30 = select i1 %29, i32 %1, i32 %2
  %31 = select i1 %29, i32 %2, i32 %1
  %32 = lshr i32 %31, 23
  %33 = and i32 %32, 255
  %34 = lshr i32 %30, 23
  %35 = and i32 %34, 255
  %36 = and i32 %31, 8388607
  %37 = and i32 %30, 8388607
  %38 = icmp eq i32 %33, 0
  br i1 %38, label %39, label %45

; <label>:39                                      ; preds = %28
  %40 = tail call i32 @llvm.ctlz.i32(i32 %36, i1 false) #3
  %41 = add nuw nsw i32 %40, 24
  %42 = and i32 %41, 31
  %43 = shl i32 %36, %42
  %44 = sub nsw i32 9, %40
  br label %45

; <label>:45                                      ; preds = %39, %28
  %aSignificand.0 = phi i32 [ %43, %39 ], [ %36, %28 ]
  %aExponent.0 = phi i32 [ %44, %39 ], [ %33, %28 ]
  %46 = icmp eq i32 %35, 0
  br i1 %46, label %47, label %53

; <label>:47                                      ; preds = %45
  %48 = tail call i32 @llvm.ctlz.i32(i32 %37, i1 false) #3
  %49 = add nuw nsw i32 %48, 24
  %50 = and i32 %49, 31
  %51 = shl i32 %37, %50
  %52 = sub nsw i32 9, %48
  br label %53

; <label>:53                                      ; preds = %47, %45
  %bSignificand.0 = phi i32 [ %51, %47 ], [ %37, %45 ]
  %bExponent.0 = phi i32 [ %52, %47 ], [ %35, %45 ]
  %54 = and i32 %31, -2147483648
  %55 = xor i32 %31, %30
  %56 = icmp slt i32 %55, 0
  %57 = shl i32 %aSignificand.0, 3
  %58 = or i32 %57, 67108864
  %59 = shl i32 %bSignificand.0, 3
  %60 = or i32 %59, 67108864
  %61 = sub nsw i32 %aExponent.0, %bExponent.0
  %62 = icmp eq i32 %aExponent.0, %bExponent.0
  br i1 %62, label %74, label %63

; <label>:63                                      ; preds = %53
  %64 = icmp ult i32 %61, 32
  br i1 %64, label %65, label %74

; <label>:65                                      ; preds = %63
  %66 = sub nsw i32 0, %61
  %67 = and i32 %66, 31
  %68 = shl i32 %60, %67
  %69 = icmp ne i32 %68, 0
  %70 = and i32 %61, 31
  %71 = lshr i32 %60, %70
  %72 = zext i1 %69 to i32
  %73 = or i32 %72, %71
  br label %74

; <label>:74                                      ; preds = %63, %53, %65
  %bSignificand.1 = phi i32 [ %60, %53 ], [ %73, %65 ], [ 1, %63 ]
  br i1 %56, label %75, label %86

; <label>:75                                      ; preds = %74
  %76 = sub i32 %58, %bSignificand.1
  %77 = icmp eq i32 %58, %bSignificand.1
  br i1 %77, label %.thread, label %78

; <label>:78                                      ; preds = %75
  %79 = icmp ult i32 %76, 67108864
  br i1 %79, label %80, label %95

; <label>:80                                      ; preds = %78
  %81 = tail call i32 @llvm.ctlz.i32(i32 %76, i1 false) #3
  %82 = add nsw i32 %81, -5
  %83 = and i32 %82, 31
  %84 = shl i32 %76, %83
  %85 = sub nsw i32 %aExponent.0, %82
  br label %95

; <label>:86                                      ; preds = %74
  %87 = add i32 %bSignificand.1, %58
  %88 = and i32 %87, 134217728
  %89 = icmp eq i32 %88, 0
  br i1 %89, label %95, label %90

; <label>:90                                      ; preds = %86
  %fold = add i32 %bSignificand.1, %57
  %91 = and i32 %fold, 1
  %92 = lshr i32 %87, 1
  %93 = or i32 %92, %91
  %94 = add nsw i32 %aExponent.0, 1
  br label %95

; <label>:95                                      ; preds = %86, %90, %78, %80
  %aSignificand.1 = phi i32 [ %84, %80 ], [ %76, %78 ], [ %87, %86 ], [ %93, %90 ]
  %aExponent.1 = phi i32 [ %85, %80 ], [ %aExponent.0, %78 ], [ %aExponent.0, %86 ], [ %94, %90 ]
  %96 = icmp sgt i32 %aExponent.1, 254
  br i1 %96, label %97, label %100

; <label>:97                                      ; preds = %95
  %98 = or i32 %54, 2139095040
  %99 = bitcast i32 %98 to float
  br label %.thread

; <label>:100                                     ; preds = %95
  %101 = icmp slt i32 %aExponent.1, 1
  br i1 %101, label %102, label %112

; <label>:102                                     ; preds = %100
  %103 = sub nsw i32 1, %aExponent.1
  %104 = sub nsw i32 0, %103
  %105 = and i32 %104, 31
  %106 = shl i32 %aSignificand.1, %105
  %107 = icmp ne i32 %106, 0
  %108 = and i32 %103, 31
  %109 = lshr i32 %aSignificand.1, %108
  %110 = zext i1 %107 to i32
  %111 = or i32 %110, %109
  br label %112

; <label>:112                                     ; preds = %102, %100
  %aSignificand.2 = phi i32 [ %111, %102 ], [ %aSignificand.1, %100 ]
  %aExponent.2 = phi i32 [ 0, %102 ], [ %aExponent.1, %100 ]
  %113 = and i32 %aSignificand.2, 7
  %114 = lshr i32 %aSignificand.2, 3
  %115 = and i32 %114, 8388607
  %116 = shl i32 %aExponent.2, 23
  %117 = or i32 %116, %54
  %118 = or i32 %117, %115
  %119 = icmp ugt i32 %113, 4
  %120 = zext i1 %119 to i32
  %.6 = add i32 %118, %120
  %121 = icmp eq i32 %113, 4
  %122 = and i32 %.6, 1
  %123 = select i1 %121, i32 %122, i32 0
  %result.1 = add i32 %123, %.6
  %124 = bitcast i32 %result.1 to float
  br label %.thread

.thread:                                          ; preds = %9, %23, %18, %24, %97, %112, %75, %27
  %.2 = phi float [ %a, %27 ], [ %99, %97 ], [ %124, %112 ], [ 0.000000e+00, %75 ], [ %.mux, %9 ], [ %b, %23 ], [ %b, %18 ], [ %26, %24 ]
  ret float %.2
}

; Function Attrs: nounwind
define void @vec_add(i32* nocapture readonly %in1, i32* nocapture readonly %in2, i32* nocapture %out) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !22
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !23
  %3 = add nsw i32 %2, %1
  %4 = getelementptr inbounds i32, i32* %in1, i32 %3
  %5 = load i32, i32* %4, align 4, !tbaa !24
  %6 = getelementptr inbounds i32, i32* %in2, i32 %3
  %7 = load i32, i32* %6, align 4, !tbaa !24
  %8 = add nsw i32 %7, %5
  %9 = getelementptr inbounds i32, i32* %out, i32 %3
  store i32 %8, i32* %9, align 4, !tbaa !24
  ret void
}

; Function Attrs: nounwind
define void @vec_add_half(i16* nocapture readonly %in1, i16* nocapture readonly %in2, i16* nocapture %out) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !22
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !23
  %3 = add nsw i32 %2, %1
  %4 = getelementptr inbounds i16, i16* %in1, i32 %3
  %5 = load i16, i16* %4, align 2, !tbaa !28
  %6 = zext i16 %5 to i32
  %7 = getelementptr inbounds i16, i16* %in2, i32 %3
  %8 = load i16, i16* %7, align 2, !tbaa !28
  %9 = zext i16 %8 to i32
  %10 = add nuw nsw i32 %9, %6
  %11 = trunc i32 %10 to i16
  %12 = getelementptr inbounds i16, i16* %out, i32 %3
  store i16 %11, i16* %12, align 2, !tbaa !28
  ret void
}

; Function Attrs: nounwind
define void @vec_add_half_improved(<2 x i16>* nocapture readonly %in1, <2 x i16>* nocapture readonly %in2, <2 x i16>* nocapture %out) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !22
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !23
  %3 = add nsw i32 %2, %1
  %4 = getelementptr inbounds <2 x i16>, <2 x i16>* %in1, i32 %3
  %5 = load <2 x i16>, <2 x i16>* %4, align 4, !tbaa !30
  %6 = getelementptr inbounds <2 x i16>, <2 x i16>* %in2, i32 %3
  %7 = load <2 x i16>, <2 x i16>* %6, align 4, !tbaa !30
  %8 = add <2 x i16> %7, %5
  %9 = getelementptr inbounds <2 x i16>, <2 x i16>* %out, i32 %3
  store <2 x i16> %8, <2 x i16>* %9, align 4, !tbaa !30
  ret void
}

; Function Attrs: nounwind
define void @vec_add_byte(i8* nocapture readonly %in1, i8* nocapture readonly %in2, i8* nocapture %out) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !22
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !23
  %3 = add nsw i32 %2, %1
  %4 = getelementptr inbounds i8, i8* %in1, i32 %3
  %5 = load i8, i8* %4, align 1, !tbaa !30
  %6 = zext i8 %5 to i32
  %7 = getelementptr inbounds i8, i8* %in2, i32 %3
  %8 = load i8, i8* %7, align 1, !tbaa !30
  %9 = zext i8 %8 to i32
  %10 = add nuw nsw i32 %9, %6
  %11 = trunc i32 %10 to i8
  %12 = getelementptr inbounds i8, i8* %out, i32 %3
  store i8 %11, i8* %12, align 1, !tbaa !30
  ret void
}

; Function Attrs: nounwind
define void @vec_add_byte_improved(<4 x i8>* nocapture readonly %in1, <4 x i8>* nocapture readonly %in2, <4 x i8>* nocapture %out) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !22
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !23
  %3 = add nsw i32 %2, %1
  %4 = getelementptr inbounds <4 x i8>, <4 x i8>* %in1, i32 %3
  %5 = load <4 x i8>, <4 x i8>* %4, align 4, !tbaa !30
  %6 = getelementptr inbounds <4 x i8>, <4 x i8>* %in2, i32 %3
  %7 = load <4 x i8>, <4 x i8>* %6, align 4, !tbaa !30
  %8 = add <4 x i8> %7, %5
  %9 = getelementptr inbounds <4 x i8>, <4 x i8>* %out, i32 %3
  store <4 x i8> %8, <4 x i8>* %9, align 4, !tbaa !30
  ret void
}

; Function Attrs: nounwind
define void @add_float(float* nocapture readonly %in1, float* nocapture readonly %in2, float* nocapture %out) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !22
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !23
  %3 = add nsw i32 %2, %1
  %4 = getelementptr inbounds float, float* %in1, i32 %3
  %5 = load float, float* %4, align 4, !tbaa !31
  %6 = getelementptr inbounds float, float* %in2, i32 %3
  %7 = load float, float* %6, align 4, !tbaa !31
  %8 = fadd float %5, %7
  %9 = getelementptr inbounds float, float* %out, i32 %3
  store float %8, float* %9, align 4, !tbaa !31
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @llvm.ctlz.i32(i32, i1) #2

attributes #0 = { nounwind readnone "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!opencl.kernels = !{!0, !6, !9, !12, !15, !18}
!llvm.ident = !{!21}

!0 = !{void (i32*, i32*, i32*)* @vec_add, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"int*", !"int*", !"int*"}
!4 = !{!"kernel_arg_base_type", !"int*", !"int*", !"int*"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !""}
!6 = !{void (i16*, i16*, i16*)* @vec_add_half, !1, !2, !7, !8, !5}
!7 = !{!"kernel_arg_type", !"short*", !"short*", !"short*"}
!8 = !{!"kernel_arg_base_type", !"short*", !"short*", !"short*"}
!9 = !{void (<2 x i16>*, <2 x i16>*, <2 x i16>*)* @vec_add_half_improved, !1, !2, !10, !11, !5}
!10 = !{!"kernel_arg_type", !"short2*", !"short2*", !"short2*"}
!11 = !{!"kernel_arg_base_type", !"short __attribute__((ext_vector_type(2)))*", !"short __attribute__((ext_vector_type(2)))*", !"short __attribute__((ext_vector_type(2)))*"}
!12 = !{void (i8*, i8*, i8*)* @vec_add_byte, !1, !2, !13, !14, !5}
!13 = !{!"kernel_arg_type", !"char*", !"char*", !"char*"}
!14 = !{!"kernel_arg_base_type", !"char*", !"char*", !"char*"}
!15 = !{void (<4 x i8>*, <4 x i8>*, <4 x i8>*)* @vec_add_byte_improved, !1, !2, !16, !17, !5}
!16 = !{!"kernel_arg_type", !"char4*", !"char4*", !"char4*"}
!17 = !{!"kernel_arg_base_type", !"char __attribute__((ext_vector_type(4)))*", !"char __attribute__((ext_vector_type(4)))*", !"char __attribute__((ext_vector_type(4)))*"}
!18 = !{void (float*, float*, float*)* @add_float, !1, !2, !19, !20, !5}
!19 = !{!"kernel_arg_type", !"float*", !"float*", !"float*"}
!20 = !{!"kernel_arg_base_type", !"float*", !"float*", !"float*"}
!21 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
!22 = !{i32 12426}
!23 = !{i32 12566}
!24 = !{!25, !25, i64 0}
!25 = !{!"int", !26, i64 0}
!26 = !{!"omnipotent char", !27, i64 0}
!27 = !{!"Simple C/C++ TBAA"}
!28 = !{!29, !29, i64 0}
!29 = !{!"short", !26, i64 0}
!30 = !{!26, !26, i64 0}
!31 = !{!32, !32, i64 0}
!32 = !{!"float", !26, i64 0}
