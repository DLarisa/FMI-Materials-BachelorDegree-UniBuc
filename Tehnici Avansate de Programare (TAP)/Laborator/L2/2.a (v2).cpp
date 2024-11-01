/*
    Complexitate: O(n * log n)
      Sortare: O(n * log n)
      Parcurgem vectorul de Scoruri: timp liniar -> O(n)

    Soluție:
      Realizăm un vector de scoruri (frecvență/lungime) și îl ordonăm descrescător.
      Ordinea textelor pe bandă este dat de care text are scorul mai mare.

    Corectitudine:
      Textele de pe bandă le putem considera entități bidimensionale (formate din
      frecvență și lungime). Trebuie să găsim o metodă de sortare care să conducă la o
      soluție optimă. Ținem cont că frecvențele mai mari conduc la o sumă mai mare și
      lungimea trebuie să fie cât mai mică. Vom folosi raportul acestor 2 valori pentru
      a ordona activitățile (prima activitate are raportul cel mai mare).
      Demonstrăm corectitudinea algoritmului prin metoda reducerii la absurd. Vom considera
      că există o soluție optimă, B, mai bună decât soluția noastră, A.
      Ipoteza 1: Toate rapoartele (frecvență / lungime) sunt diferite.
      Ipoteza 2: Rapoartele R1 >= R2 >= ... Rn (i.e. F1/L1 >= ... >= Fn/Ln).
      Datorită ipotezei 2, soluția noastră va fi A=(1, 2, ..., n). Deoarece am presupus că
      A nu este optim -> A!=B, deci B va conține 2 activități consecutive (i, j) astfel încât
      i>j. Dacă am considera o soluție C care derivă din B, dar realizăm operația de swap(i, j),
      atunci Li va crește cu Lj, iar Lj va scădea cu Li. Deci, obținem o pierdere Fi*Lj și un
      profit Fj*Li. Din ipoteza 2, i>j -> Ri<Rj -> Fi*Lj<Fj*Li -> contradicție pt că C devine
      optim, dar noi am presupus B ca fiind optim.
*/
#include <iostream>
#include <algorithm>
#include <vector>
#include <utility>
using namespace std;

struct text
{
    int l, f;
    //l=lungime; f=frecvență
};

int main()
{
    int n, i;
    cout<<"Nr Texte: "; cin>>n;
    vector<text> V; V.resize(n);
    cout<<"Date Intrare (lungime, frecventa): "<<endl;
    for(i=0; i<n; i++) cin>>V[i].l>>V[i].f;

    vector< pair<double, int>> Scor;
    double aux;
    for(i=0; i<n; i++)
    {
        aux=(double)(V[i].f)/(double)(V[i].l);
        Scor.push_back({aux, i}); //scorul si pozitia in vectorul initial
    }

    sort(Scor.begin(), Scor.end()); //sortam crescator dupa scor
    int a, s=0, M=0;
    cout<<"Permutarea: ";
    for(i=n-1; i>=0; i--) //luam scorurile in ordine descrescatoare
    {
        a=Scor[i].second; //pozitia in vectorul initial
        s+=V[a].l;
        M+=V[a].f*s;
        cout<<a+1<<" ";
    }
    cout<<endl<<"Suma: "<<M<<endl;

    return 0;
}
