.data

	buffer: .space 4
	result: .asciiz "second largest: "
	
.text
main:

	li $t0, 0
	la $t1, buffer				#load address of buffer
	
	li $t8, 0					#max index
	li $t9, 0					#store max value
	
Loop:
	beq $t0, 4, doneReading		#done if we read 4 integers
	
	add $t2, $t1, $t0			#calculate index address
	
	li $v0, 5					#read integer
	syscall
	sb $v0, ($t2)				#store at calculated index
	
	bgt $t9, $v0, dontUpdate	#check if it was the biggest
	
	
updateMax:						#the number we read is the largest so far

	move $t9, $v0				#max value 
	move $t8, $t0				#index of max value

dontUpdate:						#the number we read isn't the largest so far

	addi $t0, $t0, 1
	j Loop
	
doneReading:



li $t6, 0 						#index of second largest 
li $t7, 0 						#max (except t8)

li $t0, 0 						#reset counter

secondLargest:

	beq $t0, 4, found			#stop searching after 4th number

	add $t2, $t1, $t0 			
	
	lb $t3, ($t2)
	
	#two cases where we don't update second largest
	#	1. it's the largetst 
	#	2. it's not the largest (except for whatever is in index t8)
	beq $t0, $t8, dontUpdateSecondLargest
	bgt, $t7, $t3, dontUpdateSecondLargest
	
updateSecondLargest:			#update second largest

	move $t7, $t3
	move $t6, $t0

dontUpdateSecondLargest:		#otherwise just increment
	
	addi $t0, $t0, 1	
	j secondLargest
	
found:

	#print string 
	li $v0, 4
	la $a0, result
	syscall 
	
	#print second largest number
	move $a0, $t7
	li $v0, 1
	syscall
	
	#terminate program
	li $v0, 10
	syscall
