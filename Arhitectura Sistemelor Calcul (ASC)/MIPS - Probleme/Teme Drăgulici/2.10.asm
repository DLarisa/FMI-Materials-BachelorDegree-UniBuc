.data
	n: .word 3
	s: .space 4
.text
#for(i=1;i<=n;i++) s=s+i
   main:
   	li $t0, 0 
   	lw $t1, n  #t1=n
   	li $t2, 0   #t2=i
   	for:
   	bge $t2,$t1,afisare # if(i>=n)   afisare
   		addi $t2,$t2,1  #i++
   		add $t0,$t0,$t2 #s=s+i
   		j for
   	
   	afisare:
   	sw $t0, s 
   	
   	li $v0,10  #return 0
   	syscall
   		
