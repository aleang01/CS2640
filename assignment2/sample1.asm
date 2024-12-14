.text
main:

	li $t0, 15
	li $t1, 3
	li $t2, 1
	
	move $a0, $t0
	move $a1, $t1
	move $a2, $t2
	
	jal minOfThree
	
	move $a0, $v0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	
minOfThree:

	addi $sp, $sp, -8	# Save registers to stack
	sw $ra, 4($sp)
	sw $a0, 0($sp)

	slt $t0, $a0, $a1
	bne $t0, $0, First
	j Second
	
First:
	slt $t1, $a0, $a2
	beq $t1, $0, Third	# case first > 3rd
	# otherwise return a0
	move $v0, $a0
	j Return
Second:
	slt $t2, $a1, $a2
	beq $t2, $0, Third	#case second > 3rd
	#otherwise return a1
	move $v0, $a1
	j Return
Third:
	move $v0, $a2
Return:
	
	lw $a0, 0($sp)		# Restore from stack
	lw $ra, 4($sp)
	addi $sp, $sp, 8 
	
	jr $ra
