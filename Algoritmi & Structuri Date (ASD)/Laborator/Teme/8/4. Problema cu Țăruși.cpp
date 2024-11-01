#include <iostream>//Problema 4
#include <string.h>
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

int main()
{
    int i,n,pereche[100];
    cout<<"Nr Tarusi:";cin>>n;
    for(i=0;i<n;i++) cin>>pereche[i];
    for(i=0;i<n;i++)
        if(isEmpty()) push(pereche[i]);
        else if(pereche[i]==peek()) pop();
             else push(pereche[i]);
    if(isEmpty()) cout<<"Configuratie Valida";
    else cout<<"Configuratie Invalida";


    return 0;
}
