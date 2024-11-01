#include <iostream> //Kruskal
#include <fstream>
#include <algorithm>
#include <vector>
#include <utility>
#include <list>
using namespace std;

int t[100], h[100]; //t=vector tati, h=vector inaltime
void init(int n) //Initializare
{
    //Fiecare Nod e propriul Arbore
    for(int i=1; i<=n; i++) t[i]=i, h[i]=0;
}
int Find(int x) //Cautam Radacina Arbore
{
    if(x==t[x]) return x;
    return Find(t[x]);
}
void Union(int x, int y) //Unim 2 Arbori (=C.Conexe)
//Arborele cu h mai mica devine subarbore pt celalalt
{
    int a=Find(x), b=Find(y);
    if(h[b]>h[a]) t[a]=b;
    else if(h[b]<h[a]) t[b]=a;
         else if(a!=b) {t[b]=a; h[a]++;}
}

int main()
{
    int n, m, i, j, x, y, p;
    vector< pair<int, pair<int,int>>> E; //primul int = pondere, pair (x,y)=muchie
    ifstream fin ("date.txt");
    fin>>n>>m; E.resize(m);
    list< pair<int, int>> T; //Arborele Partial de Cost Min
    //Citire Date
    for(i=0; i<m; i++)
    {
        fin>>x>>y>>p;
        E[i]={p, {x,y}};
    }
    fin.close();

    //Sortam Crescator Muchiile dupa Pondere
    sort(E.begin(),E.end());
    init(n);

    /*
    //Afisare Muchii Sortate
    for(i=0; i<m; i++)
        cout<<E[i].first<<' '<<E[i].second.first<<"->"<<E[i].second.second<<endl;
    cout<<endl;
    */

    int S=0; //suma ponderi
    for(i=0; i<m; i++)
    {
        p=E[i].first;
        x=E[i].second.first;
        y=E[i].second.second;
        if(Find(x)!=Find(y)) //Sa nu formeze un Ciclu
        {
            T.push_back({x,y});
            S+=p;
            Union(x,y);
        }
    }
    cout<<"Cost: "<<S<<endl;
    //Afisare APCM
    for(auto P: T) cout<<P.first+'A'<<' '<<P.second+'A'<<endl;

    return 0;
}
