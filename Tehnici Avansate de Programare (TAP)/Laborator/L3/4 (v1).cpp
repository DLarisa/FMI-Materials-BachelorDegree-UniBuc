#include <iostream> //O(n*log n)
#include <math.h>
#include <algorithm>
using namespace std;
/*
Consideram complexitatea timp a algoritmului ca fiind T(n). Folosim sort cu
complexitatea de O(n * log n). Algoritmul divide toate punctele in 2 submultimi si se
apeleaza recursiv. Dupa dividere, banda este gasita in O(n). Dureaza tot O(n) ca sa imparti
vectorul Py in jurul benzii. Punctele sunt gasite in O(n).
T(n) = 2T(n/2) + O(n) + O(n) + O(n)
T(n) = 2T(n/2) + O(n)
T(n) = T(n * Log n)
*/
struct punct
{
    int x, y;
} first, second;
//Sort dupa coordonata x
int cmpX(punct p1, punct p2)
{return (p1.x>p2.x);}
//Sort dupa coordonata y
int cmpY(punct p1, punct p2)
{return (p1.y>p2.y);}
//Distanta intre 2 puncte
float distanta(punct p1, punct p2)
{return sqrt((p1.x-p2.x)*(p1.x-p2.x)+(p1.y-p2.y)*(p1.y-p2.y));}
//Distanta Minima dintre maxim 3 puncte -> Brute Force
float d_min(punct p[], int n)
{
    float mini=9999;
    int i, j;
    for(i=0; i<n; i++)
        for(j=i+1; j<n; j++)
            if(distanta(p[i], p[j])<mini) mini=distanta(p[i], p[j]), first=p[j], second=p[i];
    return mini;
}

//Cele mai apropiate 2 puncte din vectorul ordonat dupa coordonata y.
//Limita superioara este data de distanta minima d. Si desi pare O(n^2),
//for-ul interior se executa de maxim 6 ori. -> O(n)
float vector_dis(punct v[], int n, float d)
{
    float mini=d;
    int i, j;
    for(i=0; i<n; i++)
        for(j=i+1; j<n && (v[j].y-v[i].y)<mini; j++)
            if(distanta(v[i], v[j])<mini) mini=distanta(v[i], v[j]);
    return mini;
}
//Gaseste distanta minima dintre puncte. Avem nevoie de 2 vectori, Px si Py; unde am sortat punctele dupa X si dupa Y.
float rezolvare(punct Px[], punct Py[], int n)
{
    if(n<=3) return d_min(Px, n); //aici folosim forta bruta - pt 2 sau 3 puncte

    //Punctul de mijloc
    int mij=n/2;
    punct P_mij=Px[mij];

    //Impartim vectorul Py in 2 dupa mijloc
    punct Py_st[mij+1], Py_dr[n-mij-1];
    int st=0, dr=0, i, j=0;
    for(i=0; i<n; i++)
    {
        if(Py[i].x<=P_mij.x)  Py_st[st++]=Py[i];
        else Py_dr[dr++]=Py[i];
    }

    //Distanta Minima dintre punctul de mijloc si linia verticala; pe dreapta si stanga
    float st_dis=rezolvare(Px, Py_st, mij);
    float dr_dis=rezolvare(Py+mij, Py_dr, n-mij);
    float distanta=min(st_dis, dr_dis); //minimul dintre dreapta si stanga

    punct v[n];      //contine punctele cele mai apropiate (cu o distanta mai mica decat d) de linia care trece prin punctul de mijloc
    for(i=0; i<n; i++)
        if(abs(Py[i].x-P_mij.x)<distanta) v[j]=Py[i], j++;

    return min(distanta, vector_dis(v, j, distanta));
}


int main()
{
    int i, n;
    cout<<"N: "; cin>>n;
    punct *P=new punct[n];
    for(i=0; i<n; i++) cin>>P[i].x>>P[i].y;

    punct Px[n];
    punct Py[n];
    for(i=0; i<n; i++) Px[i]=P[i], Py[i]=P[i];

    sort(Px, Px+n, cmpX);
    sort(Py, Py+n, cmpY);

    cout<< "Distanta Minima: " <<rezolvare(Px, Py, n)<<endl;
    cout<<"Punctele: "<<endl<<first.x<<" "<<first.y<<endl<<second.x<<" "<<second.y<<endl;

    return 0;

}
