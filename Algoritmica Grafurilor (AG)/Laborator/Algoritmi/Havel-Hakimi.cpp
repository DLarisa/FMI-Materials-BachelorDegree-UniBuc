#include <iostream> //Havel-Hakimi
#include <fstream>
#include <list>
#include <vector>
#include <utility>
#include <algorithm>
using namespace std;

int main()
{
    ifstream fin("date.txt");
    int n, i, j, x;
    vector< pair<int, char>> S, aux; //int=grad, char=eticheta
    list< pair<char, char>> E; //Lista de Muchii
    fin>>n; //n=nr grade (din s0)
    S.resize(n); aux.resize(n); //vectorii au acum fix n componente
    for(i=0; i<n; i++)
    {
        fin>>x; //citim fiecare grad
        if(x<0 || x>=n) //daca gradul e negativ sau mai mare decat n-1 avem eroare
        {cout<<"NU Nu"; return 0;}
        S[i]={x, 'A'+i}; //sau make.pair
       //---> S contine nodurile cu gradul si eticheta corespunzatoare
    }
    fin.close();
    sort(S.begin(), S.end()); //sortam nodurile crescator

    /*
    //Afisam Nodurile Initiale Sortate
    for(i=0; i<n; i++) cout<<S[i].second<<' '<<S[i].first<<'\n';
    cout<<endl;
    */

    while(S[n-1].first>0) //cat timp nu exista valori <=0
    {
        int d=S[n-1].first; //degree pt nodul pe care il eliminam (cel max)
        char et=S[n-1].second; //eticheta pt nodul pe care il eliminam (cel max)
        S.pop_back(); n--; //elimin nodul max
        for(i=1; i<=d; i++) //iau urmatoarele d noduri cele mai mari
        {
            S[n-i].first--; //le scad gradul
            E.push_back({et, S[n-i].second}); //pun muchiile in lista
            if(S[n-i].first<0)
            {cout<<"NU!"; return 0;} //daca avem vreun grad negativ
        }

        //Sortare prin Interclasare si pune in vectorul auxiliar
        merge(S.begin(), S.begin()+n-d, S.begin()+n-d, S.end(), aux.begin());

        //Punem in Vectorul Initial nodurile sortate din aux
        for(i=0; i<n; i++) S[i]=aux[i];
    }
    //Afisare Muchii
    for(pair<char, char> p: E) cout<<p.first<<' '<<p.second<<endl;

    return 0;
}
