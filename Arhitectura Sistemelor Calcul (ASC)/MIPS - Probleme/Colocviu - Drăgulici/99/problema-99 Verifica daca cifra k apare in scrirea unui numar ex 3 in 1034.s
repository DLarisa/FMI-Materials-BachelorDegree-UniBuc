.data

n:.word 10324
k:.word 5
mesaj1:.asciiz "Apare"
mesaj2:.asciiz "Nu apare"

.text
main:

subiu $sp,$sp,8  # alocam spatiu pentru 2 elemente in stiva
lw $t0,n     # t0=n
sw $t0,0($sp)  # n devine primul element din stiva
lw $t0,k       #  t0=k
sw $t0,4($sp)   # k devine al doilea element din stiva
jal apare       # mergem pe eticheta apare
addiu $sp,$sp,8     #dezalocam stiva

beq $v0,$zero,m1     #daca v0 este 0, atunci afiseza mesaj2 "Nu apare", altfel afiseaza mesaj1|Apare
j m2

m1:
	li $v0,4
	la $a0,mesaj2
	syscall
	j gata
m2:
	li $v0,4
	la $a0,mesaj1
	syscall
	j gata

gata:

li $v0,10
syscall

apare:

subiu $sp,$sp,4	#stiva este $sp:$fp:($fp vechi),(n),(k);
sw $fp,0($sp)  
addiu $fp,$sp,0
lw $t0,4($fp)   # t0=n
lw $t1,8($fp)   # t1=k
li $t2,10       # t2=10

intrare:
	beq $t0,$zero,iesire   # cat timp n este diferit de zero
	div $t0,$t2             # n=n/10
	mfhi $t3                 # t3=n%10 adica ultima cifra din n
	mflo $t4                 # t4= n/10 numarul fara ultima cifra 
	move $t0,$t4            # actualizam numarul. n=n/10
	beq $t3,$t1,da        # daca ultima cifra este k, atunci v0=1
	j intrare
da:
	li $v0,1
iesire:
	li $t5,1         #t5=1
	bne $v0,$t5,et     #daca v0 este diferit de 1, mergem pe eticheta et si facem v0=0
	j et1
et:
	li $v0,0
et1:
	lw $fp,0($fp) 
	addiu $sp,$sp,4	#stiva devine $sp:(n),(k);
	jr $ra             #revenim in programul principal


