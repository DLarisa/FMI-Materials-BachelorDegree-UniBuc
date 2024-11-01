.data
	mesaj: .asciiz "Introdu valoarea lui PI: "
	zeroFloat: .float 0.0
.text
   main:
   	lwc1 $f1, zeroFloat #f1=0.0
   	
   	li $v0, 4
   	la $a0, mesaj
   	syscall
   	
   	li $v0, 6 #cin>>float --- float se gaseste in f0
   	syscall
   	
   	li $v0, 2 #afisare float
   	add.s $f12, $f0, $f1
   	syscall
   	
   	li $v0, 10
   	syscall