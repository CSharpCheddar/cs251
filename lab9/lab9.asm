	#############################################################################
	# Lab 9
	# Author: Martin Mueller
	# Description:  Prompts the user for a sequence of up to 10 non-zero integers
	# (followed by a zero). Then sorts this sequence of non-zero numbers in
	# increasing order.
	#############################################################################
	
	.data
a:
	.space 40
prompt:
	.asciiz "Enter up to 10 non-zero integers followed by 0: "
	
	.text
	
	li $t0, 0			# $t0 counts the numbers entered so far
	
	la $t1, a			# $t1 contains address of next empty location of a
	
	li $v0, 4			# Prompt user for input
	la $a0, prompt
	syscall

INPUT_LOOP:

	li $v0, 5			# Retrieve input, load into $t2
	syscall
	move $t2, $v0
	
	beq $t2, $zero, SORT		# if next input != 0, store input in a, else sort a
	sw $t2, 0($t1)
	addi $t0, $t0, 1
	addi $t1, $t1, 4
	
	j INPUT_LOOP			# Get next number

SORT:

	li $t1, 0			# $t1 contains index
	
	la $t2, a			# $t2 contains &a[index]
	
	lw $t3, 0($t2)			# t3 contains a[index]
	
	addi $t4, $t2, -4		# $t4 contains &a[index - 1]

SORT_LOOP:

	bge $t1, $t0, EXIT		# while (index < a.length), do following, else exit program
	
	beq $t1, $zero, THEN		# if (index == 0 || a[index] >= a[index - 1]), goto THEN
	bge $t3, $t5, THEN

ELSE:

	move $t6, $t3			# Swap a[index] with a[index - 1]
	sw $t5, 0($t2)
	sw $t6, 0($t4)
	addi $t1, $t1, -1
	addi $t2, $t2, -4
	lw $t3, 0($t2)
	addi $t4, $t4, -4
	lw $t5, 0($t4)
	
	j SORT_LOOP			# Check loop condition

THEN:

	addi $t1, $t1, 1		# Move to next element in a
	addi $t2, $t2, 4
	lw $t3, 0($t2)
	addi $t4, $t4, 4
	lw $t5, 0($t4)
	
	j SORT_LOOP			# Check loop condition

EXIT:

	li $v0, 10			# Exit the program
	syscall
