#include <iostream>
#include <vector>
#include <utility>
#include <fstream>
#include <algorithm>
#include <list>
using namespace std;
int t[100], h[100]; //t=vector tati, h=vector inaltime
void init(int n)
{
    for(int i=1; i<=n; i++) t[i]=i, h[i]=0;
}
int Find(int x)
{
    if(x==t[x]) return x;
    return Find(t[x]);
}
void Union(int x,int y)
{
    int a=Find(x), b=Find(y);
    if(h[b]>h[a]) t[a]=b;
    else if(h[b]<h[a]) t[b]=a;
         else if(a!=b) {t[b]=a; h[a]++;}
}
int main()
{
    int n, m, i, j, x, y, p, S=0;
    vector< pair<int, pair<int,int>>> E; //primul int e ponderea, pair (x,y)
    ifstream fin ("graf.txt");
    fin>>n>>m; E.resize(m);
    list< pair<int, int>> T;
    for(i=0; i<m; i++)
    {
        fin>>x>>y>>p;
        E[i]={p, {x,y}};
    }
    sort(E.begin(),E.end());
    init(n);
    for(i=0; i<m; i++)
        cout<<E[i].first<<' '<<E[i].second.first<<"->"<<E[i].second.second<<endl;
    cout<<endl;
    for(i=0; i<m; i++)
    {
        p=E[i].first;
        x=E[i].second.first;
        y=E[i].second.second;
        if(Find(x)!=Find(y))
        {
            T.push_back({x,y});
            S+=p;
            Union(x,y);
        }
    }
    cout<<"Cost: "<<S<<endl;
    for(auto P: T) cout<<P.first<<' '<<P.second<<endl;


    return 0;
}
