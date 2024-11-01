#include <iostream> //O(log(min(n, m)))
#include <algorithm>
using namespace std;

//Mediana dintre 2 vectori (n=lungime a <= m=lungime b)
double mediana(int a[], int b[], int n, int m) //O(log(n))
{
    int a_min=0, a_max=n, l=(n+m+1)/2, i, j;
    while(a_min<=a_max) //mereu se va injumatati vectorul cu lungime cea mai mica
    {
        i=(a_min+a_max)/2;
        j=l-i;
        if(i<a_max && b[j-1]>a[i])  a_min=i+1; // i prea mic - mediana se va afla in jumatatea superioara a lui a
        else if(i>a_min && a[i-1]>b[j])  a_max=i-1; // i prea mare - mediana se va afla in jumatatea inferioara a lui a
             else
             { // i perfect
                int maxi_st;
                if(i==0)       maxi_st=b[j-1];
                else if(j==0)  maxi_st=a[i-1];
                     else      maxi_st=max(a[i-1], b[j-1]);
                if((n+m)%2==1) return maxi_st; //daca avem nr total de elemente impar

                int min_dr;
                if(i==n)       min_dr=b[j];
                else if(j==m)  min_dr=a[i];
                     else      min_dr=min(b[j], a[i]);

                return (maxi_st+min_dr)/2.0; //daca avem nr total de elemente nr par
            }
    }

    return 0.0;
}

int main()
{
    int n, m, i;
    cout<<"N: "; cin>>n;
    cout<<"Dati valori a: ";
    int *a=new int[n];
    for(i=0; i<n; i++) cin>>a[i];
    cout<<"M: "; cin>>m;
    cout<<"Dati valori b: ";
    int *b=new int[m];
    for(i=0; i<m; i++) cin>>b[i];

    //Ma asigur ca am pe prima pozitie vectorul cu nr minim de elemente
    if(n<m) cout<<mediana(a, b, n, m)<<endl;
    else cout<<mediana(b, a, m, n)<<endl;

    return 0;
}
