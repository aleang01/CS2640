.data
	arr: .word 1, 2, 5, 7, 8, 9, 0, 3
.text
main:
	la $a0, arr
	
	jal evenIndices
	
	move $a0, $v0
	
	jal printArr
	
	li $v0, 10
	syscall
#arg a0 = address of input array
#return v0 = address of new array with only even indices

evenIndices:
	
	
	
	jr $ra
	#a0 is address of array to print
printArr:
	move $t0, $a0
	li $t1, 0
printLoop:
	beq $t1, 16, donePrinting
	add $t2, $t1, $t0
	lb $t3, ($t2)
	li $v0, 1
	move $a0, $t3
	syscall
	addi $t1, $t1, 4
	j printLoop
donePrinting:
	jr $ra