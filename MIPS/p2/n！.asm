.data 
num: .word 0:1000

.macro calc_addr(%dst, %start, %index)
	sll %dst, %index, 2
	add %dst, %dst, %start
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

.text
	input_num($s0)				# $s0 = n
	la $s1, num					# $s1 = addr of num
	li $s2, 1					# use $s2 as digital counter
	li $s3, 0					# use $s3 as up num
	li $t0, 1
	sw $t0, 0($s1)				# num[0] = 1
	
	li $t0, 2					# i = 2
	for_begin_1:
	bgt $t0, $s0, for_end_1		# i <= n
	
		li $t1, 0				# j = 0
		for_begin_2:
		beq $t1, $s2, for_end_2	# j < digital
			
			calc_addr($t2, $s1, $t1)
			lw $t3, 0($t2)		# $t3 = num[j]
			mult $t3, $t0		# num[j] * i
			mflo $t3
			add $t3, $t3, $s3	# $t3 = num[j] * i + up
			#sw $t3, 0($t2)		# num[j] = num[j] * i + up
			li $t4, 10
			div $t3, $t4			# num[j] / 10
			mflo $s3				# up = num[j] / 10
			mfhi $t3				# $t3 = num[j] % 10
			sw $t3, 0($t2)		# num[j] = num[j] % 10
		
		addi $t1, $t1, 1
		j for_begin_2
		for_end_2:
		
		while_begin:
		beq $s3, $0, while_end
		
			li $t4, 10
			div $s3, $t4			# up / 10
			mfhi $t4	
			calc_addr($t1, $s1, $s2)
			sw $t4, 0($t1)		# num[digital] = up % 10
			addi $s2, $s2, 1		# digital++
			mflo $t4
			move $s3, $t4		# up = up / 10
		
		j while_begin
		while_end:
	
	addi $t0, $t0, 1
	j for_begin_1
	for_end_1:
	
	subi $t1, $s2, 1				# $t1 = digital - 1
	move $t0, $t1				# i = digital - 1
	for_begin_3:
	blt $t0, $0, for_end_3		# i >= 0
	
		calc_addr($t1, $s1, $t0)
		lw $t2, 0($t1)			# $t2 = num[i]
		output_num($t2)
	
	subi $t0, $t0, 1
	j for_begin_3
	for_end_3:
	
	li $v0, 10
	syscall
	