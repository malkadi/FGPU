; ModuleID = 'copy.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind
define void @copy_word(i32* nocapture readonly %in, i32* nocapture %out) #0 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %3 = add nsw i32 %2, %1
  %4 = getelementptr inbounds i32, i32* %in, i32 %3
  %5 = load i32, i32* %4, align 4, !tbaa !21
  %6 = getelementptr inbounds i32, i32* %out, i32 %3
  store i32 %5, i32* %6, align 4, !tbaa !21
  ret void
}

; Function Attrs: nounwind
define void @copy_half(i16* nocapture readonly %in, i16* nocapture %out) #0 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %3 = add nsw i32 %2, %1
  %4 = getelementptr inbounds i16, i16* %in, i32 %3
  %5 = load i16, i16* %4, align 2, !tbaa !25
  %6 = getelementptr inbounds i16, i16* %out, i32 %3
  store i16 %5, i16* %6, align 2, !tbaa !25
  ret void
}

; Function Attrs: nounwind
define void @copy_half_improved(<2 x i16>* nocapture readonly %in, <2 x i16>* nocapture %out) #0 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %3 = add nsw i32 %2, %1
  %4 = getelementptr inbounds <2 x i16>, <2 x i16>* %in, i32 %3
  %5 = bitcast <2 x i16>* %4 to i32*
  %6 = load i32, i32* %5, align 4, !tbaa !27
  %7 = getelementptr inbounds <2 x i16>, <2 x i16>* %out, i32 %3
  %8 = bitcast <2 x i16>* %7 to i32*
  store i32 %6, i32* %8, align 4, !tbaa !27
  ret void
}

; Function Attrs: nounwind
define void @copy_byte(i8* nocapture readonly %in, i8* nocapture %out) #0 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %3 = add nsw i32 %2, %1
  %4 = getelementptr inbounds i8, i8* %in, i32 %3
  %5 = load i8, i8* %4, align 1, !tbaa !27
  %6 = getelementptr inbounds i8, i8* %out, i32 %3
  store i8 %5, i8* %6, align 1, !tbaa !27
  ret void
}

; Function Attrs: nounwind
define void @copy_byte_improved(<4 x i8>* nocapture readonly %in, <4 x i8>* nocapture %out) #0 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !19
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #1, !srcloc !20
  %3 = add nsw i32 %2, %1
  %4 = getelementptr inbounds <4 x i8>, <4 x i8>* %in, i32 %3
  %5 = bitcast <4 x i8>* %4 to i32*
  %6 = load i32, i32* %5, align 4, !tbaa !27
  %7 = getelementptr inbounds <4 x i8>, <4 x i8>* %out, i32 %3
  %8 = bitcast <4 x i8>* %7 to i32*
  store i32 %6, i32* %8, align 4, !tbaa !27
  ret void
}

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }

!opencl.kernels = !{!0, !6, !9, !12, !15}
!llvm.ident = !{!18}

!0 = !{void (i32*, i32*)* @copy_word, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"int*", !"int*"}
!4 = !{!"kernel_arg_base_type", !"int*", !"int*"}
!5 = !{!"kernel_arg_type_qual", !"", !""}
!6 = !{void (i16*, i16*)* @copy_half, !1, !2, !7, !8, !5}
!7 = !{!"kernel_arg_type", !"short*", !"short*"}
!8 = !{!"kernel_arg_base_type", !"short*", !"short*"}
!9 = !{void (<2 x i16>*, <2 x i16>*)* @copy_half_improved, !1, !2, !10, !11, !5}
!10 = !{!"kernel_arg_type", !"ushort2*", !"ushort2*"}
!11 = !{!"kernel_arg_base_type", !"ushort __attribute__((ext_vector_type(2)))*", !"ushort __attribute__((ext_vector_type(2)))*"}
!12 = !{void (i8*, i8*)* @copy_byte, !1, !2, !13, !14, !5}
!13 = !{!"kernel_arg_type", !"char*", !"char*"}
!14 = !{!"kernel_arg_base_type", !"char*", !"char*"}
!15 = !{void (<4 x i8>*, <4 x i8>*)* @copy_byte_improved, !1, !2, !16, !17, !5}
!16 = !{!"kernel_arg_type", !"uchar4*", !"uchar4*"}
!17 = !{!"kernel_arg_base_type", !"uchar __attribute__((ext_vector_type(4)))*", !"uchar __attribute__((ext_vector_type(4)))*"}
!18 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
!19 = !{i32 12070}
!20 = !{i32 12210}
!21 = !{!22, !22, i64 0}
!22 = !{!"int", !23, i64 0}
!23 = !{!"omnipotent char", !24, i64 0}
!24 = !{!"Simple C/C++ TBAA"}
!25 = !{!26, !26, i64 0}
!26 = !{!"short", !23, i64 0}
!27 = !{!23, !23, i64 0}
