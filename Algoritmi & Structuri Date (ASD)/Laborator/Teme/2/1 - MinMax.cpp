#include <iostream>
using namespace std;

int main()
{
    int v[100], n, i, mini, maxi, m1, m2, aux;
    //Citire Vector
    cin>>n;
    for(i=0; i<n; i++) cin>>v[i]; // End Citire
    //Initializam minimul ;i maximul cu ultimul element
    m1=m2=v[n-1];
    //Daca nr de elemente e par sau impar
    if(n%2) aux=n-1;
    else aux=n;
    //Gasire min/max luand elementele sub forma de perechi
    for(i=0; i<aux-1; i=i+2)
    {
        if(v[i]>v[i+1]) mini=v[i+1],maxi=v[i];
        else mini=v[i],maxi=v[i+1];
        if(m1>mini) m1=mini;
        if(m2<maxi) m2=maxi;
    }
    //Afisare
    cout<<m1<<" "<<m2<<endl;

    return 0;
}
