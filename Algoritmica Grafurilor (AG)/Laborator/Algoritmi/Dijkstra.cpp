#include <iostream> //Dijkstra
#include <fstream>
#include <set>
#include <list>
#include <utility>
using namespace std;

int main ()
{
	int n, m, p, i, t[100], d[100], st, x, y;
	ifstream fin("date.txt"); fin>>n>>m;
	list< pair<int, int>> L[100]; //liste de adiacenta - vecini
	for(i=0; i<m; i++)
    {
        fin>>x>>y>>p;
        L[x].push_back({p, y});
        L[y].push_back({p, x});
    }
    fin.close();
    //Initializare
    for(i=1; i<=n; i++)
    {
        d[i]=10000; //infinitul
        t[i]=0;
    }
    cout << "Introduceti Nod Start: "; cin >> st; d[st]=0;

	set< pair<int, int>> Q; //1 int=d[x]=distanta; 2 int=eticheta nod
	Q.insert({d[st], st});
	while(Q.size()>0)
    {
        x=Q.begin()->second;
        Q.erase(Q.begin()); //sau Q.erase({d[x], x});
        for(pair<int, int> it: L[x]) //pt fiecare vecin a lui L[x]
        {
            y=it.second; p=it.first; //p=pondere
            if(d[y]>d[x]+p)
            {
                Q.erase({d[y], y});
                d[y]=d[x]+p; t[y]=x;
                Q.insert({d[y], y});
            }
        }
    }
    cout<<"Vectorul de Distante: ";
    for(i=1; i<=n; i++) cout<<d[i]<<" ";
    cout<<endl;
    cout<<"Vectorul de Tati: ";
    for(i=1; i<=n; i++) cout<<t[i]<<" ";
    cout<<endl;

	return 0;
}
