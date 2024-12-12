.data 
	arr: .word 1, 1, 2, 3, 4
	str1: .asciiz "original array: "
	str2: .asciiz "\nnew array: "
 
 
.text
main:


	la $a0, arr
	jal doubleElements

	la $a0, arr
	jal printArr

	li $v0, 10
	syscall

#a0 is address of array
doubleElements:

	move $t0, $a0
	li $t9, 0		#counter for number of elements processed

#loop to double each element 
doubleLoop:

	addi $t0, $t0, 1	#increment index
	addi $t9, $t9, 1	#increment counter

	beq $t9, 5, endLoop	#end after 5 elements 

	lw $t1, ($t0)		#load value
	sll $t1, $t1, 1		#double with left logical shift 
	sw $t1, ($t0)		#store value
	



	j doubleLoop
	
endLoop:

	jr $ra


#a0 is address of array to print
printArr:

	move $t0, $a0
	
	li $t1, 0
	
printLoop:

	beq $t1, 20, donePrinting

	add $t2, $t1, $t0
	
	lb $t3, ($t2)
	
	li $v0, 1
	move $a0, $t3
	syscall

	addi $t1, $t1, 4
	
	j printLoop
	
donePrinting:

	jr $ra