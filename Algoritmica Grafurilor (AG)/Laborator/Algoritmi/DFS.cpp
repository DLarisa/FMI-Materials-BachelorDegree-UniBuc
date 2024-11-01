#include <iostream> //DFS - Nr Componente Conexe, muchii critice
#include <vector>
#include <fstream>
using namespace std;

int vizitat[1000]; //nodurile vizitate
vector<int> Graf[1000]; //graful neorientat
void DFS(int nod)
{
    cout << nod << " "; //Afisare DFS
    vizitat[nod]=1;
    int i, lim=Graf[nod].size(), vecin;
    for(i=0; i<lim; i++) //pt toti vecinii nodului
    {
        vecin=Graf[nod][i];
        if(vizitat[vecin]==0) DFS(vecin);
    }
}

int main ()
{
    int n, m; //n=nr noduri, m=nr muchii
    ifstream fin("date.txt");
    fin>>n>>m; //citesc datele
    int i, x, y, nr_conexe=0;
    //Initializare
    for(i=0; i<m; i++)
    {
        fin>>x>>y;
        Graf[x].push_back(y);
        Graf[y].push_back(x);
    }
    fin.close();

    // DFS(start); //--- pentru o singura parcurgere
    for(i=0; i<n; i++)
        if(!vizitat[i])
        {
            nr_conexe++;
            DFS(i);
            cout<<endl;
        }
    cout<<"Nr Componente Conexe: "<<nr_conexe<<endl;

    return 0;
}
