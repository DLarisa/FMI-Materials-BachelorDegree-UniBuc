.data
	n: .word 4		# numarul de elemente din vector
	v: .word 2,3,1,1		# vectorul cu elementele lui
.text	
  main:
	lw $t3,n		# n
	li $t0,0		# cu asta inaintez in vector (corespunde cu adresa)						
				
	mulo $t3, $t3, 4	# se inmulteste $t3 cu , nu trebuie neaparat cu $t0, putea fi si scris cu 4 
	#addi $t0,$t0,-4	
	
    for:
	bge $t0,$t3,final	# se verifica daca s-a ajuns la sfarsitul vectorului $t0 = $t3
	lw $t5,v($t0)		
	add $t4,$t4,$t5
	addi $t0,$t0,4
	j for

    final:
	move $a0,$t4
	li $v0,1
	syscall 

  	li $v0,10
  	syscall
