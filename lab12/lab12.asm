##############################################################################
# Lab 12
# Author:       Martin Mueller
# Description:  Determines whether or not a 2D array with nrows rows and
#              	ncols columns contains a permutation of the integers between
#              	0 and (nrows * ncols) using functions.
##############################################################################
	.data
numRows:
	.word 3
numCols:
	.word 5
flag:
	.space 60    # 1D array of 15 integers
a:
	.word   0, 1, 2, 3, 4,
	        5, 6, 7, 8, 9,
	       10,11,12,13,14

                     # the variables above this line will change for each test case
permstr:
	.asciiz "permutation\n"
nopermstr:
	.asciiz "not a permutation\n"
	
	.text
	
	####################################################################
	#                          main function
	####################################################################

	lw $a0, numRows		# If (updateFlags(numRows, numCols, flags) == 0), goto IF
	lw $a1, numCols
	lw $a3, flag
	jal updateFlags
	beq IF, $v0, $zero

	lw $t0, numRows		# If (checkFlags(numRows * numCols, flags) == 0), goto IF
	lw $t1, nomCols
	mul $a0, $t0, $t1
	lw $a2, flag
	jal checkFlags
	beq IF $v0, $zero

	lw $v0, permstr		# Else, print "permutiation\n"
	li $a0, 4
	syscall

	j END			# Jump to the end of the program

IF:

	lw $v0, nopermstr	# Print "not a permutiation\n"
	li $a0, 4
	syscall

END:

	li $a0, 10		# End the program
	syscall

	####################################################################
	#                      updateFlags function
	####################################################################

updateFlags:

	li $t7, 0		# For w/ r init, r = 0
	j CONDR

FORR:

	li $t8, 0		# For w/ c init, c = 0
	j CONDC

FORC:

	la $t0, a
	li $t1, 4
	sub $t2, $a0, $t7
	addi $t2, $t2, -1
	mul $t2, $t2, $a1
	add $t2, $t2, $t8

	addi $t8, $t8, 1	# For w/ c ctrl var change: c++

CONDC:

	blt FORC, $t8, $a1

	addi $t7, $t7, 1	# For w/ r ctrl var change: r++

CONDR:

	blt FORR, $t7, $a0	# For w/ r condition: r < nrows

	li $v0, 1		# Return 1, maybe a permutation
	jr $ra

	####################################################################
	#                       checkFlags function
	####################################################################
