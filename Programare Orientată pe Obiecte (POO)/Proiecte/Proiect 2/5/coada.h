#ifndef COADA_H_INCLUDED
#define COADA_H_INCLUDED

#include <iostream>
#include "pereche.h"
#include "multime_pereche.h"
using namespace std;
class Coada: public Multime_Pereche
{

public:
    Coada():Multime_Pereche(){}; //Constructor
    Coada(int x, Pereche *p):Multime_Pereche(x, p){};// Constructor cu Parametrii
    ~Coada(){}; //Destructor
    Coada(const Coada &c):Multime_Pereche(c){}; //Constructor Copiere
    friend istream& operator>>(istream &input, Coada &c) //Functie Citire
    {
        input >> static_cast<Multime_Pereche&>(c);
        return input;
    }
    friend ostream& operator<<(ostream &output, Coada &c) //Functie Afisare
    {
        output << static_cast<Multime_Pereche&>(c);
        return output;
    }
    Coada operator=(const Coada &c) //Supraincarcare =
    {
        Multime_Pereche::operator=(c);
        return *this;
    }
    /*
    sau pot folosi:
    using Multime_Pereche::operator=;
    */
    using Multime_Pereche::push; //Adaugare In Coada cu Parametru
    Coada push(); //Adaugare In Coada fara Parametru
    Coada pop(); //Pop element Coada
    Pereche el_pop(); //Returneaza Perechea eliminata (cea mai veche adaugata)
};
Coada Coada::push() //Add2
{
    Pereche aux; cin>>aux;
    Multime_Pereche::push(aux);
    return *this;
}
Coada Coada::pop() //Stergere din Coada (primul element adaugat)
{
    Multime_Pereche::pop(Multime_Pereche::first());
    return *this;
}
Pereche Coada::el_pop()
{
    return Multime_Pereche::el_pop(Multime_Pereche::first());
}

#endif // COADA_H_INCLUDED
