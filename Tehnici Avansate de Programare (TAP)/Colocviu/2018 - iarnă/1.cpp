#include <iostream>
#include <fstream>
#include <algorithm>
using namespace std;

int main()
{
    int n, m , i, j, sfinal;

    ifstream fin("in.txt");
    fin>>n>>m>>sfinal;
    int M[n][m], S[n][m];
    for(i=0; i<n; i++)
        for(j=0; j<m; j++) fin>>M[i][j];
    fin.close();

    //M-> originala; S->a mea
    S[0][m-1]=M[0][m-1];
    for(j=m-2; j>=0; j--) S[0][j]=M[0][j]+S[0][j+1];
    for(i=1; i<=n-1; i++) S[i][m-1]=M[i][m-1]+S[i-1][m-1];

    for(i=1; i<n; i++)
        for(j=m-2; j>=0; j--)
            S[i][j]=max(S[i-1][j]+M[i][j], S[i][j+1]+M[i][j]);

    int rez=S[n-1][0], mini=rez;
    i=n-1, j=0;
    cout<<"Drum Inversat: ";
    while(S[i][j]!=S[0][m-1])
    {
        cout<<M[i][j]<<" ";
        ((S[i][j]-M[i][j])==S[i][j+1]) ? j=j+1 : i=i-1;
        mini=min(mini, S[i][j]);
    }
    cout<<S[i][j]<<endl;

    cout<<"Smin: ";
    if(mini<0) mini*=(-1);
    if(rez+mini<sfinal) cout<<sfinal<<endl;
    else cout<<mini+1<<endl;


    return 0;
}
