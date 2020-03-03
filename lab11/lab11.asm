##############################################################################
# Lab 11
# Author:      Martin Mueller
# Description: Determines whether or not a 2D array with nrows rows and
#              ncols columns contains a permutation of the integers between
#              0 and (nrows * ncols).
##############################################################################
	.data
a:
	.word	1,  2,  3,  4,  5,
		6,  7,  8,  9, 10,
		0, 14, 13, 12, 11
count:
	.space 60    # 1D array of 15 integers
nrows:
	.word 3
ncols:
	.word 5

r:                   # the variables above this line will change for each test case
	.space 4
c:
	.space 4
i:
	.space 4
perstr:
	.asciiz "permutation\n"
noperstr:
	.asciiz "not a permutation\n"
	.text
	sw $zero, r		# For w/ r init: r = 0
	j CONDR

FORR:

	sw $zero, c		# For w/ c init: c = 0
	j CONDC

FORC:

	la $t0, a		# $t7 = a[r][c]
	lw $t1, r
	lw $t2, ncols
	mul $t1, $t1, $t2
	lw $t2, c
	add $t1, $t1, $t2
	sll $t1, $t1, 2
	add $t0, $t0, $t1
	lw $t7, 0($t0)

	blt $t7, $zero, NOPER	# if tmp < 0 || tmp >= nrows * ncols, end early
	lw $t0, nrows
	lw $t1, ncols
	mul $t0, $t0, $t1
	bge $t7, $t0, NOPER
	
	la $t0, count		# count[tmp] = 1;
	sll $t1, $t7, 2
	add $t0, $t0, $t1
	li $t1, 1
	sw $t1, 0($t0)
	
	lw $t0, c		# For w/ c ctrl var change: c++
	addi $t0, $t0, 1
	sw $t0, c
	
	j CONDC			# Check for w/ c condition

NOPER:

	li $v0 4		# Display "not a permution\n"
	la $a0 noperstr
	syscall
	
	j END			# End program

CONDC:

	lw $t0, c		# For w/ c condition: c < ncols
	lw $t1, ncols
	blt $t0, $t1, FORC

	lw $t0, r		# For w/ r ctrl var change: r++
	addi $t0, $t0, 1
	sw $t0, r

CONDR:

	lw $t0, r		# For w/ r condition: r < nrows
	lw $t1, nrows
	blt $t0, $t1, FORR

	sw $zero, i		# For w/ i init: i = 0
	j CONDI

FORI:

	la $t0, count		# if count[i] == 0, goto IF
	lw $t1, i
	sll $t1, $t1, 2
	add $t0, $t0, $t1
	lw $t0, 0($t0)
	beq $t0, $zero, IF

	lw $t0, i		# For w/ i ctrl var change: i++
	addi $t0, $t0, 1
	sw $t0, i
	
	j CONDI			# Check for w/ i condition

IF:

	li $v0 4		# Display "not a permution\n"
	la $a0 noperstr
	syscall

	j END			# Break out of loop

CONDI:

	lw $t0, i		# For w/ i condition: i < nrows * ncols
	lw $t1, nrows
	lw $t2, ncols
	mul $t1, $t1, $t2
	blt $t0, $t1, FORI

	li $v0 4		# Display "permution\n"
	la $a0 perstr
	syscall

END:

	li $v0, 10		# End program
	syscall