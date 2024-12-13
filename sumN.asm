.data
	prompt: .asciiz "Enter a number N: "
	result: .asciiz "Here is the result:\n"
.text

main:

	la $a0, prompt	# Print prompt message
	li $v0, 4
	syscall
	
	# Read user input
	li $v0, 5
	syscall
	

	move $a0, $v0	# Moves user integer into $a0
	
	jal sumN
	
	move $s0, $v0	# Save result of sumN to $s0
	
	# Print result statement
	la $a0, result
	li $v0, 4
	syscall
	
	# Print result
	move $a0, $s0
	li $v0, 1
	syscall
	
	# End program
	li $v0, 10
	syscall

sumN:

	
	addi $sp, $sp, -8	# Save space for 2 registers
	sw $ra, 4($sp)
	sw $a0, 0($sp)
	
	# Check if n = 0, and branch to base case if so
	beqz $a0, equalsZero
	
	addi $a0, $a0, -1
	jal sumN

	lw $a0, 0($sp)		# Restore from the stack
	lw $ra, 4($sp)
	addi $sp, $sp, 8

	add $v0, $v0, $a0	# Adds the values from $a0 to $v0
			
	jr $ra

equalsZero:

	li $v0, 0	# Returns 0

	jr $ra


