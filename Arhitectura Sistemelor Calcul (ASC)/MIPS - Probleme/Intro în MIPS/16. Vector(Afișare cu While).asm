#Citire, Afisare Vector
.data
	vector: .space 12 #3 valori
	#int=4 biti
	newLine: .asciiz "\n"
.text
   main:
   	li $t1, 40
   	li $t2, 512
   	li $t3, 63
   	
   	#index t0=0 (i=0)
   	sw $t1, vector($t0) #vector[0]=4
   	   addi $t0, $t0, 4    
   	   #t0+=4 --- am trecut mai departe in vector (i++ ---> i=1)
   	sw $t2, vector($t0)
   	   addi $t0, $t0, 4
   	sw $t3, vector($t0)
   	
   	li $t0, 0 #i=0 (=t0)
   	
   	while:
   	beq $t0, 12, exit #if(i==n)
   	   lw $t1, vector($t0) #t1=v[i]
   	   jal afisare
   	   addi $t0, $t0, 4
   	   j while
       #end_while
   	
afisare: li $v0, 1 #cout<<v[i]
   	 move $a0, $t1
   	 syscall
   	 
   	 li $v0, 4 #cout<<endl
   	 la $a0, newLine
   	 syscall
   	 
   	 jr $ra #return in functie
#end_afisare
   	
exit: li $v0, 10
      syscall
#end_exit
   	