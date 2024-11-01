#include <iostream>
#include "pereche.h"
#include "multime_pereche.h"
#include "stiva.h"
#include "coada.h"
using namespace std;

void simulare(Coada &c1, Coada c2, int i) //i=1/0--->imi spune daca fac push sau pop
//i=0--->pop  ||  i=1--->push
{
    //Voi Considera c1 ca fiind drept Stiva

    //Push
    //Nu se modifica absolut Nimic... doar adaug Perechea la sfarsitul lui c1
    if(i==1) {c1.push(); return;}
    if(i==0) //Pop
    {
        int k=c1.Get_n();
        if(k==0) return; //daca c1 e Vida, nu avem la ce sa dam pop


        //c2 tb sa fie neapart NULL
        Coada c3; c2=c3;
        Pereche x; //x=perechea ce se elimina din coada
        int j=1; //pt nr de elemente din c1
        while(j!=k) //cat timp x!=ultima pereche din coada
        {
            x=c1.el_pop();
            c2.push(x); //pun el in c2
            c1.pop(); //scot el din c1
            j++;
        }
        //Acum c2 are toate elementele din c1, mai putin ultimul adaugat
        c1=c2; //c1 este stiva
        c2=c3; //c2 redevine NULL
    }
}
int main()
{
    /*
    int n, i;
    cout << "Nr de Obiecte: "; cin >> n;
    Pereche a[100];
    Multime_Pereche mp[100];
    Stiva s[100];
    Coada c[100];
    for(i=0; i<n; i++)
    {
        cout << "Pereche: " << endl; cin >> a[i];
        cout << "Multime_Pereche: " << endl; cin >> mp[i];
        cout << "Stiva: " << endl; cin >> s[i];
        cout << "Coada: " << endl; cin >> c[i];
    }
    for(i=0; i<n; i++) cout<<a[i]<<" ";
    cout<<endl;
    for(i=0; i<n; i++) cout<<mp[i]<<" ";
    cout<<endl;
    for(i=0; i<n; i++) cout<<s[i]<<" ";
    cout<<endl;
    for(i=0; i<n; i++) cout<<c[i]<<" ";
    cout<<endl;
    */

    /*
    Pereche x(1, 2);
    Multime_Pereche mp; cin>>mp; cout<<mp<<endl;
    Stiva s, s1; s.push(x); cout<<s<<endl<<s1<<endl;
    Coada c; c.push(); c.push(); c.push(); c.pop(); c.pop(); c.push(); cout<<c;
    */

    /*
    Coada c1, c2; cin>>c1;
    simulare(c1, c2, 0);
    simulare(c1, c2, 1);
    simulare(c1, c2, 1);
    simulare(c1, c2, 1);
    simulare(c1, c2, 0);
    cout<<c1;
    */

    //Coada s; s.el_pop();

    return 0;
}
