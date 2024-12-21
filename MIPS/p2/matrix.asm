.data
data1: .space 256
data2: .space 256
space: .asciiz " "
enter: .asciiz "\n"

.macro calc_addr(%dst, %line, %row, %rank)
    # dts: the register to save the calculated address
    # row: the row that element is in
    # column: the column that element is in
    # rank: the number of lines(rows) in the matrix
    multu %line, %rank
    mflo %dst
    addu %dst, %dst, %row
    sll %dst, %dst, 2
.end_macro

.text
li $v0, 5
syscall
move $s0, $v0			# $s0 = n

# input matrix1
li $t0, 0				# i = 0
for_begin_1:
beq $t0, $s0, for_end_1

li $t1, 0				# j = 0
for_begin_2:
beq $t1, $s0, for_end_2

li $v0, 5
syscall
move $t2, $v0			# $t2 = input_num
calc_addr($t3, $t0, $t1, $s0)
la $s1, data1
add $t3, $t3, $s1
sw $t2, 0($t3)

addi $t1, $t1, 1
j for_begin_2
for_end_2:

addi $t0, $t0, 1
j for_begin_1
for_end_1:

# input matrix2
li $t0, 0				# i = 0
for_begin_3:
beq $t0, $s0, for_end_3

li $t1, 0				# j = 0
for_begin_4:
beq $t1, $s0, for_end_4

li $v0, 5
syscall
move $t2, $v0			# $t2 = input_num
calc_addr($t3, $t0, $t1, $s0)
la $s1, data2
add $t3, $t3, $s1
sw $t2, 0($t3)

addi $t1, $t1, 1
j for_begin_4
for_end_4:

addi $t0, $t0, 1
j for_begin_3
for_end_3:

# claculate and output the num
li $t0, 0				# i = 0
for_begin_5:
beq $t0, $s0, for_end_5

li $t1, 0				# j = 0
for_begin_6:
beq $t1, $s0, for_end_6

li $s1, 0				# use $s1 as counter
li $t2, 0				# k = 0
for_begin_7:
beq $t2, $s0, for_end_7

calc_addr($t3, $t0, $t2, $s0)
la $t4, data1
add $t4, $t4, $t3
lw $s2, 0($t4)			# $s2 = num in matrix1
calc_addr($t3, $t2, $t1, $s0)
la $t4, data2
add $t4, $t4, $t3
lw $s3, 0($t4)			# $s3 = num in matrix2
mult $s3, $s2
mflo $t3					# $t3 = $s3 * $s2
add $s1, $s1, $t3		# counter added

addi $t2, $t2, 1
j for_begin_7
for_end_7:

li $v0, 1
move $a0, $s1
syscall					# output num in counter
li $v0, 4
la $a0, space
syscall					# output " "

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
