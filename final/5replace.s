.data
	str: .asciiz "SAMPLE STRING"
	
.text
main:

	la $a0, str
	li $a1, 'A'
	li $a2, 'a'
	jal replace
	
	la $a0, str
	li $a1, 'S'
	li $a2, 's'
	jal replace
	
	la $a0, str
	li $v0, 4
	syscall
	
	#end program
	li $v0, 10
	syscall
	

#a0 is address of string 
#a1 is character to replace
#a2 is replacement character 	
replace: 

	lb $t0, ($a0)	# Load character 
	
	beqz $t0, replaceDone	# Stop loop after null character encountered
				# (End of string)
				
	bne $t0, $a1, replaceMatchEnd	# If character doesn't match character to replace,
					# branch to skip replacement

	replaceMatch:
	
		la $t1, ($a2)	# Load replacement character in $t1
		move $t0, $t1	# Set current character to replacement

	replaceMatchEnd:
	
	sb $t0, ($a0)
	addi $a0, $a0, 1	# Move to next character in string
	
	j replace

replaceDone:

	jr $ra
