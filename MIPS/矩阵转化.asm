.data
space:	.asciiz " " 
enter:	.asciiz "\n"
matrix: .space 10000

.text

li	 $v0, 5
syscall
move $s0, $v0	#put n in $s0
li	 $v0, 5
syscall
move $s1, $v0	#put m in $s1

mult $s0, $s1
mflo $s2			#put n*m in $s2

li	 $t0, 0		#use $t0 as i
for_begin_1:		#input the matrix
beq  $t0, $s2, for_end_1
nop

li	 $v0, 5
syscall
la   $t1, matrix	#put the address of matrix in $t1
li	 $t2, 4
mult $t0, $t2
mflo $t2
addu $t1, $t1, $t2
sw	 $v0, 0($t1)

addi $t0, $t0, 1
j for_begin_1	#output
nop
for_end_1:


move $t0, $s2		#use $t0 as i, init: i=n*m-1
addi $t0, $t0, -1
for_begin_2:
blt 	 $t0, $0, for_end_2
nop

la	 $t3, matrix
li 	 $t4, 4
mult $t0, $t4
mflo $t4
addu $t3, $t3, $t4
lw	 $t5, 0($t3)		   #put num in $t5
beq  $t5, 0, next_loop #if num==0, then go to next loop

div	 $t0, $s1
mflo $t1		#put line in $t1
addu $t1, $t1, 1
mfhi $t2		#put row in $t2
addu $t2, $t2, 1
li 	 $v0, 1
move $a0, $t1
syscall		#output line
li 	 $v0, 4
la	 $a0, space
syscall		#output space
li 	 $v0, 1
move $a0, $t2
syscall		#output row
li 	 $v0, 4
la	 $a0, space
syscall		#output space
li	 $v0, 1
move	 $a0, $t5
syscall 		#output num
li   $v0, 4
la	 $a0, enter
syscall 		#output enter

next_loop:
addi $t0, $t0, -1
j for_begin_2
nop
for_end_2:

li   $v0, 10
syscall
