#III.9 --- oglindeste bitii
.data
	x: .word 259
	y: .space 100
.text
   main:
   	lw $t0, x
   	
   	jal bts

#afisare
	li $v0, 4 
	la $a0, y
	syscall
	
	li $v0, 10
	syscall
#end_main

   bts:
   	li $t1, 0 #i=t1
   	li $t2, 32
   	#t3=masca (1<<31=100...0)
   	li $t3, 1
   	sll $t3, $t3, 31
   	
   	for:
   	beq $t1, $t2, exit 
   	#t4=n&(1<<i)
   	and $t4, $t0, $t3  
   	   beq $t4, $zero, bit0 
   	         li $t4, '1'
   	         sb $t4, y($t1)
   	         j cond1
   	   
   	   bit0: li $t4, '0'
   	   	 sb $t4, y($t1)
   	   	 
   	   	 cond1: addi $t1, $t1, 1
   	   	 	#t3=t3>>1(010...0) etc
   	   	 	srl $t3, $t3, 1
   	   	 	j for
   	#end_for
   	
   	exit: jr $ra	
   #end_bts