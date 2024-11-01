#include <iostream> //Daca o Secventa de Grade e Arbore
#include <fstream>
#include <list>
#include <vector>
#include <utility>
#include <algorithm>
#include <queue>
using namespace std;

int main()
{
    ifstream fin("date.txt");
    int n, i, j;
    char x, y;
    vector<int> V;
    queue<char> T, NT; //terminale si neterminale
    list< pair<char, char>> E;
    fin>>n; //nr grade din s0
    V.resize(n);
    int S=0; //suma gradelor
    //Citesc Datele
    for(i=0; i<n; i++)
    {
        fin>>V[i]; //secventa de grade
        S+=V[i]; //suma grade
        if(V[i]<1) {cout<<"NU NU"; return 0;}
        else if(V[i]==1) T.push('A'+i);
        else NT.push('A'+i);
    }
    fin.close();

    if(S!=2*(n-1)) {cout<<"NU Merge"; return 0;}
    while(!NT.empty())
    {
        x=NT.front(); y=T.front();
        T.pop(); V[x-'A']--;
        if(V[x-'A']==1)
        {
            NT.pop(); T.push(x);
        }
        E.push_back({x, y});
    }
    //Pt Valorile Ramase
    x=T.front(); T.pop(); y=T.front(); E.push_back({x, y});
    //Afisare
    for(auto i: E) cout<<i.first<<" "<<i.second<<endl;

    return 0;
}
