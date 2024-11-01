#include <iostream> //QuickSelect
using namespace std;
int v[100], n;
int pozitie(int st, int dr) //Stabilește poziția Pivotului --- ca la QuickSort
{
	int x = v[dr], i = st, j;
    for (j = st; j <= dr - 1; j++)
        if (v[j] <= x)
        {swap(v[i], v[j]); i++;}

    swap(v[i], v[dr]);
    return i;
}
int QuickSelect(int st, int dr, int k) //Returneaza al K-lea element din vectorul ordonat
{
    if(st==dr) return v[st];
    int i=pozitie(st, dr), k1=i+st+1;
    if(k1==k) return v[k];
    if(k1>k) return QuickSelect(st,i-1,k);
    else return QuickSelect(i+1,dr,k-k1);
}
int main()
{
	int i, k;
	cout << "Nr Elemente:"; cin >> n;
	for (i = 1; i <= n; i++) cin >> v[i];
	cout << "k:"; cin >> k;
	cout << QuickSelect(0,n,k) << " ";
	cout << endl;

    return 0;
}
