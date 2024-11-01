#include <iostream> //Arbore Binar Cautare
using namespace std;
struct arb
{
	int info;
	arb *st, *dr;
};
arb *nou(int x) //Adaugare Nod Nou in Arbore
{
    arb *r=new arb;
    r->info=x;
    r->st=r->dr=NULL;
    return r;
}
void ins(arb *&R, int x) //Inserare in Arbore
{
    if(R==NULL) R=nou(x);
    else
    {
        if(x>R->info) ins(R->dr,x);
        else ins(R->st,x);
    }
}
arb *maxim(arb *R) //Maximul din Arbore cu Radacina r
{
    while(R->dr!=NULL) R=R->dr;
    return R;
}
void sters(arb *&R, int x)
{
    if(R==NULL) return;
    //Daca x<Nod se afla in subarborele st
    if(x<R->info) sters(R->st, x);
    //Daca x>Nod se afla in subarborele dr
    else if (x>R->info) sters(R->dr, x);
    //Daca x=Nod stergem Nod
    else
    {
        //Daca Nod=Frunza (nu are niciun copil)
        if(R->dr==NULL && R->st==NULL)
        {delete R; R=NULL;}
        //Nodul are un copil
        else if(R->dr==NULL)
             {
                arb *aux=R;
                R=R->st;
                delete aux;
             }
             else if(R->st==NULL)
             {
                arb *aux=R;
                R=R->dr;
                delete aux;
             }
        //Daca Nodul are 2 copii
        else
        {
            arb *aux=maxim(R->st);
            R->info=aux->info;
            sters(R->st, aux->info);
        }
    }
}
void RSD(arb *R) //preordine
{
	if(R)
	{
		cout<<R->info<<" ";
		RSD(R->st);
		RSD(R->dr);
	}
}
void SRD(arb *R) //inordine
{
	if(R)
	{
		SRD(R->st);
		cout<<R->info<<" ";
		SRD(R->dr);
	}
}
void SDR(arb *R)  //postordine
{
	if (R)
	{
		SDR(R->st);
		SDR(R->dr);
		cout<<R->info<<" ";
	}
}
int caut(arb *R, int x) //Cautare Nod x in Arbore cu Radacina r
{
    if(R==NULL) return 0;
    if(R->info==x) return 1;
    if(R->info<x) return caut(R->dr, x);
    return caut(R->st, x);
}
void RSD1(arb *R, int lvl)
{
	if(R)
	{
	    for(int i=0; i<lvl; i++) cout<<" ";
		cout<<R->info<<endl;
		RSD1(R->st,lvl+1);
		RSD1(R->dr,lvl+1);
	}
}

int main()
{
    arb *r=NULL;
    ins(r,30);ins(r,20);ins(r,50);ins(r,80);ins(r,10);ins(r,25);ins(r,7);
    ins(r,6);ins(r,11);ins(r,14);ins(r,12);
    RSD(r); cout<<endl;
    SRD(r); cout<<endl;
    SDR(r); cout<<endl;
    /*cout<<maxim(r)->info<<endl;
    cout<<caut(r,20)<<endl;
    cout<<caut(r,10)<<endl;
    sters(r,20);SRD(r);cout<<endl;
    sters(r,50);SRD(r);cout<<endl;
    RSD1(r,1);cout<<endl;*/

    return 0;
}
