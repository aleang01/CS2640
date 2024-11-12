.data
	numbers: .word 8, 100, 0, 3, 7, 5, 15, 12
	message: .asciiz "Sorted array: "
.text
main:

	li $t0, 0	# Counter for index
	li $t9, 7	# Length of array
	
OuterLoop:

	li $t1, 0	# Counter for index (inner loop)
	li $t9, 10	# Max value
	
	InnerLoop:
	
		mul $t6, $t1, 4		# Macro instruction
		
		add $t1, $t2, $t6	# Calculates current index
		
		lw $t4, 0($t3)
		lw $t5, 4($t3)
	
		# If $t5 > $t4, skip swap
		bgt $t5, $t4, NoSwap
		
		
		sw $t4, 4($t3)
		sw $t5, 0($t3)	
		
		NoSwap:
		
			addi $t1, $t1, 1
			beq $t1, $t9, DoneInnerLoop
			
		j InnerLoop
		
		DoneInnerLoop:
	

j OuterLoop