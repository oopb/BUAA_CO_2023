.data 
G: .word 0:64
symbol: .word 0:8

.macro push(%src)
	sw %src, 0($sp)
	subi $sp, $sp, 4
.end_macro
	
.macro pop(%dst)
	addi $sp, $sp, 4
	lw %dst, 0($sp)
.end_macro

.macro get_index_addr(%dst, %start, %index)
	sll %dst, %index, 2
	add %dst, %dst, %start
.end_macro

.macro get_index_num(%dst, %start, %index)
	push($a0)
	get_index_addr($a0, %start, %index)
	lw %dst, 0($a0)
	pop($a0)
.end_macro

.macro put_index_num(%src, %start, %index)
	push($a0)
	get_index_addr($a0, %start, %index)
	sw %src, 0($a0)
	pop($a0)
.end_macro

.macro calc_addr(%dst, %start, %i, %j)
	# %start = addr of start
	push($a3)
	li $a3, 8				# $a1 = rank
	mult $a3, %i
	mflo %dst
	add %dst, %dst, %j
	sll %dst, %dst, 2
	add %dst, %dst, %start
	pop($a3)
.end_macro

.macro put_matrix(%src, %start, %i, %j)
	push($a0)
	calc_addr($a0, %start, %i, %j)
	sw %src, 0($a0)
	pop($a0)
.end_macro

.macro get_matrix(%dst, %start, %i, %j)
	push($a0)
	calc_addr($a0, %start, %i, %j)
	lw %dst, 0($a0)
	pop($a0)
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
	la $s0, G				# $s0 = addr of G
	input_num($s1)			# $s1 = n
	input_num($s2)			# $s2 = m
	la $s3, symbol			# $s3 = addr of symbol
	li $a2, 0				# ans = 0
	
	li $t0, 0				# i = 0
	for_begin_1:
	beq $t0, $s2, for_end_1	# i < m
		
		input_num($t1)		# $t1 = x
		input_num($t2)		# $t2 = y
		subi $t1, $t1, 1
		subi $t2, $t2, 1
		li $t3, 1
		put_matrix($t3, $s0, $t1, $t2)
		put_matrix($t3, $s0, $t2, $t1)
	
	addi $t0, $t0, 1
	j for_begin_1
	for_end_1:
	
	li $a1, 0
	jal hamilton_dfs			# dfs(0)
	
	output_num($a2)			# output ans
	
	li $v0, 10
	syscall
	
	
	
hamilton_dfs:						# (index : $a1)
	push($ra)
	push($t0)
	push($t1)
	push($s4)
	
	li $t1, 1
	put_index_num($t1, $s3, $a1)		# symbol[index] = 1
	li $s4, 1						# flag = 1
	
	li $t0, 0						# i = 0
	for_begin_2:
	beq $t0, $s1, for_end_2			# i < n
	
		if_begin_1:
		get_index_num($t1, $s3, $t0)	# $t1 = symbol[i]
		bne $t1, $0, if_end_1		# if (symbol[i] == 0)
		move $s4, $0					# flag = 0
		j for_end_2					# break
		if_end_1:
	
	addi $t0, $t0, 1
	j for_begin_2
	for_end_2:
	
	if_begin_2:
	beq $s4, $0, if_end_2			# if (flag)
	get_matrix($t0, $s0, $a1, $0)	
	beq $t0, $0, if_end_2			# if (G[index][0])
	
	li $a2, 1						# ans = 1
	j return							# return
	
	if_end_2:
	
	li $t0, 0						# i = 0
	for_begin_3:
	beq $t0, $s1, for_end_3			# i < n
		
		if_begin_3:
		get_index_num($t1, $s3, $t0)	# $t1 = symbol[i]
		bne $t1, $0, if_end_3		# if (!symbol[i])
		get_matrix($t1, $s0, $a1, $t0)
		beq $t1, $0, if_end_3		# if (G[index][i])
		
		push($a1)
		move $a1, $t0
		jal hamilton_dfs				# dfs(i)
		pop($a1)
		
		if_end_3:
	
	addi $t0, $t0, 1
	j for_begin_3
	for_end_3:
	
	put_index_num($0, $s3, $a1)		# symbol[index] = 0
	
	return:
	
	pop($s4)
	pop($t1)
	pop($t0)
	pop($ra)
	jr $ra