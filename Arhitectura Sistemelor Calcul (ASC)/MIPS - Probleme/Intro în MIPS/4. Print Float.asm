.data
	PI: .float 3.14
.text
   main:
   	li $v0, 2 #print float from f12 care se afla in Coproc 1
   	lwc1 $f12, PI #load word from into Coprocessor 1
   	#f12=PI
   	syscall
   	