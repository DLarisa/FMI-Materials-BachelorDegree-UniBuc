#include <iostream> //BFS
#include <vector>
#include <queue>
#include <fstream>
using namespace std;

int vizitat[1000];
int tata[1000], distanta[1000];
vector<int> Graf[1000];

int main ()
{
    int n, m, st; //n=nr noduri, m=nr muchii, st=start

    ifstream fin("date.txt");
    fin>>n>>m; //citesc datele
    int i, x, y;
    for(i=0; i<m; i++)
    {
        fin>>x>>y;
        Graf[x].push_back(y);
        Graf[y].push_back(x);
    }
    fin.close();
    //Initializare
    for(i=0; i<n; i++) distanta[i]=-1;

    queue<int> Q;
    int vecin, lim;
    cout << "Nod Start: "; cin >> st;
    Q.push(st); vizitat[st]=1; distanta[st]=0;
    while(!Q.empty())
    {
        x=Q.front(); Q.pop();
        cout << x << " "; //Afisare Noduri BFS
        lim=Graf[x].size();
        for(i=0; i<lim; i++)
        {
            vecin=Graf[x][i];
            if(!vizitat[vecin])
            {
                tata[vecin]=x;
                vizitat[vecin]=1;
                distanta[vecin]=distanta[x]+1;
                Q.push(vecin);
            }
        }
    }
    cout<<endl;
    for(i=1; i<=n; i++) cout<<tata[i]<<" ";
    cout<<endl;
    for(i=1; i<=n; i++) cout<<distanta[i]<<" ";
    cout<<endl;

	return 0;
}
