#include <iostream>
using namespace std;

struct domino {int x, y;};

int main()
{
	int i, j, n, maxi=0, nr=0;
	cout << "Nr Piese: "; cin>>n;

	domino a[n];
	int v[n], p[n];
	cout<<"Dati Piesele: "<<endl;
	for(i=0; i<n; i++) cin>>a[i].x>>a[i].y;

	//Initializez Vectori: v->lungime, p->pozitii
	for(i=0; i<n; i++) v[i]=1, p[i]=-1;

	for(i=0; i<n; i++)
		for(j=0; j<i; j++)
			if(a[j].y==a[i].x && 1+v[j]>v[i]) v[i]=1+v[j], p[i]=j;

    //Lungime Maxima Sir
	for(i=0; i<n; i++)
        if(v[i]>maxi) maxi=v[i];

	for(i=0; i<=n; i++)
		if(v[i]==maxi)
		{
			j=i;
			while (j>=0)
			{
				cout<<"("<<a[j].x<<", "<<a[j].y<< ")  ";
				j=p[j];
			}
			cout<<endl; nr++;
		}
    cout<<"Nr Solutii: "<<nr<<endl;

	return 0;
}
