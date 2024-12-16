    .data
prompt:     .asciiz "Enter an arithmetic expression (e.g., 3 + 5 * 2 - (4 / 2)): "
result:     .asciiz "\nPostfix expression: "
new_line:   .asciiz "\n"
expression: .space 100        # space for user input

    .text
    .globl main

main:
    # Print prompt
    li $v0, 4
    la $a0, prompt
    syscall

    # Read the expression (string) from user input
    li $v0, 8
    la $a0, expression
    li $a1, 100
    syscall

    # Initialize stack pointers
    la $t0, operand_stack       # operand stack pointer
    la $t1, operator_stack      # operator stack pointer
    li $t2, 0                   # operand stack index
    li $t3, 0                   # operator stack index
    li $t4, 0                   # postfix expression index

    # Parse the expression
    la $t5, expression          # pointer to input expression

parse_loop:
    lb $t6, 0($t5)             # load byte from expression
    beqz $t6, done              # if end of string (null terminator), stop

    # Skip whitespace
    li $t7, 32                  # ASCII for space
    beq $t6, $t7, skip_whitespace

    # Check if it's a digit (ASCII '0' to '9')
    li $t7, 48                  # ASCII '0'
    li $t8, 57                  # ASCII '9'
    blt $t6, $t7, not_digit
    bgt $t6, $t8, not_digit

    # It's a digit, convert it to integer and store in operand stack
    sub $t6, $t6, $t7           # convert ASCII to integer ('0' -> 0, '1' -> 1, ...)
    sb $t6, 0($t0)               # store the number in operand stack
    addi $t0, $t0, 1             # move operand stack pointer
    addi $t4, $t4, 1             # increment postfix expression index
    j next_char

not_digit:
    # Handle operators (+, -, *, /)
    beq $t6, 43, handle_plus      # '+'
    beq $t6, 45, handle_minus     # '-'
    beq $t6, 42, handle_multiply  # '*'
    beq $t6, 47, handle_divide    # '/'
    beq $t6, 40, handle_open_paren    # '('
    beq $t6, 41, handle_close_paren   # ')'

skip_whitespace:
    addi $t5, $t5, 1             # move to next character in input string
    j parse_loop

# Handle operators (+, -, *, /)

handle_plus:
    j handle_operator

handle_minus:
    j handle_operator

handle_multiply:
    j handle_operator

handle_divide:
    j handle_operator

# Process the operator
handle_operator:
    # Pop operators from operator stack if they have higher or equal precedence
    # (For simplicity, we assume all operators are left-associative)

    # Compare with top of the operator stack for precedence (implement precedence here)

    # Push the current operator onto the operator stack
    sb $t6, 0($t1)
    addi $t1, $t1, 1             # move operator stack pointer
    j next_char

handle_open_paren:
    # Push '(' onto operator stack
    sb $t6, 0($t1)
    addi $t1, $t1, 1             # move operator stack pointer
    j next_char

handle_close_paren:
    # Pop operators from the operator stack until '(' is found
    lb $t9, -1($t1)              # load top of operator stack
    beq $t9, 40, pop_paren       # if '(' is found, stop
    # Pop operator and append to postfix expression
    sb $t9, 0($t0)
    addi $t0, $t0, 1             # move operand stack pointer
    addi $t1, $t1, -1            # pop operator
    j handle_close_paren

pop_paren:
    addi $t1, $t1, -1            # pop '(' from operator stack
    j next_char

next_char:
    addi $t5, $t5, 1             # move to next character in input string
    j parse_loop

done:
    # Output the postfix expression
    li $v0, 4
    la $a0, result
    syscall

    li $v0, 4
    la $a0, postfix_expression  # print the postfix expression
    syscall

    # Print new line
    li $v0, 4
    la $a0, new_line
    syscall

    # Exit program
    li $v0, 10
    syscall

# Operand and Operator Stack Definitions
    .data
operand_stack: .space 400       # space for operand stack (100 integers max)
operator_stack: .space 400      # space for operator stack (100 operators max)
postfix_expression: .space 400 # space for output postfix expression
