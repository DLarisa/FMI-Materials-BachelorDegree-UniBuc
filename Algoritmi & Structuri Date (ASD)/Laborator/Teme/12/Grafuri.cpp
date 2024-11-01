 #include <iostream>
 #include <fstream>
using namespace std;
int a[100][100], viz[100], v[100], prim=1, ultim=1;
int grad(int i, int n) //Grad Nod
{
    int nr=0;
    for(int j=1; j<=n; j++)
        if(a[i][j]) nr++;
    return nr;
}
void maxgrad(int n)
{
    int i, maxi=0, aux;
    for(i=1; i<=n; i++)
    {
        aux=grad(i, n);
        if(maxi<aux) maxi=aux;
    }
    for(i=1; i<=n; i++)
        if(grad(i, n)==maxi) cout<<i<<" ";
}
int nr_muchii(int n)
{
    int i, j, nr=0;
    for(i-1; i<=n; i++)
        for(j=1; j<=i; j++)
            if(a[i][j]) nr++;
    return nr;
}
void DFS(int nod, int n)
{
	cout<<nod<<" "; viz[nod]=1;
	for(int k=1; k<=n; k++)
		if(a[nod][k]==1 && viz[k]==0) DFS(k, n);
}
void BFS(int n)
{
	int k, varf;
	if(prim<=ultim)
	{
		varf=v[prim];
		for(k=1; k<=n; k++)
			if(a[varf][k]==1 && viz[k]==0)
            {
				ultim++;
				v[ultim]=k;
				viz[k]=1;
			}
		prim++;
		BFS(n);
	}
}


int main()
{
    int x, y, n, i, j;
    ifstream f("graf.txt");
    f>>n; //nr noduri
    while(f>>x>>y) a[x][y]=1;
    f.close();
    for(i=1; i<=n; i++)
    {
        for(j=1; j<=n; j++) cout<<a[i][j]<<" ";
        cout<<endl;
    }
    cout<<endl;
    for(i=1; i<=n; i++)
    {
        cout<<i<<": ";
        for(j=1; j<=n; j++)
            if(a[i][j]) cout<<j<<", ";
        cout<<endl;
    }
    cout<<endl<<grad(3, n);
    cout<<endl; maxgrad(n);
    cout<<endl<<nr_muchii(n)<<endl;
    int nod; cout<<"De la ce Varf Incepe DFS: "; cin>>nod;
    //DFS(nod, n);
    v[1]=nod;
    BFS(n);
    for(i=1; i<=ultim; i++)  cout<<v[i]<<" ";


    return 0;
}
