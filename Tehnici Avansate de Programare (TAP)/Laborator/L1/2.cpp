#include <iostream>
#include <algorithm>
#include <vector>
using namespace std;

struct triplet
{
    int a, b, c;
};
triplet nou(int x, int y, int z, int k)
{
    triplet aux;
    int s=k+z;
    aux.a=max(max(x, y), s);
    aux.c=min(min(x, y), s);
    aux.b=(x+y+s)-aux.a-aux.c;
    return aux;
}

int main()
{
    //citire date
    int n, i, j, x, y, z;
    triplet aux;
    vector<triplet> V;
    cout<<"n: "; cin>>n;
    cout<<"Dati dimendiunile: ";
    for(i=0; i<n; i++)
    {
        cin>>x>>y>>z;
        aux.a=max(max(x, y), z);
        aux.c=min(min(x, y), z);
        aux.b=(x+y+z)-aux.a-aux.c;
        V.push_back(aux);
    }
    sort(V.begin(), V.end(), [](const triplet &lhs, const triplet &rhs) {return lhs.a > rhs.a;});

    for(i=0; i<V.size(); i++)
    {
        aux=V[i];
        for(j=0; j<V.size(); j++)
            if(i!=j)
        {
            if(aux.a==V[j].a)
                if(aux.b==V[j].b || aux.b==V[j].c)
                {
                    aux=nou(aux.a, aux.b, aux.c, (V[j].b+V[j].c)-aux.b);
                    V.erase(V.begin()+j);
                }
            else if(aux.c==V[j].b || aux.c==V[j].c)
                {
                    aux=nou(aux.a, aux.c, aux.b, (V[j].b+V[j].c)-aux.c);
                    V.erase(V.begin()+j);
                }
                 else;
            else if(aux.a==V[j].b)
                if(aux.b==V[j].a || aux.b==V[j].c)
                {
                    aux=nou(aux.a, aux.b, aux.c, (V[j].a+V[j].c)-aux.b);
                    V.erase(V.begin()+j);
                }
                else if(aux.c==V[j].a || aux.c==V[j].c)
                {
                    aux=nou(aux.a, aux.c, aux.b, (V[j].a+V[j].c)-aux.c);
                    V.erase(V.begin()+j);
                }
                 else;
            else if(aux.a==V[j].c)
                if(aux.b==V[j].a || aux.b==V[j].b)
                {
                    aux=nou(aux.a, aux.b, aux.c, (V[j].a+V[j].b)-aux.b);
                    V.erase(V.begin()+j);
                }
                else if(aux.c==V[j].a || aux.c==V[j].b)
                {
                    aux=nou(aux.a, aux.c, aux.b, (V[j].a+V[j].b)-aux.c);
                    V.erase(V.begin()+j);
                }
                 else;
            else if(aux.b==V[j].a)
                if(aux.c==V[j].b || aux.c==V[j].c)
                {
                    aux=nou(aux.b, aux.c, aux.a, (V[j].b+V[j].c)-aux.c);
                    V.erase(V.begin()+j);
                }
                else;
            else if(aux.b==V[j].b)
                if(aux.c==V[j].a || aux.c==V[j].c)
                {
                    aux=nou(aux.b, aux.c, aux.a, (V[j].a+V[j].c)-aux.c);
                    V.erase(V.begin()+j);
                }
                else;
        }
        V[i]=aux;
    }

    int r=0;
    for(i=0; i<V.size(); i++)
        if(r<V[i].c/2) r=V[i].c/2;
    cout<<r<<endl;
//    for(i=0; i<V.size(); i++)
//        cout<<V[i].a<<" "<<V[i].b<<" "<<V[i].c<<endl;

    return 0;
}
