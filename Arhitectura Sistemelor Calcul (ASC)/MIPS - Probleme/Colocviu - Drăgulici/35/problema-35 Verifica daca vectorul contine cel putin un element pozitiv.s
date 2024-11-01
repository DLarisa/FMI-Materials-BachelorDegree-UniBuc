.data
v:.word -1,-2,-3,-3,11,-5
n:.word 6
mesaj1:.asciiz "exista"
mesaj2:.asciiz "nu exista"
x:.word 0

.text
main:

subu $sp,$sp,8   # alocam memorie pentru 2 elemente in stiva
la $t0,v             # in t0 punem adresa vectorului 
sw $t0,0($sp)        # primul element din stiva devine adresa vectorului
lw $t0,n             # in t0 il punem pe n ( refolosire registru)
sw $t0,4($sp)	#stiva devine $sp:(adresa lui v),(n); al doilea element din vector devine nr de elem.
jal verifica  # salt la eticheta verifica
addu $sp,$sp,8  # dezalocam stiva    
beq $zero,$v0,m1      #daca v0 este 0 ,atunci afisam nu exista, altfel afisam ca exista elem. pozitiv
	j m2
m1:
	li $v0,4
	la $a0,mesaj2
	syscall
	li $v0,10
	syscall

m2:
	li $v0,4  
	la $a0,mesaj1
	syscall
	li $v0,10
	syscall
 


verifica:
	subu $sp,$sp,4       # alocam spatiu in stiva pentru un element
	sw $fp,0($sp)        # in stiva punem primul element fp.
	addiu $fp,$sp,0	   #stiva devine $sp,$fp:(fp vechi),(adresa lui v),(n);
	li $t0,0           # t0=0
	lw $t1,8($fp)     # t1 = al doilea element din stiva:  t1= nr de elemente4
	lw $t2,4($fp)      # t2=adresa vectorului

intrare:
	beq $t0,$t1,iesire        # cat timp conturul i(t0) este diferit de nr de elemem
		lw $t3,0($t2)       # in t3 punem primul element din vector
		bgt $t3,$zero,et1   #daca elementul este pozitiv, v0=1.
		addi $t0,$t0,1         #i++
		addi $t2,$t2,4      #trecem la urmatorul element din vector
		j intrare
et1:
	li $v0,1          
	j iesire

iesire:
	li $t0,1        # punem in t0 1
	beq $t0,$v0,et2   # daca am gasit un element pozitiv, sarim peste pasul in care il facem pe v0=0
	    li $v0,0      #punem in v0 0
et2:
	lw $fp,0($fp)      
	addu $sp,$sp,4	#stiva devine $sp:(adresa lui v),(n);
	jr $ra           # revenim in programul principal
	

