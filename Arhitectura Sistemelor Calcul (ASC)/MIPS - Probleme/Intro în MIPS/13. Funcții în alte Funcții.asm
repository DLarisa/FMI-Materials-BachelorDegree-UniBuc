.data
	newLine: .asciiz "\n"
.text
   main:
   	li $s0, 10
   	jal mareste
   	
   	li $v0, 4 #print newLine
   	la $a0, newLine
   	syscall 
   	
   	jal afisare
   
   li $v0, 10 #return 0
   syscall
   
   	mareste:
   		subu $sp, $sp, 8 #acum salvam 2 valori 
   		sw $s0, 0($sp) #sp[0]=s0
   		sw $ra, 4($sp) #sp[1]=ra (4/4)
   		
   		addi $s0, $s0, 30
   		
   		#Functie in Functie
   		jal afisare 
   		#ra=adresa de aici --- nu se mai pastreaza adresa din main
   		 
   		lw $s0, 0($sp) #s0=sp[0]
   		lw $ra, 4($sp) #ra=sp[1] --- restauram adresa din main
   		addi $sp, $sp, 4 #pop din stiva
   		
   		jr $ra
   		
   	afisare:
   		li $v0, 1
   		move $a0, $s0
   		syscall
   		jr $ra  #sare in "mareste"