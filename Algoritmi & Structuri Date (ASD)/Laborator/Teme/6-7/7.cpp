#include <iostream>
using namespace std;
#define MAXIM 1000
int v[MAXIM], n;
void ShiftUp(int n)
{
    if (n==MAXIM)
    {
        cout << "Overflow: Nu se poate insera.";
        return;
    }
    int parinte, aux;
    if(n!=1)
    {
        parinte=n/2;
        if(v[parinte]>v[n])
        {
            swap(v[parinte],v[n]);
            ShiftUp(parinte);
        }
    }
}
void ins(int k)
{
   n++; v[n]=k; ShiftUp(n);
}
void MinHeapify(int i)
{
    int st=2*i, dr=2*i+1, mini=i;
    if(st<n && v[st]<v[i]) mini=st;
    if(dr<n && v[dr]<v[mini]) mini=dr;
    if(mini!=i)
    {
        swap(v[i], v[mini]);
        MinHeapify(mini);
    }
}
int extras()
{
    if(n<=0) return MAXIM;
    if(n==2)
    {
        n--;
        return v[1];
    }
    int root=v[1];
    v[1]=v[n];
    n--;
    MinHeapify(1);
    return root;
}

int main()
{
    int i;
    ins(2);ins(16);ins(74);ins(58);ins(36);ins(4);ins(28);
    ins(15);ins(35);ins(82);ins(6);
    cout<<extras()<<" "<<extras()<<" "<<extras()<<" "<<extras()<<" "<<extras()<<" "<<extras()<<" "<<endl;
    cout<<extras()<<" "<<extras()<<" "<<extras()<<" "<<extras()<<" "<<extras();

    return 0;
}
