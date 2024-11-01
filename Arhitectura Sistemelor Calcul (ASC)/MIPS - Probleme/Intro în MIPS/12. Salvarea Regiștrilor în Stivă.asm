.data
	newLine: .asciiz "\n"
.text
   main:
   	li $s0, 10
   	jal mareste
   	
   	li $v0, 4 #print newLine
   	la $a0, newLine
   	syscall 
   	
   	li $v0, 1 #print Int
   	move $a0, $s0
   	syscall
   
   li $v0, 10 #return 0
   syscall
   
   	mareste:
   		#$sp=pointer pt stiva
   		addi $sp, $sp, -4 #alocam memorie in stiva de 4 biti pt ca stiva merge in jos
   		#push() - am alocat loc doar pt o singura valoare
   		#daca voiam sa alocam pt mai multe valori: nr_val*4
   		#sau --- subu $sp, $sp, 4
   		
   		sw $s0, 0($sp) #sp[0]=s0
   		addi $s0, $s0, 30
   		
   		li $v0, 1
   		move $a0, $s0
   		syscall
   		
   		lw $s0, 0($sp) #s0=sp[0]
   		addi $sp, $sp, 4 #pop din stiva
   		
   		jr $ra
