.data
	prompt: .asciiz "What is the starting number?: "
	evenmsg: .asciiz " is even, so divide by 2\n"
	oddmsg: .asciiz " is odd, so multiply by 3 and add 1\n"
	endmsg: .asciiz "\nWe've reached the number 1, ending program. . ."
	stepsmsg: .asciiz "Steps taken: "
.text

.macro printNewline
	.data
	newline: .asciiz "\n"
	.text
	li $v0, 4		# Syscall for print string 
	la $a0, newline		# Load address of newline to $a0
	syscall			# Print newline
.end_macro

.macro printTab
	.data
	tab: .asciiz "\t"
	.text
	li $v0, 4		# Syscall for print string 
	la $a0, tab		# Load address of tab to $a0
	syscall			# Print tab
.end_macro

.macro printEquals
	.data
	equals: .asciiz "= "
	.text
	li $v0, 4		# Syscall for print string 
	la $a0, equals		# Load address of equals to $a0
	syscall			# Print equals sign
.end_macro

main:
	li $v0, 4		# Syscall for print string 
	la $a0, prompt		# Load address of prompt to $a0
	syscall			# Print prompt message

	li $v0, 5		# Read a integer user input N to $v0
	syscall
	
	move $t0, $v0		# Store $v0 to $t0
	
	li $s0, 2		# Store 2 to $s0
	li $s1, 0		# Initialize steps counter to $s1
	
OuterLoop:
	div $t0, $s0		# Divide $t0 by $s0, with quotient (LO) and remainder (HI) preserved
	mfhi $t1		# Store remainder to $t1
	
	beq $t0, 1, End		# If number after operations = 1, branch to end
	beqz $t1, Even		# If remainder = 0, branch to Even
	bnez $t1, Odd		# If remainder =/ 0, branch to Odd
	Even:
		li $v0, 1		# Print number in $t0
		move $a0, $t0
		syscall
	
		li $v0, 4		# Syscall for print string 
		la $a0, evenmsg		# Load address of evenmsg to $a0
		syscall			# Print that number is even
		
		div $t0, $s0		# Divide $t0 by 2
					# We can assume that there is no remainder after dividing by 2
					# so that HI = 0
					
		mflo $t0		# Store quotient in $t0
							
		printTab		# Prints tab
		
		printEquals		# Prints equals
		
		li $v0, 1		# Print number in $t0
		move $a0, $t0
		syscall
		
		printNewline
		
		add $s1, $s1, 1		# Increase steps counter by 1
		j OuterLoop

	Odd:
		li $v0, 1		# Print number in $t0
		move $a0, $t0
		syscall
		
		li $v0, 4		# Syscall for print string 
		la $a0, oddmsg		# Load address of oddmsg to $a0
		syscall			# Print that number is odd
		
		mul $t0, $t0, 3		# Store product of $t0 and 3 in $t0
		add $t0, $t0, 1		# Add 1 to $t0 and store in $t0
		
		printTab		# Prints tab
		
		printEquals		# Prints equals
		
		li $v0, 1		# Print number in $t0
		move $a0, $t0
		syscall
		
		printNewline
		
		add $s1, $s1, 1		# Increase steps counter by 1
		j OuterLoop
		
End: 	
	# Print end message
	li $v0, 4
	la $a0, endmsg
	syscall
	
	printNewline
	
	# Print steps taken
	li $v0, 4
	la $a0, stepsmsg
	syscall
	
	li $v0, 1
	move $a0, $s1
	syscall
	
	# End program
	li $v0, 10
	syscall
