	.text
	.section .mdebug.cc_fgpu
	.previous
	.file	"compiler_outputs/xcorr.ll"
	.globl	__addsf3
	.align	2
	.type	__addsf3,@function
	.ent	__addsf3                # @__addsf3
__addsf3:
	.frame	sp,8,lr
	.mask 	0x00000600,-4
	.set	noreorder
	.set	nomacro
# BB#0:
	addi	sp, sp, -2
	lswi	r9, sp[4]               # 4-byte Folded Spill
	lswi	r10, sp[0]              # 4-byte Folded Spill
	li	r3, 65535
	lui	r3, 32767
	and	r4, r1, r3
	addi	r5, r4, -1
	li	r6, 65534
	lui	r6, 32639
	sltu	r6, r6, r5
	and	r5, r2, r3
	bne	r6, r0, LBB0_2
# BB#1:
	addi	r3, r5, -1
	li	r6, 65535
	lui	r6, 32639
	sltu	r3, r3, r6
	bne	r3, r0, LBB0_9
LBB0_2:
	xor	r3, r2, r1
	li	r6, 0
	lui	r6, 32768
	xor	r3, r3, r6
	li	r8, 0
	lui	r8, 32704
	add	r7, r0, r1
	movz	r7, r8, r3
	li	r6, 0
	lui	r6, 32640
	xor	r9, r4, r6
	add	r3, r0, r1
	movz	r3, r7, r9
	sltu	r7, r6, r5
	sltu	r9, r6, r4
	or	r7, r9, r7
	movn	r3, r8, r7
	beq	r4, r6, LBB0_27
# BB#3:
	bne	r7, r0, LBB0_27
# BB#4:
	add	r3, r0, r2
	beq	r5, r6, LBB0_27
# BB#5:
	bne	r4, r0, LBB0_8
	beq	r0, r0, LBB0_6
LBB0_8:
	add	r3, r0, r1
	beq	r5, r0, LBB0_27
LBB0_9:
	sltu	r3, r4, r5
	add	r4, r0, r1
	movn	r4, r2, r3
	movn	r2, r1, r3
	li	r1, 65535
	lui	r1, 127
	and	r3, r4, r1
	srli	r5, r2, 23
	andi	r6, r5, 255
	srli	r5, r4, 23
	andi	r5, r5, 255
	bne	r5, r0, LBB0_11
# BB#10:
	srli	r5, r3, 1
	or	r5, r3, r5
	srli	r7, r5, 2
	or	r5, r5, r7
	srli	r7, r5, 4
	or	r5, r5, r7
	srli	r7, r5, 8
	or	r5, r5, r7
	srli	r7, r5, 16
	nor	r5, r5, r7
	li	r7, 21845
	lui	r7, 21845
	srli	r8, r5, 1
	and	r7, r8, r7
	sub	r5, r5, r7
	li	r7, 13107
	lui	r7, 13107
	and	r8, r5, r7
	srli	r5, r5, 2
	and	r5, r5, r7
	add	r5, r8, r5
	srli	r7, r5, 4
	add	r5, r5, r7
	li	r7, 3855
	lui	r7, 3855
	and	r5, r5, r7
	li	r7, 257
	lui	r7, 257
	mul	r5, r5, r7
	srli	r7, r5, 24
	addi	r5, r0, 9
	sub	r5, r5, r7
	addi	r7, r7, 24
	andi	r7, r7, 31
	sll	r3, r3, r7
LBB0_11:
	and	r7, r2, r1
	bne	r6, r0, LBB0_13
# BB#12:
	srli	r6, r7, 1
	or	r6, r7, r6
	srli	r8, r6, 2
	or	r6, r6, r8
	srli	r8, r6, 4
	or	r6, r6, r8
	srli	r8, r6, 8
	or	r6, r6, r8
	srli	r8, r6, 16
	nor	r6, r6, r8
	li	r8, 21845
	lui	r8, 21845
	srli	r9, r6, 1
	and	r8, r9, r8
	sub	r6, r6, r8
	li	r8, 13107
	lui	r8, 13107
	and	r9, r6, r8
	srli	r6, r6, 2
	and	r6, r6, r8
	add	r6, r9, r6
	srli	r8, r6, 4
	add	r6, r6, r8
	li	r8, 3855
	lui	r8, 3855
	and	r6, r6, r8
	li	r8, 257
	lui	r8, 257
	mul	r6, r6, r8
	srli	r8, r6, 24
	addi	r6, r0, 9
	sub	r6, r6, r8
	addi	r8, r8, 24
	andi	r8, r8, 31
	sll	r7, r7, r8
LBB0_13:
	xor	r2, r4, r2
	slli	r7, r7, 3
	li	r8, 0
	lui	r8, 1024
	or	r9, r7, r8
	slli	r3, r3, 3
	add	r7, r0, r9
	beq	r5, r6, LBB0_16
# BB#14:
	sub	r6, r5, r6
	addi	r7, r0, 31
	sltu	r10, r7, r6
	addi	r7, r0, 1
	bne	r10, r0, LBB0_16
# BB#15:
	andi	r7, r6, 31
	srl	r7, r9, r7
	sub	r6, r0, r6
	andi	r6, r6, 31
	sll	r6, r9, r6
	xor	r6, r6, r0
	sltu	r6, r0, r6
	or	r7, r6, r7
LBB0_16:
	or	r6, r3, r8
	addi	r8, r0, -1
	slt	r2, r8, r2
	bne	r2, r0, LBB0_20
	beq	r0, r0, LBB0_17
LBB0_20:
	add	r2, r7, r6
	li	r6, 0
	lui	r6, 2048
	and	r6, r2, r6
	beq	r6, r0, LBB0_22
	beq	r0, r0, LBB0_21
LBB0_17:
	li	r3, 0
	lui	r3, 0
	beq	r6, r7, LBB0_27
# BB#18:
	sub	r2, r6, r7
	li	r3, 65535
	lui	r3, 1023
	sltu	r3, r3, r2
	bne	r3, r0, LBB0_22
# BB#19:
	srli	r3, r2, 1
	or	r3, r2, r3
	srli	r6, r3, 2
	or	r3, r3, r6
	srli	r6, r3, 4
	or	r3, r3, r6
	srli	r6, r3, 8
	or	r3, r3, r6
	srli	r6, r3, 16
	nor	r3, r3, r6
	li	r6, 21845
	lui	r6, 21845
	srli	r7, r3, 1
	and	r6, r7, r6
	sub	r3, r3, r6
	li	r6, 13107
	lui	r6, 13107
	and	r7, r3, r6
	srli	r3, r3, 2
	and	r3, r3, r6
	add	r3, r7, r3
	srli	r6, r3, 4
	add	r3, r3, r6
	li	r6, 3855
	lui	r6, 3855
	and	r3, r3, r6
	li	r6, 257
	lui	r6, 257
	mul	r3, r3, r6
	srli	r3, r3, 24
	addi	r3, r3, -5
	sub	r5, r5, r3
	andi	r3, r3, 31
	sll	r2, r2, r3
	beq	r0, r0, LBB0_22
LBB0_21:
	add	r3, r7, r3
	andi	r3, r3, 1
	srli	r2, r2, 1
	or	r2, r2, r3
	addi	r5, r5, 1
LBB0_22:
	li	r3, 0
	lui	r3, 32768
	and	r3, r4, r3
	addi	r4, r0, 255
	slt	r4, r5, r4
	bne	r4, r0, LBB0_24
# BB#23:
	li	r1, 0
	lui	r1, 32640
	or	r3, r3, r1
	beq	r0, r0, LBB0_27
LBB0_24:
	slt	r4, r0, r5
	bne	r4, r0, LBB0_26
	beq	r0, r0, LBB0_25
LBB0_6:
	add	r3, r0, r2
	bne	r5, r0, LBB0_27
# BB#7:
	and	r3, r2, r1
	beq	r0, r0, LBB0_27
LBB0_25:
	addi	r4, r0, 1
	sub	r4, r4, r5
	andi	r5, r4, 31
	srl	r6, r2, r5
	addi	r5, r0, 0
	sub	r4, r0, r4
	andi	r4, r4, 31
	sll	r2, r2, r4
	xor	r2, r2, r0
	sltu	r2, r0, r2
	or	r2, r2, r6
LBB0_26:
	srli	r4, r2, 3
	and	r1, r4, r1
	slli	r4, r5, 23
	or	r3, r4, r3
	or	r1, r3, r1
	andi	r2, r2, 7
	addi	r3, r0, 4
	sltu	r4, r3, r2
	add	r1, r1, r4
	xor	r2, r2, r3
	andi	r3, r1, 1
	addi	r4, r0, 0
	movz	r4, r3, r2
	add	r3, r4, r1
LBB0_27:                                # %.thread
	add	r1, r0, r3
	llwi	r10, sp[0]              # 4-byte Folded Reload
	llwi	r9, sp[4]               # 4-byte Folded Reload
	addi	sp, sp, 2
	ret
	.set	macro
	.set	reorder
	.end	__addsf3
rfunc_end0:
	.size	__addsf3, rfunc_end0-__addsf3

	.globl	__muldsi3
	.align	2
	.type	__muldsi3,@function
	.ent	__muldsi3               # @__muldsi3
__muldsi3:
	.frame	sp,0,lr
	.mask 	0x00000000,0
	.set	noreorder
	.set	nomacro
# BB#0:
	li	r3, 65535
	lui	r3, 0
	and	r4, r1, r3
	srli	r1, r1, 16
	and	r5, r2, r3
	mul	r6, r5, r4
	srli	r7, r6, 16
	macc	r7, r5, r1
	srli	r2, r2, 16
	srli	r5, r7, 16
	macc	r5, r2, r1
	and	r8, r7, r3
	macc	r8, r2, r4
	macc	r7, r2, r4
	and	r1, r6, r3
	slli	r2, r7, 16
	or	r1, r2, r1
	srli	r2, r8, 16
	add	r2, r5, r2
	ret
	.set	macro
	.set	reorder
	.end	__muldsi3
rfunc_end1:
	.size	__muldsi3, rfunc_end1-__muldsi3

	.globl	__muldi3
	.align	2
	.type	__muldi3,@function
	.ent	__muldi3                # @__muldi3
__muldi3:
	.frame	sp,8,lr
	.mask 	0x00000600,-4
	.set	noreorder
	.set	nomacro
# BB#0:
	addi	sp, sp, -2
	lswi	r9, sp[4]               # 4-byte Folded Spill
	lswi	r10, sp[0]              # 4-byte Folded Spill
	li	r5, 65535
	lui	r5, 0
	and	r6, r1, r5
	and	r7, r3, r5
	mul	r8, r7, r6
	srli	r9, r8, 16
	srli	r10, r1, 16
	macc	r9, r7, r10
	mul	r4, r4, r1
	macc	r4, r2, r3
	srli	r1, r3, 16
	macc	r4, r1, r10
	and	r2, r8, r5
	and	r3, r9, r5
	macc	r3, r1, r6
	srli	r5, r9, 16
	macc	r9, r1, r6
	slli	r1, r9, 16
	or	r1, r1, r2
	add	r2, r4, r5
	srli	r3, r3, 16
	add	r2, r2, r3
	llwi	r10, sp[0]              # 4-byte Folded Reload
	llwi	r9, sp[4]               # 4-byte Folded Reload
	addi	sp, sp, 2
	ret
	.set	macro
	.set	reorder
	.end	__muldi3
rfunc_end2:
	.size	__muldi3, rfunc_end2-__muldi3

	.globl	__mulsf3
	.align	2
	.type	__mulsf3,@function
	.ent	__mulsf3                # @__mulsf3
__mulsf3:
	.frame	sp,32,lr
	.mask 	0x0001fe00,-4
	.set	noreorder
	.set	nomacro
# BB#0:
	addi	sp, sp, -8
	lswi	r9, sp[28]              # 4-byte Folded Spill
	lswi	r10, sp[24]             # 4-byte Folded Spill
	lswi	r11, sp[20]             # 4-byte Folded Spill
	lswi	r12, sp[16]             # 4-byte Folded Spill
	lswi	r13, sp[12]             # 4-byte Folded Spill
	lswi	r14, sp[8]              # 4-byte Folded Spill
	lswi	r15, sp[4]              # 4-byte Folded Spill
	lswi	r16, sp[0]              # 4-byte Folded Spill
	xor	r3, r2, r1
	li	r11, 0
	lui	r11, 32768
	and	r10, r3, r11
	srli	r3, r1, 23
	andi	r13, r3, 255
	addi	r3, r13, -1
	addi	r4, r0, 253
	sltu	r5, r4, r3
	li	r12, 65535
	lui	r12, 127
	and	r3, r1, r12
	and	r4, r2, r12
	srli	r6, r2, 23
	andi	r14, r6, 255
	bne	r5, r0, LBB3_2
# BB#1:
	addi	r15, r0, 0
	addi	r5, r14, -1
	addi	r6, r0, 254
	sltu	r5, r5, r6
	bne	r5, r0, LBB3_14
LBB3_2:
	li	r7, 65535
	lui	r7, 32767
	and	r5, r1, r7
	li	r1, 0
	lui	r1, 32704
	li	r6, 0
	lui	r6, 32640
	sltu	r8, r6, r5
	bne	r8, r0, LBB3_20
# BB#3:
	and	r2, r2, r7
	sltu	r7, r6, r2
	bne	r7, r0, LBB3_20
# BB#4:
	beq	r5, r6, LBB3_6
# BB#5:
	bne	r2, r6, LBB3_7
	beq	r0, r0, LBB3_6
LBB3_7:
	beq	r5, r0, LBB3_9
# BB#8:
	bne	r2, r0, LBB3_10
	beq	r0, r0, LBB3_9
LBB3_10:
	sltu	r1, r12, r5
	addi	r15, r0, 0
	bne	r1, r0, LBB3_12
# BB#11:
	srli	r1, r3, 1
	or	r1, r3, r1
	srli	r5, r1, 2
	or	r1, r1, r5
	srli	r5, r1, 4
	or	r1, r1, r5
	srli	r5, r1, 8
	or	r1, r1, r5
	srli	r5, r1, 16
	nor	r1, r1, r5
	li	r5, 21845
	lui	r5, 21845
	srli	r6, r1, 1
	and	r5, r6, r5
	sub	r1, r1, r5
	li	r5, 13107
	lui	r5, 13107
	and	r6, r1, r5
	srli	r1, r1, 2
	and	r1, r1, r5
	add	r1, r6, r1
	srli	r5, r1, 4
	add	r1, r1, r5
	li	r5, 3855
	lui	r5, 3855
	and	r1, r1, r5
	li	r5, 257
	lui	r5, 257
	mul	r1, r1, r5
	srli	r1, r1, 24
	addi	r5, r0, 9
	sub	r15, r5, r1
	addi	r1, r1, 24
	andi	r1, r1, 31
	sll	r3, r3, r1
LBB3_12:
	sltu	r1, r12, r2
	bne	r1, r0, LBB3_14
# BB#13:
	srli	r1, r4, 1
	or	r1, r4, r1
	srli	r2, r1, 2
	or	r1, r1, r2
	srli	r2, r1, 4
	or	r1, r1, r2
	srli	r2, r1, 8
	or	r1, r1, r2
	srli	r2, r1, 16
	nor	r1, r1, r2
	li	r2, 21845
	lui	r2, 21845
	srli	r5, r1, 1
	and	r2, r5, r2
	sub	r1, r1, r2
	li	r2, 13107
	lui	r2, 13107
	and	r5, r1, r2
	srli	r1, r1, 2
	and	r1, r1, r2
	add	r1, r5, r1
	srli	r2, r1, 4
	add	r1, r1, r2
	li	r2, 3855
	lui	r2, 3855
	and	r1, r1, r2
	li	r2, 257
	lui	r2, 257
	mul	r1, r1, r2
	addi	r2, r15, 9
	srli	r1, r1, 24
	sub	r15, r2, r1
	addi	r1, r1, 24
	andi	r1, r1, 31
	sll	r4, r4, r1
LBB3_14:                                # %.thread11
	slli	r1, r4, 8
	or	r1, r1, r11
	li	r16, 0
	lui	r16, 128
	or	r3, r3, r16
	addi	r9, r0, 0
	add	r2, r0, r9
	add	r4, r0, r9
	jsub	__muldi3
	srli	r3, r1, 31
	add	r4, r2, r2
	or	r3, r4, r3
	and	r4, r2, r16
	srli	r4, r4, 23
	movn	r3, r2, r4
	xori	r2, r4, 1
	sll	r1, r1, r2
	add	r2, r13, r14
	add	r2, r2, r15
	add	r2, r2, r4
	addi	r2, r2, -127
	slt	r4, r0, r2
	bne	r4, r0, LBB3_18
# BB#15:
	addi	r4, r0, 1
	sub	r4, r4, r2
	addi	r5, r0, 31
	sltu	r5, r5, r4
	bne	r5, r0, LBB3_17
	beq	r0, r0, LBB3_16
LBB3_17:
	add	r1, r0, r10
	beq	r0, r0, LBB3_20
LBB3_6:
	xor	r1, r5, r6
	movz	r5, r2, r1
	or	r2, r10, r6
	li	r1, 0
	lui	r1, 32704
	movn	r1, r2, r5
	beq	r0, r0, LBB3_20
LBB3_16:                                # %.thread13
	sub	r5, r0, r4
	andi	r5, r5, 31
	andi	r4, r4, 31
	srl	r6, r1, r4
	sll	r7, r3, r5
	or	r6, r7, r6
	sll	r1, r1, r5
	xor	r1, r1, r0
	sltu	r1, r0, r1
	or	r1, r6, r1
	srl	r3, r3, r4
	beq	r0, r0, LBB3_19
LBB3_9:
	add	r1, r0, r10
	beq	r0, r0, LBB3_20
LBB3_18:
	and	r3, r3, r12
	slli	r4, r2, 23
	or	r3, r3, r4
LBB3_19:
	or	r3, r3, r10
	sltu	r4, r11, r1
	add	r3, r4, r3
	xor	r1, r1, r11
	andi	r4, r3, 1
	movz	r9, r4, r1
	add	r1, r9, r3
	addi	r3, r0, 254
	slt	r2, r3, r2
	li	r3, 0
	lui	r3, 32640
	or	r3, r10, r3
	movn	r1, r3, r2
LBB3_20:                                # %.thread
	llwi	r16, sp[0]              # 4-byte Folded Reload
	llwi	r15, sp[4]              # 4-byte Folded Reload
	llwi	r14, sp[8]              # 4-byte Folded Reload
	llwi	r13, sp[12]             # 4-byte Folded Reload
	llwi	r12, sp[16]             # 4-byte Folded Reload
	llwi	r11, sp[20]             # 4-byte Folded Reload
	llwi	r10, sp[24]             # 4-byte Folded Reload
	llwi	r9, sp[28]              # 4-byte Folded Reload
	addi	sp, sp, 8
	ret
	.set	macro
	.set	reorder
	.end	__mulsf3
rfunc_end3:
	.size	__mulsf3, rfunc_end3-__mulsf3

	.globl	xcorr
	.align	2
	.type	xcorr,@function
	.ent	xcorr                   # @xcorr
xcorr:
	.frame	sp,0,lr
	.mask 	0x00000000,0
	.set	noreorder
	.set	nomacro
# BB#0:
	lp	r2, 2
	lp	r3, 0
	lp	r5, 1
	#APP
	lid r4, 0
	#NO_APP
	#APP
	wgoff r6, 0
	#NO_APP
	add	r4, r6, r4
	slli	r1, r4, 2
	add	r6, r5, r1
	addi	r5, r0, 0
	#APP
	size r7, 0
	#NO_APP
LBB4_1:                                 # =>This Inner Loop Header: Depth=1
	lw	r1, r3[r0]
	lw	r8, r6[r0]
	macc	r5, r8, r1
	addi	r3, r3, 4
	addi	r6, r6, 4
	addi	r7, r7, -1
	bne	r7, r0, LBB4_1
# BB#2:
	sw	r5, r2[r4]
	ret
	.set	macro
	.set	reorder
	.end	xcorr
rfunc_end4:
	.size	xcorr, rfunc_end4-xcorr

	.globl	xcorr_improved
	.align	2
	.type	xcorr_improved,@function
	.ent	xcorr_improved          # @xcorr_improved
xcorr_improved:
	.frame	sp,0,lr
	.mask 	0x00000000,0
	.set	noreorder
	.set	nomacro
# BB#0:
	lp	r2, 2
	lp	r3, 0
	lp	r4, 1
	#APP
	lid r5, 0
	#NO_APP
	#APP
	wgoff r6, 0
	#NO_APP
	add	r6, r6, r5
	slli	r1, r6, 4
	add	r7, r1, r4
	addi	r4, r0, 0
	#APP
	size r5, 0
	#NO_APP
	slli	r5, r5, 2
	slli	r1, r6, 2
	addi	r6, r7, 8
	addi	r7, r0, 4
	addi	r8, r0, -4
	addi	r10, r0, -8
	add	r12, r0, r4
	add	r11, r0, r4
	add	r9, r0, r4
LBB5_1:                                 # =>This Inner Loop Header: Depth=1
	lw	r13, r3[r0]
	lw	r14, r6[r0]
	macc	r11, r14, r13
	lb	r14, r6[r7]
	macc	r9, r14, r13
	lb	r14, r6[r8]
	macc	r12, r14, r13
	lb	r14, r6[r10]
	macc	r4, r14, r13
	addi	r3, r3, 4
	addi	r6, r6, 4
	addi	r5, r5, -1
	bne	r5, r0, LBB5_1
# BB#2:
	sw	r4, r2[r1]
	ori	r3, r1, 1
	sw	r12, r2[r3]
	ori	r3, r1, 2
	sw	r11, r2[r3]
	ori	r1, r1, 3
	sw	r9, r2[r1]
	ret
	.set	macro
	.set	reorder
	.end	xcorr_improved
rfunc_end5:
	.size	xcorr_improved, rfunc_end5-xcorr_improved

	.globl	xcorr_half
	.align	2
	.type	xcorr_half,@function
	.ent	xcorr_half              # @xcorr_half
xcorr_half:
	.frame	sp,0,lr
	.mask 	0x00000000,0
	.set	noreorder
	.set	nomacro
# BB#0:
	lp	r2, 2
	lp	r3, 0
	lp	r5, 1
	#APP
	lid r4, 0
	#NO_APP
	#APP
	wgoff r6, 0
	#NO_APP
	add	r4, r6, r4
	slli	r1, r4, 1
	add	r6, r5, r1
	addi	r5, r0, 0
	#APP
	size r7, 0
	#NO_APP
LBB6_1:                                 # =>This Inner Loop Header: Depth=1
	xori	r1, r6, 30
	slli	r1, r1, 3
	lw	r8, r6[r0]
	sll	r1, r8, r1
	xori	r8, r3, 30
	slli	r8, r8, 3
	lw	r9, r3[r0]
	sll	r8, r9, r8
	srai	r8, r8, 16
	srai	r1, r1, 16
	macc	r5, r1, r8
	addi	r3, r3, 2
	addi	r6, r6, 2
	addi	r7, r7, -1
	bne	r7, r0, LBB6_1
# BB#2:
	sh	r5, r2[r4]
	ret
	.set	macro
	.set	reorder
	.end	xcorr_half
rfunc_end6:
	.size	xcorr_half, rfunc_end6-xcorr_half

	.globl	xcorr_half_improved
	.align	2
	.type	xcorr_half_improved,@function
	.ent	xcorr_half_improved     # @xcorr_half_improved
xcorr_half_improved:
	.frame	sp,0,lr
	.mask 	0x00000000,0
	.set	noreorder
	.set	nomacro
# BB#0:
	lp	r2, 2
	lp	r3, 0
	lp	r5, 1
	#APP
	lid r4, 0
	#NO_APP
	#APP
	wgoff r6, 0
	#NO_APP
	add	r1, r6, r4
	slli	r4, r1, 2
	add	r7, r4, r5
	addi	r5, r0, 0
	#APP
	size r6, 0
	#NO_APP
	addi	r1, r7, 4
	addi	r7, r0, -4
	add	r8, r0, r5
LBB7_1:                                 # =>This Inner Loop Header: Depth=1
	lb	r9, r1[r7]
	slli	r10, r9, 16
	srai	r10, r10, 16
	lw	r11, r3[r0]
	slli	r12, r11, 16
	srai	r12, r12, 16
	macc	r5, r10, r12
	srai	r9, r9, 16
	macc	r8, r9, r12
	srai	r10, r11, 16
	macc	r5, r9, r10
	lw	r9, r1[r0]
	slli	r9, r9, 16
	srai	r9, r9, 16
	macc	r8, r9, r10
	addi	r3, r3, 4
	addi	r1, r1, 4
	addi	r6, r6, -1
	bne	r6, r0, LBB7_1
# BB#2:
	add	r1, r2, r4
	sh	r5, r1[r0]
	addi	r1, r1, 2
	sh	r8, r1[r0]
	ret
	.set	macro
	.set	reorder
	.end	xcorr_half_improved
rfunc_end7:
	.size	xcorr_half_improved, rfunc_end7-xcorr_half_improved

	.globl	xcorr_byte
	.align	2
	.type	xcorr_byte,@function
	.ent	xcorr_byte              # @xcorr_byte
xcorr_byte:
	.frame	sp,0,lr
	.mask 	0x00000000,0
	.set	noreorder
	.set	nomacro
# BB#0:
	lp	r2, 2
	lp	r3, 0
	lp	r5, 1
	#APP
	lid r4, 0
	#NO_APP
	#APP
	wgoff r6, 0
	#NO_APP
	add	r4, r4, r6
	add	r6, r5, r4
	addi	r5, r0, 0
	#APP
	size r7, 0
	#NO_APP
LBB8_1:                                 # =>This Inner Loop Header: Depth=1
	xori	r1, r6, 31
	slli	r1, r1, 3
	lw	r8, r6[r0]
	sll	r1, r8, r1
	xori	r8, r3, 31
	slli	r8, r8, 3
	lw	r9, r3[r0]
	sll	r8, r9, r8
	srai	r8, r8, 24
	srai	r1, r1, 24
	macc	r5, r1, r8
	addi	r3, r3, 1
	addi	r6, r6, 1
	addi	r7, r7, -1
	bne	r7, r0, LBB8_1
# BB#2:
	sb	r5, r2[r4]
	ret
	.set	macro
	.set	reorder
	.end	xcorr_byte
rfunc_end8:
	.size	xcorr_byte, rfunc_end8-xcorr_byte

	.globl	xcorr_byte_improved
	.align	2
	.type	xcorr_byte_improved,@function
	.ent	xcorr_byte_improved     # @xcorr_byte_improved
xcorr_byte_improved:
	.frame	sp,0,lr
	.mask 	0x00000000,0
	.set	noreorder
	.set	nomacro
# BB#0:
	lp	r2, 2
	lp	r3, 0
	lp	r5, 1
	#APP
	lid r4, 0
	#NO_APP
	#APP
	wgoff r6, 0
	#NO_APP
	add	r1, r6, r4
	slli	r4, r1, 2
	add	r7, r4, r5
	addi	r5, r0, 0
	#APP
	size r6, 0
	#NO_APP
	addi	r7, r7, 4
	addi	r9, r0, -4
	add	r1, r0, r5
	add	r8, r0, r5
	add	r10, r0, r5
LBB9_1:                                 # =>This Inner Loop Header: Depth=1
	lb	r11, r7[r9]
	slli	r12, r11, 24
	srai	r12, r12, 24
	lw	r13, r3[r0]
	slli	r14, r13, 24
	srai	r14, r14, 24
	macc	r5, r12, r14
	slli	r12, r11, 16
	srai	r12, r12, 24
	slli	r15, r13, 16
	srai	r15, r15, 24
	macc	r5, r12, r15
	macc	r1, r12, r14
	slli	r12, r11, 8
	srai	r12, r12, 24
	srai	r11, r11, 24
	macc	r10, r11, r14
	macc	r8, r12, r14
	macc	r1, r12, r15
	slli	r14, r13, 8
	srai	r14, r14, 24
	macc	r5, r12, r14
	macc	r8, r11, r15
	lw	r12, r7[r0]
	slli	r16, r12, 24
	srai	r16, r16, 24
	macc	r10, r16, r15
	macc	r1, r11, r14
	macc	r8, r16, r14
	slli	r15, r12, 16
	srai	r15, r15, 24
	macc	r10, r15, r14
	srai	r13, r13, 24
	macc	r8, r15, r13
	macc	r1, r16, r13
	macc	r5, r11, r13
	slli	r11, r12, 8
	srai	r11, r11, 24
	macc	r10, r11, r13
	addi	r3, r3, 4
	addi	r7, r7, 4
	addi	r6, r6, -1
	bne	r6, r0, LBB9_1
# BB#2:
	sb	r5, r2[r4]
	add	r2, r2, r4
	addi	r3, r0, 3
	sb	r10, r2[r3]
	addi	r3, r0, 2
	sb	r8, r2[r3]
	addi	r3, r0, 1
	sb	r1, r2[r3]
	ret
	.set	macro
	.set	reorder
	.end	xcorr_byte_improved
rfunc_end9:
	.size	xcorr_byte_improved, rfunc_end9-xcorr_byte_improved

	.globl	xcorr_float
	.align	2
	.type	xcorr_float,@function
	.ent	xcorr_float             # @xcorr_float
xcorr_float:
	.frame	sp,0,lr
	.mask 	0x00000000,0
	.set	noreorder
	.set	nomacro
# BB#0:
	lp	r2, 2
	lp	r3, 0
	lp	r5, 1
	#APP
	lid r4, 0
	#NO_APP
	#APP
	wgoff r6, 0
	#NO_APP
	add	r4, r6, r4
	slli	r1, r4, 2
	add	r6, r5, r1
	li	r5, 0
	lui	r5, 0
	#APP
	size r7, 0
	#NO_APP
LBB10_1:                                # =>This Inner Loop Header: Depth=1
	lw	r1, r6[r0]
	lw	r8, r3[r0]
	fmul	r1, r8, r1
	fadd	r5, r5, r1
	addi	r3, r3, 4
	addi	r6, r6, 4
	addi	r7, r7, -1
	bne	r7, r0, LBB10_1
# BB#2:
	sw	r5, r2[r4]
	ret
	.set	macro
	.set	reorder
	.end	xcorr_float
rfunc_end10:
	.size	xcorr_float, rfunc_end10-xcorr_float


