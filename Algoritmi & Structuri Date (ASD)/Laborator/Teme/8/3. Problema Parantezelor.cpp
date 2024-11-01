#include <iostream>
#include <string.h>
using namespace std;

struct nodStiva
{
    int info;
    nodStiva *next;
} *prim;
nodStiva *Nou(int x)
{
    nodStiva *n=new nodStiva;
    n->info=x;
    n->next=NULL;
    return n;
}
int isEmpty()
{
    return prim==NULL;
}

void push(int x)
{
    nodStiva *n=Nou(x);
    n->next=prim;
    prim=n;
}
int pop()
{
    if (isEmpty()) return -1;
    nodStiva *n=prim;
    prim=prim->next;
    int sters=n->info;
    return sters;
}

int main()
{
    char s[100];cin.getline(s,100);
    int i, ok=1;
    for(i=0;i<strlen(s);i++)
    {
        if(s[i]=='(') push(1);
        else if(pop()==-1) {ok=0;break;}
    }
    if(ok==0 || isEmpty()==0) cout<<"Incorect";
    else cout<<"Corect";


    return 0;
}
