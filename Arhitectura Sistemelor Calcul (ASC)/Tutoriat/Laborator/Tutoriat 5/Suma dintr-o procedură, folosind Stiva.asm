/*********** Programul în C ***********
#include <stdio.h>
#include <stdlib.h>
int suma(int x, int y)
{
	int sum=x+y;
	return sum;
}
int main()
{
	int x=3, y=5, sum;
	sum=suma(x, y);
	return 0;
}
***************************************/

.data
	x:.word 5
	y:.word 3
	sum:.space 4
.text
   main:
	lw $t0, y

	subu $sp, $sp,4 
	sw $t0, 0($sp) #push(y)

	lw $t0, x

	subu $sp, $sp,4 
	sw $t0, 0($sp) #push(x)

	jal suma #suma(x,y)

	lw $t0, 4($sp)
	sw $t0, sum

	addi $sp, $sp, 4 #pop()
	addi $sp, $sp, 4 #pop()

	li $v0,10
	syscall

	suma:
	   subu $sp, $sp, 4
	   sw $fp, 0($sp) #push($fp) - salvarea $fp-ului
	   move $fp, $sp # $fp=$sp

 	   lw $t0, 4($sp) # $t0=x
	   lw $t1, 8($sp) # $t1=y
	   add $t0, $t0, $t1 # $t0=x+y

	   sw $t0, 8($fp) # suprascriem x+y peste y

	   lw $fp, 0($fp) #restaurarea $fp-ului
	   addi $sp, $sp, 4 #pop()

	   jr $ra