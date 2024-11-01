#include <iostream>
#include <vector>
using namespace std;

int main()
{

    int i, j, l, n, k, vectors[100][100], prev[100][100];
    bool t[100][100];

    cout<<"Nr de Vectori: "; cin>>n;
    cout<<"Numarul k: "; cin>>k;

    int sizes[n];
    for(i=0; i<n; i++)
    {
        cout<<"Dimensiune Vector "<<i+1<<": "; cin>>sizes[i];
        cout<<"Elemente Vector: ";
        for(j=0; j<sizes[i]; j++) cin>>vectors[i][j];
    }

    // t[0][elementDinPrimulVector]=true ; prev[0][analog]=-1;
    for(j=0; j<sizes[0]; j++)
    {
        t[0][vectors[0][j]]=true;
        prev[0][vectors[0][j]]=-1;
    }

    //Pentru fiecare vector
    for(i=0; i<n-1; i++)
        for(j=0; j<sizes[i+1]; j++) //Pentru fiecare element din vector
            for(l=0; l<k; l++) //parcurgem primele k pozitii
                if(t[i][l]==true)
                {
                    t[i+1][l+vectors[i+1][j]]=true;
                    prev[i+1][l+vectors[i+1][j]]=vectors[i+1][j];
                }

    if(t[n-1][k]==true)
    {
        i=n-1;
        while(i>0)
        {
            cout<<prev[i][k]<<' ';
            k=k-prev[i][k];
            i--;
        }
        if(prev[i][k]==-1) cout<<k;
    }
    else cout<<0;

    return 0;

}
