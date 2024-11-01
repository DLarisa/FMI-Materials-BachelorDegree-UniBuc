.data
	x: .word 25
.text
   main: 
   	lw $t1, x
   	addi $t2, $zero, 2 #t1=0+4 (add!=addi --- la addi ai efectiv un nr)
   	mul $t0, $t1, $t2 #t0=t1*t2
   	#mul=inmultire cu overflow (nr nu pot fi mai mari de 16 biti)
   	#pune maxim 32 de biti in LO
   	
   	li $v0, 1
   	move $a0, $t0
   	syscall
   
   	li $v0, 10
   	syscall