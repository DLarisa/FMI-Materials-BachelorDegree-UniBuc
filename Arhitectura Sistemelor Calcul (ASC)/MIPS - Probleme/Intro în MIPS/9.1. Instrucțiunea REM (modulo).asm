.data
	c: .word 50
	i: .word 7
.text
   main:
   	lw $t0, c
   	lw $t1, i
   	
   	rem $t2, $t0, $t1 #t2=t0%t1
   	
   	li $v0, 1 #afisare
   	move $a0, $t2
   	syscall
   	li $v0, 10
   	syscall