.data
	prompt: .asciiz "Expression: "
	result: .asciiz "\nAnswer = "
	newline: .asciiz "\n"
	expression: .space 100    # space to store input expression
	postFixArray: .space 100	# array for postfix expression
.text
main:

    # Print prompt
    li $v0, 4
    la $a0, prompt
    syscall

    # Read expression
    li $v0, 8
    la $a0, expression
    li $a1, 100		# max size of buffer
    syscall

    # Initialize addresses
    la $s3, expression  # load address of expression
    la $s4, postFixArray

    jal readExpression

    # Print result
    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    move $a0, $t0           # move result to $a0
    syscall

    # Exit program
    li $v0, 10
    syscall
    
readExpression:



    lb $t0, 0($s3)     # load byte from expression
    beqz $t0, done      # end if null character 

    # Check if the byte is a digit (ASCII '0' to '9')
    li $t1, 48          # Load "0"
    li $t2, 57          # Load "9"
    blt $t0, $t1, operator
    bgt $t0, $t2, operator

    # If it's a digit, accumulate the number
    sub $t4, $t4, $t5    # convert ASCII to integer ('0' -> 0, '1' -> 1, ...)
    mul $t1, $t1, 10     # shift left by one decimal place
    add $t1, $t1, $t4    # add the current digit to the number

    j next_char

operator:


addition:


subtraction:


multiplication:


nextChar:
    # Move to next character in expression
    addi $s3, $s3, 1
    j readExpression
