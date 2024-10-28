.data
	prompt: .asciiz "How many numbers to print?: "
	endmsg: .asciiz "\nAll numbers displayed, exiting program..."
.text

main:
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 4
	la $a0, endmsg
	syscall
	
	li $v0, 10
	syscall