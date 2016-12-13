; ModuleID = 'div.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

; Function Attrs: nounwind readnone
define i32 @__udivsi3(i32 signext %a, i32 signext %b) #0 {
entry:
  %shr = lshr i32 %a, 31
  %cmp = icmp ult i32 %shr, %b
  %cond = select i1 %cmp, i32 0, i32 -2147483648
  %cond3 = select i1 %cmp, i32 0, i32 %b
  %sub = sub i32 %shr, %cond3
  %shl4 = shl i32 %sub, 1
  %shr5 = lshr i32 %a, 30
  %and6 = and i32 %shr5, 1
  %add7 = or i32 %shl4, %and6
  %cmp8 = icmp ult i32 %add7, %b
  %cond9 = select i1 %cmp8, i32 0, i32 1073741824
  %add10 = or i32 %cond9, %cond
  %cond15 = select i1 %cmp8, i32 0, i32 %b
  %sub16 = sub i32 %add7, %cond15
  %shl17 = shl i32 %sub16, 1
  %shr18 = lshr i32 %a, 29
  %and19 = and i32 %shr18, 1
  %add20 = or i32 %shl17, %and19
  %cmp21 = icmp ult i32 %add20, %b
  %cond22 = select i1 %cmp21, i32 0, i32 536870912
  %add23 = or i32 %add10, %cond22
  %cond28 = select i1 %cmp21, i32 0, i32 %b
  %sub29 = sub i32 %add20, %cond28
  %shl30 = shl i32 %sub29, 1
  %shr31 = lshr i32 %a, 28
  %and32 = and i32 %shr31, 1
  %add33 = or i32 %shl30, %and32
  %cmp34 = icmp ult i32 %add33, %b
  %cond35 = select i1 %cmp34, i32 0, i32 268435456
  %add36 = or i32 %add23, %cond35
  %cond41 = select i1 %cmp34, i32 0, i32 %b
  %sub42 = sub i32 %add33, %cond41
  %shl43 = shl i32 %sub42, 1
  %shr44 = lshr i32 %a, 27
  %and45 = and i32 %shr44, 1
  %add46 = or i32 %shl43, %and45
  %cmp47 = icmp ult i32 %add46, %b
  %cond48 = select i1 %cmp47, i32 0, i32 134217728
  %add49 = or i32 %add36, %cond48
  %cond54 = select i1 %cmp47, i32 0, i32 %b
  %sub55 = sub i32 %add46, %cond54
  %shl56 = shl i32 %sub55, 1
  %shr57 = lshr i32 %a, 26
  %and58 = and i32 %shr57, 1
  %add59 = or i32 %shl56, %and58
  %cmp60 = icmp ult i32 %add59, %b
  %cond61 = select i1 %cmp60, i32 0, i32 67108864
  %add62 = or i32 %add49, %cond61
  %cond67 = select i1 %cmp60, i32 0, i32 %b
  %sub68 = sub i32 %add59, %cond67
  %shl69 = shl i32 %sub68, 1
  %shr70 = lshr i32 %a, 25
  %and71 = and i32 %shr70, 1
  %add72 = or i32 %shl69, %and71
  %cmp73 = icmp ult i32 %add72, %b
  %cond74 = select i1 %cmp73, i32 0, i32 33554432
  %add75 = or i32 %add62, %cond74
  %cond80 = select i1 %cmp73, i32 0, i32 %b
  %sub81 = sub i32 %add72, %cond80
  %shl82 = shl i32 %sub81, 1
  %shr83 = lshr i32 %a, 24
  %and84 = and i32 %shr83, 1
  %add85 = or i32 %shl82, %and84
  %cmp86 = icmp ult i32 %add85, %b
  %cond87 = select i1 %cmp86, i32 0, i32 16777216
  %add88 = add i32 %cond87, %add75
  %cond93 = select i1 %cmp86, i32 0, i32 %b
  %sub94 = sub i32 %add85, %cond93
  %shl95 = shl i32 %sub94, 1
  %shr96 = lshr i32 %a, 23
  %and97 = and i32 %shr96, 1
  %add98 = or i32 %shl95, %and97
  %cmp99 = icmp ult i32 %add98, %b
  %cond100 = select i1 %cmp99, i32 0, i32 8388608
  %add101 = add i32 %add88, %cond100
  %cond106 = select i1 %cmp99, i32 0, i32 %b
  %sub107 = sub i32 %add98, %cond106
  %shl108 = shl i32 %sub107, 1
  %shr109 = lshr i32 %a, 22
  %and110 = and i32 %shr109, 1
  %add111 = or i32 %shl108, %and110
  %cmp112 = icmp ult i32 %add111, %b
  %cond113 = select i1 %cmp112, i32 0, i32 4194304
  %add114 = add i32 %add101, %cond113
  %cond119 = select i1 %cmp112, i32 0, i32 %b
  %sub120 = sub i32 %add111, %cond119
  %shl121 = shl i32 %sub120, 1
  %shr122 = lshr i32 %a, 21
  %and123 = and i32 %shr122, 1
  %add124 = or i32 %shl121, %and123
  %cmp125 = icmp ult i32 %add124, %b
  %cond126 = select i1 %cmp125, i32 0, i32 2097152
  %add127 = add i32 %add114, %cond126
  %cond132 = select i1 %cmp125, i32 0, i32 %b
  %sub133 = sub i32 %add124, %cond132
  %shl134 = shl i32 %sub133, 1
  %shr135 = lshr i32 %a, 20
  %and136 = and i32 %shr135, 1
  %add137 = or i32 %shl134, %and136
  %cmp138 = icmp ult i32 %add137, %b
  %cond139 = select i1 %cmp138, i32 0, i32 1048576
  %add140 = add i32 %add127, %cond139
  %cond145 = select i1 %cmp138, i32 0, i32 %b
  %sub146 = sub i32 %add137, %cond145
  %shl147 = shl i32 %sub146, 1
  %shr148 = lshr i32 %a, 19
  %and149 = and i32 %shr148, 1
  %add150 = or i32 %shl147, %and149
  %cmp151 = icmp ult i32 %add150, %b
  %cond152 = select i1 %cmp151, i32 0, i32 524288
  %add153 = add i32 %add140, %cond152
  %cond158 = select i1 %cmp151, i32 0, i32 %b
  %sub159 = sub i32 %add150, %cond158
  %shl160 = shl i32 %sub159, 1
  %shr161 = lshr i32 %a, 18
  %and162 = and i32 %shr161, 1
  %add163 = or i32 %shl160, %and162
  %cmp164 = icmp ult i32 %add163, %b
  %cond165 = select i1 %cmp164, i32 0, i32 262144
  %add166 = add i32 %add153, %cond165
  %cond171 = select i1 %cmp164, i32 0, i32 %b
  %sub172 = sub i32 %add163, %cond171
  %shl173 = shl i32 %sub172, 1
  %shr174 = lshr i32 %a, 17
  %and175 = and i32 %shr174, 1
  %add176 = or i32 %shl173, %and175
  %cmp177 = icmp ult i32 %add176, %b
  %cond178 = select i1 %cmp177, i32 0, i32 131072
  %add179 = add i32 %add166, %cond178
  %cond184 = select i1 %cmp177, i32 0, i32 %b
  %sub185 = sub i32 %add176, %cond184
  %shl186 = shl i32 %sub185, 1
  %shr187 = lshr i32 %a, 16
  %and188 = and i32 %shr187, 1
  %add189 = or i32 %shl186, %and188
  %cmp190 = icmp ult i32 %add189, %b
  %cond191 = select i1 %cmp190, i32 0, i32 65536
  %add192 = add i32 %add179, %cond191
  %cond197 = select i1 %cmp190, i32 0, i32 %b
  %sub198 = sub i32 %add189, %cond197
  %shl199 = shl i32 %sub198, 1
  %shr200 = lshr i32 %a, 15
  %and201 = and i32 %shr200, 1
  %add202 = or i32 %shl199, %and201
  %cmp203 = icmp ult i32 %add202, %b
  %cond204 = select i1 %cmp203, i32 0, i32 32768
  %add205 = add i32 %add192, %cond204
  %cond210 = select i1 %cmp203, i32 0, i32 %b
  %sub211 = sub i32 %add202, %cond210
  %shl212 = shl i32 %sub211, 1
  %shr213 = lshr i32 %a, 14
  %and214 = and i32 %shr213, 1
  %add215 = or i32 %shl212, %and214
  %cmp216 = icmp ult i32 %add215, %b
  %cond217 = select i1 %cmp216, i32 0, i32 16384
  %add218 = add i32 %add205, %cond217
  %cond223 = select i1 %cmp216, i32 0, i32 %b
  %sub224 = sub i32 %add215, %cond223
  %shl225 = shl i32 %sub224, 1
  %shr226 = lshr i32 %a, 13
  %and227 = and i32 %shr226, 1
  %add228 = or i32 %shl225, %and227
  %cmp229 = icmp ult i32 %add228, %b
  %cond230 = select i1 %cmp229, i32 0, i32 8192
  %add231 = add i32 %add218, %cond230
  %cond236 = select i1 %cmp229, i32 0, i32 %b
  %sub237 = sub i32 %add228, %cond236
  %shl238 = shl i32 %sub237, 1
  %shr239 = lshr i32 %a, 12
  %and240 = and i32 %shr239, 1
  %add241 = or i32 %shl238, %and240
  %cmp242 = icmp ult i32 %add241, %b
  %cond243 = select i1 %cmp242, i32 0, i32 4096
  %add244 = add i32 %add231, %cond243
  %cond249 = select i1 %cmp242, i32 0, i32 %b
  %sub250 = sub i32 %add241, %cond249
  %shl251 = shl i32 %sub250, 1
  %shr252 = lshr i32 %a, 11
  %and253 = and i32 %shr252, 1
  %add254 = or i32 %shl251, %and253
  %cmp255 = icmp ult i32 %add254, %b
  %cond256 = select i1 %cmp255, i32 0, i32 2048
  %add257 = add i32 %add244, %cond256
  %cond262 = select i1 %cmp255, i32 0, i32 %b
  %sub263 = sub i32 %add254, %cond262
  %shl264 = shl i32 %sub263, 1
  %shr265 = lshr i32 %a, 10
  %and266 = and i32 %shr265, 1
  %add267 = or i32 %shl264, %and266
  %cmp268 = icmp ult i32 %add267, %b
  %cond269 = select i1 %cmp268, i32 0, i32 1024
  %add270 = add i32 %add257, %cond269
  %cond275 = select i1 %cmp268, i32 0, i32 %b
  %sub276 = sub i32 %add267, %cond275
  %shl277 = shl i32 %sub276, 1
  %shr278 = lshr i32 %a, 9
  %and279 = and i32 %shr278, 1
  %add280 = or i32 %shl277, %and279
  %cmp281 = icmp ult i32 %add280, %b
  %cond282 = select i1 %cmp281, i32 0, i32 512
  %add283 = add i32 %add270, %cond282
  %cond288 = select i1 %cmp281, i32 0, i32 %b
  %sub289 = sub i32 %add280, %cond288
  %shl290 = shl i32 %sub289, 1
  %shr291 = lshr i32 %a, 8
  %and292 = and i32 %shr291, 1
  %add293 = or i32 %shl290, %and292
  %cmp294 = icmp ult i32 %add293, %b
  %cond295 = select i1 %cmp294, i32 0, i32 256
  %add296 = add i32 %add283, %cond295
  %cond301 = select i1 %cmp294, i32 0, i32 %b
  %sub302 = sub i32 %add293, %cond301
  %shl303 = shl i32 %sub302, 1
  %shr304 = lshr i32 %a, 7
  %and305 = and i32 %shr304, 1
  %add306 = or i32 %shl303, %and305
  %cmp307 = icmp ult i32 %add306, %b
  %cond308 = select i1 %cmp307, i32 0, i32 128
  %add309 = add i32 %add296, %cond308
  %cond314 = select i1 %cmp307, i32 0, i32 %b
  %sub315 = sub i32 %add306, %cond314
  %shl316 = shl i32 %sub315, 1
  %shr317 = lshr i32 %a, 6
  %and318 = and i32 %shr317, 1
  %add319 = or i32 %shl316, %and318
  %cmp320 = icmp ult i32 %add319, %b
  %cond321 = select i1 %cmp320, i32 0, i32 64
  %add322 = add i32 %add309, %cond321
  %cond327 = select i1 %cmp320, i32 0, i32 %b
  %sub328 = sub i32 %add319, %cond327
  %shl329 = shl i32 %sub328, 1
  %shr330 = lshr i32 %a, 5
  %and331 = and i32 %shr330, 1
  %add332 = or i32 %shl329, %and331
  %cmp333 = icmp ult i32 %add332, %b
  %cond334 = select i1 %cmp333, i32 0, i32 32
  %add335 = add i32 %add322, %cond334
  %cond340 = select i1 %cmp333, i32 0, i32 %b
  %sub341 = sub i32 %add332, %cond340
  %shl342 = shl i32 %sub341, 1
  %shr343 = lshr i32 %a, 4
  %and344 = and i32 %shr343, 1
  %add345 = or i32 %shl342, %and344
  %cmp346 = icmp ult i32 %add345, %b
  %cond347 = select i1 %cmp346, i32 0, i32 16
  %add348 = add i32 %add335, %cond347
  %cond353 = select i1 %cmp346, i32 0, i32 %b
  %sub354 = sub i32 %add345, %cond353
  %shl355 = shl i32 %sub354, 1
  %shr356 = lshr i32 %a, 3
  %and357 = and i32 %shr356, 1
  %add358 = or i32 %shl355, %and357
  %cmp359 = icmp ult i32 %add358, %b
  %cond360 = select i1 %cmp359, i32 0, i32 8
  %add361 = add i32 %add348, %cond360
  %cond366 = select i1 %cmp359, i32 0, i32 %b
  %sub367 = sub i32 %add358, %cond366
  %shl368 = shl i32 %sub367, 1
  %shr369 = lshr i32 %a, 2
  %and370 = and i32 %shr369, 1
  %add371 = or i32 %shl368, %and370
  %cmp372 = icmp ult i32 %add371, %b
  %cond373 = select i1 %cmp372, i32 0, i32 4
  %add374 = add i32 %add361, %cond373
  %cond379 = select i1 %cmp372, i32 0, i32 %b
  %sub380 = sub i32 %add371, %cond379
  %shl381 = shl i32 %sub380, 1
  %shr382 = lshr i32 %a, 1
  %and383 = and i32 %shr382, 1
  %add384 = or i32 %shl381, %and383
  %cmp385 = icmp ult i32 %add384, %b
  %cond386 = select i1 %cmp385, i32 0, i32 2
  %add387 = add i32 %add374, %cond386
  %cond392 = select i1 %cmp385, i32 0, i32 %b
  %sub393 = sub i32 %add384, %cond392
  %shl394 = shl i32 %sub393, 1
  %and396 = and i32 %a, 1
  %add397 = or i32 %shl394, %and396
  %not.cmp398 = icmp uge i32 %add397, %b
  %cond399 = zext i1 %not.cmp398 to i32
  %add400 = add i32 %add387, %cond399
  ret i32 %add400
}

; Function Attrs: nounwind readnone
define i32 @__divsi3(i32 signext %a, i32 signext %b) #0 {
entry:
  %cmp = icmp slt i32 %a, 0
  %sub = sub nsw i32 0, %a
  %cond = select i1 %cmp, i32 %sub, i32 %a
  %cmp1 = icmp slt i32 %b, 0
  %sub3 = sub nsw i32 0, %b
  %cond6 = select i1 %cmp1, i32 %sub3, i32 %b
  %0 = and i32 %b, %a
  %1 = icmp slt i32 %0, 0
  %2 = or i32 %b, %a
  %3 = icmp sgt i32 %2, -1
  %4 = or i1 %1, %3
  %div = udiv i32 %cond, %cond6
  %sub13 = sub i32 0, %div
  %cond15 = select i1 %4, i32 %div, i32 %sub13
  ret i32 %cond15
}

; Function Attrs: nounwind
define void @div_int(i32* nocapture readonly %in, i32* nocapture %out, i32 signext %val) #1 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !10
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !11
  %add.i = add nsw i32 %1, %0
  %arrayidx = getelementptr inbounds i32, i32* %in, i32 %add.i
  %2 = load i32, i32* %arrayidx, align 4, !tbaa !12
  %div = sdiv i32 %2, %val
  %arrayidx1 = getelementptr inbounds i32, i32* %out, i32 %add.i
  store i32 %div, i32* %arrayidx1, align 4, !tbaa !12
  ret void
}

; Function Attrs: nounwind readnone
define float @__divsf3(float %a, float %b) #0 {
entry:
  %0 = bitcast float %a to i32
  %shr = lshr i32 %0, 23
  %and = and i32 %shr, 255
  %1 = bitcast float %b to i32
  %shr2 = lshr i32 %1, 23
  %and3 = and i32 %shr2, 255
  %xor = xor i32 %1, %0
  %and6 = and i32 %xor, -2147483648
  %and8 = and i32 %0, 8388607
  %and10 = and i32 %1, 8388607
  %sub = add nsw i32 %and, -1
  %cmp = icmp ugt i32 %sub, 253
  %sub11 = add nsw i32 %and3, -1
  %cmp12 = icmp ugt i32 %sub11, 253
  %or.cond = or i1 %cmp, %cmp12
  br i1 %or.cond, label %if.then, label %if.end.61

if.then:                                          ; preds = %entry
  %and14 = and i32 %0, 2147483647
  %and16 = and i32 %1, 2147483647
  %cmp17 = icmp ugt i32 %and14, 2139095040
  br i1 %cmp17, label %if.then.18, label %if.end

if.then.18:                                       ; preds = %if.then
  %or = or i32 %0, 4194304
  %2 = bitcast i32 %or to float
  br label %cleanup.146

if.end:                                           ; preds = %if.then
  %cmp21 = icmp ugt i32 %and16, 2139095040
  br i1 %cmp21, label %if.then.22, label %if.end.26

if.then.22:                                       ; preds = %if.end
  %or24 = or i32 %1, 4194304
  %3 = bitcast i32 %or24 to float
  br label %cleanup.146

if.end.26:                                        ; preds = %if.end
  %cmp27 = icmp eq i32 %and14, 2139095040
  %cmp29 = icmp eq i32 %and16, 2139095040
  br i1 %cmp27, label %if.then.28, label %if.end.34

if.then.28:                                       ; preds = %if.end.26
  br i1 %cmp29, label %cleanup.146, label %if.else

if.else:                                          ; preds = %if.then.28
  %4 = and i32 %1, -2147483648
  %or32 = xor i32 %4, %0
  %5 = bitcast i32 %or32 to float
  br label %cleanup.146

if.end.34:                                        ; preds = %if.end.26
  br i1 %cmp29, label %if.then.36, label %if.end.38

if.then.36:                                       ; preds = %if.end.34
  %6 = bitcast i32 %and6 to float
  br label %cleanup.146

if.end.38:                                        ; preds = %if.end.34
  %tobool = icmp eq i32 %and14, 0
  %tobool46 = icmp ne i32 %and16, 0
  br i1 %tobool, label %if.then.39, label %if.end.45

if.then.39:                                       ; preds = %if.end.38
  %7 = bitcast i32 %and6 to float
  %. = select i1 %tobool46, float %7, float 0x7FF8000000000000
  ret float %.

if.end.45:                                        ; preds = %if.end.38
  br i1 %tobool46, label %if.end.50, label %if.then.47

if.then.47:                                       ; preds = %if.end.45
  %or48 = or i32 %and6, 2139095040
  %8 = bitcast i32 %or48 to float
  br label %cleanup.146

if.end.50:                                        ; preds = %if.end.45
  %cmp51 = icmp ult i32 %and14, 8388608
  br i1 %cmp51, label %if.then.52, label %if.end.54

if.then.52:                                       ; preds = %if.end.50
  %9 = tail call i32 @llvm.ctlz.i32(i32 %and8, i1 false) #3
  %sub.i.339 = add nuw nsw i32 %9, 24
  %shl.mask.i.340 = and i32 %sub.i.339, 31
  %shl.i.341 = shl i32 %and8, %shl.mask.i.340
  %sub2.i.342 = sub nsw i32 9, %9
  br label %if.end.54

if.end.54:                                        ; preds = %if.then.52, %if.end.50
  %aSignificand.0 = phi i32 [ %shl.i.341, %if.then.52 ], [ %and8, %if.end.50 ]
  %scale.0 = phi i32 [ %sub2.i.342, %if.then.52 ], [ 0, %if.end.50 ]
  %cmp55 = icmp ult i32 %and16, 8388608
  br i1 %cmp55, label %if.then.56, label %if.end.61

if.then.56:                                       ; preds = %if.end.54
  %10 = tail call i32 @llvm.ctlz.i32(i32 %and10, i1 false) #3
  %sub.i = add nuw nsw i32 %10, 24
  %shl.mask.i = and i32 %sub.i, 31
  %shl.i = shl i32 %and10, %shl.mask.i
  %sub2.i354 = add nsw i32 %scale.0, -9
  %sub58 = add nsw i32 %sub2.i354, %10
  br label %if.end.61

if.end.61:                                        ; preds = %if.then.56, %if.end.54, %entry
  %aSignificand.2 = phi i32 [ %and8, %entry ], [ %aSignificand.0, %if.then.56 ], [ %aSignificand.0, %if.end.54 ]
  %bSignificand.1 = phi i32 [ %and10, %entry ], [ %shl.i, %if.then.56 ], [ %and10, %if.end.54 ]
  %scale.3 = phi i32 [ 0, %entry ], [ %sub58, %if.then.56 ], [ %scale.0, %if.end.54 ]
  %or62 = or i32 %aSignificand.2, 8388608
  %or63 = or i32 %bSignificand.1, 8388608
  %sub64 = sub nsw i32 %and, %and3
  %add65 = add nsw i32 %sub64, %scale.3
  %shl = shl i32 %or63, 8
  %sub66 = sub i32 1963258675, %shl
  %and.i.320 = and i32 %sub66, 65331
  %and1.i.321 = and i32 %shl, 65280
  %mul.i.322 = mul nuw i32 %and.i.320, %and1.i.321
  %shr.i.323 = lshr i32 %sub66, 16
  %mul3.i.324 = mul nuw i32 %shr.i.323, %and1.i.321
  %11 = lshr i32 %or63, 8
  %shr4.i.325 = and i32 %11, 65535
  %mul6.i.326 = mul nuw i32 %and.i.320, %shr4.i.325
  %mul9.i.327 = mul nuw i32 %shr.i.323, %shr4.i.325
  %shr10.i.328 = lshr i32 %mul.i.322, 16
  %and11.i.329 = and i32 %mul3.i.324, 65280
  %add.i.330 = add nuw nsw i32 %shr10.i.328, %and11.i.329
  %and12.i.331 = and i32 %mul6.i.326, 65535
  %add13.i.332 = add nuw nsw i32 %add.i.330, %and12.i.331
  %shr14.i.333 = lshr i32 %add13.i.332, 16
  %shr15.i.334 = lshr i32 %mul3.i.324, 16
  %shr17.i.335 = lshr i32 %mul6.i.326, 16
  %add16.i.336 = add i32 %mul9.i.327, %shr15.i.334
  %add18.i.337 = add i32 %shr17.i.335, %add16.i.336
  %add19.i.338 = add i32 %add18.i.337, %shr14.i.333
  %sub68 = sub i32 0, %add19.i.338
  %and1.i.297 = and i32 %sub68, 65535
  %mul.i.298 = mul nuw i32 %and1.i.297, %and.i.320
  %shr.i.299 = lshr i32 %mul.i.298, 16
  %mul9.i.302 = mul nuw i32 %and1.i.297, %shr.i.323
  %add.i.303 = add i32 %shr.i.299, %mul9.i.302
  %shr14.i.304 = lshr i32 %add.i.303, 16
  %shr18.i.305 = and i32 %add.i.303, 65535
  %shr22.i.306 = lshr i32 %sub68, 16
  %mul24.i.307 = mul nuw i32 %shr22.i.306, %and.i.320
  %add25.i.308 = add i32 %shr18.i.305, %mul24.i.307
  %fold.i.309 = add i32 %add.i.303, %mul24.i.307
  %shl27.i.310 = shl i32 %fold.i.309, 16
  %shr31.i.312 = lshr i32 %add25.i.308, 16
  %mul37.i.313 = mul nuw i32 %shr22.i.306, %shr.i.323
  %add34.i.314 = add i32 %shr14.i.304, %mul37.i.313
  %add40.i.315 = add i32 %add34.i.314, %shr31.i.312
  %r.sroa.8.0.insert.ext.i.316 = zext i32 %shl27.i.310 to i64
  %r.sroa.0.0.insert.ext.i.317 = zext i32 %add40.i.315 to i64
  %r.sroa.0.0.insert.shift.i.318 = shl nuw i64 %r.sroa.0.0.insert.ext.i.317, 32
  %r.sroa.0.0.insert.insert.i.319 = or i64 %r.sroa.0.0.insert.shift.i.318, %r.sroa.8.0.insert.ext.i.316
  %shr70.224 = lshr i64 %r.sroa.0.0.insert.insert.i.319, 31
  %conv = trunc i64 %shr70.224 to i32
  %and.i.277 = and i32 %conv, 65535
  %mul.i.279 = mul nuw i32 %and.i.277, %and1.i.321
  %shr.i.280350 = lshr i32 %add40.i.315, 15
  %shr.i.280 = and i32 %shr.i.280350, 65535
  %mul3.i.281 = mul nuw i32 %shr.i.280, %and1.i.321
  %mul6.i.283 = mul nuw i32 %and.i.277, %shr4.i.325
  %mul9.i.284 = mul nuw i32 %shr.i.280, %shr4.i.325
  %shr10.i.285 = lshr i32 %mul.i.279, 16
  %and11.i.286 = and i32 %mul3.i.281, 65280
  %add.i.287 = add nuw nsw i32 %shr10.i.285, %and11.i.286
  %and12.i.288 = and i32 %mul6.i.283, 65535
  %add13.i.289 = add nuw nsw i32 %add.i.287, %and12.i.288
  %shr14.i.290 = lshr i32 %add13.i.289, 16
  %shr15.i.291 = lshr i32 %mul3.i.281, 16
  %shr17.i.292 = lshr i32 %mul6.i.283, 16
  %add16.i.293 = add i32 %mul9.i.284, %shr15.i.291
  %add18.i.294 = add i32 %add16.i.293, %shr17.i.292
  %add19.i.295 = add i32 %add18.i.294, %shr14.i.290
  %sub72 = sub i32 0, %add19.i.295
  %and1.i.254 = and i32 %sub72, 65535
  %mul.i.255 = mul nuw i32 %and1.i.254, %and.i.277
  %shr.i.256 = lshr i32 %mul.i.255, 16
  %mul9.i.259 = mul nuw i32 %and1.i.254, %shr.i.280
  %add.i.260 = add i32 %shr.i.256, %mul9.i.259
  %shr14.i.261 = lshr i32 %add.i.260, 16
  %shr18.i.262 = and i32 %add.i.260, 65535
  %shr22.i.263 = lshr i32 %sub72, 16
  %mul24.i.264 = mul nuw i32 %shr22.i.263, %and.i.277
  %add25.i.265 = add i32 %shr18.i.262, %mul24.i.264
  %fold.i.266 = add i32 %add.i.260, %mul24.i.264
  %shl27.i.267 = shl i32 %fold.i.266, 16
  %shr31.i.269 = lshr i32 %add25.i.265, 16
  %mul37.i.270 = mul nuw i32 %shr22.i.263, %shr.i.280
  %add34.i.271 = add i32 %shr14.i.261, %mul37.i.270
  %add40.i.272 = add i32 %add34.i.271, %shr31.i.269
  %r.sroa.8.0.insert.ext.i.273 = zext i32 %shl27.i.267 to i64
  %r.sroa.0.0.insert.ext.i.274 = zext i32 %add40.i.272 to i64
  %r.sroa.0.0.insert.shift.i.275 = shl nuw i64 %r.sroa.0.0.insert.ext.i.274, 32
  %r.sroa.0.0.insert.insert.i.276 = or i64 %r.sroa.0.0.insert.shift.i.275, %r.sroa.8.0.insert.ext.i.273
  %shr74.225 = lshr i64 %r.sroa.0.0.insert.insert.i.276, 31
  %conv75 = trunc i64 %shr74.225 to i32
  %and.i.234 = and i32 %conv75, 65535
  %mul.i.236 = mul nuw i32 %and.i.234, %and1.i.321
  %shr.i.237352 = lshr i32 %add40.i.272, 15
  %shr.i.237 = and i32 %shr.i.237352, 65535
  %mul3.i.238 = mul nuw i32 %shr.i.237, %and1.i.321
  %mul6.i.240 = mul nuw i32 %and.i.234, %shr4.i.325
  %mul9.i.241 = mul nuw i32 %shr.i.237, %shr4.i.325
  %shr10.i.242 = lshr i32 %mul.i.236, 16
  %and11.i.243 = and i32 %mul3.i.238, 65280
  %add.i.244 = add nuw nsw i32 %shr10.i.242, %and11.i.243
  %and12.i.245 = and i32 %mul6.i.240, 65535
  %add13.i.246 = add nuw nsw i32 %add.i.244, %and12.i.245
  %shr14.i.247 = lshr i32 %add13.i.246, 16
  %shr15.i.248 = lshr i32 %mul3.i.238, 16
  %shr17.i.249 = lshr i32 %mul6.i.240, 16
  %add16.i.250 = add i32 %mul9.i.241, %shr15.i.248
  %add18.i.251 = add i32 %add16.i.250, %shr17.i.249
  %add19.i.252 = add i32 %add18.i.251, %shr14.i.247
  %sub77 = sub i32 0, %add19.i.252
  %and1.i.228 = and i32 %sub77, 65535
  %mul.i.229 = mul nuw i32 %and1.i.228, %and.i.234
  %shr.i.230 = lshr i32 %mul.i.229, 16
  %mul9.i.231 = mul nuw i32 %and1.i.228, %shr.i.237
  %add.i.232 = add i32 %shr.i.230, %mul9.i.231
  %shr14.i.233 = lshr i32 %add.i.232, 16
  %shr18.i = and i32 %add.i.232, 65535
  %shr22.i = lshr i32 %sub77, 16
  %mul24.i = mul nuw i32 %shr22.i, %and.i.234
  %add25.i = add i32 %shr18.i, %mul24.i
  %fold.i = add i32 %add.i.232, %mul24.i
  %shl27.i = shl i32 %fold.i, 16
  %shr31.i = lshr i32 %add25.i, 16
  %mul37.i = mul nuw i32 %shr22.i, %shr.i.237
  %add34.i = add i32 %shr14.i.233, %mul37.i
  %add40.i = add i32 %add34.i, %shr31.i
  %r.sroa.8.0.insert.ext.i = zext i32 %shl27.i to i64
  %r.sroa.0.0.insert.ext.i = zext i32 %add40.i to i64
  %r.sroa.0.0.insert.shift.i = shl nuw i64 %r.sroa.0.0.insert.ext.i, 32
  %r.sroa.0.0.insert.insert.i = or i64 %r.sroa.0.0.insert.shift.i, %r.sroa.8.0.insert.ext.i
  %shr79.226 = lshr i64 %r.sroa.0.0.insert.insert.i, 31
  %conv80 = trunc i64 %shr79.226 to i32
  %sub81 = add i32 %conv80, -2
  %shl82 = shl i32 %aSignificand.2, 1
  %and.i = and i32 %sub81, 65535
  %and1.i = and i32 %shl82, 65534
  %mul.i = mul nuw i32 %and.i, %and1.i
  %shr.i = lshr i32 %sub81, 16
  %mul3.i = mul nuw i32 %shr.i, %and1.i
  %12 = lshr i32 %or62, 15
  %shr4.i = and i32 %12, 65535
  %mul6.i = mul nuw i32 %and.i, %shr4.i
  %mul9.i = mul nuw i32 %shr.i, %shr4.i
  %shr10.i = lshr i32 %mul.i, 16
  %and11.i = and i32 %mul3.i, 65534
  %add.i = add nuw nsw i32 %shr10.i, %and11.i
  %and12.i = and i32 %mul6.i, 65535
  %add13.i = add nuw nsw i32 %add.i, %and12.i
  %shr14.i = lshr i32 %add13.i, 16
  %shr15.i = lshr i32 %mul3.i, 16
  %shr17.i = lshr i32 %mul6.i, 16
  %add16.i = add i32 %shr15.i, %mul9.i
  %add18.i = add i32 %add16.i, %shr17.i
  %add19.i = add i32 %add18.i, %shr14.i
  %cmp84 = icmp ult i32 %add19.i, 16777216
  %cond = zext i1 %cmp84 to i32
  %cond.neg = sext i1 %cmp84 to i32
  %sub87 = add i32 %add65, %cond.neg
  %cond89 = xor i32 %cond, 1
  %shr90 = lshr i32 %add19.i, %cond89
  %add95 = add nsw i32 %sub87, 127
  %cmp96 = icmp sgt i32 %add95, 254
  br i1 %cmp96, label %if.then.98, label %if.else.101

if.then.98:                                       ; preds = %if.end.61
  %or99 = or i32 %and6, 2139095040
  %13 = bitcast i32 %or99 to float
  br label %cleanup.146

if.else.101:                                      ; preds = %if.end.61
  %cond92 = select i1 %cmp84, i32 24, i32 23
  %shl93 = shl i32 %or62, %cond92
  %mul = mul i32 %shr90, %or63
  %sub94 = sub i32 %shl93, %mul
  %cmp102 = icmp slt i32 %add95, 1
  %shl105 = shl i32 %sub94, 1
  %cmp106 = icmp ugt i32 %shl105, %or63
  br i1 %cmp102, label %if.then.104, label %if.else.122

if.then.104:                                      ; preds = %if.else.101
  %sub108 = sub i32 -126, %sub87
  %cmp109 = icmp ult i32 %sub108, 31
  %cond111 = select i1 %cmp109, i32 %sub108, i32 31
  %conv113 = zext i1 %cmp106 to i32
  %add114 = add i32 %conv113, %shr90
  %shr.mask115 = and i32 %cond111, 31
  %shr116 = lshr i32 %add114, %shr.mask115
  %or117 = or i32 %shr116, %and6
  %14 = bitcast i32 %or117 to float
  br label %cleanup.146

if.else.122:                                      ; preds = %if.else.101
  %and128 = and i32 %shr90, 8388607
  %shl129 = shl i32 %add95, 23
  %or130 = or i32 %and128, %shl129
  %conv132 = zext i1 %cmp106 to i32
  %add133 = add i32 %conv132, %or130
  %or134 = or i32 %add133, %and6
  %15 = bitcast i32 %or134 to float
  br label %cleanup.146

cleanup.146:                                      ; preds = %if.then.28, %if.then.47, %if.then.36, %if.else, %if.then.22, %if.then.18, %if.then.98, %if.then.104, %if.else.122
  %retval.2 = phi float [ %13, %if.then.98 ], [ %14, %if.then.104 ], [ %15, %if.else.122 ], [ 0x7FF8000000000000, %if.then.28 ], [ %8, %if.then.47 ], [ %6, %if.then.36 ], [ %5, %if.else ], [ %3, %if.then.22 ], [ %2, %if.then.18 ]
  ret float %retval.2
}

; Function Attrs: nounwind
define void @div_float(float* nocapture readonly %in1, float* nocapture %out, float %val) #1 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !10
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !11
  %add.i = add nsw i32 %1, %0
  %arrayidx = getelementptr inbounds float, float* %in1, i32 %add.i
  %2 = load float, float* %arrayidx, align 4, !tbaa !16
  %div = fdiv float %2, %val, !fpmath !18
  %arrayidx1 = getelementptr inbounds float, float* %out, i32 %add.i
  store float %div, float* %arrayidx1, align 4, !tbaa !16
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
!9 = !{!"clang version 3.7.0 (tags/RELEASE_371/final)"}
!10 = !{i32 14847}
!11 = !{i32 14987}
!12 = !{!13, !13, i64 0}
!13 = !{!"int", !14, i64 0}
!14 = !{!"omnipotent char", !15, i64 0}
!15 = !{!"Simple C/C++ TBAA"}
!16 = !{!17, !17, i64 0}
!17 = !{!"float", !14, i64 0}
!18 = !{float 2.500000e+00}
