#include <iostream>
using namespace std;

int main()
{
    int v[100], n, i, j, aux;
    //Citire Vector
    cin>>n;
    for(i=0; i<n; i++) cin>>v[i]; // End Citire
    //Insertion Sort
    for(i=1; i<n; i++)
    {
        j=i-1; aux=v[i];
        while (j>=0 && v[j]>aux)
        {v[j+1]=v[j]; j--;}
        v[j+1]=aux;
        for(j=0;j<n;j++) cout<<v[j]<<" ";
        cout<<endl;
    }

    return 0;
}
