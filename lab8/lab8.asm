	#############################################################################
	# Lab 8
	# Author:	Martin Mueller
	# Description:	Given a positive integer N entered by the user, outputs the
	#		corresponding value of k if N is the kth Fibonacci number.
	#		If N is not a Fibonacci number, then outputs the two
	#		consecutive Fibonacci numbers that surround N.
	#############################################################################
	
	.data
	
prompt:
	.asciiz "Enter a positive integer: N = "
	
error:
	.asciiz "You must enter a POSITIVE integer. N = "
	
eq:
	.asciiz " is equal to F"
	
n:
	.asciiz "\n"
	
neq:
	.asciiz " is not a Fibonacci number ("
	
lt:
	.asciiz " < "
	
parenn:
	.asciiz ")\n"
	
	.text
	
	li $v0, 4		# Prompt user for input
	la $a0, prompt
	syscall
	
	li $v0, 5		# Retrieve input
	syscall
	
	move $t0, $v0		# Load input into $t0
	
	bge $t0, 1, success	# Validate input
	
failure:

	li $v0, 4		# Prompt user for new input
	la $a0, error
	syscall
	
	li $v0, 5		# Retrieve new input
	syscall
	
	move $t0, $v0		# Load new input into $t0
	
	blt $t0, 1, failure	# Validate new input
	
success:

	li $t1, 2		# Load first 3 Fibonacci numbers into $t1, $t2, and $t3
	li $t2, 1
	li $t3, 1
	
t3ge:

	bge $t3, $t0, out	# If $t3 < $t0 calculate next Fibonacci numbers, else skip
	add $t3, $t2, $t3
	sub $t2, $t3, $t2
	addi $t1, $t1, 1
	
	j t3ge			# Check if $t3 < $t0 again
	
out:

	li $v0, 1		# Output $t0
	move $a0, $t0
	syscall
	
	bne $t3, $t0, altout	# Give following output if $t3 == $t0, else give alternate output
	
	li $v0, 4		# Output " is equal to F"
	la $a0, eq
	syscall
	
	li $v0, 1		# Output $t1
	move $a0, $t1
	syscall
	
	li $v0, 4		# Output newline
	la $a0, n
	syscall
	
	j exit			# Jump to program end
	
altout:

	li $v0, 4		# Following for if $t3 != $t0, output " is not a Fibonacci number ("
	la $a0, neq
	syscall
	
	li $v0, 1		# Output $t2
	move $a0, $t2
	syscall
	
	li $v0, 4		# Output " < "
	la $a0, lt
	syscall
	
	li $v0, 1		# Output $t0
	move $a0, $t0
	syscall
	
	li $v0, 4		# Output " < "
	la $a0, lt
	syscall
	
	li $v0, 1		# Output $t3
	move $a0, $t3
	syscall
	
	li $v0, 4		# Output ")" and a newline
	la $a0, parenn
	syscall
	
exit:
	
	li $v0, 10		# Exit the program
	syscall
