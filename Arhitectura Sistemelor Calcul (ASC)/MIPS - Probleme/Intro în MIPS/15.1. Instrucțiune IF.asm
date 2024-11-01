.data
	mesaj1: .asciiz "Numerele sunt egale"
	mesaj2: .asciiz "Numerele nu sunt egale"
.text
   main:
   	li $t0, 5
   	li $t1, 50
   	
   	beq $t0, $t1, egale #if(t0==t1) egale
   	   #nr nu sunt egale
   	   li $v0, 4  
   	   la $a0, mesaj2
   	   syscall
   	   j return0
   	   
   	egale: #nr sunt egale
   	   li $v0, 4  
   	   la $a0, mesaj1
   	   syscall
   	
return0:li $v0, 10
   	syscall

	#b/blt/bge.... - conditii