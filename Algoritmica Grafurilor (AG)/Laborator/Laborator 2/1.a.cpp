#include <iostream>
#include <fstream>
#include <list>
#include <utility>
using namespace std;
ifstream fin("graf.txt");
int m, n;
int times; //times=nr pasi
int status[100]; //white=0 (nevizitat), gray=1, black=2
int dt[100]; //discovery time
int tata[100], low[100], crit[100]; //crit=vector caracteristic de noduri critice
list <int> L[100]; //lista de vecini
//list < pair<int, int> >;
int dfs(int x)
{
    times++; status[x]=1;//devine gray
    int nrc=0; //nr copii
    dt[x]=low[x]=times; //low va fi updatat
    for(int y: L[x])
    {
        if(status[y]==0)
        {
            tata[y]=x; nrc++;
            dfs(y);
            low[x]=min(low[x], low[y]);
            if(dt[x]<=low[y])
                crit[x]=1; //verific daca x a devenit punct critic din cauza lui y
            if(dt[x]<low[y]) cout<<"Muchie Critica: "<<x<<" "<<y<<endl;
        }
        if(status[y]==1)
            if(y!=tata[x]) //xy=muchie de intoarcere
            {low[x]=min(low[x], dt[y]);}
    }
    status[x]=2; return nrc;
}

int main()
{
    int i, j, x, y;
    int s; //start
    fin>>n>>m; //nod, muchii
    for(i=0; i<m; i++)
    {
        fin>>x>>y;
        L[x].push_back(y); L[y].push_back(x);
    }
    cin>>s;
    if(dfs(s)>1) crit[s]=1;
    else crit[s]=0;
    cout<<"Discovery Time: ";
    for(i=1; i<=n; i++) cout<<dt[i]<<" ";
    cout<<endl;
    cout<<"Lower: ";
    for(i=1; i<=n; i++) cout<<low[i]<<" ";
    cout<<endl;
    cout<<"Noduri Critice: ";
    for(i=1; i<=n; i++)
        if(crit[i]==1) cout<<i<<" ";
    cout<<endl;
    fin.close();

    return 0;
}
