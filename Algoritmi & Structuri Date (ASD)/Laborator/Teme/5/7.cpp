#include <iostream>
using namespace std;
struct nod
{
    int info;
    nod *next;
};
//Creare Nod Nou cu Informatie Data
nod *nou(int x)
{
	nod *p = new nod;
	p->info = x;
	p->next = NULL;
	return p;
}
//Functie pentru a Adauga un Nod Nou la Inceputul unei Liste
void ins(nod *&a, int x)
{
    nod *p=nou(x);
    p->next=a;
    a=p;
}
int oglinda(nod *&a) //Oglinda Lista + Lungime Lista
{
    nod *p,*c,*n;
    int l=0; //Lungime Lista
    p=NULL; n= NULL; c=a;
    while(c!=NULL)
    {l++;n=c->next;c->next=p;p=c;c=n;}
    a=p;
    return l;
}
//Functie care Creaza o Lista Vida cu o Lungime Data
nod *lista(int l)
{
    nod *prim=NULL;
    while(l--) ins(prim,0);
    return prim;
}
//Functie pentru Inmultirea a 2 Liste
nod *inm(nod *a, nod *b)
{
    int n=oglinda(a), m=oglinda(b);
    nod *f=lista(m+n+1); //Marime max a Listei Finale e de m+n+1
    nod *b1=b, *f1=f, *f2, *a1; //Pointeri pentru a parcurge
    while(b1)
    {
        int nr=0;
        f2=f1;
        a1=a; //Parcurgem Lista a
        while(a1)
        {
            int s=a1->info*b1->info+nr;
            f2->info=f2->info+s%10;
            nr=s/10+f2->info/10;
            f2->info=f2->info%10;
            a1=a1->next;
            f2=f2->next;
        }
        if(nr) f2->info+=nr;
        f1=f1->next;
        b1=b1->next;
    }
    oglinda(f);oglinda(a);oglinda(b);
    while(f->info==0)
    {
        nod *aux=f;
        f=f->next;
        delete(aux);
    }
    return f;
}
void afisare(nod *p)
{
	if (p)
	{
		cout << p->info;
		afisare(p->next);
	}
}

int main()
{
    nod *a, *b, *f; a = b = NULL;
    ins(a,3);ins(a,1);ins(a,2);
    ins(b,2);ins(b,4);ins(b,1);
    afisare(a);cout<<endl;afisare(b);cout<<endl;
    f=inm(a,b);afisare(f);

    return 0;
}
