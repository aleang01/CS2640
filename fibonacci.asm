.data
	prompt: .asciiz "How many numbers to print?: "
	endmsg: .asciiz "\nAll numbers displayed, exiting program..."
	newline: .asciiz "\n"
.text

main:	
	li $v0, 4		# Syscall for print string 
	la $a0, prompt		# Load address of prompt to $a0
	syscall			# Print prompt message
	
	li $v0, 5		# Read a integer user input N to $v0
	syscall
	
	move $t1, $v0		# Store $v0 to $t1
	li $t0, 2		# Initialize loop index $t0 at 2

One:				
	li $v0, 1		# Print 1
	la $a0, 1
	syscall
	
	bge $t1, 2, Two		# Base condition N = 2 or N > 2
	b End			# End if condition not met
Two:
	li $v0, 4		# Print newline
	la $a0, newline
	syscall
	
	li $v0, 1		# Print 1
	li $a0, 1
	syscall
	
	bgt $t1, 2, Fib	# N > 2
	b End			# End if condition not met
Fib:
	li $t2, 1		# Second to last fib number
	li $t3, 1		# Last fib number
	Loop:
		beq $t0, $t1, End	# If index = N, branch to End
	
		add $t4, $t2, $t3	# Adds second-last fib number to last fib number, stores in $t4
		move $t2, $t3		# Move value of last to second-last fib number
		move $t3, $t4		# Move value of newest to last fib number
	
		li $v0, 4
		la $a0, newline
		syscall			# Print newline
	
		li $v0, 1
		move $a0, $t4
		syscall			# Print new number
	
		add $t0, $t0, 1	# Increase loop index $t0 by 1
		j Loop
End: 	
	# Print end message
	li $v0, 4
	la $a0, endmsg
	syscall
	
	# End program
	li $v0, 10
	syscall
