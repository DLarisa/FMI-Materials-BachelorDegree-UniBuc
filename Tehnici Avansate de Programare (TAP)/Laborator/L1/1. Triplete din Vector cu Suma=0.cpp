#include <iostream>
#include <unordered_set>
#include <vector>
#include <algorithm>
#include <string>
using namespace std;

struct triplet
{
    int a, b, c;
};

int main()
{
    //Citire Date
    int n, i, l, r;
    vector<int> V; //Vectorul de numere
    cout<<"Nr elemente Vector: "; cin>>n;
    cout<<"Dati Elementele Vectorului: ";
    for(i=0; i<n; i++)
    {cin>>l; V.push_back(l);}
    //Sortare Vector
    sort(V.begin(), V.end());

    int sum;
    string aux;
    triplet nou; //auxiliar ca sa pot sa bag in vector tripletul gasit
    vector<triplet> Triplete; //vom pune tripletele unice in el
    unordered_set<string> T; //pt a pastra tripletele unice (putem cauta mai usor in el cu string si dupa punem in vector)
    for(i=0; i<n-2; i++)
    {
        l=i+1; r=n-1; //left and right
        while(l<r) //deplasam concomitent capetele
        {
            sum=V[i]+V[l]+V[r];
            if(sum==0) //daca suma=0
            {
                //facem stringul format din triplet
                aux=to_string(V[i])+","+to_string(V[l])+","+to_string(V[r]);
                if(T.find(aux)==T.end()) //daca nu gaseste tripletul
                {
                    //il pot insera si in vectorul de string si invectorul de triplete
                    T.insert(aux);
                    nou.a=V[i]; nou.b=V[l]; nou.c=V[r]; //tripletul nou gasit il punem in vector
                    Triplete.push_back(nou);
                }
                l++, r--; //ne mutam concomitent
            }
            else if(sum>0) r--; //daca suma e mai mare decat 0, ne mutam din dr pt ca vectorul e ordonat
            else l++;
        }
    }

    //Afisare
    if(T.size()==0) cout<<"Nu exista triplete."<<endl;
    else
    {
        for(i=0; i<Triplete.size(); i++)
            cout<<"("<<Triplete[i].a<<", "<<Triplete[i].b<<", "<<Triplete[i].c<<"); ";
        cout<<endl;
    }

    return 0;
}
