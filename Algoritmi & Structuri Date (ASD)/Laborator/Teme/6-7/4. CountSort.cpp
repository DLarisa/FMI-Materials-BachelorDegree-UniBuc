#include <iostream> //CountSort
using namespace std;

int v[100],i[1000],fin[100],n;
void CS(int maxi)
{
    int j;
    for(j=0;j<n;j++) i[v[j]]++;
    for(j=1;j<=maxi;j++)
      i[j]+=i[j-1];
    for(j=0;j<n;j++)
    {
        fin[i[v[j]]-1]=v[j];
        i[v[j]]--;
    }

}
int main()
{
    int i, maxi=0;
    cout<<"Nr Elemente: ";cin>>n;
    for(i=0;i<n;i++)
    {
        cin>>v[i];
        if(maxi<v[i]) maxi=v[i];
    }
    CS(maxi);
    for(i=0;i<n;i++) cout<<fin[i]<<" ";

    return 0;
}
