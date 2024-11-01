#include <iostream>
#include <vector>
using namespace std;

//Punct cu Coordonatele x, y
struct punct
{
    double x, y;
};

/*
   Input: 3 puncte
   Returneaza:  >0, daca P2 este la stanga liniei formate de P0P1
                =0, daca P2 este coliniar P0P1
                <0, daca P2 este la dreapta liniei P0P1
*/
float stanga(punct P0, punct P1, punct P2)
{
    return (P1.x-P0.x)*(P2.y-P0.y) - (P2.x-P0.x)*(P1.y-P0.y);
}

/*
    Folosim o adaptare a algoritmului lui Melkman (1985), cu timp liniar.
    Input:       n=nr de puncte initiale
                 P=poligonul simplu, de intrare (nu tb sa aiba linii care sa se intersecteze)
    Output:      CH=acoperirea convexa
    Returneaza:  nr_h=nr de puncte din acoperirea convexa
*/
int ConvexHull(int n, vector<punct> P, vector<punct> &CH)
{
    /*
       Initializam D(deque -> vector circular) de la baza(bottom), la varf(top)
       a.i. primele 3 puncte din P formeaza un triunghi CCW (counterclockwise).
       (Spre deosebire de Melkman, unde varfurile sunt CW).
    */
    vector<punct> D; D.resize(2*n+1);

    //Initializam indicii bottom si top
    int b=n-2, t=b+3;
    D[b]=D[t]=P[2]; //al 3-lea varf este si la inceput si la finalul vectorului
    if(stanga(P[0], P[1], P[2])>0) //P2 e la stanga P0P1
    {
        D[b+1] = P[0];
        D[b+2] = P[1];           // nodurile CCW sunt: 2,0,1,2
    }
    else if(stanga(P[0], P[1], P[2])<0) //P2 e la dreapta P0P1
    {
        D[b+1] = P[1];
        D[b+2] = P[0];           // nodurile CCW sunt: 2,1,0,2
    }
    else
    {
        //cand primele 3 puncte sunt coliniare, putem ignora punctul din mijloc; 2->1 si 3->2... tot asa, pana avem >0 || <0
        while(stanga(P[0], P[1], P[2])==0 && P.size()>=3) P.erase(P.begin()+1);

        if(P.size()<3)
        {
            cout<<"Toate Punctele au fost Coliniare. Acoperirea Convexa: ("<<P[0].x<<", "<<P[0].y<<"); ("<<P[1].x<<", "<<P[1].y<<")"<<endl;
            return -1;
        }
        else //Facem Verificarea ca sa le aranjam in CCW
        {
            if(stanga(P[0], P[1], P[2])>0) //P2 e la stanga P0P1
            {
                D[b+1] = P[0];
                D[b+2] = P[1];           // nodurile CCW sunt: 2,0,1,2
            }
            else //P2 e la dreapta P0P1
            {
                D[b+1] = P[1];
                D[b+2] = P[0];           // nodurile CCW sunt: 2,1,0,2
            }
        }
    }

    //Procesam Restul Varfurilor Poligonului
    int i, nr_h;
    for(i=0; i<n; i++)
    {
        //Verificam daca varful urmator face parte din acoperirea convexa

        //Verificam Cazul de Coliniaritate
        if((stanga(D[b], D[b+1], P[i])==0) && (stanga(D[t-1], D[t], P[i])==0))
        {
            while(stanga(D[b], D[b+1], P[i])==0) D.erase(D.begin()+b+1);
            while(stanga(D[t-1], D[t], P[i])==0) D.erase(D.begin()+t);
        }

        //Avem un nod interior acoperirii convexe, deci il putem ignora
        if((stanga(D[b], D[b+1], P[i])>0) && (stanga(D[t-1], D[t], P[i])>0))
            continue;

        /*Suntem In cazul unui nod aflat in exteriorul unghiului*/
        //Luam cel mai din dreapta punct tangential de la baza deque
        while(stanga(D[b], D[b+1], P[i])<=0)   ++b;   //scot baza deque
        D[--b]=P[i];           //adaugare P[i] la baza lista

        //Luam cel mai din stanga punct tangential de la varf deque
        while(stanga(D[t-1], D[t], P[i])<=0)   --t;   //scot varf deque
        D[++t]=P[i];           //adaugare P[i] la varf lista
    }

    //Numar Varfurile Acoperirii Convexe
    for(nr_h=0; nr_h<=(t-b); nr_h++)
        CH[nr_h]=D[b+nr_h];

    D.clear(); //elimin structura de baza auxiliara

    return nr_h-1; //ca sa nu se repete primul element si la finalul vectorului
}

int main()
{
    //Date de Intrare
    int n, i;
    vector<punct> P; //Vectorul cu Punctele date Initial
    cout<<"Nr Puncte: "; cin>>n;
    P.resize(n);
    cout<<"Dati Punctele: "<<endl;
    for(i=0; i<n; i++) cin>>P[i].x>>P[i].y;

    vector<punct> CH; //Vectorul care contine punctele din acoperirea convexa; Convex Hull
    CH.resize(n+1); //Pt ca primul si ultimul nod din CH coincid (deci, un nod in plus)

    int nr_h=ConvexHull(n, P, CH);
    if(nr_h==-1) return 0; //Am avut o Eroare la Introducerea Poligonului Simplu

    //Afisare Solutie (CCW - CounterClockWise)
    cout<<endl<<"Acoperirea Convexa: "<<endl;
    for(i=0; i<nr_h; i++)
        cout<<CH[i].x<<" "<<CH[i].y<<endl;

    return 0;
}
