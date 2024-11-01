#include <iostream>
using namespace std;
int v[100][100], m;
struct nodStiva //Declarare Structura Nod Stiva
{
    int info;
    nodStiva *next;
} *prim;
nodStiva *Nou(int x) //Creare Nou Nod Stiva
{
    nodStiva *n=new nodStiva;
    n->info=x;
    n->next=NULL;
    return n;
}
int isEmpty() //Daca Stiva e Goala
{
    return prim==NULL;
}
int peek()  //Elementul din Varful Stivei
{
    if(isEmpty()) return -1;
    return prim->info;
}
void push(int x) //Inserare in Stiva
{
    nodStiva *n=Nou(x);
    n->next=prim;
    prim=n;
}
int pop()  //Stergere din Stiva
{
    if (isEmpty()) return -1;
    nodStiva *n=prim;
    prim=prim->next;
    int sters=n->info;
    return sters;
}
void color(int i, int j, int c)
{
    v[i][j]=c;
    if(v[i][j+1]==1 && j+1<m)  {push(v[i][j+1]); color(i, j+1, c); pop();}
    if(v[i][j-1]==1 && j-1>=0) {push(v[i][j-1]); color(i, j-1, c); pop();}
    if(v[i+1][j]==1 && i+1<m)  {push(v[i+1][j]); color(i+1, j, c); pop();}
    if(v[i-1][j]==1 && i-1>=0) {push(v[i-1][j]); color(i-1, j, c); pop();}
}

int main()
{
    int i, j, c=2;
    cout<<"m: ";cin>>m;
    for(i=0; i<m; i++)
        for(j=0; j<m; j++) cin>>v[i][j];
    for(i=0; i<m; i++)
        for(j=0; j<m; j++)
            if(v[i][j]==1)
            {
                push(v[i][j]);
                color(i, j, c);
                pop();
                if(isEmpty()) c++;
            }

    cout<<endl;
    for(i=0; i<m; i++)
    {
        for(j=0; j<m; j++) cout<<v[i][j]<<" ";
        cout<<endl;
    }

    return 0;
}
