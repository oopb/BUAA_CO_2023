.data
matrix1: .word 0:100
matrix2: .word 0:100
space: .asciiz " "
enter: .asciiz "\n"

.macro calc_addr(%dst, %start, %i, %j, %rank)
	# %start = addr of start
	# %rank = num of line
	mult %rank, %i
	mflo %dst
	add %dst, %dst, %j
	sll %dst, %dst, 2
	add %dst, %dst, %start
.end_macro

.text
	li $v0, 5
	syscall
	move $s0, $v0			# $s0 = m1
	li $v0, 5
	syscall
	move $s1, $v0			# $s1 = n1
	li $v0, 5
	syscall
	move $s2, $v0			# $s2 = m2
	li $v0, 5
	syscall
	move $s3, $v0			# $s3 = n2
	sub $s4, $s0, $s2
	addi $s4, $s4, 1			# $s4 = m1-m2+1
	sub $s5, $s1, $s3
	addi $s5, $s5, 1			# $s5 = n1-n2+1
	
	la $s6, matrix1			# $s6 = addr of matrix1
	la $s7, matrix2			# $s7 = addr of matrix2
	
# input matrix1
li $t0, 0					# i = 0
for_begin_1:
beq $t0, $s0, for_end_1
	li $t1, 0				# j = 0
	for_begin_2:
	beq $t1, $s1, for_end_2
	
		li $v0, 5
		syscall
		move $t2, $v0		# $t2 = input num
		calc_addr($t3, $s6, $t0, $t1, $s1)
		sw $t2, 0($t3)		# $t3 = addr of input num
	
	addi $t1, $t1, 1
	j for_begin_2
	for_end_2:
addi $t0, $t0, 1
j for_begin_1
for_end_1:

# input matrix2
li $t0, 0					# i = 0
for_begin_3:
beq $t0, $s2, for_end_3
	li $t1, 0				# j = 0
	for_begin_4:
	beq $t1, $s3, for_end_4
	
		li $v0, 5
		syscall
		move $t2, $v0		# $t2 = input num
		calc_addr($t3, $s7, $t0, $t1, $s3)
		sw $t2, 0($t3)		# $t3 = addr of input num
	
	addi $t1, $t1, 1
	j for_begin_4
	for_end_4:
addi $t0, $t0, 1
j for_begin_3
for_end_3:

# calucate and output
li $t0, 0					# i = 0
for_begin_5:
beq $t0, $s4, for_end_5		# i < m3
	li $t1, 0				# j = 0
	for_begin_6:
	beq $t1, $s5, for_end_6	# j < n3
		
		li $t2, 0			# use $t2 as counter
		
		li $t3, 0					# k = 0
		for_begin_7:
		beq $t3, $s2, for_end_7		# k < m2
			li $t4, 0				# l = 0
			for_begin_8:
			beq $t4, $s3, for_end_8 	# l < n2
				
				add $t5, $t0, $t3
				add $t6, $t1, $t4
				calc_addr($t7, $s6, $t5, $t6, $s1)
				lw $t7, 0($t7)		# $t7 = f[i+k][j+l]
				calc_addr($t8, $s7, $t3, $t4, $s3)
				lw $t8, 0($t8)		# $t8 = h[k][l]
				mult $t7, $t8
				mflo $t9
				add $t2, $t2, $t9	# counter += f[i+k][j+l]*h[k][l]
			
			addi $t4, $t4, 1
			j for_begin_8
			for_end_8:			
		addi $t3, $t3, 1
		j for_begin_7
		for_end_7:
		
		li $v0, 1
		move $a0, $t2
		syscall				# output num
		li $v0, 4
		la $a0, space
		syscall				# output " "
		
	addi $t1, $t1, 1
	j for_begin_6
	for_end_6:
	
	li $v0, 4
	la $a0, enter
	syscall					# output "\n"
	
addi $t0, $t0, 1
j for_begin_5
for_end_5:

li $v0, 10
syscall