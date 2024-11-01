.data
	x: .space 4
	y: .space 100
.text
   main:  
   	li $t0, 259
   	sw $t0, x   #x=259
   	
   	subu $sp, $sp, 8 
   	sw $t0, 4($sp)
   	la $t0, y
   	sw $t0, 0($sp) #$sp:(adresa y)(x)
   	
   	jal bts 
   	addu $sp, $sp, 8 #lista vida
   	
   	#afisare
	li $v0, 4 
	la $a0, y
	syscall
	
	li $v0, 10
	syscall
#end_main

   bts: 
   	subu $sp, $sp, 8
   	li $s0, 0 #i=0
	sw $s0, 0($sp)
	sw $fp,4($sp)
	addiu $fp, $sp, 4
	# acum stiva este $sp:($s0 v)$fp:($fp vechi)(adresa y)(x)
	lw $t0, 4($fp)
   	move $sp, $t0 #sp are adresa de inceput a lui y
 
   	li $t0, 32 #t0=32
   	
   	for:
   	lw $s0, -4($fp)
   	beq $s0, $t0, exit
   	#s1=masca(1<<i)
   	li $s1, 1
   	sllv $s1, $s1, $s0
   	#s1=n&(1<<i)
   	lw $s2, 8($fp)
   	and $s1, $s1, $s2
   	
   	lw $t1, 4($fp) #t1=y
   	add $t1, $t1, $s0 #t1=y[i]
   	
   	beq $s1, $zero, bit0
   		li $s1, '1'
   	        sb $s1, 0($t1)
   	        j cond1
   	   
   	   bit0: li $s1, '0'
   	   	 sb $s1, 0($t1)
   	   	 
   	   	 cond1: addi $s0, $s0, 1
   	   	 	sw $s0, -4($fp)
   	   	 	j for
   	#end_for
   	
   	exit: jr $ra	
   #end_bts
