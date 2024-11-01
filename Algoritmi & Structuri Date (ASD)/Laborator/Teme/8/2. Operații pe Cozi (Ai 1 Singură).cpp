#include <iostream> //2. Operatii cu Cozi
using namespace std;

struct nodCoada //Declarare Structura Nod Coada
{
    int info;
    nodCoada *next;
} *prim, *ultim;
nodCoada *Nou(int x) //Creare Nou Nod Coada
{
    nodCoada *n=new nodCoada;
    n->info=x;
    n->next=NULL;
    return n;
}
int isEmpty() //Daca Coada e Goala
{
    return prim==NULL;
}
int peek()  //Elementul din Varful Cozii
{
    if(isEmpty()) return -1;
    return prim->info;
}
void push(int x) //Inserare in Coada
{
    nodCoada *q=Nou(x);
    if(isEmpty()) ultim=prim=q;
    else
    {
        ultim->next=q;
        ultim=q;
    }
}
int pop()  //Stergere din Coada
{
    if (isEmpty()) return -1;
    nodCoada *p=prim;
    prim=prim->next;
    if (prim==NULL) ultim=NULL;
    int sters=p->info;
    return sters;
}
void afisare()  //Afisare Coada
{
    if(prim==NULL) cout<<"Coada Vida"<<endl;
    else
    {
        nodCoada *p=prim;
        cout<<"Out: ";
        while(p!=NULL)
        {
            cout<<p->info<<" ";
            p=p->next;
        }
        cout<<":In"<<endl;
    }
}
int cautare(int x) //Cautare Element in Coada
{
    nodCoada *p=prim;
    int nr=0;
    while(p!=NULL)
    {
        if(p->info==x) return nr;
        nr++;p=p->next;
    }
    return -1;
}

int main()
{
    afisare();
    push(1); push(2); push(3);
    afisare();
    cout<<cautare(2)<<endl;
    cout<<cautare(4)<<endl;
    cout<<isEmpty()<<endl;
    cout<<pop()<<endl;
    afisare();
    cout<<peek()<<endl;
    afisare();
    pop();pop();
    afisare();
    cout<<pop()<<endl<<isEmpty()<<endl;

    return 0;
}
