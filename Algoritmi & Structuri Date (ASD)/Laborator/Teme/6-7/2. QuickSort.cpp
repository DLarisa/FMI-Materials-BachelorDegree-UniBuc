#include <iostream> //QuickSort
using namespace std;
int v[100], n;
int pozitie(int st, int dr) //Stabilește poziția pivotului
{
	int x = v[dr], i = st, j;
    for (j = st; j <= dr - 1; j++)
        if (v[j] <= x)
        {swap(v[i], v[j]); i++;}

    swap(v[i], v[dr]);
    return i;
}
void quick(int st, int dr)
{
	if (st<dr)
	{
		int i=pozitie(st,dr);
		quick(st, i-1);
		quick(i+1, dr);
	}
}
int main()
{
	int i;
	cout << "n="; cin >> n;
	for (i = 1; i <= n; i++) cin >> v[i];
	quick(1, n);
	for (i = 1; i <= n; i++) cout << v[i] << " ";
	cout << endl;

    return 0;
}
