#include <iostream>
#include <fstream>
#include <algorithm>
#include <utility>
#include <vector>
using namespace std;

int cmp(pair<int, int> a, pair<int, int> b)
{
    if(a.second==b.second) return a.first>=b.first;
    return a.second<=b.second;
}

int main()
{
    int n, i, x, y;
    pair<int, int> aux;
    vector< pair<int, int>> L;

    ifstream fin("in.txt");
    fin>>n;
    L.resize(n);
    for(i=0; i<n; i++) {fin>>x>>y; L[i]={x, y};}
    fin.close();

    sort(L.begin(), L.end(), cmp);

    cout<<L[0].first<<" "<<L[0].second<<endl; aux=L[0];
    for(i=1; i<n; i++)
        if(L[i].second!=aux.second && L[i].first>=aux.second)
        {
            aux=L[i];
            cout<<L[i].first<<" "<<L[i].second<<endl;
        }

    return 0;
}
