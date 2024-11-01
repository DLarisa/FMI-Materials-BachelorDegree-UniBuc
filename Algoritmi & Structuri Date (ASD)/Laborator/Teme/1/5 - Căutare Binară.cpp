#include <iostream>
using namespace std;

int main()
{
    int v[100], n, i, k, p=-1, s=0, d, m;
    //Citire Vector
    cin>>n; d=n-1;
    for(i=0; i<n; i++) cin>>v[i]; // End Citire
    //Citire Element Cautat
    cin>>k;
    //Cautarea Binara
    while(s<=d)
    {
        m=(s+d)/2;  //Mijlocul
        if(k==v[m]) {p=m+1;break;}  //Gasit
        else if(k<v[m]) d=m-1;   //Elementul e mai mic decat mijlocul
        else s=m+1;  //Elementul e mai mare decat mijlocul
    }
    //Afisare pozitia elementului cautat sau -1 daca nu exista in lista
    cout<<p;

    return 0;
}
