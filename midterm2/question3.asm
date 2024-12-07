.data
	msg1: .asciiz "in function F\n"
	msg2: .asciiz "in function G\n"
.text
main:
	jal F
	li $v0, 10
	syscall
F:
	
	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $a0, 0($sp)
	
	jal G
	
	lw $a0, 0($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	
	li $v0, 4
	la $a0, msg1
	
	syscall
	
	jr $ra
G:
	li $v0, 4
	la $a0, msg2
	syscall
	
	jr $ra