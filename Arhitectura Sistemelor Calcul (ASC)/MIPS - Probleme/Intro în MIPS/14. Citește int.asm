.data
	in: .asciiz "Introduceti Varsta: "
	out: .asciiz "\nVarsta dvs este: "
.text
   main:
   	li $v0, 4
   	la $a0, in
   	syscall
   	
   	li $v0, 5 #cin>>int  --- int se gaseste in v0
   	syscall
   	
   	move $t0, $v0
   	
   	li $v0, 4
   	la $a0, out
   	syscall
   	li $v0, 1
   	move $a0, $t0
   	syscall
   	
   	li $v0, 10
   	syscall