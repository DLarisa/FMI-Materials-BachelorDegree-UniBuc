/*
    Complexitate: O(n * log n)
       Sortarea: O(n * log n)
       Parcurgem cuburile o singură dată: complexitate liniară O(n)

    Soluție:
       Sortăm descrescător cuburile după lungimea laturii. Deoarece laturile sunt distincte
       2 câte 2, nu ne facem griji că avem 2 laturi egale. Trebuie doar să verificăm ca 2
       cuburi cu aceeași culoare să nu se suprapună. Începem turnul e la cubul cu latura
       cea mai mare.

    Corectitudine:
        Demonstrăm prin inducție, după n, că algoritmul construiește o soluție optimă.
        Pt n=0, afirmația este evidentă.
        Fie n>=2. Presupunem că algoritmul construiește o soluție optimă pt orice mulțime
        de cel mult n-1 cuburi. Acum trebuie să demonstrăm că afirmația este adevărată și
        pt n.

        a) Verificăm dacă pasul 1 este corect:
           La primul pas, adăugăm în algoritm cubul cu latura cea mai mare (îl notăm 1).
           Fie soluția optimă O={o1, o2, ... ok}, cu l.o1>l.o2>...>l.ok (laturi). Presupunem
           că 1 nu aparține lui 1.
             1. Dacă c1=c.o1, putem înlocui în soluția optimă cubul o1 cu 1 și atunci vom obține
             o nouă soluție optimă, cu înălțimea mai mare (O*=O-{o1}+1 > O; pt că l1>l.o1).
             Deci contradicție.
             2. Dacă c1!=c.o1, atunci putem insera cubul 1 înaintea cubului o1 și obținem un turn
             cu înălțimea mai mare -> contradicție.
        b) Am presupus că turnul construit din n-1 cuburi este corect. Algoritmul alege la pasul
           n un nou cub cu latura mai mică decât cubul n-1 și cu o culoare diferită față de acesta.
           Cum cuburile sunt deja sortate descrescător, algoritmul alege primul cub care respectă
           condițiile, deci vom obține o soluție optimă.
           Fie r primul cub având culoarea diferită față de cubul 1 și S*={r, r+1, ...n} (mulțimea
           cuburilor care pot aparține unui turn care are la bază cubul 1). Conform ipotezei de
           inducție soluția construită de algoritm pentru S* este G*=G-{1} și este soluție optimă
           pt S*. Rezultă că G=G* + {1} este soluție optimă pentru S. Altfel, conform punctului "a"
           ar exista o soluție optimă O pt S care conține cubul 1, cu înălțime mai mare decât soluția
           G; dar atunci O-{1} devine soluție optimă pt S* (față de G*) -> contradicție.

    În cazul în care laturile nu erau diferite 2 câte 2, atunci algoritmul nu mai era optim; deoarece
    puteam să avem mai multe soluții sau posibilități cum să alegem cuburile.
    Contraexemplu:
    4 2
    10 1
    10 2
    9 1
    8 2
*/
#include <iostream>
#include <algorithm>
#include <vector>
using namespace std;

struct cub
{
    int l, c, p;
    //l=latura; c=culoare; p=pozitia initiala
};
int cmp(cub A, cub B)
{return A.l>B.l;}

int main()
{
    int n, p;
    cout<<"Nr Cuburi: "; cin>>n;
    cout<<"Nr Culori: "; cin>>p;

    int i, s; //s=inaltime turn
    vector<cub> V; V.resize(n);
    cout<<"Date de Intrare (latura, culoare): ";
    for(i=0; i<n; i++)
        cin>>V[i].l>>V[i].c, V[i].p=i+1;

    sort(V.begin(), V.end(), cmp);

    vector<cub> Turn;
    Turn.push_back(V[0]);
    s=V[0].l;
    for(i=1; i<n; i++)
        if(Turn.back().c!=V[i].c) Turn.push_back(V[i]), s+=V[i].l;

    cout<<endl<<"Inaltime: "<<s<<endl;
    cout<<"Nr Cuburi din Turn: "<<Turn.size()<<endl;
    cout<<"Cuburile: ";
    for(i=0; i<Turn.size(); i++) cout<<Turn[i].p<<" ";
    cout<<endl;

    return 0;
}
