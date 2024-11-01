#include <iostream> //Floyd-Warshall
#include <fstream>
#include <iomanip>
using namespace std;
//d=distanta i-j;
//p=(predecesori) k -> intr-un drum min ij, k e predecesorul lui j
int d[100][100], p[100][100];

int main ()
{
    int n, m, x, y, k, i, j;
    //Citire Date + Initializare
    ifstream fin("date.txt");
    fin>>n>>m;
    for(i=0; i<n; i++)
        for(j=0; j<n; j++)
            if(i!=j) d[i][j]=100000;
    for(i=0; i<m; i++)
    {
        fin>>x>>y>>k;
        d[x][y]=k; p[x][y]=x;
        //d[y][x]=k; p[y][x]= y; ->daca avem graf neorientat
    }
    fin.close();

    for(k=0; k<n; k++)
        for(i=0; i<n; i++)
            for(j=0; j<n; j++)
                if(d[i][j]>d[i][k]+d[k][j])
                {
                    d[i][j]=d[i][k]+d[k][j];
                    p[i][j]=p[k][j];
                }
    for(i=0; i<n; i++)
    {
        for(j=0; j<n; j++)
            if(d[i][j]>1000) cout<<setw(4)<<"INF"<<" ";
            else cout<<setw(4)<<d[i][j]<<" ";
        cout<<endl;
    }
    /*
    for(i=0; i<n; i++)
    {
        for(j=0; j<n; j++) cout<<p[i][j]<<" ";
        cout<<endl;
    }
    */

	return 0;
}
