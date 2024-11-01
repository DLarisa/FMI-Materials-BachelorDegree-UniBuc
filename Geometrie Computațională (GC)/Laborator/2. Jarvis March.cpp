#include <iostream>
#include <vector>
using namespace std;

struct punct
{
    double x, y;
}A[4];

//Aflu directia tripletului de pct: 0-coliniare, 1-dr, 2-st
int orientare(punct a, punct b, punct c)
{
    int val=(b.y-a.y)*(c.x-b.x) - (b.x-a.x)*(c.y-b.y);
    if(val==0) return 0;
    if(val>0) return 1;
    return 2;
}

int main()
{
    //Citire date
    cout<<"Dati Punctele: ";
    int i;
    for(i=0; i<4; i++) cin>>A[i].x>>A[i].y;

    vector<int> aux;
    //Cel mai din stanga punct - dupa x
    int mini=A[0].x, l=0, maxi=A[0].x, M=0;
    for(i=1; i<4; i++)
    {
        if(mini>A[i].x) mini=A[i].x, l=i; //tb sa retin pozitia punctului
        if(maxi<A[i].x) maxi=A[i].x, M=i; //asta e pt caz in care toate sunt coliniare
    }
    if(l==M) //daca sunt egale
    {
        maxi=A[0].y;
        for(i=1; i<4; i++)
            if(maxi<A[i].y) maxi=A[i].y, M=i;
    }

    //Aflam succesorul
    int p=l, b;
    do
    {
        aux.push_back(p); //lista cu pozitiile punctelor

        //Aleg pivot aleator:
        if(p!=0) b=0;
        else b=1;

        for(i=0; i<4; i++)
            if(orientare(A[p], A[b], A[i])==2) b=i;

        p=b;
    }while(l!=p); //nu il lasam sa devina punctul initial

    //Nr de puncte din lista determina cazul in care sunt
    int poz;
    if(aux.size()==2) //Caz toate coliniare
    {
        cout<<"I: ("<<A[l].x<<","<<A[l].y<<"); (";
        cout<<A[M].x<<","<<A[M].y<<")"<<endl;
        cout<<"J: (";
        for(i=0; i<4; i++)
            if(i!=l && i!=M) cout<<A[i].x<<","<<A[i].y<<"); (";
    }
    else if(aux.size()==3) //Triunghi
    {
        cout<<"I: ("<<A[l].x<<","<<A[l].y<<"); (";
        poz=aux[1];
        cout<<A[poz].x<<","<<A[poz].y<<"); (";
        poz=aux[2];
        cout<<A[poz].x<<","<<A[poz].y<<")"<<endl;
        cout<<"J: (";
        for(i=0; i<4; i++)
            if(i!=aux[0] && i!=aux[1] && i!=aux[2]) cout<<A[i].x<<","<<A[i].y<<")"<<endl;
    }
    else //Patrulater
    {
        cout<<"I: (";
        poz=aux[0];
        cout<<A[poz].x<<","<<A[poz].y<<"); (";
        poz=aux[2];
        cout<<A[poz].x<<","<<A[poz].y<<");"<<endl;
        cout<<"J: (";
        poz=aux[1];
        cout<<A[poz].x<<","<<A[poz].y<<"); (";
        poz=aux[3];
        cout<<A[poz].x<<","<<A[poz].y<<");"<<endl;
    }


    return 0;
}
