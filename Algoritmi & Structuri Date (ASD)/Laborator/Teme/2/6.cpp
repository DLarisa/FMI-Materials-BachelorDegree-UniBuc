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
    i=0;j=0;
    while(i<n && j<m) c[k++]=a[i++]+b[j++];
    while(i<n) c[k++]=a[i++];
    while(j<m) c[k++]=b[j++];
    for(i=0; i<k; i++)
    {
        cout<<c[i]<<"*(x^"<<i<<")";
        if (i != k-1) cout << "+";
    }
    cout<<endl;

    return 0;
}
