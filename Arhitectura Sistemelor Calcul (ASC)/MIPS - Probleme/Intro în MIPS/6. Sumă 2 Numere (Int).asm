.data
	x: .word 1 #variabilele sunt în RAM si noi le vrem în procesor
	y: .word 30
.text
   main:
   	lw $t0, x #t0=x    muta variabilele in registrii din procesor
   	lw $t1, y
   	add $t2, $t0, $t1 #t2=t0+t1
   	
   	li $v0, 1
   	add $a0, $zero, $t2 #a0=0+t2
   	#sau move $a0, $t2 --- a0=t2
   	syscall
   	
   	li $v0, 10
   	syscall