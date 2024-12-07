.data
	arr: .word 1, 2, 5, 7, 8, 9, 0, 3
.text
main:
	la $t0, arr
	
	li $v0, 1
	lw $a0, 0($t0)
	syscall
	
	li $v0, 10
	syscall