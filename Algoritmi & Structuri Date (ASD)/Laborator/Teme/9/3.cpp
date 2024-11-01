#include <iostream>
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
void afisare(arb *R, int k1, int k2)
{
   if(R)
   {
        if(k1<R->info) afisare(R->st, k1, k2);
        if(k1<=R->info && k2>=R->info) cout<<R->info<<" ";
        if(k2>R->info) afisare(R->dr, k1, k2);
   }
}

int main()
{
    arb *r=NULL;
    ins(r,50);ins(r,30);ins(r,20);ins(r,70);ins(r,40);ins(r,80);ins(r,60);
    afisare(r,10,50);

    return 0;
}
