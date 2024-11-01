#include <iostream>
using namespace std;
struct nod
{
    int info;
    nod *next;
} *prim, *ultim;
void afisare()
{
    nod *p=prim;
    while(p!=NULL)
    {
        cout<<p->info<<" ";
        p=p->next;
    }
    cout<<endl;
}
void add_f(int x)
{
    if(prim==NULL)
    {prim=ultim=new nod;prim->info=x;prim->next=NULL;}
    else
    {nod *p=new nod;p->info=x;p->next=NULL;ultim->next=p;ultim=p;}
}
void oglinda() //Oglinda Lista
{
    nod *p,*c,*n; //3 noduri (previous, current, next)
    p=NULL; n= NULL; c=prim;
    while(c!=NULL)
    {n=c->next;c->next=p;p=c;c=n;}
    prim=p;
}

int main()
{
    int n, i, x;
    cout<<"Nr Noduri: "; cin>>n;
    for(i=0; i<n; i++) {cin>>x; add_f(x);}
    oglinda();
    afisare();

    return 0;
}
