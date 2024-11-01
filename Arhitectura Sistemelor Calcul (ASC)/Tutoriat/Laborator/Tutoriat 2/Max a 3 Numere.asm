.data   
	x: .word 0
	y: .word 1
	z: .word 2
	max: .space 4   #max(x,y,z)
.text
   main:
   	lw $t0,x  #t0=x
   	lw $t1,y
   	lw $t2,z
   
        blt $t0,$t1,et1 #daca t0<t1 sare la et1
          sw $t0,max      #max=t0
          j cond1         #sare la eticheta cond1, ca sa nu se efectueze operatiile de la et1
        et1:
           sw $t1,max   #max=t1
        
        cond1:
          lw $t0,max  #t0=max
          blt $t0,$t2,et2 #t0<t2
           #sw $t0,max
           j afisare
        et2:
           sw $t2,max
        
   	afisare:
   	lw $t0,max    #t0=max
   	move $a0,$t0  #a0=t0
   	li $v0,1      #afisare
	syscall
	
	li $v0,10    #return 0
   	syscall
