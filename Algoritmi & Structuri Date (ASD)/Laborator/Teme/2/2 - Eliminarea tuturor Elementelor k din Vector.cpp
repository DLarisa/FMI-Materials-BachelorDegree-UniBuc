#include <iostream>
using namespace std;
//Subprogram pentru eliminarea unui element din vector
void sters(int v[], int &n, int p)
{
    int i;
    for(i=p;i<n;i++) v[i]=v[i+1];
    n--;
}
int main()
{
    int v[100], n, k, i, j, aux;
    //Citire Vector
    cin>>n; aux=n;
    for(i=0; i<n; i++) cin>>v[i]; // End Citire
    //Citire Numar Cautat
    cin>>k; //End Citire
    for(i=0; i<n; )
        if(v[i]==k)
        {
            sters(v,n,i);
            //Afisare dupa fiecare eliminare
            for(j=0; j<n; j++) cout<<v[j]<<" ";
            cout<<endl; //End Afisare
        }
        else i++;
    //Afisare daca nu exista elementul k in lista
    if(aux==n) cout<<"Nu exista elementul "<<k<<endl;

    return 0;
}
