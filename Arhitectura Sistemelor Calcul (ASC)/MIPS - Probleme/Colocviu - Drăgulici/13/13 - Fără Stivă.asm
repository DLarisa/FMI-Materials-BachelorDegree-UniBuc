.data
	x: .asciiz "BA"
	rp: .asciiz "Rezultat Par"
	ri: .asciiz "Rezultat Impar"
.text
   main:
   	la $t0, x #t0=adresa lui x
   	li $t1, 0 #t1=suma
   	
   	loop:
   		lb $a0, ($t0) #load 1 bit
   		beqz $a0, exit #exit daca ajungem la final asciiz
   			add $t1, $t1, $a0 #s=s+ASCII
   			addi $t0, $t0, 1 #trecem la urmatoarea litera
   			j loop
   			
   		exit: rem $t2, $t1, 2 #rest impartire la 2
   		
   		beqz $t2, zero #daca e par se duce la zero
   			li $v0, 4 #afisare pt impar
   			la $a0, ri
   			syscall
   			
   			li $v0, 10
   			syscall
   			
   		zero:
   			li $v0, 4 #afisare pt par
   			la $a0, rp
   			syscall
   			
   			li $v0, 10
   			syscall