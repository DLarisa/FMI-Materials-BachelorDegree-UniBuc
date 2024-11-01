.data
	x: .word 1754
	#word=32 biti=4 bytes=int
.text
   main:
   	li $v0, 1 #print int din a0
   	lw $a0, x #a0=x
   	syscall