.data
s:.space 27   # pentru ca fiecare litera ocupa 1 octet in memorie, si sunt maximum 27 de litere
x:.byte 'd'    #caracter de pornire
y:.byte 'h'    #caracter final

.text
main:

subu $sp, $sp,12  # sau addiu $sp, $sp,-12 ; am alocat in stiva spatiu pentru 3 elemente
la $t0,s       # in adresa lui s se va salva sirul de caractere defgh(cuprins intre x si y)
sw $t0,0($sp)   # primul element din stiva este t0
lb $t0,x        # t0=x pe biti
sw $t0,4($sp)    #al doilea element din stiva este x pe biti
lb $t0,y
sw $t0,8($sp) # al treilea element din stiva este y pe biti
jal rezolvare  # sarim la rezolvare
addiu $sp, $sp,12  #dezalocam stiva
li $v0,4     #afisam un sir de caractere
la $a0,s     #afisam sirul s, format din toate litere cuprinse intre x si y
syscall
li $v0,10     #terminare program
syscall


rezolvare:
	subu $sp,$sp,4  # se aloca spatiu pentru un element in stiva ; sau addiu $sp,$sp,-4
	sw $fp,0($sp)	## fp va indica primul element din stiva		     
	addiu $fp,$sp,0    #stiva este $sp,($s0),(fp vechi),(adresa s),(x),(y).
	subu $sp,$sp,8   ## alocam spatiu pentru inca 2 elemente
	sw $s0,-4($fp)         
	sw $s1,-8($fp)
	lw $s0,4($fp)	#s0-adresa lui s
	lw $s1,8($fp)   #s1-x
	lw $t0,12($fp)  #t0-y

intrare:
	beq $s1,$t0,iesire	 # cat timp s1 este diferit de t0  (x diferit de y)
	sb $s1,0($s0)             # punem s1 la prima adresa din vectorul s0
	addi $s0,$s0,1            # s0 trece la adresa urmatoare
	addi $s1,$s1,1            # s1 trece la adresa urmatoare
	j intrare

iesire:                            # cand s1 este egal cu t0  ( x egal cu y)
	sb $s1,0($s0)             
	lw $s0,-4($fp)
	lw $s1,-8($fp)
	lw $fp,0($fp)
	addu $sp,$sp,12                #dezalocam stiva
	jr $ra                     #revenim in programul principal
	
	
