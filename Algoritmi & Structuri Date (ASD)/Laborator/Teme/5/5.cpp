#include <iostream> //Suma 2 Liste
using namespace std;
struct nod
{
    int info;
    nod *next;
} *prim, *ultim;
void afisare(nod *p)
{
	if (p)
	{
		cout << p->info << " ";
		afisare(p->next);
	}
}
nod *ins(nod *L, int x)
{
	nod *p = new nod;
	p->info = x;
	p->next = L;
}
void add_p(int x)
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
        p->next=prim;
        prim=p;
    }
}

int main()
{
    nod *a, *b; a = b = NULL;
    int x, y, nr=0, n, m, i;
    cout<<"Nr Noduri L1: ";cin>>n;
    for(i=0; i<n; i++)
    {cin>>x; a=ins(a, x);}
	cout<<"Nr Noduri L2: ";cin>>m;
	for(i=0; i<m; i++)
    {cin>>x; b=ins(b, x);}
	while(a!=NULL && b!=NULL)
    {
        x=a->info; y=b->info;
        x=nr+x+y; add_p(x%10);
        if(x>=10) nr=1;
        else nr=0;
        a=a->next;b=b->next;
    }
    while(a!=NULL)
    {
       x=a->info+nr; add_p(x%10);
       if(x>=10) nr=1;
       else nr=0;
       a=a->next;
    }
    while(b!=NULL)
    {
       x=b->info+nr; add_p(x%10);
       if(x>=10) nr=1;
       else nr=0;
       b=b->next;
    }
    if(nr) add_p(nr);
    nod *p=prim;
    while(p)
    {
        cout<<p->info;
        p=p->next;
    }

    return 0;
}
