#include <iostream>
#include <fstream>
#include <vector>
#include <list>
#include <utility>
#include <algorithm>
using namespace std;

int grad[100], grad1[100], viz[100], viz1[100];
vector< pair<int, int>> L[100], L1[100];
void DFS(int nod) //pt graf initial
{
    viz[nod]=1;
    int vecin;
    for(auto i: L[nod])
    {
        vecin=i.first;
        if(viz[vecin]==0) DFS(vecin);
    }
}
void DFS1(int nod) //pt apcm
{
    viz1[nod]=1;
    int vecin;
    for(auto i: L1[nod])
    {
        vecin=i.first;
        if(viz1[vecin]==0) DFS1(vecin);
    }
}

int t[100], h[100];
void init(int n)
{for(int i=1; i<=n; i++) t[i]=i;}
int Find(int x)
{
    if(x==t[x]) return x;
    return Find(t[x]);
}
void Union(int x, int y)
{
    int a=Find(x), b=Find(y);
    if(h[a]<h[b]) t[a]=b;
    else if(h[a]>h[b]) t[b]=a;
        else if(a!=b) {t[b]=a; h[a]++;}
}

int main()
{
    int i, j, x, y, c, nr=0, s=0;
    vector< pair<int, pair<int, int>>> aux, graf; //cost, x, y

    ifstream fin("graf.txt");
    int n, m, k;
    fin>>n>>m>>k;
    for(i=0; i<m; i++)
    {
        fin>>x>>y>>c;
        if(s<k) aux.push_back({c, {x, y}}); //pun muchiile obligatorii intr-un vector separat
        else graf.push_back({c, {x, y}});

        L[x].push_back({y, c});
        L[y].push_back({x, c});
        grad[x]++; grad[y]++; //grade noduri
        nr++; //nr de muchii graf original
        s++; //ca sa stiu cate muchii obligatorii am
    }
    fin.close();

    //pt Graful original verific daca poate sa fie arbore
    s=0;
    for(i=0; i<n; i++) s+=grad[i];
    if(s!=2*(n-1) || nr!=n-1) cout<<"NU"<<endl;
    else
    {
        nr=0;
        for(i=0; i<n; i++) //nr componente conexe
            if(viz[i]==0)
            {DFS(i); nr++;}
        if(nr-1!=1) cout<<"NU Conex"<<endl; //pornesc numaratoarea de la nod 1
    }


    list< pair<int, int>> E; //lista muchii APCM
    sort(graf.begin(), graf.end()); //sortez graful fara muchiile obligatorii
    init(n); s=0; //in s retin costul

    //Incep cu muchiile Obligatorii
    for(i=0; i<k; i++)
    {
        c=aux[i].first;
        x=aux[i].second.first;
        y=aux[i].second.second;
        if(Find(x)!=Find(y))
        {
            s+=c; Union(x, y);
            E.push_back({x, y});
            L1[x].push_back({y, c});
            L1[y].push_back({x, c});
            grad1[x]++; grad1[y]++;
        }
        //Daca nu pot pune muchiile obligatorii, nu am arbore
        else {cout<<"Nu exista Arbore"; return 0;}
    }

    nr=0; //nr muchii
    //Continui cu restul muchiilor
    for(i=0; i<m-k; i++)
    {
        c=graf[i].first;
        x=graf[i].second.first;
        y=graf[i].second.second;
        if(Find(x)!=Find(y))
        {
            s+=c; Union(x, y);
            E.push_back({x, y});
            L1[x].push_back({y, c});
            L1[y].push_back({x, c});
            nr++; grad1[x]++; grad1[y]++;
        }
    }

    //Verific daca am obtinut arbore
    if(nr+k!=n-1) {cout<<"Nu exista Arbore"; return 0;}
    c=0; nr=0;
    for(i=1; i<=n; i++)
        if(grad1[i]!=0) c+=grad1[i], nr++;
    if(c!=2*(nr-1)) {cout<<"Nu exista Arbore"; return 0;}
    else
    {
        nr=0;
        for(i=0; i<n; i++) //nr componente conexe
            if(viz1[i]==0)
            {DFS1(i); nr++;}
        if(nr-1!=1) {cout<<"NU Conex"<<endl; return 0;} //pornesc numaratoarea de la nod 1
    }

    cout<<"Costul: "<<s<<endl;
    for(auto i: E) cout<<i.first<<" "<<i.second<<endl;

    return 0;
}
