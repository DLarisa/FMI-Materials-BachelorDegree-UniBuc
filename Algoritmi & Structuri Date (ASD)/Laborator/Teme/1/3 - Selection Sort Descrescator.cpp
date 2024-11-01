#include <iostream>
using namespace std;

int main()
{
    int v[100], n, i, j, pmin;
    //Citire Vector
    cin>>n;
    for(i=0; i<n; i++) cin>>v[i]; // End Citire
    //Selection Sort - Descrescator
    for(i=0; i<n-1; i++)
    {
        pmin=i;
        for(j=i+1;j<n;j++)
            if(v[j]>v[pmin]) pmin=j;
        swap(v[i], v[pmin]);
        //Afisare dupa fiecare pas
        for(j=0;j<n;j++) cout<<v[j]<<" ";
        cout<<endl;
        //End Afisare
    }

    return 0;
}
