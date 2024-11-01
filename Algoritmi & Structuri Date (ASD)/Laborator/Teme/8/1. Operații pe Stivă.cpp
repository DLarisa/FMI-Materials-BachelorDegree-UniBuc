#include <iostream> //1.Stiva
using namespace std;

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
void afisare()  //Afisare Stiva
{
    if(prim==NULL) cout<<"Stiva Vida"<<endl;
    else
    {
        nodStiva *p=prim;
        cout<<"Varf: ";
        while(p!=NULL)
        {
            cout<<p->info<<" ";
            p=p->next;
        }
        cout<<":Baza"<<endl;
    }
}
int cautare(int x) //Cautare Element in Stiva
{
    nodStiva *p=prim;
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
    cout<<cautare(4)<<endl<<isEmpty()<<endl<<pop()<<endl;
    afisare();
    cout<<peek()<<endl;
    afisare();
    pop();pop();
    afisare();
    cout<<pop()<<endl<<isEmpty()<<endl;

    return 0;
}
