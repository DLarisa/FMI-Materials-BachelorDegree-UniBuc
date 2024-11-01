#include <iostream> //Sortare Topologica
#include <list>
#include <queue>
#include <utility>
#include <fstream>
using namespace std;
int grad[100];

int main ()
{
    ifstream fin("date.txt");
    list< pair<int, int>> L[100]; //L[x]; primul int=y, 2 int=pondere; xy=muchie
    int i, n, m, x, y, c;
    fin>>n>>m; //n=nr noduri, m=nr muchii
    //Citire Date
    for(i=0; i<m; i++)
    {
        fin>>x>>y>>c;
        L[x].push_back({y, c});
        grad[y]++;
    }
    fin.close();

    list <int> TP; //parcurgere topologica
    queue <int> Q;
    for(i=1; i<=n; i++) //pui in coada nodurile cu grad intern nul
        if(!grad[i]) Q.push(i);
    while(!Q.empty())
    {
        x=Q.front(); Q.pop();
        TP.push_back(x);
        for(pair<int, int> p:L[x]) //pt nodurile adiacente
        {
            y=p.first; grad[y]--;
            if(!grad[y]) Q.push(y);
        }
    }
    if(TP.size()!=n) {cout<<"Graful contine ciclu"; return 0;}
    for(int x: TP) cout<<x<<" "; //Afisare Sort Topologica
    cout<<endl;

	return 0;
}
