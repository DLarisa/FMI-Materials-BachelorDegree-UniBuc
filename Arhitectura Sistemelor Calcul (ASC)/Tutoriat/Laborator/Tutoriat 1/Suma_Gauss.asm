#Suma 1+2+3+...+n=?

.data #zona pentru declararea datelor
	n: .word 11   #(word=)int n=11
	s: .word 0    #int s=0 --- unde vom pune suma
.text #codul programului
   main:   
   	#Nu lucram cu variabile, ci cu registrii (direct pe CPU), 
   	#ceea ce face ca programul sa se execute foarte rapid
   	
   	#Initializam registrii cu datele problemei
   	li $t0, 0   #t0=s=0
   	li $t1, 1   #t1=i=1
   	lw $t2, n   #t2=n
   	
   	for:     #aceasta este o eticheta 
   	bgt $t1, $t2, final  #cand i devine mai mare decat n (i>n), trebuie 
   	   		     #sa iesim din for; vom sari la eticheta "final"
   		add $t0, $t0, $t1  #t0+=t1 i.e. s+=i
   		addi $t1, $t1, 1   #t1++ i.e. i++
   		j for   #jump la eticheta "for"	 
   		
   	final:
   	#punem suma pe care am gasit-o in "s" (care inca este 0)
   	sw $t0, s   #s=t0
   	
   	#afisam suma pe ecran
   	li $v0, 1 #pt print de int, tb sa avem v0=1
   	#cand se face print int, procesorul se uita la valoarea din 
   	#registrul a0 si o afiseaza
   	lw $a0, s #a0=s
   	syscall
   	 
   	#return 0 
   	li $v0, 10
   	syscall
   	 
   	 
   	 
   	 
   	 
   	 
   	 
   	 
   	 
   	 
   	
   	
   	
   	
   	
   	
   	
	