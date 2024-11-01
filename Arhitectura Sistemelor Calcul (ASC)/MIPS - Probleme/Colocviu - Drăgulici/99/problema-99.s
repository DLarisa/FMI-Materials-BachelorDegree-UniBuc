.data

n:.word 10324
k:.word 4
mesaj1:.asciiz "Apare"
mesaj2:.asciiz "Nu apare"

.text
main:

subu $sp,8
lw $t0,n
sw $t0,0($sp)
lw $t0,k
sw $t0,4($sp)
jal apare
addu $sp,8

beq $v0,$zero,m1
j m2

m1:
	li $v0,4
	la $a0,mesaj2
	syscall
	j gata
m2:
	li $v0,4
	la $a0,mesaj1
	syscall
	j gata

gata:

li $v0,10
syscall

apare:

subu $sp,4	#stiva este $sp:$fp:($fp vechi),(n),(k);
sw $fp,0($sp)
addiu $fp,$sp,0
lw $t0,4($fp)
lw $t1,8($fp)
li $t2,10

intrare:
	beq $t0,$zero,iesire
	div $t0,$t2
	mfhi $t3
	mflo $t4
	move $t0,$t4
	beq $t3,$t1,da
	j intrare
da:
	li $v0,1
iesire:
	li $t5,1
	bne $v0,$t5,et
	j et1
et:
	li $v0,0
et1:
	lw $fp,0($fp)
	addu $sp,4	#stiva devine $sp:(n),(k);
	jr $ra


