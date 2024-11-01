.data
	x: .word 30
	y: .word 5
	n: .asciiz "\n"
.text
   main:   		
   	lw $t0, x #t0=x
   	lw $t1, y 
   	
   	#Metoda 1:
   	div $a0, $t0, $t1 #a0=t0/t1=30/5=6
   	li $v0, 1
   	syscall
   	
   		li $v0, 4 #print new line
   		la $a0, n 
   		syscall
   	
   	#Metoda 2:
   	li $t2, 8 #t2=8
   	div $t0, $t2 #t0/t2 
   	
   	#Catul se afla in LO
   	mflo $t1 #t1=catul (30/8=3)
   		li $v0, 1 #print int
   		move $a0, $t1
   		syscall
   	
   		li $v0, 4 #print new line
   		la $a0, n 
   		syscall
   		
   	#Restul se afla in HI
   	mfhi $t2 #t2=restul (30%8=6)
   		li $v0, 1 #print int
   		move $a0, $t2
   		syscall
   	
   		li $v0, 4 #print new line
   		la $a0, n 
   		syscall
   	
   	li $v0, 10
   	syscall
