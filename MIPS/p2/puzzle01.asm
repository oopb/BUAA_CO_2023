.data 
matrix: .word 1:81

.macro push(%src)
	sw %src, 0($sp)
	subi $sp, $sp, 4
.end_macro
	
.macro pop(%dst)
	addi $sp, $sp, 4
	lw %dst, 0($sp)
.end_macro

.macro calc_addr(%dst, %start, %i, %j)
	# %start = addr of start
	push($a0)
	li $a0, 9				# $a0 = rank
	mult $a0, %i
	mflo %dst
	add %dst, %dst, %j
	sll %dst, %dst, 2
	add %dst, %dst, %start
	pop($a0)
.end_macro

.text
	la $s0, matrix				# $s0 = addr of matrix
	li $v0, 5
	syscall
	move $s1, $v0				# $s1 = n
	li $v0, 5
	syscall
	move $s2, $v0				# $s2 = m
	
	# input matrix
	li $t0, 0					# i = 0
	for_begin_1:
	beq $t0, $s1, for_end_1		# i < n
	
		li $t1, 0					# j = 0
		for_begin_2:
		beq $t1, $s2, for_end_2		# j < m
			
			addi $t3, $t0, 1
			addi $t4, $t1, 1
			calc_addr($t2, $s0, $t3, $t4)
			li $v0, 5
			syscall
			sw $v0, 0($t2)			# matrix[i+1][j+1] = input num
			
		addi $t1, $t1, 1
		j for_begin_2
		for_end_2:
	
	addi $t0, $t0, 1
	j for_begin_1
	for_end_1:
	
	li $v0, 5
	syscall
	move $s3, $v0				# $s3 = n1
	li $v0, 5
	syscall
	move $s4, $v0				# $s4 = m1
	li $v0, 5
	syscall
	move $s5, $v0				# $s5 = n2
	li $v0, 5
	syscall
	move $s6, $v0				# $s6 = m3
	
	li $a0, 0					# use $a0 as counter
	jal puzzle
	
	li $v0, 1
	syscall						# output counter
	
	li $v0, 10
	syscall
	
	
puzzle:							# (i:$s3, j:$s4, outx:$s5, outy:$s6) don't use $s5, $s6
	push($ra)
	
	if:							# if(i==outx && j==outy)
	bne $s3, $s5, else
	bne $s4, $s6, else
	addi $a0, $a0, 1
	j return 
	
	else:
	
	calc_addr($t0, $s0, $s3, $s4)
	li $t1, 1
	sw $t1, 0($t0)				# matrix[i][j] = 1
	
	if_1:
	addi $s4, $s4, 1				# j++
	calc_addr($t0, $s0, $s3, $s4)
	lw $t1, 0($t0)				# $t1 = matrix[i][j+1]
	bne $t1, $0, if_2
	jal puzzle
	
	if_2:
	subi $s4, $s4, 1				# j--
	addi $s3, $s3, 1				# i++
	calc_addr($t0, $s0, $s3, $s4)
	lw $t1, 0($t0)				# $t1 = matrix[i+1][j]
	bne $t1, $0, if_3
	jal puzzle
	
	if_3:
	subi $s3, $s3, 1				# i--
	subi $s3, $s3, 1				# i--
	calc_addr($t0, $s0, $s3, $s4)
	lw $t1, 0($t0)				# $t1 = matrix[i-1][j]
	bne $t1, $0, if_4
	jal puzzle
	
	if_4:
	addi $s3, $s3, 1				# i++
	subi $s4, $s4, 1				# j--
	calc_addr($t0, $s0, $s3, $s4)
	lw $t1, 0($t0)				# $t1 = matrix[i][j-1]
	bne $t1, $0, if_end
	jal puzzle
	
	if_end:
	addi $s4, $s4, 1				# j++
	calc_addr($t0, $s0, $s3, $s4)
	li $t1, 0
	sw $t1, 0($t0)				# matrix[i][j] = 0
	
	return:
	pop($ra)
	jr $ra