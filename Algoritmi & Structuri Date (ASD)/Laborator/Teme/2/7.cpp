#include <iostream>
#include <math.h>
using namespace std;
int c[100];
int main()
{
    int a[100], b[100], n, m, i, j, k=0;
    //Citire Vector 1
    cin>>n; n++;
    for(i=0; i<n; i++) cin>>a[i]; // End Citire
    //Citire Vector 2
    cin>>m; m++;
    for(i=0; i<m; i++) cin>>b[i]; // End Citire
    k=n+m-1; //Nr Elemente nou Polinom
    for(i=0;i<n;i++)
        for(j=0;j<m;j++) c[i+j]=c[i+j]+a[i]*b[j];
    //Calcul Polinom unde i+j->putere si (c[i+j]+a[i]*b[j])->coeficient
    for(i=0;i<k;i++) //Afisare Polinom Rezultat
    {
        cout<<c[i]<<"*(x^"<<i<<")";
        if (i != k-1) cout << "+";
    }

    return 0;
}
