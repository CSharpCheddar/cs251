	#############################################################################
	# Lab 10
	# Author:      Martin Mueller
	# Description: Creates 10 pseudo-random numbers, storing them into an array,
	#              and then sorts the array.
	#############################################################################

	.data
seed:
	.space 4
a:
	.space 40
p:
	.space 4
prompt:
	.asciiz "Enter a positive (integer) seed value: "

	.text
	li $v0 4		# Prompt for seed value
	la $a0 prompt
	syscall

	li $v0 5		# Retrieve seed value, store in seed
	syscall
	sw $v0, seed

	la $t0, a		# Make p point to a
	sw $t0, p

	lw $t0, seed		# Initialize a[0]
	li $t1, 13
	mul $t0, $t0, $t1
	addi $t0, $t0, 17
	rem $t0, $t0, 37
	lw $t1, p
	sw $t0, 0($t1)

	lw $t0, p		# For loop init: p++;
	addi $t0, $t0, 4
	sw $t0, p

	j FOR			# Evaluate for loop condition

FORBODY:

	lw $t0, p		# For loop body: *p = (13 * *(p - 1) + 17) % 37;
	lw $t0, -4($t0)
	li $t1, 13
	mul $t0, $t0, $t1
	addi $t0, $t0, 17
	rem $t0, $t0, 37
	lw $t1, p
	sw $t0, 0($t1)

	lw $t0, p
	addi $t0, $t0, 4	# For loop increment: p++;
	sw $t0, p

FOR:
	
	lw $t0, p		# For loop condition: p < a + 10;
	la $t1, a
	addi $t1, $t1, 40
	blt $t0, $t1, FORBODY

	la $t0, a		# p = a;
	sw $t0, p

	j WHILE			# Evaluate while condition

WHILEBODY:

	lw $t0, p		# If p == a, goto IF
	la $t1, a
	beq $t0, $t1, IF

	lw $t0, p		# If *p >= *(p - 1), goto IF
	lw $t0, 0($t0)
	lw $t1, p
	lw $t1, -4($t1)
	bge $t0, $t1, IF

	lw $t9, p		# register int temp = *p;
	lw $t9, 0($t9)

	lw $t0, p		# *p = *(p - 1);
	lw $t0, -4($t0)
	lw $t1, p
	sw $t0, 0($t1)

	lw $t0, p		# *(p - 1) = tmp;
	sw $t9, -4($t0)

	lw $t0, p		# p--;
	addi, $t0, $t0, -4
	sw $t0, p

	j WHILE			# Reevaluate while loop condition

IF:

	lw $t0, p		# p++;
	addi $t0, $t0, 4
	sw $t0, p

WHILE:

	lw $t0, p		# While loop condition: p < a + 10;
	la $t1, a
	addi $t1, $t1, 40
	blt $t0, $t1, WHILEBODY

	li $v0, 10		# Exit program
	syscall
