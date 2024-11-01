#include <iostream>
#include <string.h>
using namespace std;

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
void maxim(Coada *CC[100], int k, int &maxi, int &p)
{
   int i, x;
   for(i=1; i<=k; i++)
   {
       x=CC[i]->ultim->info;
       if(maxi<x) maxi=x, p=i;
   }
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

int main()
{
    int n, i, j, k, x, ok=1, nr=0;
    cout<<"N: ";cin>>n;
    cout<<"K: ";cin>>k;   //Nr_Cozi_Aux
    Coada *CI=C_Noua();  //Coada_Initiala
    cout<<"Dati Vagoane de la 1 la N: ";
    for(i=1; i<=n; i++)
    {cin>>x; push(CI,x);}
    Coada *CC[100];                       //Cozi Auxiliare
    for(i=1; i<=k; i++)
    {CC[i]=C_Noua(); push(CC[i],0);}  //Creez Cozile Auxiliare
    Coada *CF=C_Noua();                 //Creez Coada_Finala
    for(i=1; i<=n; i++)                //Punem Elementele din CI in Cozile_Aux
    {
        x=pop(CI); //Extrag Elementele din CI
        j=1;       //Nr_Coada_Aux unde voi Insera
        while(j<=k && CC[j]->ultim->info>x) j++;
        if(j>k) {ok=0;break;}  //Daca am depasit Nr_Cozi_Aux
        else push(CC[j],x);
    }
    if(ok==0) cout<<"Strategie Invalida";
    else
    {
        for(i=1; i<=k; i++)  //Numaram Cozile care sunt Efectiv Folosite
            if(CC[i]->prim==CC[i]->ultim) nr++;
        k=k-nr; //Noul Nr de Cozi_Aux
        for(i=1; i<=n; i++)
        {
            int maxi=0, p=0;
            maxim(CC, k, maxi, p);
            push(CF,maxi);

            nodCoada *q=CC[p]->prim, *last;
            while(q->next!=NULL)
            {last=q; q=q->next;}
            last->next=NULL; CC[p]->ultim=last; delete q;
        }
        afisare(CF);
    }

    return 0;
}
/*
                                    ---5,8,9---(Coada_Aux 1)
                                    --- 1,7 ---(Coada_Aux 2)
(Coada_Initiala)---5,8,1,7,4,2,9,6,3---                     ---9,8,7,6,5,4,3,2,1(Coada_Finala)
                                    --- 4,6 ---(Coada_Aux 3)
                                    --- 2,3 ---(Coada_Aux 4)
*/
