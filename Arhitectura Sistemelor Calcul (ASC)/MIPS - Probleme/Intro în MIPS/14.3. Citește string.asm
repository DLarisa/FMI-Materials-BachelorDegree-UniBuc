.data
	mesaj: .asciiz "Introduceti-va Numele: " 
	out: .asciiz "\nBuna, "
	userInput: .space 20 #20 biti
.text
   main:
   	li $v0, 4
   	la $a0, mesaj
   	syscall 
   	
   	li $v0, 8 #cin>>string
   	la $a0, userInput #a0=adresa stringului pe care vrem sa-l citim
   	li $a1, 20 #a1=nr maxim de caractere ce pot fi citite
   	syscall
   	
   	li $v0, 4
   	la $a0, out
   	syscall 
   	li $v0 ,4
   	la $a0, userInput
   	syscall
   	
   	li $v0, 10
   	syscall