.data

.text
   main:
	li $t0, 22
	li $t1, 32

	subi $sp, $sp, 8 #aloc memorie pentru cele 2 valori (stiva cre?te în jos -> scãdere)
	sw $t0, 0($sp)   #sp[0]=22
	sw $t1, 4($sp)   #sp[1]=32
	j sum
	
	continue:
	   lw $t2, 0($sp)
	   addi $sp,$sp, 8  #dezaloc memoria 
	   
	   li $v0, 1 #afisare
	   move $a0, $t2
	   syscall 
	   li $v0, 10 #return 0
	   syscall

	sum:
	   lw $s1, 0($sp)
	   lw $s2, 4($sp)
	   add $s1,$s1,$s2
	   sw $s1, 0($sp)
	   j continue