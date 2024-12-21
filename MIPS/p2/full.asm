.data
symbol: .word 0:10
arry:	.word 0:10
space:	.asciiz " "
enter:	.asciiz "\n"
	
.macro push(%src)
	sw %src, 0($sp)
	subi $sp, $sp, 4
.end_macro
	
.macro pop(%dst)
	addi $sp, $sp, 4
	lw %dst, 0($sp)
.end_macro
	
.macro calc_addr(%dst, %start, %index)
	sll %dst, %index, 2
	add %dst, %dst, %start
.end_macro
	
.text
main:
	li $v0, 5
	syscall
	move $s0, $v0			# $s0 = n
	la $s1, symbol			# $s1 = addr of symbol
	la $s2, arry				# $s2 = addr of arry
	
	li $a1, 0				# use $a1 as index
	jal FullArry				# FullArry(index)
	
	li $v0, 10
	syscall
	
	
FullArry:
	push($ra)
	push($a0)
	push($t0)
	push($t1)
	push($t2)
	push($t3)
	push($t4)
	
	bge $a1, $s0, output		# if(index >= n) then output
	
	li $t0, 0				# i = 0
	for_begin_1:
	beq $t0, $s0, for_end_1	# i < n
	
		calc_addr($t1, $s1, $t0)
		lw $t2, 0($t1)		# $t2 = symbol[i]
		bne $t2, 0, if_end	# if(symbol[i] != 0) then goto if_end
		
		calc_addr($t1, $s2, $a1)
		move $t3, $t1		# $t3 = addr of ayyr[index]
		addi $t4, $t0, 1		# $t4 = i + 1
		sw $t4, 0($t3)		# arry[index] = i + 1
		calc_addr($t1, $s1, $t0)
		move $t3, $t1		# $t3 = addr of symbol[i]
		addi $t4, $0, 1		# $t4 = 1
		sw $t4, 0($t3)		# symbol[i] = 1
		addi $a1, $a1, 1	
		jal FullArry			# FullArry(index + 1)
		addi $a1, $a1, -1
		sw $0, 0($t3)		# symbol[i] = 0
		
		if_end:
	addi $t0, $t0, 1
	j for_begin_1
	for_end_1:
	j return
	
	output:
	li $t0, 0				# i = 0
	for_begin_2:
	beq $t0, $s0, for_end_2	# i < n
	
		calc_addr($t1, $s2, $t0)
		li $v0, 1
		lw $a0, 0($t1)
		syscall				# output num
		li $v0, 4
		la $a0, space
		syscall				# output " "
	
	addi $t0, $t0, 1
	j for_begin_2
	for_end_2:
	
	li $v0, 4
	la $a0, enter
	syscall					# output "\n"
	
	return:
	pop($t4)
	pop($t3)
	pop($t2)
	pop($t1)
	pop($t0)
	pop($a0)
	pop($ra)
	jr $ra