.data
	myMessage: .asciiz "Hello World!\n" 
	#asciiz spre deosebire de ascii pune terminator la final de string
.text
   main: #eticheta
   	li $v0, 4 #print string terminat cu "\0" din a0
   	la $a0, myMessage #a0=adresa string
   	syscall