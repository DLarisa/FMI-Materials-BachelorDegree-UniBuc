/*
    Complexitate: O(n * log n)
       Sortare: O(n * log n)
       Parcurgerea tuturor actvităților: timp liniar -> O(n)
       Init: O(n)
       Find: O(log maxi)
       Union: O(1)

    Soluție:
       Folosim o implementare similară cu algoritmul lui Kruskal. Sortăm descrescător
       activitățile după profit. Fiecărei activități îi vom asocia cel mai târziu interval
       de timp disponibil pt a se efectua. Fiecare interval de timp e propriul "părinte"
       inițial. Dacă unei activități îi este asociat un număr t, atunci primește intervalul
       de timp [t-1, t]. Funcția Find va găsi mereu "rădăcina" unui set, adică cel mai
       apropiat interval de timp disponibil. Dacă Find întoarce valoarea 0, atunci nu putem
       adăuga activitatea în listă. Funcția Union unește intervalele de timp.

    Corectitudine:
       Vom demonstra prin inducție, după n, că algoritmul construiește o soluție optimă.
       (Vom folosi ca reper corectitudinea algoritmului Kruskal).
       Pt. n=0, afirmația este evidentă.
       Fie n>=2. Presupunem că algoritmul construiește o soluție optimă pt orice mulțime
       de cel mult n-1 activități. Acum trebuie să demonstrăm că afirmația este adevărată
       și pt n.

       a) Verificăm dacă pasul 1 este corect:
          La primul pas, adăugăm în algoritm activitatea (A1) cu profitul cel mai mare și o
          plasăm în intervalul [t-1, t], unde t este dat în datele de intrare. Dacă presupunem
          că A1 nu aparține soluției optime, avem 2 posibilități:
            1. În intervalul [t-1, t] există o altă activitate. Putem construi o altă soluție
            care să aibă în acel interval de timp pe A1 și atunci noua soluție va fi optimă față
            de cea veche, de unde rezultă contradicția.
            2. În intervalul [t-1, t] nu există nicio activitate. Dacă adăugăm A1, atunci soluția
            nouă este mai bună decât cea veche. -> contradicție
       b) Am presupus că soluția din n-1 activități este corectă. La pasul n, algoritmul caută un
          interval liber de timp pt a insera activitatea de pe poziția n din vectorul sortat descrescător.
          Dacă funcția Find returnează 0, atunci nu există un interval și trecem la activitatea următoare.
          Altfel, (pp că Find returnează numărul t) activitatea este inserată în intervalul [t-1, t] și apoi,
          funcția Union desemnează tata[t]=t-1 (deci marchează ca ocupat acel interval de timp). Ținem cont
          că t-ul selectat va fi mereu cea mai mare valoare posibilă pt a lăsa libere intervalele mai mici
          (unde putem pune activități cu deadlineuri mai apropiate de 0).
          Sau putem demonstra folosind contracția.
*/
#include <iostream>
#include <algorithm>
#include <vector>
using namespace std;

struct job
{
    int nr, p, t;
    //nr=pozitie; p=profit; t=timp
};
int cmp(job A, job B)
{return A.p>B.p;}

class DisjointSet
{
	vector<int> tata;
	vector<int> rank;
public:
	void Init(int maxi)
	{
		tata.resize(maxi+1); rank.resize(maxi+1);
		for(int i=0; i<=maxi; i++)
		{tata[i]=i; rank[i]=0;}
	}

	int Find(int k)
	{
		if(tata[k]!=k) tata[k]=Find(tata[k]);
		return tata[k];
	}

	void Union(int a, int b)
	{
		int x=Find(a), y=Find(b);
		if(x==y) return;
		if(rank[x]>rank[y]) tata[x]=y;
		else if(rank[x]<rank[y]) tata[y]=x;
		     else
             {
                tata[y]=x;
                rank[x]++;
             }
	}

};

int main()
{
    int n, i, maxi=0, s=0;
    cout<<"Nr Activitati: "; cin>>n;
    cout<<"Date de Intrare (profit, deadline): "<<endl;
    vector<job> V; V.resize(n);
    for(i=0; i<n; i++)
    {
        cin>>V[i].p>>V[i].t, V[i].nr=i+1;
        maxi=max(maxi, V[i].t); //deadline-ul maxim
    }
    sort(V.begin(), V.end(), cmp); //sort după profit (descrescător)

    DisjointSet ds;
	ds.Init(maxi);

    cout<<"Activitati: "<<endl;
    for(i=0; i<n; i++)
    {
        int free=ds.Find(V[i].t);
        if(free>0)
        {
            ds.Union(ds.Find(free-1), free);
            s+=V[i].p;
            cout<<V[i].nr<<" ";
        }
    }
    cout<<endl<<"Profit: "<<s<<endl;

    return 0;
}
