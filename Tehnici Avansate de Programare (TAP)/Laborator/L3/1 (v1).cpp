#include <iostream>
#include <vector>
using namespace std;

int binar(vector<int> V, int st, int dr) //O(log N) -> cautare binara
{
    if(dr>=st)
    {
        int m=st+(dr-st)/2;
        if(V[m]==m) return m;
        if(V[m]>m) return binar(V, st, m-1);
        return binar(V, m+1, dr);
    }
    return -1;
}
int main()
{
    int n, i;
    cout<<"Nr Elemente: "; cin>>n;
    vector<int> A; A.resize(n);
    cout<<"Dati Valori: ";
    for(i=0; i<n; i++) cin>>A[i]; //O(n) -> citire

    i=binar(A, 0, n-1);
    if(i==-1)  cout<<"Nu exista."<<endl;
    else cout<<i<<endl;

    return 0;

}
