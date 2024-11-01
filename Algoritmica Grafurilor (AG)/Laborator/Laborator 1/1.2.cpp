#include <iostream>
#include <fstream>
#include <list>
#include <utility> //pt pair
using namespace std;
int M[50][50];

int main()
{
    int n, m, x, y, i, j;
    ifstream fin("graf.in");
    list< pair<int, int> > E;
    fin>>n>>m;
    for(i=0; i<m; i++)
    {
        fin>>x>>y;
        E.push_back({x, y});
    }
    //Lista de Muchii
    cout<<"Lista de Muchii:\n";
    for(pair<int, int> p:E) cout<<p.first<<" "<<p.second<<'\n';
    cout<<endl<<endl;

    //Matrice de Adiacenta
    cout<<"Matrice de adiacenta:\n";
    for(pair<int, int> p:E) M[p.first][p.second]=M[p.second][p.first]=1;
    for(i=1; i<=m; i++)
    {
        for(j=1; j<=m; j++) cout<<M[i][j]<<" ";
        cout<<endl;
    }

    return 0;
}
