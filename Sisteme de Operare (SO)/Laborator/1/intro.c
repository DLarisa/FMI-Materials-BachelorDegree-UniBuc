#include <stdio.h>

int main(int argc, char *argv[])
{
	printf("Nr Argumente: %d\n", argc); //Predefinit, argument count=1 pt ca pune denumirea programului in argv[0]
	printf("Nume Program: %s\n", argv[0]);
	for(int i=1; i<argc; i++)
        printf("Agumentul %d: %s\n", i, argv[i]); //Vectorul Argument Vector retine numele programului si nr de argumente transmise programului (sub forma de string)

	return 0;
}
