.data
	prompt: .asciiz "Enter a string (max 100 characters): "
	question: .asciiz "Would you like to encode or decode?  Enter 0 for encode or 1 for decode  "
	result: .asciiz "Here is the result\n"
	buffer: .space 100
	
.text
main:

	la $a0, prompt 
	li $v0, 4
	syscall

	#read string input 
	la $a0, buffer	#address to read string into  
	li $a1, 100		#max size 
	li $v0, 8 		#code for read string 
	syscall 
	
	#print prompt to enter 0 for encode and 1 for decode 
	la $a0, question
	li $v0, 4
	syscall
	
	#read integer from user 
	li $v0, 5
	syscall 
	
	#if user enetered 0, branch to encode string and call function
	beq $v0, $0, EncodeString
	
	#otherwise call decode function and jump to print 
	jal Decode	
	j Print 
	
	
EncodeString: #if we branched here, user selected encode 

	jal Encode
	
Print:	
	
	#print result message
	li $v0, 4
	la $a0, result 
	syscall 
	
	#print whatever is in buffer (whether it is an encoded or decoded string)
	la $a0, buffer 
	syscall
	
	#end program
	li $v0, 10
	syscall
	
	
	
Encode: 

	la $a0, buffer	# Loads input string into $a0

EncodeLoop:

	lb $t0, 0($a0)      # Load the current character into $t0
	
	# Finish when null character encountered
	beqz $t0, EncodeDone 

	# Add current character code by 1
	addi $t0, $t0, 1

	# Store the character in $t0 back to $a0
	sb $t0, 0($a0)
	
	# Move to the next character in the string
	addi $a0, $a0, 1
	
	# Return to the start of the loop
	j EncodeLoop

EncodeDone:

	jr $ra 
	
Decode: 

	la $a0, buffer	# Loads input string into $a0

DecodeLoop:

	lb $t0, 0($a0)      # Load the current character into $t0
	
	# Finish when null character encountered
	beqz $t0, DecodeDone 

	# Subtract current character code by 1
	subi $t0, $t0, 1

	# Store the character in $t0 back to $a0
	sb $t0, 0($a0)
	
	# Move to the next character in the string
	addi $a0, $a0, 1
	
	# Return to the start of the loop
	j DecodeLoop

DecodeDone:

	jr $ra