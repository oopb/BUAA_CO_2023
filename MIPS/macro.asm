.macro push(%src)
	sw %src, 0($sp)
	subi $sp, $sp, 4
.end_macro

.macro pop(%dst)
	addi $sp, $sp, 4
	lw %dst, 0($sp)
.end_macro

.macro calc_addr(%dst, %i, %j, %rank)
	# %dst = offset addr
	# %dst == %rank is allowed
	mult %i, %rank
	mflo %dst
	add %dst, %dst, %j
	sll %dst, %dst, 2
.end_macro

.macro input_num(%dst)
	li $v0, 5
	syscall
	move %dst, $v0
.end_macro

.macro output_num(%src)
	li $v0, 1
	move $a0, %src
	syscall
.end_macro