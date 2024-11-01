#include <iostream>
#include <fstream>
#include <list>
#include <utility>
#include <queue>
using namespace std;
int pred[50], d[50]; //pred=predecesor; d=distanta
bool check[50];

int main()
{
    int n, m, x, y, i;
    ifstream fin("graf.in");
    list< pair<int, int> > E;
    list<int> L[100];
    fin>>n>>m;
    for(i=0; i<m; i++)
    {
        fin>>x>>y;
        E.push_back({x, y});
        L[x].push_back(y);
    }
    //Lista de Muchii
    cout<<"Lista de Muchii:\n";
    for(pair<int, int> p:E) cout<<p.first<<" "<<p.second<<'\n';
    cout<<endl<<endl;


    while(fin>>x) check[x]=true;
    int s; cout<<"Nod Start: "; cin>>s;
    queue<int> Q;
    Q.push(s); pred[s]=-1; d[s]=0;
    while(!Q.empty())
    {
        x=Q.front(); Q.pop();
        if(check[x]) break;
        for(int j: L[x]) //NEAPARAT int in interior paranteza
            if(!pred[j])
            {
                pred[j]=x; d[j]=d[pred[j]]+1;
                Q.push(j);
            }
    }
    cout<<"Cel mai apropiat punct de control: "<<x<<endl;
    cout<<"Distanta: "<<d[x]<<endl;
    list<int> distanta;
    while(x!=-1)
    {distanta.push_front(x); x=pred[x];}
    for(int j: distanta) cout<<j<<" ";
    cout<<endl;

    fin.close();

    return 0;
}
