.data
	
.text
   main:
   	#srl = impartire pe biti >>
   	li $t0, 4 #t0=4
   	sll $t0, $t0, 3 #t0=t0*(2^3)=t0*8=t0<<3
   	
   	li $v0, 1
   	move $a0, $t0
   	syscall
   
   	li $v0, 10
   	syscall