.data
	x: .space 4
	y: .space 100
.text
   main:
   	li $t0, 259
   	
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
   	
   	for:
   	beq $t1, $t2, exit 
   	#t3=masca (1<<i)
   	li $t3, 1 
   	sllv $t3, $t3, $t1
   	#t4=n&(1<<i)
   	and $t4, $t0, $t3  
   	   beq $t4, $zero, bit0 
   	         li $t4, '1'
   	         sb $t4, y($t1)
   	         j cond1
   	   
   	   bit0: li $t4, '0'
   	   	 sb $t4, y($t1)
   	   	 
   	   	 cond1: addi $t1, $t1, 1
   	   	 	j for
   	#end_for
   	
   	exit: jr $ra	
   #end_bts