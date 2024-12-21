.data
data: .space 100

.macro calc_addr(%dst, %start, %index)
	sll %dst, %index, 2
	add %dst, %dst, %start
.end_macro

.text
li $v0, 5
syscall
move $s0, $v0			# $s0 = n
la $s1, data				# $s1 = addr of data

# input
li $t0, 0				# i = 0
for_begin_1:
beq $t0, $s0, for_end_1

li $v0, 12
syscall
move $t1, $v0			# $t1 = input char
calc_addr($t2, $s1, $t0)
sw $t1, 0($t2)			# $t2 = addr of $t1

addi $t0, $t0, 1
j for_begin_1
for_end_1:

# judge and output
li $t0, 2
divu $s0, $t0
mflo $s2					# $s2 = n/2
li $a0, 1

li $t0, 0				# i = 0
for_begin_2:
beq $t0, $s2, for_end_2

calc_addr($t1, $s1, $t0)
lw $t2, 0($t1)			# $t2 = data[i]
sub $t3, $s0, $t0
subi $t3, $t3, 1			# $t3 = n - i - 1
calc_addr($t1, $s1, $t3)
lw $t4, 0($t1)			# $t4 = data[n-i]
seq $a0, $t2, $t4		# if($t2 == $t4) then $a0 = 1 else $a0 = 0
beq $a0, 0, for_end_2	# if($a0 == 0) then break

addi $t0, $t0, 1
j for_begin_2
for_end_2:

li $v0, 1
syscall
li $v0, 10
syscall