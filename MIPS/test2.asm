ori $t0, $t0, 15
nop
ori $t1, $t1, 15
add $t2, $t0, $0
nop
beq $t1, $t2, loop0
nop
sw $t0, 0($0)
loop0:
sw $t0, 4($0)
addi $t1, $t0, 1
nop
beq $t0, $t1, loop1
nop
sw $t0, 8($0)
loop1:
sw $t0, 12($0)
mult $t0, $t0
mflo $t1
nop
bne $t0, $t1, loop2
nop
sw $t0, 16($0)
loop2:
sw $t0, 20($0)
lw $t1, 4($0)
nop
nop
bne $t0, $t1, loop3
nop
sw $t0, 24($0)
loop3:
sw $t0, 28($0)
add $t1, $t0, $t0
add $t2, $t1, $t0
addi $t1, $t0, 10
sub $t2, $t1, $t0
mult $t0, $t0
mflo $t1
add $t2, $t0, $t1
add $t1, $t0, $t0
addi $t2, $t1, 10
addi $t1, $t0, 10
addi $t2, $t1, 10
mult $t0, $t0
mflo $t1
addi $t2, $t1, 10
add $t1, $0, $0
lb $t2, 4($t1)
addi $t1, $0, 4
lh $t2, 4($t1)
mult $0, $0
mflo $t1
lw $t2, 4($t1)
add $t1, $0, $0
sw $t0, 32($t1)
addi $t1, $0, 4
sb $t0, 33($t1)
mult $0, $0
mflo $t1
sh $t0, 42($t1)
add $t1, $t0, $t0
mult $t1, $t1
mflo $t2
addi $t1, $t0, 10
mult $t1, $t1
mflo $t2
mult $t0, $t0
mflo $t1
div $t1, $t0
mflo $t2
add $t1, $t0, $t0
mthi $t1
mfhi $t2
addi $t1, $t0, 10
mtlo $t1
mflo $t2
mult $t0, $t0
mflo $t1
mthi $t1
mfhi $t2
lw $t1, 4($0)
nop
add $t2, $t1, $t1
lw $t1, 4($0)
nop
addi $t2, $t1, 1
lw $t1, 0($0)
nop
lw $t2, 4($t1)
lw $t1, 4($0)
nop
sb $t0, 31($t1)
lw $t1, 4($0)
nop
mult $t1, $t1
mflo $t2
lw $t1, 4($0)
nop
mthi $t1
mfhi $t2
lw $t1, 4($0)
sw $t1, 48($0)
lw $t1, 4($0)
beq $t0, $t1, loop4
nop
sw $t0, 52($0)
loop4:
sw $t0, 56($0)
add $t1, $t0, $t0
beq $t1, $t0, loop5
nop
sw $t0, 60($0)
loop5:
sw $t0, 64($0)
addi $t1, $t0, 10
bne $t0, $t1, loop6
nop
sw $t0, 68($0)
loop6:
sw $t0, 72($0)
mult $t0, $t0
mflo $t1
beq $t0, $t1, loop7
nop
sw $t0, 76($0)
loop7:
sw $t0, 80($0)
lw $t1, 4($0)
nop
beq $t0, $t1, loop8
nop
sw $t0, 84($0)
loop8:
sw $t0, 88($0)
lw $t1, 4($0)
add $t2, $t0, $t1
nop
lw $t1, 4($0)
addi $t2, $t1, 10
nop
lw $t1, 0($0)
lw $t2, 4($t1)
nop
lw $t1, 4($0)
sw $t0, 77($t1)
lw $t1, 4($0)
mult $t1, $t1
mflo $t2
lw $t1, 4($0)
mthi $t1
mfhi $t2
mult $0, $0
nop
nop
nop
nop
nop
nop
mult $t0, $t0
mflo $t2


