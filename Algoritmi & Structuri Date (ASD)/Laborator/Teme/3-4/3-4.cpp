#include <iostream> //LISTE
using namespace std;

struct nod //Declaram Structura unui Nod
{
    int info;
    nod *next;
} *prim, *ultim;
//Subpunct 1
void add_p(int x) //Inserare Nod la Inceputul Listei
{
    if(prim==NULL) //Lista Vida
    {
        prim=ultim=new nod; //Alocare Adresa Nod Nou
        prim->info=x;
        prim->next=NULL;
    }
    else //Exista cel putin un nod in lista
    {
        nod *p=new nod;
        p->info=x;
        p->next=prim;
        prim=p; //Primul nod devine p
    }
}
//End Subpunct 1
//Subpunct 2
void add_f(int x) //Inserare Nod la Finalul Listei
{
    if(prim==NULL) //Lista Vida
    {
        prim=ultim=new nod; //Alocare Adresa Nod Nou
        prim->info=x;
        prim->next=NULL;
    }
    else //Exista cel putin un nod in lista
    {
        nod *p=new nod;
        p->info=x;
        p->next=NULL;
        ultim->next=p;
        ultim=p; //Ultimul nod devine p
    }
}
//End Subpunct 2
//Subpunct 3
void afisare() //Afisare Lista
{
    nod *p=prim;
    while(p!=NULL)
    {
        cout<<p->info<<" ";
        p=p->next;
    }
    cout<<endl;
}
//End Subpunct 3
//Subpunct 4
int val(int x) //Cautare Valoare x in Lista
{
    nod *p=prim;
    int nr=0;
    while(p!=NULL)
    {
        nr++;
        if(x==p->info) return nr;
        p=p->next;
    }
    return -1;
}
//End Subpunct 4
//Subpunct 5
int poz(int x) //Cautare Valoare de pe Pozitia x din Lista
{
    nod *p=prim;
    while(p!=NULL)
    {
        x--;
        if(x==0) return p->info;
        p=p->next;
    }
    return -1;
}
//End Subpunct 5
//Subpunct 6
void iv(int v, int x) //Inserare dupa prima aparitie a unei Valori date
{
    nod *p=prim;
    while(p!=NULL)
    {
        if(v==p->info)
        {
            nod *q= new nod;
            q->info=x;
            if(p==ultim) //Caz particular daca valoarea e ultima in Lista
            {
                q->next=NULL;
                ultim->next=q;
                ultim=q;
            }
            else //Altfel
            {
                q->next=p->next;
                p->next=q;
            }
            break; //Nu mai parcurgem Lista
        }
        p=p->next; //Trecem la urmatorul Nod
    }
}
//End Subpunct 6
//Subpunct 7
void ip(int nr, int x) //Inserare pe o Pozitie data
{
    nod *p=prim, *r;
    while(p!=NULL)
    {
        if(nr==0)
        {
            nod *q= new nod;
            q->info=x;
            if(p==prim) //Caz particular daca valoarea e Prima in Lista
            {
                q->next=prim;
                prim=q;
            }
            else //Altfel
            {
                q->next=p;
                r->next=q;
            }
            break; //Nu mai parcurgem Lista
        }
        nr--;r=p;
        p=p->next; //Trecem la urmatorul Nod
    }
}
//End Subpunct 7
//Subpunct 8
void sv(int x) //Stergere de X
{
    nod *p=prim;
    nod *last;
    while(p!=NULL && p->info!=x)
    {
        last=p; //last ia valoarea de dinaintea lui p
        p=p->next;
    }
    if(p==NULL) {cout<<"Nu exista valoarea "<<x<<endl; return;}
    //return ca un fel de break
    if(p==prim) //Primul Nod
    {
        prim=prim->next;
        if(prim==ultim) ultim=NULL; //Avem Lista cu un Singur Nod
        delete p; return;
    }
    if(p==ultim) //Ultimul Nod
    {
        last->next=NULL;
        ultim=last;
        delete p; return;
    }
    //Un Nod din mijloc
    last->next=p->next;
    delete p;
}
//End Subpunct 8
//Subpunct 9
void sp(int nr) //Stergere de pe Pozitia nr
{
    nod *p=prim;
    nod *last;
    while(p!=NULL && nr!=1)
    {
        last=p; //last ia valoarea de dinaintea lui p
        p=p->next;
        nr--;
    }
    if(p==NULL) {cout<<"Nu exista pozitia "<<nr<<endl; return;}
    if(p==prim) //Primul Nod
    {
        prim=prim->next;
        if(prim==ultim) ultim=NULL; //Avem Lista cu un Singur Nod
        delete p; return;
    }
    if(p==ultim) //Ultimul Nod
    {
        last->next=NULL;
        ultim=last;
        delete p; return;
    }
    //Un Nod din mijloc
    last->next=p->next;
    delete p;
}
//End Subpunct 9

int main()
{
    afisare();add_p(1);add_p(2);add_p(3);afisare();add_f(4);afisare();
    cout<<val(5)<<endl<<val(1)<<endl<<poz(5)<<endl<<poz(3)<<endl;
    sp(1);afisare();sp(1);afisare();sv(4);afisare();add_f(5);afisare();sv(1);sp(1);afisare();
    add_f(8);afisare();


    return 0;
}
