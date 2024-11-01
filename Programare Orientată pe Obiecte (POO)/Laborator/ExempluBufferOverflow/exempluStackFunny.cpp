#include <iostream>
#include <stdio.h>
using namespace std;

void f1() //adresa
{
    char v[256];
    scanf("%s", v);
}
void f2() //adresa
{
    char vv[256];
    printf("%s", vv);
}
int main()
{
    f1(); //jump la adresa lui f1
    /*
        STIVA f1

        adresa pt return main
        parametrii functiei (optionali)
        ce valoare am citit noi de la tastatura
    */
    f2(); //o sa se intoarca la adresa lui f1 pt ca e libera si ramane valoare reziduala ce am citit noi

    return 0;
}
