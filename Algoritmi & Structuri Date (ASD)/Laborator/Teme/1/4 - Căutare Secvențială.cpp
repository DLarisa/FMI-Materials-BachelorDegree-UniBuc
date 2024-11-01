#include <iostream>
using namespace std;

int main()
{
    int v[100], n, i, k, p=-1;
    //Citire Vector
    cin>>n;
    for(i=0; i<n; i++) cin>>v[i]; // End Citire
    //Citire Element Cautat
    cin>>k;
    //Cautarea Secventiala
    for(i=0; i<n; i++)
        if(k==v[i]) {p=i+1;break;}
    //Afisare Pozitia Elementului daca a fost gasit sau -1 in caz contrar
    cout<<p;

    return 0;
}
