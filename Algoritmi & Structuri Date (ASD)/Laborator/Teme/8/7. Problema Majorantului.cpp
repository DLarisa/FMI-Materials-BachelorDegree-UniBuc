#include <iostream>
using namespace std;
/*
n=9
n/2+1=5
0 5 0 7 0 3 0 2 0
Punem in Stiva si Elementul Ramas e cel cautat (Elementele se bat daca nu sunt egale)
0 5 (bate pe 0)
5 0
0 7
7 0
0 3
3 0
0 2
2 0
0 0 (Raman ambele pt ca sunt egale)
La final mai verificam o data 0-urile
*/
struct nodStiva //Declarare Structura Nod Stiva
{
    int info;
    nodStiva *next;
} *prim;
nodStiva *Nou(int x) //Creare Nou Nod Stiva
{
    nodStiva *n=new nodStiva;
    n->info=x;
    n->next=NULL;
    return n;
}
int isEmpty() //Daca Stiva e Goala
{
    return prim==NULL;
}
int peek()  //Elementul din Varful Stivei
{
    if(isEmpty()) return -1;
    return prim->info;
}
void push(int x) //Inserare in Stiva
{
    nodStiva *n=Nou(x);
    n->next=prim;
    prim=n;
}
int pop()  //Stergere din Stiva
{
    if (isEmpty()) return -1;
    nodStiva *n=prim;
    prim=prim->next;
    int sters=n->info;
    return sters;
}

int main()
{
    int n, v[100], i, x, nr=0;
    cout<<"Nr Elemente: "; cin>>n;
    for(i=0; i<n; i++) cin>>v[i];
    push(v[0]);
    for(i=1; i<n; i++)
    {
        if(v[i]!=peek()) pop();
        push(v[i]);
    }
    x=pop();
    if(prim!=NULL) x=prim->info;
    for(i=0; i<n; i++)
        if(v[i]==x) nr++;
    if(nr>=n/2+1) cout<<"Majorantul: "<<x<<endl;
    else cout<<"Eroare";

    return 0;
}
