#include <iostream> //O(n*log n)
using namespace std;

//Imbina 2 vectori sortati si returneaza nr de inversiuni din ei
int merge(int v[], int aux[], int st, int mij, int dr)
{
    //i=indice pt subvector stang; j=indice pt subarbore drept; k=indice pt vectorul rezultat din imbinare
    int i=st, j=mij, k=st, nr=0;

    while((i<=mij-1) && (j<=dr))
        if(v[i]<=2*v[j]) aux[k++]=v[i++];
        else           aux[k++]=v[j++], nr+=(mij-i);

    //Copiez restul de elemente(daca mai sunt) din subvectorul stang in aux
    while(i<=mij-1) aux[k++]=v[i++];
    //Copiez restul de elemente(daca mai sunt) din subvectorul drept in aux
    while(j<=dr)    aux[k++]=v[j++];

    //Copiez din aux(unde avem imbinarea) in vectorul initial
    for(i=st; i<=dr; i++)  v[i]=aux[i];

    return nr;
}
//Functie Recursiva care sorteaza vectorul si intoarce nr de inversiuni din el
int mergeSort(int v[], int aux[], int st, int dr)
{
    int mij, nr=0;
    if(dr>st)
    {
        mij=(dr+st)/2;

        nr=mergeSort(v, aux, st, mij);
        nr+=mergeSort(v, aux, mij+1, dr);
        nr+=merge(v, aux, st, mij+1, dr);
    }
    return nr;
}

int main()
{
    int n, i;
    cout<<"Nr Elemente: "; cin>> n;
    int *v=new int[n], *aux=new int[n];
    cout<<"Dati Elementele Vectorului: ";
    for(i=0; i<n; i++) cin>>v[i];

    cout<<"Nr Inversiuni Semnificative: "<<mergeSort(v, aux, 0, n-1);

    return 0;
}
