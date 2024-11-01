#include <iostream>
using namespace std;

int main()
{
    int v[100], n, i, sortat;
    //Citire Vector
    cin>>n;
    for(i=0; i<n; i++) cin>>v[i]; // End Citire
    //Bubble Sort
    do
    {
        sortat=0; //Verifica daca se realizeaza interschimbari
        for(i=0; i<n-1; i++)
            if(v[i]>v[i+1])
            {
                swap(v[i],v[i+1]);sortat=1;
                //Afisare Pasi Sortare
                for(i=0; i<n; i++) cout<<v[i]<<" ";
                cout<<endl;  //End Afisare
            }

    }while(sortat>0);

    return 0;
}
