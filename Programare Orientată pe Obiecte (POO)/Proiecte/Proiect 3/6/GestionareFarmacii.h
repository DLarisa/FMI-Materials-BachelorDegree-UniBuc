#ifndef GESTIONAREFARMACII_H_INCLUDED
#define GESTIONAREFARMACII_H_INCLUDED
#include "Farmacie.h"
#include "Fizica.h"
#include "Online.h"
#include <iostream>
#include <vector>
#include <typeinfo>
using namespace std;

template <class TipFarmacie>
class GestionareFarmacii
{
    vector <TipFarmacie*> v;
    static int index;
    static const int id;
public:
    GestionareFarmacii(); //Constructor
    ~GestionareFarmacii(); //Destructor
    void operator+=(const TipFarmacie &f); //Overload +=
    void print();
};
template <class TipFarmacie> int GestionareFarmacii<TipFarmacie>::index=0;
template <> int const GestionareFarmacii<Fizica>::id=1070;
template <> int const GestionareFarmacii<Farmacie>::id=1000;

template <class TipFarmacie>
GestionareFarmacii<TipFarmacie>::GestionareFarmacii()
{
    index=0;
}
template <class TipFarmacie>
GestionareFarmacii<TipFarmacie>::~GestionareFarmacii()
{
    this->v.clear();
    index=0;
}
template <class TipFarmacie>
void GestionareFarmacii<TipFarmacie>::operator +=(const TipFarmacie &f)
{
    TipFarmacie *aux= new TipFarmacie(f);
    v.push_back(aux); index++;
}
template <class TipFarmacie>
void GestionareFarmacii<TipFarmacie>::print()
{
    if(typeid(TipFarmacie)==typeid(Fizica)) cout<< endl << "Lant Farmacii Fizice: ";
    else cout<<"Lant Farmacii: ";
    cout << id << endl;
    cout << "Nr de Farmacii din Lant: " << index << endl;
    int i;
    cout << endl << "Farmaciile: " << endl;
    for(i=0; i<v.size(); i++)
        cout << i+1 << ": " << endl << *(v[i]) << endl;
}

// ************************************* SPECIALIZARE
template <>
class GestionareFarmacii<Online>
{
    vector <Online*> v;
    static int index;
    static const int id=1079;
public:
    GestionareFarmacii()
    {

    }
    ~GestionareFarmacii()
    {
        this->v.clear();
        index=0;
    }
    void operator+=(Online &f)
    {
        Online *aux= new Online(f);
        v.push_back(aux); index++;
    }
    void print()
    {
        Online a;
        cout << endl << "Nr Total de Vizitatori: ";
        int i, s=0;
        for(i=0; i<v.size(); i++)
        {a=*(v[i]); s+=a.getNr();}
        cout<<s;
    }
};
template<> int GestionareFarmacii<Online>::index=0;



#endif // GESTIONAREFARMACII_H_INCLUDED
