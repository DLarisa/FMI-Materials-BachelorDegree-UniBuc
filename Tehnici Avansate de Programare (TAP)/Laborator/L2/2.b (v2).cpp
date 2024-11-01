/*
    Complexitate: O(n * log n)
      Sortare: O(n * log n)
      Parcurgem liniar vectorul de texte: O(n)

    Soluție:
      Se ordonează crescător vectorul după lungimile textelor. Luăm grupuri de b (nr benzi)
      texte și le punem pe benzi (câte un text pe bandă), la pasul 0 (pași pari) de sus în jos
      și la pasul 1 (pași impari) de jos în sus. Dacă n%i>0 atunci textele trebuie puse astfel
      încât ultima bandă să "fie" completă. (Exemple la finalul algoritmului).

    Corectitudine:
      În orice soluție optimă, toate cele p benzi vor conține cel puțin un text (p<=n).
      Obs1: Pe fiecare bandă, textele sunt aranjate crescător după lungime.
      Obs2: Benzile pot fi renumerotate astfel încât n1>=...>=np. (după nr de texte de pe fiecare bandă)
      În plus, oricare ar fi k1<k2, nk1-nk2<=1.
      Pp prin absurd că există 2 benzi k1 și k2 astfel încât nk1-nk2>1. Dacă mutăm primul text
      de pe banda k1, pe banda k2, atunci noua soluție va avea S*=S-L(k1)*nk1+L(k1)*(nk2+1)=
      =S-L(k1)*(nk1-nk2-1)<S -> contradicție pt că am presupus S optim.
      Obs3: Textele așezate pe prima poziție din cele p benzi, sunt ordonate crescător.
      Pp prn absurd că există 2 benzi k1 și k2, k1<k2, cu L(cuv1)>L(cuv2); unde cuv1, cuv2 sunt
      textele de pe poziția 1 de pe banda k1, respectiv k2. Și am demonstrat mai sus că
      0<=nk1-nk2<=1. Dacă interschimbăm cele 2 cuvinte (cuv1 îl punem pe banda k2 și cuv2 pe k1),
      noua soluție S*=S-(L(cuv1)-L(cuv2))*(nk1-nk2)<S -> contradicție pt că am presupus S optim.
      Obs4: Textele așezate pe prima poziție de pe cele p benzi corespund primelor p texte
      ordonate crescător după lungime.
      Acest lucru se demonstrează ușor prin inducție.
      Obs5: Dacă n%p!=0, atunci cel n%p texte trebuie așezate pe benzile cu suma cea mai mică.
      Se demonstrează prin reducere la absurd, cu diferențe de sume (cum am procedat mai sus).
*/
#include <iostream>
#include <algorithm>
#include <vector>
#include <utility>
using namespace std;

struct text
{
    int l, p;
    //l=lungime; p=banda pe care îl așezăm
};
int cmp(text A, text B)
{return A.l<B.l;}

int main()
{
    int n, i, b;
    cout<<"Nr Texte: "; cin>>n;
    vector<text> V; V.resize(n);
    cout<<"Nr Benzi: "; cin>>b;
    cout<<"Date Intrare (lungime): "<<endl;
    for(i=0; i<n; i++) cin>>V[i].l, V[i].p=0;

    sort(V.begin(), V.end(), cmp);

    int x=n/b;
    for(i=0; i<x*b; i++)
    {
        if((i/b)%2==0) V[i].p=i%b;
        else V[i].p=b-(i%b)-1;
    }
    int y=b-(n-x*b);
    for(i=x*b; i<n; i++)
    {
        if((i/b)%2==0) V[i].p=i%b+y;
        else V[i].p=b-(i%b)-1-y;
    }

    return 0;
}
/*
    Exemple:
    1) n=7; b=4;
       Text: 0 1 3 5 6 11 20

       0) 0, 20
       1) 1, 11
       2) 3,  6
       3) 5

    2) n=10, b=4;
       Text: 0 5 3 1 6 22 20 47 38 11

       0) 0, 22
       1) 1, 20
       2) 3, 11, 38
       3) 5,  6, 47

    3) n=8, b=4;
       Text: 22 1 0 5 6 11 20 3

       0) 0, 22
       1) 1, 20
       2) 3, 11
       3) 5,  6
*/
