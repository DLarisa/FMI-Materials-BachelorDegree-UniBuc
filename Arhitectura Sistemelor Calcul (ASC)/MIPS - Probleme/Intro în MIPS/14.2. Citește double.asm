.data
	in: .asciiz "Introduceti un nr double: "
.text
   main:
   	li $v0, 4
   	la $a0, in
   	syscall
   	
   	li $v0, 7 #cin>>double --- double se afla in f0 si $f1
   	syscall
   	
   	li $v0, 3 #afisare double
   	add.d $f12, $f0, $f10 #toti registrii liberi sunt 0
   	syscall
   	
   	li $v0, 10
   	syscall