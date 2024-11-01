.data
s:.space 27
x:.byte 'd'
y:.byte 'h'

.text
main:

subu $sp,12
la $t0,s
sw $t0,0($sp)
lb $t0,x
sw $t0,4($sp)
lb $t0,y
sw $t0,8($sp)
jal rezolvare
addu $sp,12
li $v0,4
la $a0,s
syscall
li $v0,10
syscall


rezolvare:
	subu $sp,4
	sw $fp,0($sp)			     
	addiu $fp,$sp,0    #stiva este $sp,($s0),(fp vechi),(adresa s),(x),(y).
	subu $sp,8
	sw $s0,-4($fp)
	sw $s1,-8($fp)
	lw $s0,4($fp)	#s0-adresa lui s
	lw $s1,8($fp)   #s1-x
	lw $t0,12($fp)  #t0-y

intrare:
	beq $s1,$t0,iesire	
	sb $s1,0($s0)
	addi $s0,$s0,1
	addi $s1,$s1,1
	j intrare

iesire:
	sb $s1,0($s0)
	lw $s0,-4($fp)
	lw $s1,-8($fp)
	lw $fp,0($fp)
	addu $sp,12
	jr $ra
	
	
