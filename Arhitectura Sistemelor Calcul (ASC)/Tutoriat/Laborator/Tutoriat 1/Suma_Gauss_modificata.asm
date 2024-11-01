#Suma 1+2+3+...+n=?
#Presupunem acum ca citim n de la tastatura

.data #zona pentru declararea datelor
	s: .word 0    #int s=0 --- unde vom pune suma
.text #codul programului
   main:   
   	li $v0, 5 #cin>>int  --- int se gaseste in v0
   	syscall
   	move $t2, $v0  #t2=n=v0=val citita de la consola
   	
   	#Initializam registrii cu datele problemei
   	li $t0, 0   #t0=s=0
   	li $t1, 1   #t1=i=1

   	
   	for:     
   	bgt $t1, $t2, final  
   		add $t0, $t0, $t1  #t0+=t1 i.e. s+=i
   		addi $t1, $t1, 1   #t1++ i.e. i++
   		j for   #jump la eticheta "for"	 
   		
   	final:
   	#punem suma pe care am gasit-o in "s" (care inca este 0)
   	sw $t0, s   #s=t0
   	
   	#afisam suma pe ecran
   	li $v0, 1 
   	lw $a0, s #a0=s
   	syscall
   	 
   	#return 0 
   	li $v0, 10
   	syscall
   	 
   	 
   	 
   	 
   	 
   	 
   	 
   	 
   	 
   	 
   	
   	
   	
   	
   	
   	
   	
	