#include <iostream> //MergeSort
using namespace std;
void interclasare(int a[], int st, int m, int dr)
{
	int c[100], i = st, j = m + 1, k = -1;
	while (i <= m && j <= dr)
		if (a[i] < a[j]) c[++k] = a[i++];
		else c[++k] = a[j++];
	while (i <= m) c[++k] = a[i++];
	while (j <= dr) c[++k] = a[j++];
	for (i = 0; i <= k; i++) a[st + i] = c[i];
}
void Msort(int a[], int st, int dr)
{
	int m = st + (dr - st) / 2;
	if (st < dr)
	{
		Msort(a, st, m);
		Msort(a, m + 1, dr);
		interclasare(a, st, m, dr);
	}
}

int main()
{
	int a[100], n, i, k;
	cout << "Nr de elemente="; cin >> n;
	for (i = 0; i < n; i++) { cin >> k; a[i] = k; }
	Msort(a, 0, n - 1);
	for (i = 0; i < n; i++) cout << a[i] << " ";
	cout << endl;

    return 0;
}
