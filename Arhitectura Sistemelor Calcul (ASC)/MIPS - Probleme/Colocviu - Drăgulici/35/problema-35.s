.data
v:.word -1,-2,-3,-3,-4,-5
n:.word 6
mesaj1:.asciiz "exista"
mesaj2:.asciiz "nu exista"
x:.word 0

.text
main:

subu $sp,8
la $t0,v
sw $t0,0($sp)
lw $t0,n
sw $t0,4($sp)	#stiva devine $sp:(adresa lui v),(n);
jal verifica
addu $sp,8
beq $zero,$v0,m1
	j m2
m1:
	li $v0,4
	la $a0,mesaj2
	syscall
	li $v0,10
	syscall

m2:
	li $v0,4
	la $a0,mesaj1
	syscall
	li $v0,10
	syscall



verifica:
	subu $sp,4
	sw $fp,0($sp)
	addiu $fp,$sp,0	   #stiva devine $sp,$fp:(fp vechi),(adresa lui v),(n);
	li $t0,0
	lw $t1,8($fp)
	lw $t2,4($fp)

intrare:
	beq $t0,$t1,iesire
		lw $t3,0($t2)
		bgt $t3,$zero,et1
		addi $t0,$t0,1
		addi $t2,$t2,4
		j intrare
et1:
	li $v0,1
	j iesire

iesire:
	li $t0,1
	beq $t0,$v0,et2
	    li $v0,0
et2:
	lw $fp,0($fp)
	addu $sp,4	#stiva devine $sp:(adresa lui v),(n);
	jr $ra
	

