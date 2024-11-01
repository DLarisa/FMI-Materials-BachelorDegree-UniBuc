.data
	x: .word 100
	y: .word 250
.text
   main:
   	#prin conventie, argumentele le punem in a0-a3
   	lw $a1, x #a1=x
   	lw $a2, y
   	jal adunare
   	
   	li $v0, 1
   	move $a0, $v1
   	syscall
   	
   	li $v0, 10
   	syscall

#aici am pus procedura dupa return 0 ca sa vedeti ca merge si nu intram in vreo bucla infinita
#procedati insa cum vi s-a spus la laborator   	
   	adunare:
   		#prin conventie, valoarea returnata in $v1
   		add $v1, $a1, $a2 #t0=a1+a2
   		jr $ra