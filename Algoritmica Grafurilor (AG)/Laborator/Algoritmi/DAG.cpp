#include <iostream> //DAG
#include <list>
#include <queue>
#include <utility>
#include <fstream>
using namespace std;
int d[100], t[100], st, grad[100];
//d=distanta, t=tata, st=nod de start

int main ()
{
    ifstream fin("date.txt");
    list< pair<int, int>> L[100]; //L[x]; primul int=y, 2 int=pondere; xy=muchie
    int i, n, m, x, y, c;
    fin>>n>>m; //n=nr noduri, m=nr muchii
    for(i=0; i<m; i++)
    {
        fin>>x>>y>>c;
        L[x].push_back({y, c});
        grad[y]++;
    }
    fin.close();

    list<int> TP; //sortare topologica
    queue<int> Q;
    for(i=1; i<=n; i++)
        if(!grad[i]) Q.push(i);
    while(!Q.empty())
    {
        x=Q.front(); Q.pop();
        TP.push_back(x);
        for(pair<int, int> p: L[x]) //pt noduri adiacente
        {
            y=p.first; grad[y]--;
            if(!grad[y]) Q.push(y);
        }
    }

    cout<<"Nod Start: "; cin>>st; //nod start
    //Initializare
    for(i=1; i<=n; i++) d[i]=1000, t[i]=-1;
    t[st]=d[st]=0;
    for(int x: TP)
        for(pair<int, int> p: L[x]) //fiecare vecin a lui x
        {
            y=p.first; c=p.second;
            if(d[y]>d[x]+c) d[y]=d[x]+c, t[y]=x;
        }
    cout<<"Vectorul de Distante: ";
    for(i=1; i<=n; i++) cout<<d[i]<<" ";
    cout<<endl;
    cout<<"Vectorul de Tati: ";
    for(i=1; i<=n; i++) cout<<t[i]<<" ";
    cout<<endl;

	return 0;
}
