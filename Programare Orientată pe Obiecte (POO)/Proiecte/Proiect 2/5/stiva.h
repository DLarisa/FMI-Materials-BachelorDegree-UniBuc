#ifndef STIVA_H_INCLUDED
#define STIVA_H_INCLUDED

#include <iostream>
#include "pereche.h"
#include "multime_pereche.h"
using namespace std;
class Stiva: public Multime_Pereche
{

public:
    Stiva():Multime_Pereche(){}; //Constructor
    Stiva(int x, Pereche *p):Multime_Pereche(x, p){};// Constructor cu Parametrii
    ~Stiva(){}; //Destructor
    Stiva(const Stiva &s):Multime_Pereche(s){}; //Constructor Copiere
    friend istream& operator>>(istream &input, Stiva &s) //Functie Citire
    {
        input >> static_cast<Multime_Pereche&>(s);
        return input;
    }
    friend ostream& operator<<(ostream &output, Stiva &s) //Functie Afisare
    {
        output << static_cast<Multime_Pereche&>(s);
        return output;
    }
    using Multime_Pereche::operator=;
    using Multime_Pereche::push; //Adaugare In Stiva cu Parametru
    Stiva push(); //Adaugare In Stiva fara Parametru
    Stiva pop(); //Pop element Stiva
    Pereche el_pop(); //Returneaza Perechea eliminata din varf Stiva
};
Stiva Stiva::push() //Add2
{
    Pereche aux; cin>>aux;
    Multime_Pereche::push(aux);
    return *this;
}
Stiva Stiva::pop() //Stergere din Stiva (ultimul element adaugat)
{
    Multime_Pereche::pop(Multime_Pereche::last());
    return *this;
}
Pereche Stiva::el_pop()
{
    return Multime_Pereche::el_pop(Multime_Pereche::last());
}

#endif // STIVA_H_INCLUDED
