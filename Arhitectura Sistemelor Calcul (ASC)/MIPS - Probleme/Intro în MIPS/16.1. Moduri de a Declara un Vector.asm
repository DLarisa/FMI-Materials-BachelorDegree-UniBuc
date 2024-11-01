#Initializare Vector
.data
	vector: .word 100:3 #vor fi 3 elemente si toate vor fi 100
	#(sau) v: .word 1 2 3
	#(sau) v: .space 12 --- pt 3(*4) elemente
	newLine: .asciiz "\n"
.text
   main:
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