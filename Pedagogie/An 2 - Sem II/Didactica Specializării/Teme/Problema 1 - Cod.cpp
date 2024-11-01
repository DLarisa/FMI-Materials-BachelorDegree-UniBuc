#include <iostream>
#include <algorithm>
#include <vector>
#include <math.h>
using namespace std;

//Afisare Vector
void afisare(vector<double> A)
{
    for(int i=0; i<A.size(); i++) cout<<A[i]<<" ";
    cout<<endl;
}

int main()
{
    //Pas 1: Citire date de Intrare
    int n, i; //n = nr de elemente ale vectorului
    cout<<"Dati nr de elemente: "; cin>>n;
    if(n<3) {cout<<"Dati mai mult de 3 numere!"; return 0;}

    double mini, maxi, aux;
    vector<double> A; //Sirul nostru
    A.resize(n); cout<<"Dati elementele sirului: ";
    for(i=0; i<n; i++) cin>>A[i]; //Citire Elemente ale Sirului A


    ///Subpunct a)
    //Pas 2: Identificarea minimului si maximului
    mini=min(A[0], A[1]);
    for(i=2; i<n; i++) mini=min(mini, A[i]);
    maxi=max(A[0], A[1]);
    for(i=2; i<n; i++) maxi=max(maxi, A[i]);
    //Pas 3: Verificare cazuri degenerate + Afisare
    cout<<"Subpunct a: "<<endl;
    if(mini*maxi<0) cout<<"Nu se poate calcula radicalul unui numar negativ."<<endl;
    else afisare(A);


    ///Subpunct b)
    for(i=1; i<n-1; i++)
        if(A[i]==0) A[i]=sqrt(abs(A[i-1]*A[i+1]));
    cout<<"Subpunct b: "<<endl;
    afisare(A);


    return 0;
}
