#include <iostream> //RadixSort - Original
using namespace std;

int v[1000],fin[1000],n;
int cifre(int n)
{if(n) return 1+cifre(n/10);}
void CS(int p) //Folosim CountSort
{
    int j, aux, i[10]={0};
    for(j=0;j<n;j++)
    {
        aux=(v[j]/p)%10;
        i[aux]++;
    }
    for(j=1;j<=9;j++)
      i[j]+=i[j-1];
    for(j=n-1;j>=0;j--)
    {
        aux=(v[j]/p)%10;
        fin[i[aux]-1]=v[j];
        i[aux]--;
    }
    for(j=0;j<n;j++) v[j]=fin[j]; //Punem in Vectorul Initial Vaux dupa fiecare Pas
}
void radix(int nr)
{
    int i, p=1;
    for(i=0;i<nr;i++)
    {CS(p);p*=10;}
}
int main()
{
    int i, nr=0, aux;
    cout<<"Nr Elemente: ";cin>>n;
    for(i=0;i<n;i++)
    {
        cin>>v[i];
        aux=cifre(v[i]);
        if(nr<aux) nr=aux;
    }
    radix(nr);
    for(i=0;i<n;i++) cout<<v[i]<<" ";

    return 0;
}
