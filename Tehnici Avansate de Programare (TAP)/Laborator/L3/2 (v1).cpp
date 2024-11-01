#include <iostream> //O(n*log n)
#include <vector>
#include <unordered_map> //Inserarea, Stergerea si Cautarea -> O(1) on average
using namespace std;

struct nod //structura nod
{
    int info;
    nod *st, *dr;
};
nod *nou(int info) //se creaza un nod nou
{
    nod *n=new nod;
    n->info=info;
    n->dr=n->st=NULL;
    return n;
}
//Construieste recursiv arborele
nod *tree(vector<int> I, vector<int> P, int I_Start, int I_End, int *id, unordered_map<int, int> &mp)
{
    if(I_Start>I_End) return NULL;

    /*Nod curent din traversarea in postordine folosind indexul id si scade valoarea lui id*/
    int poz=P[*id];
    nod *Nod_Nou=nou(poz);
    (*id)--;

    /*Daca acest nod nu are copii, returneaza*/
    if(I_Start==I_End) return Nod_Nou;

    /*Altfel gaseste pozitia acestui nod in traversarea in Inordine*/
    int I_poz=mp[poz];

    /*Folosind I_poz, construiesc subarborele stang si pe cel drept*/
    Nod_Nou->dr=tree(I, P, I_poz+1, I_End, id, mp);
    Nod_Nou->st=tree(I, P, I_Start, I_poz-1, id, mp);

    return Nod_Nou;
}
//Construieste un unordered_map si cheama functia de mai sus
//Pt ca folosim unordered_map, avem complexitate buna
nod *construieste(vector<int> I, vector<int> P, int n)
{
    // Punem toti indexii din inordine ca sa ii putem gasi rapid ulterior
    unordered_map<int, int> mp;
    for(int i=0; i<n; i++) mp[I[i]]=i;
    int index=n-1; //Index in postordine - ultimul nod din postordine e radacina
    return tree(I, P, 0, n-1, &index, mp);
}
int Nr_nod(nod *radacina) //numara nodurile din arbore - pt cazul cand avem eroare
{
    int nr=1;
    if(radacina->st!=NULL) nr+=Nr_nod(radacina->st);
    if(radacina->dr!=NULL) nr+=Nr_nod(radacina->dr);
    return nr;
}
void Preordine(nod *Nod) //Afisare Preordine
{
    if(Nod==NULL) return;
    cout<<Nod->info<<" ";
    Preordine(Nod->st);
    Preordine(Nod->dr);
}
void Inordine(nod *Nod) //Afisare Inordine
{
    if(Nod==NULL) return;
    Inordine(Nod->st);
    cout<<Nod->info<<" ";
    Inordine(Nod->dr);
}
void Postordine(nod *Nod) //Afisare Postordine
{
    if(Nod==NULL) return;
    Postordine(Nod->st);
    Postordine(Nod->dr);
    cout<<Nod->info<<" ";
}

int main()
{
    int n, i;
    cout<<"Nr Elemente: "; cin>>n;
    vector<int> P; P.resize(n);
    vector<int> I; I.resize(n);
    cout<<"Dati Valori Postordine: ";
    for(i=0; i<n; i++) cin>>P[i];
    cout<<"Dati Valori Inordine: ";
    for(i=0; i<n; i++) cin>>I[i];

    nod *radacina=construieste(I, P, n);
    if(Nr_nod(radacina)!=n) cout<<"Nu."<<endl;
    else
    {
        Preordine(radacina); cout<<endl;
        Inordine(radacina); cout<<endl;
        Postordine(radacina); cout<<endl;
    }

    return 0;

}
