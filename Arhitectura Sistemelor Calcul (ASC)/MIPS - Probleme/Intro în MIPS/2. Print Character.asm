.data
	myCharacter: .byte 'L'
	#byte = 8 biti
.text
   main:
   	li $v0, 4
   	la $a0, myCharacter
   	syscall