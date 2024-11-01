#include <iostream>
#include <list>
using namespace std;

int main()
{
    int x;
    list <int> L; //lista
    do
    {
        cin>>x;
        if(x%2) L.push_back(x);
        else L.push_front(x);
    }while(x!=0);
    for(int p: L) cout<<p<<" ";
    cout<<endl;
    L.pop_front();
    for(list <int>:: iterator i=L.begin(); i!=L.end(); i++)
        //i merge la urmatorul element din lista
        cout<<*i<<" "; //valoarea de la adresa lui i

    return 0;
}
