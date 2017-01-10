; ModuleID = 'ludecomposition_fadd_fmul_hard_float.cl'
target datalayout = "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
target triple = "mips-unknown-uknown"

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
define void @ludecomposition_L_pass_fadd_fmul_hard_float(float* nocapture readonly %mat, float* nocapture %L, i32 signext %size, i32 signext %k) #1 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !8
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !9
  %add.i = add nsw i32 %1, %0
  %cmp = icmp ult i32 %add.i, %size
  br i1 %cmp, label %if.then, label %if.end.13

if.then:                                          ; preds = %entry
  %mul = mul i32 %add.i, %size
  %add = add i32 %mul, %k
  %arrayidx = getelementptr inbounds float, float* %mat, i32 %add
  %2 = load float, float* %arrayidx, align 4, !tbaa !10
  %mul1 = mul i32 %k, %size
  %add2 = add i32 %mul1, %k
  %arrayidx3 = getelementptr inbounds float, float* %mat, i32 %add2
  %3 = load float, float* %arrayidx3, align 4, !tbaa !10
  %div = fdiv float %2, %3, !fpmath !14
  %arrayidx6 = getelementptr inbounds float, float* %L, i32 %add
  store float %div, float* %arrayidx6, align 4, !tbaa !10
  %add7 = add i32 %k, 1
  %cmp8 = icmp eq i32 %add.i, %add7
  br i1 %cmp8, label %if.then.9, label %if.end.13

if.then.9:                                        ; preds = %if.then
  %arrayidx12 = getelementptr inbounds float, float* %L, i32 %add2
  store float 1.000000e+00, float* %arrayidx12, align 4, !tbaa !10
  br label %if.end.13

if.end.13:                                        ; preds = %if.then, %if.then.9, %entry
  ret void
}

; Function Attrs: nounwind
define void @ludecomposition_U_pass_fmul_fadd_hard_float(float* nocapture %mat, float* nocapture readonly %L, i32 signext %size, i32 signext %k) #1 {
entry:
  %0 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 1) #3, !srcloc !8
  %1 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 1) #3, !srcloc !9
  %add.i = add nsw i32 %1, %0
  %2 = tail call i32 asm sideeffect "lid $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !8
  %3 = tail call i32 asm sideeffect "wgoff $0, $1", "=r,I,~{$1}"(i32 0) #3, !srcloc !9
  %add.i.39 = add nsw i32 %3, %2
  %mul = mul i32 %add.i, %size
  %add = add i32 %mul, %k
  %arrayidx = getelementptr inbounds float, float* %L, i32 %add
  %4 = load float, float* %arrayidx, align 4, !tbaa !10
  %add9 = add i32 %add.i.39, %mul
  %arrayidx10 = getelementptr inbounds float, float* %mat, i32 %add9
  %5 = load float, float* %arrayidx10, align 4, !tbaa !10
  %mul11 = mul i32 %k, %size
  %add12 = add i32 %add.i.39, %mul11
  %arrayidx13 = getelementptr inbounds float, float* %mat, i32 %add12
  %6 = load float, float* %arrayidx13, align 4, !tbaa !10
  %neg = fsub float -0.000000e+00, %4
  %7 = tail call float @llvm.fmuladd.f32(float %neg, float %6, float %5)
  store float %7, float* %arrayidx10, align 4, !tbaa !10
  ret void
}

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

; Function Attrs: nounwind readnone
declare i32 @llvm.ctlz.i32(i32, i1) #2

attributes #0 = { nounwind readnone "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="mips32r2" "target-features"="+mips32r2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!opencl.kernels = !{!0, !6}
!llvm.ident = !{!7}

!0 = !{void (float*, float*, i32, i32)* @ludecomposition_L_pass_fadd_fmul_hard_float, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float*", !"float*", !"uint", !"uint"}
!4 = !{!"kernel_arg_base_type", !"float*", !"float*", !"uint", !"uint"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !"", !""}
!6 = !{void (float*, float*, i32, i32)* @ludecomposition_U_pass_fmul_fadd_hard_float, !1, !2, !3, !4, !5}
!7 = !{!"clang version 3.7.0 (tags/RELEASE_371/final)"}
!8 = !{i32 12994}
!9 = !{i32 13134}
!10 = !{!11, !11, i64 0}
!11 = !{!"float", !12, i64 0}
!12 = !{!"omnipotent char", !13, i64 0}
!13 = !{!"Simple C/C++ TBAA"}
!14 = !{float 2.500000e+00}
