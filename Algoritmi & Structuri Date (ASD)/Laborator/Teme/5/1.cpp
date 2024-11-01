#include <iostream>
using namespace std;
struct nod
{
    float info;
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
    {
        prim=ultim=new nod;
        prim->info=x;
        prim->next=NULL;
    }
    else
    {
        nod *p=new nod;
        p->info=x;
        p->next=NULL;
        ultim->next=p;
        ultim=p;
    }
}

int main()
{
    int n,x,i; cin>>n;
    nod *p;
    for(i=0;i<n;i++) {cin>>x; add_f(x);}
    p=prim;
    while(p->next!=NULL)
    {
        nod *q=new nod;
        q->info=(p->info+p->next->info)  /2;
        q->next=p->next;
        p->next=q;
        p=q->next;
    }
    afisare();

    return 0;
}
