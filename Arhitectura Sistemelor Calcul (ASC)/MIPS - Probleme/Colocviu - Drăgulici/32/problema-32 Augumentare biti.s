.data
x:.asciiz "999783"  # sir de caractere
y:.ascii "0"
z:.word 0

.text
main:

subu $sp,$sp,4      #alocam memorie pentru un element pe stiva
la $t0,x        # in t0 copiem sirul x
sw $t0,0($sp)    # sirul x devine primul element din stiva
jal succesor      #sarim la succesor
addu $sp,$sp ,4       # alocam memorie pentru un element in stiva
li $v0,4       # afisam sirul de caractere
la $a0,x
syscall
li $v0,10        #terminarea programului
syscall


succesor:
	addiu $sp,$sp,-4        # alocam memorie pentru un element in stiva; addiu $sp,$sp,-4
	sw $fp,0($sp)       # punem fb sa pointeze ca primul element din stiva. Adica sirul nostru
	addiu $fp,$sp,0      # fp=sp
	lw $t0,4($fp)      # il punem pe t0 al doilea element din stiva
	li $t2,9           # t2=9.
	lb $t1,0($t0)      #  t1= primul caracter din t0(adica '9')  lb de fapt face o citire pe litere a sirului nostru
	lb $t3,y           #t3=y pe biti, ADICA t3 =0
	sub $t1,$t1,$t3     #t1=t1-t3 . Cand scadem dintr-un sir de caractere '0' obtinem valoarea.
	
intrare:
	bne $t1,$t2,iesire     # cat timp t1 este t2, adica caracterul nostru este 9
	sb $t3,0($t0)           # primul caracter din sir   
	addi $t0,$t0,1           # t0++ ( Se trece la urmatorul caracter din sir)
	lb $t1,0($t0)            # in t1 salvam urmatorul caracter din sir
	sub $t1,$t1,$t3        # t1=t1-t3. Adica '9'-'0'=9 ca valoare
	j intrare

iesire:                         #cand intalnim un caracter diferit de 9
	
	add $t1,$t1,$t3     #t1='t1'+'0'
	bne $t1,$zero,et     # daca t1(caracterul diferit de 9) este diferit caracterul NULL
	j gata
	
et:                         # Daca sirul inca nu s-a terminat
	sub $t1,$t1,$t3      # din caracter se face cifra
	addi $t1,$t1,1       # caracterul nostru este adunat cu 1  
	add $t1,$t1,$t3      # din cifra il transformam inapoi in caracter.
	sb $t1,0($t0)         # punem t1 primul caracter din sirul x

gata:
	lw $fp,0($fp)  # fp va pointa catre varful sitvei fp
	addiu $sp,$sp,4     # dezalocam stiva
	jr $ra         # revenim in programul principal
	

	
	
	
	
	
