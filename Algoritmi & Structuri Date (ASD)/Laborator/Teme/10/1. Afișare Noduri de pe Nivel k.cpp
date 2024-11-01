#include <iostream> //Afisare Noduri de pe Nivel k
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

void nod_lvl(arb *R, int k)
{
	if(R)
	{
	    if(k==0) cout<<R->info<<" ";
	    else
        {
            nod_lvl(R->st,k-1);
            nod_lvl(R->dr,k-1);
        }
	}
}

int main()
{
    arb *r=NULL;
    ins(r,2);ins(r,5);ins(r,1);ins(r,4);ins(r,3);ins(r,7);ins(r,6);
    nod_lvl(r,3);

    return 0;
}
