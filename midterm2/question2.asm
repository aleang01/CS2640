.data
	str: .asciiz "SaMpLe StRiNg\n"
.text
main:
	li $v0, 4
	la $a0, str
	syscall
	
	jal toLower
	
	li $v0, 4	# Print result string
	la $a0, str
	syscall
	
	li $v0, 10	# End
	syscall
	#arg a0 = address of string
toLower:
	
	lb $t0, ($a0)
	
	beqz $t0, Done	# Branch to done when null character encountered
	
	blt $t0, 97, lowerCase
	j nextLetter
	
lowerCase:
	addi $t0, $t0, 32	# Shift character code +32
	
	sb $t0, 0($a0)
nextLetter:
	addi $a0, $a0, 1
	
	j toLower
	
	
Done:	
	jr $ra
