li $t0, 0				# i = 0
for_begin_1:
beq $t0, $s0, for_end_1



addi $t0, $t0, 1
j for_begin_1
for_end_1:
