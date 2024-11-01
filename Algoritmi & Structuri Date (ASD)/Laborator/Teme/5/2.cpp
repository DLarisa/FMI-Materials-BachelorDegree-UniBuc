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
void ins(int x)
{
    nod *p=new nod;
    if(prim==NULL) {prim=ultim=new nod;prim->info=x;prim->next=NULL;}
    else
        if(x<prim->info)
        {p->info=x;p->next=prim;prim=p;}
         else
            if(x>ultim->info)
            {p->info=x;p->next=NULL;ultim->next=p;ultim=p;}
            else
            {
                nod *q=prim;p=prim->next;
                while(p->info<x) q=q->next,p=p->next;
                nod *r=new nod; r->info=x;
                q->next=r;r->next=p;
            }
}

int main()
{
    int n, i, x;
    cout<<"Nr Noduri: "; cin>>n;
    for(i=0; i<n; i++) {cin>>x; ins(x);}

    afisare();

    return 0;
}
