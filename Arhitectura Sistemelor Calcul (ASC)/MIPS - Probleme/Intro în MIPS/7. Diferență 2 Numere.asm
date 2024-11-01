.data
	x: .word 20
	y: .word 15
.text
   main:
   	lw $t0, x #t0=x
   	lw $t1, y
   	sub $t0, $t0, $t1 #t0=t0-t1
   	
   	li $v0, 1
   	move $a0, $t0
   	syscall
   	
   	li $v0, 10
   	syscall