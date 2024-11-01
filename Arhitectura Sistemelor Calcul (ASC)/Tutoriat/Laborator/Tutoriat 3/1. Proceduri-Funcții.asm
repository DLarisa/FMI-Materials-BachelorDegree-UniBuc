.data
	message: .asciiz "Hey World! \n"
.text
#puteti pune procedurile atat intre .text si main; dar si dupa return 0;
#(o sa le pun aici, pt ca am remarcat ca asa faceti la lab)

afisare: #eticheta --- functie ceruta sa se execute
   	li $v0, 4        #4 - afisare de string
   	la $a0, message  #in a0 tb sa aveti adresa string-ului pt a putea sa se afiseze
   	syscall
   	jr $ra #se va intoarce inapoi in program unde a fost apelata functia
   	#ra=returneaza adresa functiei

   main: 
   	jal afisare #sare la eticheta afisare si, ulterior, se va intoarce in main
   	#ra=adresa din program de unde a fost apelata de jal 
   	#(jal mereu pune in ra adresa, de aia, daca ai functii recursive cu mai multi jal, 
   	#fa o stiva care sa retina toate adresele ra, ca sa stii unde sa te intorci)
   
   	addi $a0, $zero, 100 #Afisam nr 100 dupa ce am apelat functia
   	li $v0, 1
   	syscall
   	
   	li $v0, 10
   	syscall
   
 