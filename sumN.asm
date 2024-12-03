.data
	prompt: .asciiz "Enter a number N: "
	result: .asciiz "Here is the result:\n"
.text

main:

	la $a0, prompt
	li $v0, 4
	syscall
	
	# Read user input
	li $v0, 5
	syscall
	
	move $a0, $v0	# Moves user integer into $a0
	
	jal sumN
	
	j End

sumN:

	# Check if n = 0, and branch to base case if so
	beqz $a0, equalsZero
	
	addi $a0, $a0, -1
	jal sumN
	
	add $v0, $v0, $a0
	
	jr $ra

equalsZero:

	move $v0, $zero
	jr $ra

End:

	# Print result statement
	la $a1, result
	li $v0, 4
	syscall
	
	# Print result
	li $v0, 1
	syscall
	
	# End program
	li $v0, 10
	syscall