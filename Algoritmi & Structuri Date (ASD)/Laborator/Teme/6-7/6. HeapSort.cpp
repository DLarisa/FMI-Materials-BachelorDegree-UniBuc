#include <iostream> //HeapSort
using namespace std;

void heap(int v[], int n, int i)
{
    int root=i, st=2*i+1, dr=2*i+2;
    if(st<n && v[st]>v[root]) root=st;
    if(dr<n && v[dr]>v[root]) root=dr;
    if(root!=i)
    {
        swap(v[i], v[root]);
        heap(v, n, root);
    }
}
void HeapSort(int v[], int n)
{
    int i;
    for (i=n/2-1; i>=0; i--) heap(v, n, i);
    for (i=n-1; i>=0; i--)
    {
        swap(v[0], v[i]); //Max de pe Pozitia 0 se pune la final Heap
        heap(v, i, 0);  //Heap pt rest Heap
    }
}

int main()
{
    int n, i, v[100];
    cout<<"Nr Elemente: ";cin>>n;
    for(i=0; i<n; i++) cin>>v[i];
    HeapSort(v, n);
    for(i=0; i<n; i++) cout<<v[i]<<" ";

    return 0;
}
