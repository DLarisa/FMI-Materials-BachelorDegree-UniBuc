#include <stdio.h>
#include <string.h>

int main(void)
{
    char buff[7];
    int pass = 0;

    printf("Enter the password : \n");
    scanf("%s", buff);

    if(strcmp(buff, "parola"))
    {
        printf ("Wrong Password \n");
    }
    else
    {
        printf ("Correct Password \n");
        pass = 1;
    }

    if(pass)
    {
        printf ("Root privileges given to the user \n");
    }

    return 0;
}
/*
    STIVA MAIN

    7 biti pt parola (char)
    4 biti pt int

    scrii o parola mai mare 7 biti si atunci trece in memoria lui pass --->
    pass nu mai e 0 si atunci iti da privilegiile utilizatorului
    (compilatorul mereu pune pointerii si dupa int, double etc...)

    **************************************************************************
    In Heap se pune memoria alocata dinamic
    In Stack e memoria normala
*/
