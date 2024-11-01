#include <iostream> //Intersectia a 2 Segmente
using namespace std;

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

int main()
{
    //Citire date
    cout<<"Dati Punctele: ";
    int i;
    double aux1, aux2, x, y;
    for(i=0; i<4; i++) cin>>A[i].x>>A[i].y;

    //Segment A0A1 - Ecuatie
    double a1, b1, c1;
    aux1=A[1].x-A[0].x; aux2=A[1].y-A[0].y;
    a1=aux2, b1=-aux1, c1=A[0].y*aux1-A[0].x*aux2;

    //Segment A2A3 - Ecuatie
    double a2, b2, c2;
    aux1=A[3].x-A[2].x; aux2=A[3].y-A[2].y;
    a2=aux2, b2=-aux1, c2=A[2].y*aux1-A[2].x*aux2;

    //Calcul Determinant
    double det=a1*b2-b1*a2;
    if(det!=0) //Intersectia e un Punct
    {
        aux1=b2*(-c1)+b1*c2; x=aux1/det;
        aux2=a1*(-c2)+c1*a2; y=aux2/det;
        punct q; q.x=x; q.y=y;
        if(Segment(A[0], q, A[1]) && Segment(A[2], q, A[3])) //Daca punctul apartine ambelor segmente
            cout<<"Punct de Intersectie: ("<<x<<", "<<y<<")"<<endl;
        else cout<<"Intersectie: Multime Vida";
    }
    else
    {
        //Calcul Rang M*
        if(a1*c2-a2*c1==0 && b1*c2-b2*c1==0)  //Rang 1
        {
            if(Segment(A[0], A[2], A[1]))
                cout<<"Intersectia: Segmentul cu capetele ("<<A[2].x<<", "<<A[2].y<<"); ("<<A[1].x<<", "<<A[1].y<<")"<<endl;
            else if(Segment(A[0], A[3], A[1]))
                cout<<"Intersectia: Segmentul cu capetele ("<<A[3].x<<", "<<A[3].y<<"); ("<<A[1].x<<", "<<A[1].y<<")"<<endl;
            else cout<<"Intersectia: Multime Vida"<<endl;
        }
        else //Rang 2
            cout<<"Intersectia: Multimea Vida"<<endl;
    }

    return 0;
}
