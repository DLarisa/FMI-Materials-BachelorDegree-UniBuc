.data
	n: .word 12
	s: .word 0
.text
  main:

 	li $t0, 2  #i=2
 	lw $t1, n
 	div $t1, $t0  #t1/t0
 	mflo $t2     #t2=[n/2]

  for:
        bgt $t0, $t2, iesire  
  	  div $t1, $t0
  	  mfhi $t3  #t3=t1%t0   t3=n%i
  	  beq $t3, $0, divizor #if(t3 == 0) sar la divizor
  	      j continua

  divizor:
 	lw $t4, s
 	add $t4, $t4, $t0
 	sw $t4, s #reactualizam s
  continua:
 	addi $t0, $t0, 1 #i++
 	j for #ca sa repete for-ul

  iesire:
 	lw $t4, s
 	addi $t4, $t4, 1 #tb sa mai adaugam la suma divizorilor pe 1 si numarul insusi
 	add $t4, $t4, $t1
 	sw $t4, s

 	li $v0,10
 	syscall
