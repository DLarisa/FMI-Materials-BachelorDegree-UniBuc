.data
x:.asciiz "999783"
y:.ascii "0"
z:.word 0

.text
main:

subu $sp,4
la $t0,x
sw $t0,0($sp)
jal succesor
addu $sp,4
li $v0,4
la $a0,x
syscall
li $v0,10
syscall


succesor:
	subu $sp,4
	sw $fp,0($sp)
	addiu $fp,$sp,0
	lw $t0,4($fp)
	li $t2,9
	lb $t1,0($t0)
	lb $t3,y
	sub $t1,$t1,$t3
	
intrare:
	bne $t1,$t2,iesire
	sb $t3,0($t0)
	addi $t0,$t0,1
	lb $t1,0($t0)
	sub $t1,$t1,$t3
	j intrare

iesire:
	
	add $t1,$t1,$t3
	bne $t1,$zero,et
	j gata
	
et:
	sub $t1,$t1,$t3
	addi $t1,$t1,1
	add $t1,$t1,$t3
	sb $t1,0($t0)

gata:
	lw $fp,0($fp)
	addu $sp,4
	jr $ra
	

	
	
	
	
	