#include <iostream>
#include <algorithm>
#include <vector>
using namespace std;

int main()
{
    int i, j, n, m;

    cout<<"Tabla Sah (n, m): "; cin>>n>>m;
    int t[n][m];
    cout<<"Elemente Tabla: ";
    for(i=0; i<n; i++)
        for(j=0; j<m; j++) cin>>t[i][j];

    //matrice de valori maxime
    int val_max[100][100];
    //matrice succesor
    int succ[100][100];
    //initializam valoarea maxima cu primul element din matrice
    val_max[0][0]=t[0][0];


    //OBS : ROBOTUL SE POATE DEPLASA DOAR IN JOS SAU IN DREAPTA --> :
    //Pornim cu a doua linie si a doua coloana in calculum sumelor partiale
    //valoarea maxima de pe o linie este valoarea elementului curent + valoarea elementului de deasupra
    for(i=1; i<n; i++)
        val_max[i][0]=t[i][0]+val_max[i-1][0];


    //valoarea maxima de pe o coloana este valoarea elementului curent + valoarea elementului din stanga
    for(j=1; j<m; j++)
        val_max[0][j]=t[0][j]+val_max[0][j-1];

    //Daca valoarea maxima este mai mare pe linie, mergem in dreapta, altfel mergem in stanga
    if(val_max[0][1]>=val_max[1][0]) succ[0][0]=0;
    else   succ[0][0]=1;

    //parcurgem matricea si comparam valorile maxime ( pentru cazul in care mergem in dreapta sau in jos)
    for(i=1; i<n; i++)
        for(j=1; j<m; j++)
            if(val_max[i-1][j]>=val_max[i][j-1])
            {
                val_max[i][j]=val_max[i-1][j]+t[i][j];
                succ[i-1][j]=1;
            }
            else
            {
                val_max[i][j]=val_max[i][j-1]+t[i][j];
                succ[i][j]=0;
            }



    succ[n-1][m-1]=-1, i=0, j=0;
    while(succ[i][j]!=-1)
    {
        cout<<i+1<<' '<<j+1<<endl;
        if(succ[i][j]==0) j++;
        else i++;
    }
    cout<<i+1<<' '<<j+1<<endl;
    cout<<"Valoarea totala este: "<<val_max[i][j];

     return 0;
}
