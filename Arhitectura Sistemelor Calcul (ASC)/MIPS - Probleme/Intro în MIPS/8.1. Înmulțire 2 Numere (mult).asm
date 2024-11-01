.data
	x: .word 2000
.text
   main:
   	lw $t0, x
   	addi $t1, $zero, 10 #t1=10
   	mult $t0, $t1 #t0*t1 si pune rezultatul in 2 registrii HI si LO
   	#mult=inmultire cu nr mari
   	mflo $s0 #move from LO to s0 (daca nr nu sunt prea mari)
   	mfhi $s1 #move from HI to s1 (daca nr sunt mari)
   	
   	li $v0, 1
   	move $a0, $s0
   	syscall
   
   	li $v0, 10
   	syscall