#include <iostream>
using namespace std;
//Subprogram pentru inserarea unui element din vector
void ins(int v[], int &n, int p, int a[], int t)
{
    int i,j=0;
    for(i=n+t-1;i>p+t;i--) v[i]=v[i-t];
    n+=t;
    for(i=p+1;i<=p+t;i++) v[i]=a[j++];
}
int main()
{
    int v[100], a[100], t, n, k, i, j, aux;
    //Citire Vector Initial
    cin>>n; aux=n;
    for(i=0; i<n; i++) cin>>v[i]; // End Citire
    //Citire Vector Adaugat
    cin>>t;
    for(i=0; i<t; i++) cin>>a[i]; // End Citire
    //Citire Numar Cautat
    cin>>k; //End Citire
    for(i=0; i<n; i++)
        if(v[i]==k) {ins(v,n,i,a,t);break;}
    //Afisare daca nu exista elementul k in Vector
    if(aux==n) cout<<"Nu exista elementul "<<k<<endl;
    else //Altfel
        for(i=0;i<n;i++) cout<<v[i]<<" ";
    cout<<endl;

    return 0;
}
