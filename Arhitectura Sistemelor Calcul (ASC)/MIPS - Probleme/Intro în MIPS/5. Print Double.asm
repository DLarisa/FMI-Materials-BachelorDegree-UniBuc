.data
	myDouble: .double 7.202 #double=64 biti
	zeroDouble: .double 0.0
.text
   main:
   	ldc1 $f2, myDouble #double ocupã 2 regittrii (f2 si f3)
   	#pune double în f(nr par)
   	ldc1 $f0, zeroDouble
   	
   	li $v0, 3 #print double din f12
   	add.d $f12, $f2, $f0 #f12=f2+f0
   	syscall
   	
   	li $v0, 10 #return 0
   	syscall
   	
   	
 #########    SAU     #########
 	
 
 	ldc1 $f12, myDouble
 	li $v0, 3
 	syscall