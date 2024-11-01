#include <iostream> //Lista Dublu Inlantuita (Tip Coada)
using namespace std;
struct nod
{
	int info;
	nod *next, *pre;
};
void ins1(nod *&P, nod *&U, int x) //Inserare pe Prima Poziție
{
	nod *z=new nod;
	z->info=x;
	z->pre=NULL;
	z->next=P;
	if(!P && !U) U=z;
	else P->pre=z;
	P=z;
}
void ins2(nod *&P, nod *&U, int x) //Inserare pe Ultima Pozitie
{
	nod *z=new nod;
	z->info=x;
	z->next=NULL;
	z->pre=U;
	if(!P && !U) P=z;
	else U->next=z;
	U=z;
}
void del1(nod *&P, nod *&U) //Stergere Prima Pozitie
{
	if(P == U) P=U=NULL;
	else if(P && U)
	{P=P->next; P->pre=NULL;}
}
void del2(nod *&P, nod *&U) //Stergere Ultima Pozitie
{
	if(P == U) P=U=NULL;
	else if(P && U)
	{U=U->pre; U->next=NULL;}
}
void delPK(nod* &P, nod *&U, int k) //Stergere Pozitia K
{
	int i;
	nod *z=new nod;
	z=P;
	for(i=1; i<k; i++) z=z->next;
	if(z==P) del1(P, U);
	else if(z==U) del2(P, U);
	else
	{
		z->pre->next=z->next;
		z->next->pre=z->pre;
	}
}
void afisare1(nod *p) //Afisare Inceput Lista
{
	if(p)
	{
		cout<<p->info<<" ";
		afisare1(p->next);
	}
}
void afisare2(nod *p) //Afisare Sfarsit Lista
{
	if(p)
	{
		cout<<p->info<<" ";
		afisare2(p->pre);
	}
}

int main()
{
    nod *a, *b; a=b=NULL;
	int n, k, i;
	cout <<"Nr Elemente: "; cin>>n;
	for(i=0; i<n; i++)
	{
		cin>>k;
		ins1(a, b, k);
	}
	afisare1(a);
	cout<<endl;
	afisare2(b);
	cout<<endl;

    return 0;
}
