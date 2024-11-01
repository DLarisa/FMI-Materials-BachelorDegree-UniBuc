#include <iostream>
using namespace std;
struct arb
{
	string info;
	arb *st, *dr;
};
arb *nou(string x) //Adaugare Nod Nou in Arbore
{
    arb *r=new arb;
    r->info=x;
    r->st=r->dr=NULL;
    return r;
}
void ins(arb *&R, string x) //Inserare in Arbore
{
    if(R==NULL) R=nou(x);
    else
    {
        if(x>R->info) ins(R->dr,x);
        else ins(R->st,x);
    }
}
void inordine(arb *R, string v[], int &i)
//Se obtine vectorul sortat prin traversarea arborelui in inordine
{
    if(R!=NULL)
    {
        inordine(R->st, v, i);
        v[i++]=R->info;
        inordine(R->dr, v, i);
    }
}
void sortare(string v[], int n)
{
    arb *R=NULL;
    ins(R, v[0]);
    int i;
    for (i=1; i<n; i++) ins(R, v[i]);
    i=0; inordine(R, v, i);
}


int main()
{
    string v[100];
    int n, i;
    cout<<"n: "; cin>>n;
    for(i=0; i<n; i++) cin>>v[i];
    sortare(v, n);
    for(i=0; i<n; i++) cout<<v[i]<<" ";

    return 0;
}
