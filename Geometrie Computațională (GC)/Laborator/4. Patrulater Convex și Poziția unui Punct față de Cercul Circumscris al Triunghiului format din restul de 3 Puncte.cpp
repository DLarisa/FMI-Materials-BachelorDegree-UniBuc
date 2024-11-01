#include <iostream>
#include <math.h>
using namespace std;
#define PI 3.14159265359

struct punct
{
    double x, y;
}A[4];
int Segment(punct a, punct q, punct b) //daca q apartine segment ab
{
    if(q.x <= max(a.x, b.x) && q.x >= min(a.x, b.x) &&
       q.y <= max(a.y, b.y) && q.y >= min(a.y, b.y))
       return 1;

    return 0;
}
double distanta(punct A, punct B)
{return sqrt((A.x-B.x)*(A.x-B.x)+(A.y-B.y)*(A.y-B.y));}
double cosinus(punct B, punct A, punct C)
{
    punct AB, AC;
    double prod;

    AB.x = B.x - A.x;
    AB.y = B.y - A.y;

    AC.x = C.x - A.x;
    AC.y = C.y - A.y;

    prod = AB.x * AC.x + AB.y * AC.y;
    return prod/(distanta(A, B)*distanta(A, C));

}

int main()
{
    //Citire date
    cout<<"Dati Punctele: ";
    int i;
    double aux1, aux2, x, y;
    for(i=0; i<4; i++) cin>>A[i].x>>A[i].y;

    //Segment A0A2 - Ecuatie prima Diagonala
    double a1, b1, c1;
    aux1=A[2].x-A[0].x; aux2=A[2].y-A[0].y;
    a1=aux2, b1=-aux1, c1=A[0].y*aux1-A[0].x*aux2;

    //Segment A1A3 - Ecuatie a doua Diagonala
    double a2, b2, c2;
    aux1=A[3].x-A[1].x; aux2=A[3].y-A[1].y;
    a2=aux2, b2=-aux1, c2=A[1].y*aux1-A[1].x*aux2;

    //Calcul Determinant pt a Verifica daca Diagonalele se Intersecteaza
    double det=a1*b2-b1*a2;
    if(det!=0) //Intersectia e un Punct - Deci Patrulaterul este Convex
    {
        aux1=b2*(-c1)+b1*c2; x=aux1/det;
        aux2=a1*(-c2)+c1*a2; y=aux2/det;
        punct q; q.x=x; q.y=y;
        if(Segment(A[0], q, A[2]) && Segment(A[1], q, A[3])) //Daca punctul apartine ambelor segmente
        {
            cout<<"Patrulaterul este Convex."<<endl;
            double u1, u2, u; //unghiul A1, A3
            u1=acos(cosinus(A[0], A[1], A[2]));
            u2=acos(cosinus(A[0], A[3], A[2]));
            u=(u1+u2)*180.0/PI;
            if(u>179.99 && u<180.01) cout<<"A4 este pe Cerc.";
            else if(u>180) cout<<"A4 este in interiorul Cercului.";
                else cout<<"A4 este in exteriorul Cercului.";
        }
        else cout<<"Patrulaterul NU este Conex."<<endl;
    }
    else //Patrulaterul NU este convex (da multime vida)
        cout<<"Patrulaterul NU este Convex."<<endl;

    return 0;
}
