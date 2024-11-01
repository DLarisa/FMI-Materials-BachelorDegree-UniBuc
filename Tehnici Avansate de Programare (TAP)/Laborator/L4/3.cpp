#include <iostream>
#include <string.h>
#include <iomanip>
#include <algorithm>
using namespace std;
char a[50], b[50];
int n, m, d[50][50];
void afisare(int n, int m)
{
	if (n > 0 && m > 0)
	{
		if (d[n][m] == 1 + d[n - 1][m])
		{
			afisare(n - 1, m);
			cout << "eliminare " << a[n - 1] << endl;
		}
		else
			if (d[n][m] == 1 + d[n][m - 1])
			{
				afisare(n, m - 1);
				cout << "insereaza " << b[m - 1] << " pe pozitia " << m - 1 << endl;
			}
			else
				if (a[n - 1] != b[m - 1] && d[n][m] == 1 + d[n - 1][m - 1])
				{
					afisare(n - 1, m - 1);
					cout << "inlocuire " << a[n - 1] << " cu " << b[m - 1] << endl;
				}
				else
					if (a[n - 1] == b[m - 1] && d[n][m] == d[n - 1][m - 1])
						afisare(n - 1, m - 1);
	}
	else
		if (m > 0)
			cout << "insereaza " << b[m - 1] << " pe pozitia " << m - 1 << endl;
		else
			if (n > 0) cout << "eliminare " << a[n - 1] << endl;
}
int main()
{
	int i, j;
	cout << "Cuvantul 1: "; cin.get(a, 50); cin.get();
	cout << "Cuvantul 2: "; cin.get(b, 50); cin.get();
	n = strlen(a);
	m = strlen(b);
	for (j = 0; j <= m; j++) d[0][j] = j;
	for (i = 0; i <= n; i++) d[i][0] = i;
	for (i = 1; i <= n; i++)
		for (j = 1; j <= m; j++)
		{
			d[i][j] = min(1 + d[i - 1][j], 1 + d[i][j - 1]);
			if (a[i - 1] == b[j - 1])
				d[i][j] = min(d[i - 1][j - 1], d[i][j]);
			else
				d[i][j] = min(1 + d[i - 1][j - 1], d[i][j]);
		}
	for (i = 0; i <= n; i++)
	{
		for (j = 0; j <= m; j++) cout << setw(3) << d[i][j];
		cout << endl;
	}
	afisare(n, m);
	cout<<"Distanta L: "<<d[n][m]<<endl;

	return 0;
}
