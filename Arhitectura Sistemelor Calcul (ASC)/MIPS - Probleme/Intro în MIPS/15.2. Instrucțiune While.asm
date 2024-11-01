#Suma lui Gauss
.data
	n: .space 4
	mesaj: .asciiz "Introduceti n: "
.text
#cin>>n
#while(i<=n) s=s+n,i++
#cout<<n
   main:
   	li $v0, 4 #afisare mesaj
   	la $a0, mesaj
   	syscall
   	
   	li $v0, 5 #cin>>n
   	syscall
   	
   	move $t0, $v0 #t0=n
   	while:
   	bgt $t1, $t0, afisare #if(i>n) afisare
   	   add $t2, $t2, $t1 #s+=i
   	   addi $t1, $t1 1
   	   j while
   	
 afisare:
 	li $v0, 1
 	move $a0, $t2
 	syscall
 	
   	li $v0, 10
   	syscall