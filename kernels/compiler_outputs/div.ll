; ModuleID = 'div.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind readnone
define float @__divsf3(float %a, float %b) #0 {
  %1 = bitcast float %a to i32
  %2 = lshr i32 %1, 23
  %3 = and i32 %2, 255
  %4 = bitcast float %b to i32
  %5 = lshr i32 %4, 23
  %6 = and i32 %5, 255
  %7 = xor i32 %4, %1
  %8 = and i32 %7, -2147483648
  %9 = and i32 %1, 8388607
  %10 = and i32 %4, 8388607
  %11 = add nsw i32 %3, -1
  %12 = icmp ugt i32 %11, 253
  %13 = add nsw i32 %6, -1
  %14 = icmp ugt i32 %13, 253
  %or.cond = or i1 %12, %14
  br i1 %or.cond, label %15, label %64

; <label>:15                                      ; preds = %0
  %16 = and i32 %1, 2147483647
  %17 = and i32 %4, 2147483647
  %18 = icmp ugt i32 %16, 2139095040
  br i1 %18, label %19, label %22

; <label>:19                                      ; preds = %15
  %20 = or i32 %1, 4194304
  %21 = bitcast i32 %20 to float
  br label %.thread

; <label>:22                                      ; preds = %15
  %23 = icmp ugt i32 %17, 2139095040
  br i1 %23, label %24, label %27

; <label>:24                                      ; preds = %22
  %25 = or i32 %4, 4194304
  %26 = bitcast i32 %25 to float
  br label %.thread

; <label>:27                                      ; preds = %22
  %28 = icmp eq i32 %16, 2139095040
  %29 = icmp eq i32 %17, 2139095040
  br i1 %28, label %30, label %35

; <label>:30                                      ; preds = %27
  br i1 %29, label %.thread, label %31

; <label>:31                                      ; preds = %30
  %32 = and i32 %4, -2147483648
  %33 = xor i32 %32, %1
  %34 = bitcast i32 %33 to float
  br label %.thread

; <label>:35                                      ; preds = %27
  br i1 %29, label %36, label %38

; <label>:36                                      ; preds = %35
  %37 = bitcast i32 %8 to float
  br label %.thread

; <label>:38                                      ; preds = %35
  %39 = icmp eq i32 %16, 0
  %40 = icmp ne i32 %17, 0
  br i1 %39, label %41, label %43

; <label>:41                                      ; preds = %38
  %42 = bitcast i32 %8 to float
  %. = select i1 %40, float %42, float 0x7FF8000000000000
  ret float %.

; <label>:43                                      ; preds = %38
  br i1 %40, label %47, label %44

; <label>:44                                      ; preds = %43
  %45 = or i32 %8, 2139095040
  %46 = bitcast i32 %45 to float
  br label %.thread

; <label>:47                                      ; preds = %43
  %48 = icmp ult i32 %16, 8388608
  br i1 %48, label %49, label %55

; <label>:49                                      ; preds = %47
  %50 = tail call i32 @llvm.ctlz.i32(i32 %9, i1 false) #3
  %51 = add nuw nsw i32 %50, 24
  %52 = and i32 %51, 31
  %53 = shl i32 %9, %52
  %54 = sub nsw i32 9, %50
  br label %55

; <label>:55                                      ; preds = %49, %47
  %aSignificand.0 = phi i32 [ %53, %49 ], [ %9, %47 ]
  %scale.0 = phi i32 [ %54, %49 ], [ 0, %47 ]
  %56 = icmp ult i32 %17, 8388608
  br i1 %56, label %57, label %64

; <label>:57                                      ; preds = %55
  %58 = tail call i32 @llvm.ctlz.i32(i32 %10, i1 false) #3
  %59 = add nuw nsw i32 %58, 24
  %60 = and i32 %59, 31
  %61 = shl i32 %10, %60
  %62 = add nsw i32 %scale.0, -9
  %63 = add nsw i32 %62, %58
  br label %64

; <label>:64                                      ; preds = %57, %55, %0
  %aSignificand.2 = phi i32 [ %9, %0 ], [ %aSignificand.0, %57 ], [ %aSignificand.0, %55 ]
  %bSignificand.1 = phi i32 [ %10, %0 ], [ %61, %57 ], [ %10, %55 ]
  %scale.3 = phi i32 [ 0, %0 ], [ %63, %57 ], [ %scale.0, %55 ]
  %65 = or i32 %aSignificand.2, 8388608
  %66 = or i32 %bSignificand.1, 8388608
  %67 = sub nsw i32 %3, %6
  %68 = add nsw i32 %67, %scale.3
  %69 = shl i32 %66, 8
  %70 = sub i32 1963258675, %69
  %71 = and i32 %70, 65331
  %72 = and i32 %69, 65280
  %73 = mul nuw i32 %71, %72
  %74 = lshr i32 %70, 16
  %75 = mul nuw i32 %74, %72
  %76 = lshr i32 %66, 8
  %77 = and i32 %76, 65535
  %78 = mul nuw i32 %71, %77
  %79 = mul nuw i32 %74, %77
  %80 = lshr i32 %73, 16
  %81 = and i32 %75, 65280
  %82 = add nuw nsw i32 %80, %81
  %83 = and i32 %78, 65535
  %84 = add nuw nsw i32 %82, %83
  %85 = lshr i32 %84, 16
  %86 = lshr i32 %75, 16
  %87 = lshr i32 %78, 16
  %88 = add i32 %79, %86
  %89 = add i32 %87, %88
  %90 = add i32 %89, %85
  %91 = sub i32 0, %90
  %92 = and i32 %91, 65535
  %93 = mul nuw i32 %92, %71
  %94 = lshr i32 %93, 16
  %95 = mul nuw i32 %92, %74
  %96 = add i32 %94, %95
  %97 = lshr i32 %96, 16
  %98 = and i32 %96, 65535
  %99 = lshr i32 %91, 16
  %100 = mul nuw i32 %99, %71
  %101 = add i32 %98, %100
  %fold.i.5 = add i32 %96, %100
  %102 = shl i32 %fold.i.5, 16
  %103 = lshr i32 %101, 16
  %104 = mul nuw i32 %99, %74
  %105 = add i32 %97, %104
  %106 = add i32 %105, %103
  %107 = zext i32 %102 to i64
  %108 = zext i32 %106 to i64
  %109 = shl nuw i64 %108, 32
  %110 = or i64 %109, %107
  %111 = lshr i64 %110, 31
  %112 = trunc i64 %111 to i32
  %113 = and i32 %112, 65535
  %114 = mul nuw i32 %113, %72
  %115 = lshr i32 %106, 15
  %116 = and i32 %115, 65535
  %117 = mul nuw i32 %116, %72
  %118 = mul nuw i32 %113, %77
  %119 = mul nuw i32 %116, %77
  %120 = lshr i32 %114, 16
  %121 = and i32 %117, 65280
  %122 = add nuw nsw i32 %120, %121
  %123 = and i32 %118, 65535
  %124 = add nuw nsw i32 %122, %123
  %125 = lshr i32 %124, 16
  %126 = lshr i32 %117, 16
  %127 = lshr i32 %118, 16
  %128 = add i32 %119, %126
  %129 = add i32 %128, %127
  %130 = add i32 %129, %125
  %131 = sub i32 0, %130
  %132 = and i32 %131, 65535
  %133 = mul nuw i32 %132, %113
  %134 = lshr i32 %133, 16
  %135 = mul nuw i32 %132, %116
  %136 = add i32 %134, %135
  %137 = lshr i32 %136, 16
  %138 = and i32 %136, 65535
  %139 = lshr i32 %131, 16
  %140 = mul nuw i32 %139, %113
  %141 = add i32 %138, %140
  %fold.i.4 = add i32 %136, %140
  %142 = shl i32 %fold.i.4, 16
  %143 = lshr i32 %141, 16
  %144 = mul nuw i32 %139, %116
  %145 = add i32 %137, %144
  %146 = add i32 %145, %143
  %147 = zext i32 %142 to i64
  %148 = zext i32 %146 to i64
  %149 = shl nuw i64 %148, 32
  %150 = or i64 %149, %147
  %151 = lshr i64 %150, 31
  %152 = trunc i64 %151 to i32
  %153 = and i32 %152, 65535
  %154 = mul nuw i32 %153, %72
  %155 = lshr i32 %146, 15
  %156 = and i32 %155, 65535
  %157 = mul nuw i32 %156, %72
  %158 = mul nuw i32 %153, %77
  %159 = mul nuw i32 %156, %77
  %160 = lshr i32 %154, 16
  %161 = and i32 %157, 65280
  %162 = add nuw nsw i32 %160, %161
  %163 = and i32 %158, 65535
  %164 = add nuw nsw i32 %162, %163
  %165 = lshr i32 %164, 16
  %166 = lshr i32 %157, 16
  %167 = lshr i32 %158, 16
  %168 = add i32 %159, %166
  %169 = add i32 %168, %167
  %170 = add i32 %169, %165
  %171 = sub i32 0, %170
  %172 = and i32 %171, 65535
  %173 = mul nuw i32 %172, %153
  %174 = lshr i32 %173, 16
  %175 = mul nuw i32 %172, %156
  %176 = add i32 %174, %175
  %177 = lshr i32 %176, 16
  %178 = and i32 %176, 65535
  %179 = lshr i32 %171, 16
  %180 = mul nuw i32 %179, %153
  %181 = add i32 %178, %180
  %fold.i = add i32 %176, %180
  %182 = shl i32 %fold.i, 16
  %183 = lshr i32 %181, 16
  %184 = mul nuw i32 %179, %156
  %185 = add i32 %177, %184
  %186 = add i32 %185, %183
  %187 = zext i32 %182 to i64
  %188 = zext i32 %186 to i64
  %189 = shl nuw i64 %188, 32
  %190 = or i64 %189, %187
  %191 = lshr i64 %190, 31
  %192 = trunc i64 %191 to i32
  %193 = add i32 %192, -2
  %194 = shl i32 %aSignificand.2, 1
  %195 = and i32 %193, 65535
  %196 = and i32 %194, 65534
  %197 = mul nuw i32 %195, %196
  %198 = lshr i32 %193, 16
  %199 = mul nuw i32 %198, %196
  %200 = lshr i32 %65, 15
  %201 = and i32 %200, 65535
  %202 = mul nuw i32 %195, %201
  %203 = mul nuw i32 %198, %201
  %204 = lshr i32 %197, 16
  %205 = and i32 %199, 65534
  %206 = add nuw nsw i32 %204, %205
  %207 = and i32 %202, 65535
  %208 = add nuw nsw i32 %206, %207
  %209 = lshr i32 %208, 16
  %210 = lshr i32 %199, 16
  %211 = lshr i32 %202, 16
  %212 = add i32 %210, %203
  %213 = add i32 %212, %211
  %214 = add i32 %213, %209
  %215 = icmp ult i32 %214, 16777216
  %216 = zext i1 %215 to i32
  %.neg6 = sext i1 %215 to i32
  %217 = add i32 %68, %.neg6
  %218 = xor i32 %216, 1
  %219 = lshr i32 %214, %218
  %220 = add nsw i32 %217, 127
  %221 = icmp sgt i32 %220, 254
  br i1 %221, label %222, label %225

; <label>:222                                     ; preds = %64
  %223 = or i32 %8, 2139095040
  %224 = bitcast i32 %223 to float
  br label %.thread

; <label>:225                                     ; preds = %64
  %226 = select i1 %215, i32 24, i32 23
  %227 = shl i32 %65, %226
  %228 = mul i32 %219, %66
  %229 = sub i32 %227, %228
  %230 = icmp slt i32 %220, 1
  %231 = shl i32 %229, 1
  %232 = icmp ugt i32 %231, %66
  br i1 %230, label %233, label %243

; <label>:233                                     ; preds = %225
  %234 = sub i32 -126, %217
  %235 = icmp ult i32 %234, 31
  %236 = select i1 %235, i32 %234, i32 31
  %237 = zext i1 %232 to i32
  %238 = add i32 %237, %219
  %239 = and i32 %236, 31
  %240 = lshr i32 %238, %239
  %241 = or i32 %240, %8
  %242 = bitcast i32 %241 to float
  br label %.thread

; <label>:243                                     ; preds = %225
  %244 = and i32 %219, 8388607
  %245 = shl i32 %220, 23
  %246 = or i32 %244, %245
  %247 = zext i1 %232 to i32
  %248 = add i32 %247, %246
  %249 = or i32 %248, %8
  %250 = bitcast i32 %249 to float
  br label %.thread

.thread:                                          ; preds = %30, %44, %36, %31, %24, %19, %222, %233, %243
  %.2 = phi float [ %224, %222 ], [ %242, %233 ], [ %250, %243 ], [ 0x7FF8000000000000, %30 ], [ %46, %44 ], [ %37, %36 ], [ %34, %31 ], [ %26, %24 ], [ %21, %19 ]
  ret float %.2
}

; Function Attrs: nounwind readnone
define i32 @__udivsi3(i32 signext %a, i32 signext %b) #0 {
  %1 = lshr i32 %a, 31
  %2 = icmp ult i32 %1, %b
  %3 = select i1 %2, i32 0, i32 -2147483648
  %4 = select i1 %2, i32 0, i32 %b
  %5 = sub i32 %1, %4
  %6 = shl i32 %5, 1
  %7 = lshr i32 %a, 30
  %8 = and i32 %7, 1
  %9 = or i32 %6, %8
  %10 = icmp ult i32 %9, %b
  %11 = select i1 %10, i32 0, i32 1073741824
  %12 = or i32 %11, %3
  %13 = select i1 %10, i32 0, i32 %b
  %14 = sub i32 %9, %13
  %15 = shl i32 %14, 1
  %16 = lshr i32 %a, 29
  %17 = and i32 %16, 1
  %18 = or i32 %15, %17
  %19 = icmp ult i32 %18, %b
  %20 = select i1 %19, i32 0, i32 536870912
  %21 = or i32 %12, %20
  %22 = select i1 %19, i32 0, i32 %b
  %23 = sub i32 %18, %22
  %24 = shl i32 %23, 1
  %25 = lshr i32 %a, 28
  %26 = and i32 %25, 1
  %27 = or i32 %24, %26
  %28 = icmp ult i32 %27, %b
  %29 = select i1 %28, i32 0, i32 268435456
  %30 = or i32 %21, %29
  %31 = select i1 %28, i32 0, i32 %b
  %32 = sub i32 %27, %31
  %33 = shl i32 %32, 1
  %34 = lshr i32 %a, 27
  %35 = and i32 %34, 1
  %36 = or i32 %33, %35
  %37 = icmp ult i32 %36, %b
  %38 = select i1 %37, i32 0, i32 134217728
  %39 = or i32 %30, %38
  %40 = select i1 %37, i32 0, i32 %b
  %41 = sub i32 %36, %40
  %42 = shl i32 %41, 1
  %43 = lshr i32 %a, 26
  %44 = and i32 %43, 1
  %45 = or i32 %42, %44
  %46 = icmp ult i32 %45, %b
  %47 = select i1 %46, i32 0, i32 67108864
  %48 = or i32 %39, %47
  %49 = select i1 %46, i32 0, i32 %b
  %50 = sub i32 %45, %49
  %51 = shl i32 %50, 1
  %52 = lshr i32 %a, 25
  %53 = and i32 %52, 1
  %54 = or i32 %51, %53
  %55 = icmp ult i32 %54, %b
  %56 = select i1 %55, i32 0, i32 33554432
  %57 = or i32 %48, %56
  %58 = select i1 %55, i32 0, i32 %b
  %59 = sub i32 %54, %58
  %60 = shl i32 %59, 1
  %61 = lshr i32 %a, 24
  %62 = and i32 %61, 1
  %63 = or i32 %60, %62
  %64 = icmp ult i32 %63, %b
  %65 = select i1 %64, i32 0, i32 16777216
  %66 = add i32 %65, %57
  %67 = select i1 %64, i32 0, i32 %b
  %68 = sub i32 %63, %67
  %69 = shl i32 %68, 1
  %70 = lshr i32 %a, 23
  %71 = and i32 %70, 1
  %72 = or i32 %69, %71
  %73 = icmp ult i32 %72, %b
  %74 = select i1 %73, i32 0, i32 8388608
  %75 = add i32 %66, %74
  %76 = select i1 %73, i32 0, i32 %b
  %77 = sub i32 %72, %76
  %78 = shl i32 %77, 1
  %79 = lshr i32 %a, 22
  %80 = and i32 %79, 1
  %81 = or i32 %78, %80
  %82 = icmp ult i32 %81, %b
  %83 = select i1 %82, i32 0, i32 4194304
  %84 = add i32 %75, %83
  %85 = select i1 %82, i32 0, i32 %b
  %86 = sub i32 %81, %85
  %87 = shl i32 %86, 1
  %88 = lshr i32 %a, 21
  %89 = and i32 %88, 1
  %90 = or i32 %87, %89
  %91 = icmp ult i32 %90, %b
  %92 = select i1 %91, i32 0, i32 2097152
  %93 = add i32 %84, %92
  %94 = select i1 %91, i32 0, i32 %b
  %95 = sub i32 %90, %94
  %96 = shl i32 %95, 1
  %97 = lshr i32 %a, 20
  %98 = and i32 %97, 1
  %99 = or i32 %96, %98
  %100 = icmp ult i32 %99, %b
  %101 = select i1 %100, i32 0, i32 1048576
  %102 = add i32 %93, %101
  %103 = select i1 %100, i32 0, i32 %b
  %104 = sub i32 %99, %103
  %105 = shl i32 %104, 1
  %106 = lshr i32 %a, 19
  %107 = and i32 %106, 1
  %108 = or i32 %105, %107
  %109 = icmp ult i32 %108, %b
  %110 = select i1 %109, i32 0, i32 524288
  %111 = add i32 %102, %110
  %112 = select i1 %109, i32 0, i32 %b
  %113 = sub i32 %108, %112
  %114 = shl i32 %113, 1
  %115 = lshr i32 %a, 18
  %116 = and i32 %115, 1
  %117 = or i32 %114, %116
  %118 = icmp ult i32 %117, %b
  %119 = select i1 %118, i32 0, i32 262144
  %120 = add i32 %111, %119
  %121 = select i1 %118, i32 0, i32 %b
  %122 = sub i32 %117, %121
  %123 = shl i32 %122, 1
  %124 = lshr i32 %a, 17
  %125 = and i32 %124, 1
  %126 = or i32 %123, %125
  %127 = icmp ult i32 %126, %b
  %128 = select i1 %127, i32 0, i32 131072
  %129 = add i32 %120, %128
  %130 = select i1 %127, i32 0, i32 %b
  %131 = sub i32 %126, %130
  %132 = shl i32 %131, 1
  %133 = lshr i32 %a, 16
  %134 = and i32 %133, 1
  %135 = or i32 %132, %134
  %136 = icmp ult i32 %135, %b
  %137 = select i1 %136, i32 0, i32 65536
  %138 = add i32 %129, %137
  %139 = select i1 %136, i32 0, i32 %b
  %140 = sub i32 %135, %139
  %141 = shl i32 %140, 1
  %142 = lshr i32 %a, 15
  %143 = and i32 %142, 1
  %144 = or i32 %141, %143
  %145 = icmp ult i32 %144, %b
  %146 = select i1 %145, i32 0, i32 32768
  %147 = add i32 %138, %146
  %148 = select i1 %145, i32 0, i32 %b
  %149 = sub i32 %144, %148
  %150 = shl i32 %149, 1
  %151 = lshr i32 %a, 14
  %152 = and i32 %151, 1
  %153 = or i32 %150, %152
  %154 = icmp ult i32 %153, %b
  %155 = select i1 %154, i32 0, i32 16384
  %156 = add i32 %147, %155
  %157 = select i1 %154, i32 0, i32 %b
  %158 = sub i32 %153, %157
  %159 = shl i32 %158, 1
  %160 = lshr i32 %a, 13
  %161 = and i32 %160, 1
  %162 = or i32 %159, %161
  %163 = icmp ult i32 %162, %b
  %164 = select i1 %163, i32 0, i32 8192
  %165 = add i32 %156, %164
  %166 = select i1 %163, i32 0, i32 %b
  %167 = sub i32 %162, %166
  %168 = shl i32 %167, 1
  %169 = lshr i32 %a, 12
  %170 = and i32 %169, 1
  %171 = or i32 %168, %170
  %172 = icmp ult i32 %171, %b
  %173 = select i1 %172, i32 0, i32 4096
  %174 = add i32 %165, %173
  %175 = select i1 %172, i32 0, i32 %b
  %176 = sub i32 %171, %175
  %177 = shl i32 %176, 1
  %178 = lshr i32 %a, 11
  %179 = and i32 %178, 1
  %180 = or i32 %177, %179
  %181 = icmp ult i32 %180, %b
  %182 = select i1 %181, i32 0, i32 2048
  %183 = add i32 %174, %182
  %184 = select i1 %181, i32 0, i32 %b
  %185 = sub i32 %180, %184
  %186 = shl i32 %185, 1
  %187 = lshr i32 %a, 10
  %188 = and i32 %187, 1
  %189 = or i32 %186, %188
  %190 = icmp ult i32 %189, %b
  %191 = select i1 %190, i32 0, i32 1024
  %192 = add i32 %183, %191
  %193 = select i1 %190, i32 0, i32 %b
  %194 = sub i32 %189, %193
  %195 = shl i32 %194, 1
  %196 = lshr i32 %a, 9
  %197 = and i32 %196, 1
  %198 = or i32 %195, %197
  %199 = icmp ult i32 %198, %b
  %200 = select i1 %199, i32 0, i32 512
  %201 = add i32 %192, %200
  %202 = select i1 %199, i32 0, i32 %b
  %203 = sub i32 %198, %202
  %204 = shl i32 %203, 1
  %205 = lshr i32 %a, 8
  %206 = and i32 %205, 1
  %207 = or i32 %204, %206
  %208 = icmp ult i32 %207, %b
  %209 = select i1 %208, i32 0, i32 256
  %210 = add i32 %201, %209
  %211 = select i1 %208, i32 0, i32 %b
  %212 = sub i32 %207, %211
  %213 = shl i32 %212, 1
  %214 = lshr i32 %a, 7
  %215 = and i32 %214, 1
  %216 = or i32 %213, %215
  %217 = icmp ult i32 %216, %b
  %218 = select i1 %217, i32 0, i32 128
  %219 = add i32 %210, %218
  %220 = select i1 %217, i32 0, i32 %b
  %221 = sub i32 %216, %220
  %222 = shl i32 %221, 1
  %223 = lshr i32 %a, 6
  %224 = and i32 %223, 1
  %225 = or i32 %222, %224
  %226 = icmp ult i32 %225, %b
  %227 = select i1 %226, i32 0, i32 64
  %228 = add i32 %219, %227
  %229 = select i1 %226, i32 0, i32 %b
  %230 = sub i32 %225, %229
  %231 = shl i32 %230, 1
  %232 = lshr i32 %a, 5
  %233 = and i32 %232, 1
  %234 = or i32 %231, %233
  %235 = icmp ult i32 %234, %b
  %236 = select i1 %235, i32 0, i32 32
  %237 = add i32 %228, %236
  %238 = select i1 %235, i32 0, i32 %b
  %239 = sub i32 %234, %238
  %240 = shl i32 %239, 1
  %241 = lshr i32 %a, 4
  %242 = and i32 %241, 1
  %243 = or i32 %240, %242
  %244 = icmp ult i32 %243, %b
  %245 = select i1 %244, i32 0, i32 16
  %246 = add i32 %237, %245
  %247 = select i1 %244, i32 0, i32 %b
  %248 = sub i32 %243, %247
  %249 = shl i32 %248, 1
  %250 = lshr i32 %a, 3
  %251 = and i32 %250, 1
  %252 = or i32 %249, %251
  %253 = icmp ult i32 %252, %b
  %254 = select i1 %253, i32 0, i32 8
  %255 = add i32 %246, %254
  %256 = select i1 %253, i32 0, i32 %b
  %257 = sub i32 %252, %256
  %258 = shl i32 %257, 1
  %259 = lshr i32 %a, 2
  %260 = and i32 %259, 1
  %261 = or i32 %258, %260
  %262 = icmp ult i32 %261, %b
  %263 = select i1 %262, i32 0, i32 4
  %264 = add i32 %255, %263
  %265 = select i1 %262, i32 0, i32 %b
  %266 = sub i32 %261, %265
  %267 = shl i32 %266, 1
  %268 = lshr i32 %a, 1
  %269 = and i32 %268, 1
  %270 = or i32 %267, %269
  %271 = icmp ult i32 %270, %b
  %272 = select i1 %271, i32 0, i32 2
  %273 = add i32 %264, %272
  %274 = select i1 %271, i32 0, i32 %b
  %275 = sub i32 %270, %274
  %276 = shl i32 %275, 1
  %277 = and i32 %a, 1
  %278 = or i32 %276, %277
  %not. = icmp uge i32 %278, %b
  %279 = zext i1 %not. to i32
  %280 = add i32 %273, %279
  ret i32 %280
}

; Function Attrs: nounwind readnone
define i32 @__divsi3(i32 signext %a, i32 signext %b) #0 {
  %1 = icmp slt i32 %a, 0
  %2 = sub nsw i32 0, %a
  %3 = select i1 %1, i32 %2, i32 %a
  %4 = icmp slt i32 %b, 0
  %5 = sub nsw i32 0, %b
  %6 = select i1 %4, i32 %5, i32 %b
  %7 = and i32 %b, %a
  %8 = icmp slt i32 %7, 0
  %9 = or i32 %b, %a
  %10 = icmp sgt i32 %9, -1
  %11 = or i1 %8, %10
  %12 = udiv i32 %3, %6
  %13 = sub i32 0, %12
  %14 = select i1 %11, i32 %12, i32 %13
  ret i32 %14
}

; Function Attrs: nounwind
define void @div_int(i32* nocapture readonly %in, i32* nocapture %out, i32 signext %val) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !10
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !11
  %3 = add nsw i32 %2, %1
  %4 = getelementptr inbounds i32, i32* %in, i32 %3
  %5 = load i32, i32* %4, align 4, !tbaa !12
  %6 = sdiv i32 %5, %val
  %7 = getelementptr inbounds i32, i32* %out, i32 %3
  store i32 %6, i32* %7, align 4, !tbaa !12
  ret void
}

; Function Attrs: nounwind
define void @div_float(float* nocapture readonly %in1, float* nocapture %out, float %val) #1 {
  %1 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !10
  %2 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !11
  %3 = add nsw i32 %2, %1
  %4 = getelementptr inbounds float, float* %in1, i32 %3
  %5 = load float, float* %4, align 4, !tbaa !16
  %6 = fdiv float %5, %val, !fpmath !18
  %7 = getelementptr inbounds float, float* %out, i32 %3
  store float %6, float* %7, align 4, !tbaa !16
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @llvm.ctlz.i32(i32, i1) #2

attributes #0 = { nounwind readnone "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!opencl.kernels = !{!0, !6}
!llvm.ident = !{!9}

!0 = !{void (i32*, i32*, i32)* @div_int, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"int*", !"int*", !"int"}
!4 = !{!"kernel_arg_base_type", !"int*", !"int*", !"int"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !""}
!6 = !{void (float*, float*, float)* @div_float, !1, !2, !7, !8, !5}
!7 = !{!"kernel_arg_type", !"float*", !"float*", !"float"}
!8 = !{!"kernel_arg_base_type", !"float*", !"float*", !"float"}
!9 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
!10 = !{i32 14696}
!11 = !{i32 14836}
!12 = !{!13, !13, i64 0}
!13 = !{!"int", !14, i64 0}
!14 = !{!"omnipotent char", !15, i64 0}
!15 = !{!"Simple C/C++ TBAA"}
!16 = !{!17, !17, i64 0}
!17 = !{!"float", !14, i64 0}
!18 = !{float 2.500000e+00}
