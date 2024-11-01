#58. Procedura ce primeste prin stiva ca parametrii 
#adresa unui vector v si lungimea sa n si interschinba componenetele daca
#prima componenta e mai mare decat a doua
#Dumitrache Larisa - 141
.data
	v: .word 3, 4, 3, 2#vector
	n: .word 4 #nr elemente
	mesaj: .asciiz "Transformat"
.text
   main:
   	subu $sp, $sp, 8 #aloc memorie pe stiva pt 2 elemente
   	lw $t0, n #t0=n
   	sw $t0, 4($sp)
   	la $t0, v        #in t0 punem adresa vectorului 
	sw $t0, 0($sp) # $sp:(adr.v)(n)
	
	jal interschimba
	
	addu $sp, $sp, 8 #eliberez stiva
	
	li $v0, 4 #afisez mesajul
	la $a0, mesaj
	syscall
	
	li $v0, 10 #return 0
	syscall
#end_main

#start_procedura
   interschimba:
   	# primeste:$sp:(adresa v)(n)
   	subu $sp, $sp, 4
	sw $fp, 0($sp)
	addiu $fp, $sp, 4 #pun fp in stiva
	subu $sp, $sp, 4 #pun s0 in stiva
	sw $s0, -4($fp)
	
	li $s0, 0 #s0=0 (i=0)
	lw $t0, 4($fp)# $t0=n
	
	for:
	bgt $s0, $t0, exit #i diferit de n
	   lw $t1, 0($fp)# $t1=v
	   move $t2, $s0 # $t2=i
	   sll $t2, $t2, 2 # $t2=i*4
	   
	   move $t3, $t2 #pentru al 2 element din vector (i+1)
	   add $t3, $t3, 4 
	   
	   add $t2,$t1,$t2 # $t2=(unsigned char *)v+i*4=v+i
           lw $t2, 0($t1)# $t2=*(v+i)=v[i]
           
           add $t3,$t1,$t3 #pt v[i+1]
           lw $t4, 0($t3)
           
           bge $t2, $t4, mare #v[i]>v[i+1]
           j cond
           mare: #interschimbare
                 move $t9, $t2 #aux=t2
                 sw $t2, 0($t3)
                 sw $t4, -4($t3)
           
           cond:
           addi $s0, $s0, 2 #actualizez i=i+2
   	   sw $s0, -4($fp) #actualizez in stiva
   	   j for
           
	exit: jr $ra #sar inapoi in program 
#end_procedura	
	