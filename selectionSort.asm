.data
	vector: .word 32,45,6,76,12
	primeiraparte: .asciiz "Indice: "
	segundaparte: .asciiz " que possui valor: "
	terceiraparte: .asciiz " troca com indice: "
	quartaparte: .asciiz " que possui valor: "
	quebralinha: .asciiz "\n"
	space: .asciiz " "
	
.text
	la $a0, vector
	addi $a1, $zero, 5
	addi $v0, $zero, 1
	jal selection
	addi $a1, $zero, 5
	j printArray
	
	


	
selection:#selection(int vector[], int size)
	addi $sp, $sp, -8
	sw $a1, 0($sp)
	sw $ra, 4($sp)

	beq $s3, $a1, return
	sll $s1, $s3, 2 #s1 = index_zero*4
	add $s1, $a0, $s1 #s1 = v[0]
	
	add $t0, $t0, $zero

forSel:

	lw $s6, 0($s1) #s6 = min_value	
	sll $t5, $t0, 2 #t5 = index_j*4
	add $t5, $a0, $t5 #t5 = v[j]
	lw $s7, 0($t5)	#s7 = j_value
	slt $t3, $t0, $a1 #if(j<=size) t3==1
	beq $t3, $zero, exitFor
	addi $t0, $t0, 1 #j++
	blt $s7, $s6, if #if vector[j] < vector[min]
	bge $t0, $a1, exitFor

	j forSel

	
exitFor: 
	bge $s3, $a1, return #if s3>=size, return
	addi $s3, $s3, 1
	add $t0, $s3, 0

	jal selection

return:
	lw $a1, 0($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	jr $ra
if:	

	add $t9, $s6, $zero #temp = min
	add $s6, $s7, $zero #min = j
	#addi $t0, $t0, 1
	j printTroca	
swap:
	########SWAP#########
	sw $s6, 0($s1) 
	sw $t9, 0($t5)
	addi $s3, $s3, 1
	addi $s0, $s0, 1
	#####################
	j selection
	
printTroca:
	addi $sp, $sp, -8
	sw $a0, 0($sp)
	sw $v0, 4($sp)
	la $a0, primeiraparte
	addi $v0, $zero, 4
	syscall
	addi $a0, $t0, -1
	addi $v0, $zero, 1
	syscall
	la $a0, segundaparte
	addi $v0, $zero, 4
	syscall
	add $a0, $s6, $zero
	addi $v0, $zero, 1
	syscall
	la $a0, terceiraparte
	addi $v0, $zero, 4
	syscall
	add $a0, $s3, $zero
	addi $v0, $zero, 1
	syscall
	la $a0, quartaparte
	addi $v0, $zero, 4
	syscall
	add $a0, $t9, $zero
	addi $v0, $zero, 1
	syscall
	la $a0, quebralinha
	addi $v0, $zero, 4
	syscall
	lw $a0, 0($sp)
	lw $v0, 4($sp)
	addi $sp, $sp, 8

	j swap	
	

	
printArray:
	add $s0, $zero, $zero
	add $a2, $a0, $zero
	for:slt $t9, $s0, $a1
	beq $t9, $zero, exit
	sll $t1, $s0, 2
	add $t1, $a2, $t1
	lw $a0, 0($t1)
	addi $v0, $zero, 1
	syscall
	addi $s0, $s0, 1
	la $a0, space
	addi $v0, $zero, 4
	syscall
	j for
	lw $a0, 0($t1)
	

exit: nop
