.data
	message: .asciiz "Hey World! \nMy name is.\n"
.text
   main: #cine cere functia sa se execute
   	jal afisare #sare si se va intoarce in main
   	#ra=adresa din program de unde a fost apelata de jal 
   	#(jal mereu pune in ra adresa, de aia, daca ai functii recursive cu mai multi jal, 
   	#fa o stiva care sa retina toate adresele ra, ca sa stii unde sa te intorci)
   
   	addi $a0, $zero, 100 #Afisam nr 100 dupa ce am apelat functia
   	li $v0, 1
   	syscall
   	
   	li $v0, 10
   	syscall
   
   	afisare: #eticheta --- functie ceruta sa se execute
   		li $v0, 4
   		la $a0, message
   		syscall
   		jr $ra #se va intoarce inapoi in program unde a fost apelata functia
   		#ra=returneaza adresa functiei