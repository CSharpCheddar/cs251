addi $t1, $zero, 1  # Compute first quatronacci number
addi $t2, $zero, 1  # Compute second quatronacci number
addi $t3, $zero, 2  # Compute third quatronacci number
addi $t4, $zero, 4  # Compute fourth quatronacci number
add $t5, $t1, $t2   # Compute fifth quatronacci number
add $t5, $t5, $t3
add $t5, $t5, $t4
add $t6, $t2, $t3   # Compute sixth quatronacci number
add $t6, $t6, $t4
add $t6, $t6, $t5
add $t7, $t3, $t4   # Compute seventh quatronacci number
add $t7, $t7, $t5
add $t7, $t7, $t6
addi $v0, $zero, 10 # Terminate program
syscall