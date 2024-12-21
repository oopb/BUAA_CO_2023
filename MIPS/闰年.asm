li 		$v0, 5
syscall
move 	$t0, $v0		#store n in $t0

li 		$t1, 100		#store 100 in $t1
div 		$t0, $t1		#n/100
mfhi		$t2			#store the rest_num in $t2
sltiu	$s0, $t2, 1
beq 		$s0, 0, div_100_end
nop

div_100:
mflo		$t0
div_100_end:

li 		$t1, 4		#store 4 in $t1
div 		$t0, $t1		#n/4
mfhi 	$t2			#store the rest_num in $t2

sltiu	$a0, $t2, 1

out:
	li	$v0, 1
	syscall
	li	$v0, 10
	syscall