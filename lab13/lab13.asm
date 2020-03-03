##############################################################################
# Lab 13
# Author:      Martin Mueller
# Description: Prompts the user for the value of n and then computes the
#              value of the nth Quatronacci number q(n) in two different ways.
#              Both approaches are recursive, but the second uses a 1D array
#              and is much more efficient than the first one.
##############################################################################

##############################################################################	
# At the beginning of each function, right under its comment block
# you must depict its activation record in a comment block like this one:
#
#    +------------------+
#  0 |        ???       |
#    +------------------+
#  1 |        ???       |
#    +------------------+
#  2 |        ???       |
#    +------------------+
#    |        ...       |
#    
# with the appropriate number of elements in the frame and the question marks
# replaced with the name of the register or variable stored in it
#
# or else indicate EXPLICITLY that the activation record is empty, like this:
#
#    [The activation record for this function is empty.]
#
##############################################################################
	.data
s:
	.asciiz "n = "
newline:
	.asciiz "\n"
method1:
	.asciiz "using method 1:\n  q[n] = "
method2:
	.asciiz "using method 2:\n  q[n] = "
	
	.text
	
	####################################################################
	#                         main function
	####################################################################
	#    [The activation record for this function is empty.]
	la $a0, s			# computeQtwice( getInt(s) );
	jal getInt
	move $a0, $v0
	jal computeQtwice

	li $v0, 10			# return 0;
	syscall
	####################################################################
	#                        getInt function
	####################################################################
	#    [The activation record for this function is empty.]
getInt:
	li $v0, 4			# printf("%s", prompt);
	syscall

	li $v0, 5			# scanf("%d", &n);
	syscall

	jr $ra				# return n;
	####################################################################
	#                 computeQrecursively1 function
	####################################################################
	#    +------------------+
	#  0 |        $s0       |
	#    +------------------+
	#  4 |        $ra       |
	#    +------------------+
	#  8 |        $a0       |
	#    +------------------+
computeQrecursively1:
	addi $sp, $sp, -12		# Prologue: save $a0, $ra, and $s0
	sw $a0, 8($sp)
	sw $ra, 4($sp)
	sw $s0 0($sp)

	li $t0, 2			# if (i <= 2), goto return1
	ble $a0, $t0, return1

	li $t0, 3			# if (i == 3), goto return2
	beq $a0, $t0, return2

	li $t0, 4			# if (i == 4), goto return4
	beq $a0, $t0, return4

	addi $a0,  $a0, -1		# return computeQrecursively(i-1) + computeQrecursively(i-2) +
	jal computeQrecursively1	#   computeQrecursively(i-3) + computeQrecursively(i-4);
	move $s0, $v0
	lw $a0, 8($sp)
	addi $a0, $a0, -2
	jal computeQrecursively1
	add $s0, $s0, $v0
	lw $a0, 8($sp)
	addi $a0, $a0, -3
	jal computeQrecursively1
	add $s0, $s0, $v0
	lw $a0, 8($sp)
	addi $a0, $a0, -4
	jal computeQrecursively1
	add $v0, $v0, $s0
	lw $ra, 4($sp)
	lw $s0, 0($sp)
	addi $sp, $sp, 12
	jr $ra

return1:
	li $v0, 1			# return 1;
	lw $ra, 4($sp)
	lw $s0, 0($sp)
	addi $sp, $sp, 12
	jr $ra

return2:
	li $v0, 2			# return 2;
	lw $ra, 4($sp)
	lw $s0, 0($sp)
	addi $sp, $sp, 12
	jr $ra

return4:
	li $v0, 4			# return 4;
	lw $ra, 4($sp)
	lw $s0, 0($sp)
	addi $sp, $sp, 12
	jr $ra
	####################################################################
	#                       recHelper function
	####################################################################
	#    +------------------+
	#  0 |        $s0       |
	#    +------------------+
	#  4 |        $ra       |
	#    +------------------+
	#  8 |        $a0       |
	#    +------------------+
	# 12 |        $a1       |
	#    +------------------+
recHelper:
	addi $sp, $sp, -16		# Prologue: save $a1, $a0, $ra, and $s0
	sw $a1, 12($sp)
	sw $a0, 8($sp)
	sw $ra, 4($sp)
	sw $s0, 0($sp)

	lw $t0, 8($sp)			# if (q[i] > 0), goto return
	lw $t1, 12($sp)
	sll $t1, $t1, 2
	add $t0, $t0, $t1
	lw $t1, 0($t0)
	bgt $t1, $zero, return

	lw $a0, 8($sp)			# q[i] = recHelper(q, i-1) + recHelper(q, i-2) +
	lw $a1, 12($sp)			#   recHelper(q, i-3) + recHelper(q, i-4);
	addi $a1, $a1, -1
	jal recHelper
	move $s0, $v0
	lw $a0, 8($sp)
	lw $a1, 12($sp)
	addi $a1, $a1, -2
	jal recHelper
	add $s0, $s0, $v0
	lw $a0, 8($sp)
	lw $a1, 12($sp)
	addi $a1, $a1, -3
	jal recHelper
	add $s0, $s0, $v0
	lw $a0, 8($sp)
	lw $a1, 12($sp)
	addi $a1, $a1, -4
	jal recHelper
	add $s0, $s0, $v0
	lw $t0, 8($sp)
	lw $t1, 12($sp)
	sll $t1, $t1, 2
	add $t0, $t0, $t1
	sw $s0, 0($t0)

return:
	lw $t0, 8($sp)			# return q[i];
	lw $t1, 12($sp)
	sll $t1, $t1, 2
	add $t0, $t0, $t1
	lw $v0, 0($t0)
	lw $ra, 4($sp)
	addi $sp, $sp, 16
	jr $ra
	####################################################################
	#                 computeQrecursively2 function
	####################################################################
	#    +------------------+
	#  0 |        $ra       |
	#    +------------------+
	#  4 |  fourth argument |
	#    +------------------+
	#  8 |  fifth argument  |
	#    +------------------+
computeQrecursively2:
	addi $sp, $sp, -4		# Prologue: save $ra
	sw $ra, 0($sp)

	sw $a1, 4($a0)			# q[1] = q1;

	sw $a2, 8($a0)			# q[2] = q2;

	sw $a3, 12($a0)			# q[3] = q3;

	lw $t0, 4($sp)			# q[4] = q4;
	sw $t0, 16($a0)

	lw $a1, 8($sp)			# return recHelper(q, i);
	jal recHelper
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	####################################################################
	#                       initList function
	####################################################################
	#    +------------------+
	#  0 |         i        |
	#    +------------------+
initList:
	addi $sp, $sp, -4		# Prologue: int i = 0;
	sw $zero, 0($sp)

	j condition			# Begin for loop

for:
	lw $t0, 0($sp)			# q[i] = v;
	sll $t0, $t0, 2
	add $t0, $t0, $a0
	sw $a2, 0($t0)

	lw $t0, 0($sp)			# i++;
	addi $t0, $t0, 1
	sw $t0, 0($sp)

condition:
	lw $t0, 0($sp)			# For loop condition: i < n
	blt $t0, $a1, for

	addi $sp, $sp, 4		# Epilogue: pop stack and return
	jr $ra
	####################################################################
	#                     computeQtwice function
	####################################################################
	#     +------------------+
	#  0  |         q        |
	#     +------------------+
	# 144 |        $ra       |
	#     +------------------+
	# 148 |        $a0       |
	#     +------------------+
computeQtwice:
	addi $sp, $sp, -152		# Prologue: save $a0, $ra, and: int *q = (int *) malloc( 36 * sizeof(int) );
	sw $a0, 148($sp)
	sw $ra, 144($sp)

	
	la $v0, 4			# printf("using method 1:\n q[n] = %d\n", computeQrecursively1(n));
	la $a0, method1
	syscall
	lw $a0, 148($sp)
	jal computeQrecursively1
	move $a0, $v0
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, newline
	syscall

	move $a0, $sp			# initList(q, n+1, -1);
	lw $a1, 148($sp)
	addi $a1, $a1, 1
	li $a2, -1
	jal initList

	li $v0, 4			# printf("using method 2:\n q[n] = %d\n", computeQrecursively2(q, 1, 1, 2, 4, n));
	la $a0, method2
	syscall
	move $a0, $sp
	li $a1, 1
	li $a2, 1
	li $a3, 2
	lw $t0, 148($sp)
	addi $sp, $sp -8
	sw $t0, 4($sp)
	li $t0, 4
	sw $t0, 0($sp)
	jal computeQrecursively2
	addi, $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, newline
	syscall
	
	lw $ra, 144($sp)		# Epilogue: pop stack and return
	addi $sp, $sp, 152
	jr $ra