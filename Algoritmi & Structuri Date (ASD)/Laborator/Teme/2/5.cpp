#include <iostream>
#include <math.h>
using namespace std;

int main()
{
    int v[100], n, t, i, nr=0;
    //Citire Vector
    cin>>n; n++;
    for(i=0; i<n; i++) cin>>v[i]; // End Citire
    cin>>t; //Citire t
    for(i=0; i<n; i++) nr=nr+v[i]*(pow(t,i));
    cout<<nr;

    return 0;
}
