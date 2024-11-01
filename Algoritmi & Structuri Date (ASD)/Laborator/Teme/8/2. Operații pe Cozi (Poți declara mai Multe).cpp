#include <iostream>//Operatii pe Cozi
#include <string.h>
using namespace std;
/*
    prim(de unde se iau in coada) 4 3 2 1 ultim(de unde se insereaza elemente)
    FIFO - First In First Out
*/
struct nodCoada  //Structura Nod
{
    int info;
    nodCoada *next;
};
struct Coada  //Structura Coada
{
    nodCoada *prim, *ultim;
};
nodCoada *nod_nou(int x)  //Creare Nod Nou
{
    nodCoada *n= new nodCoada;
    n->info=x;
    n->next=NULL;
    return n;
}
Coada *C_Noua()  //Creare Coada Noua
{
    Coada *q=new Coada;
    q->prim=q->ultim=NULL;
    return q;
}
int isEmpty(Coada *q) //Daca Coada e Goala
{
    return q->prim==NULL;
}
int peek(Coada *q)  //Elementul din Varful Cozii
{
    if(isEmpty(q)) return -1;
    return q->prim->info;
}
void push(Coada *q, int x) //Adaugare Nod x in Coada
{
    nodCoada *n = nod_nou(x);
    if(isEmpty(q))         //Daca Coada e Vida
        q->prim=q->ultim=n;
    else     //Daca avem cel putin un nod in Coada
    {
        q->ultim->next=n;
        q->ultim=n;
    }
}
int pop(Coada *q)  //Stergere din Coada
{
    if(isEmpty(q)) return -1; //Coada e Vida
    nodCoada *n=q->prim;
    q->prim=q->prim->next;
    //Daca prim=NULL, atunci si ultim=NULL
    if(q->prim==NULL) q->ultim = NULL;
    //Return Element Sters
    return n->info;
}
void afisare(Coada *q)  //Afisare Coada
{
    if(isEmpty(q)) cout<<"Coada Vida"<<endl;
    else
    {
        nodCoada *p=q->prim;
        cout<<"Out: ";
        while(p!=NULL)
        {
            cout<<p->info<<" ";
            p=p->next;
        }
        cout<<":In"<<endl;
    }
}
int cautare(Coada *q, int x) //Cautare Element in Coada
{
    nodCoada *n=q->prim;
    int nr=0;
    while(n!=NULL)
    {
        if(n->info==x) return nr;
        nr++;n=n->next;
    }
    return -1;
}

int main()
{
    Coada *q=C_Noua();
    afisare(q);
    push(q,1); push(q,2); push(q,3);
    afisare(q);
    cout<<cautare(q,2)<<endl;
    cout<<cautare(q,4)<<endl;
    cout<<isEmpty(q)<<endl;
    cout<<pop(q)<<endl;
    afisare(q);
    cout<<peek(q)<<endl;
    afisare(q);
    pop(q);pop(q);
    afisare(q);
    cout<<pop(q)<<endl<<isEmpty(q)<<endl;

    return 0;
}
