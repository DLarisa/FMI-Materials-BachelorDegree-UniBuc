#include <iostream>
using namespace std;

int main()
{
    int v[100], n, i, aux;
    //Citire Vector
    cin>>n;
    for(i=0; i<n; i++) cin>>v[i]; // End Citire
    aux=v[0];
    for(i=1; i<n; i++) aux=aux^v[i]; //Operatii pe biti
    cout<<aux<<endl;

    return 0;
}
