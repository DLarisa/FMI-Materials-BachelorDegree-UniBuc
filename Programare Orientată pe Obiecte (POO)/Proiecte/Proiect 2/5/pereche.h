#ifndef PERECHE_H_INCLUDED
#define PERECHE_H_INCLUDED

#include <iostream>
using namespace std;
class Pereche
{
    int prim, doi; //prim=nr 1; doi=nr 2
public:
    Pereche(); //Constructor
    Pereche(int, int); //Constructor Parametrii
    virtual ~Pereche(); //Destructor
    Pereche(const Pereche &p); //Constructor Copiere
    friend std::istream& operator>>(std::istream &input, Pereche &p) //Functie Citire
    {
        cout << "Da-ti Valori pt o Pereche: ";
        input >> p.prim >> p.doi;
        return input;
    }
    friend std::ostream& operator<<(std::ostream &output, const Pereche &p) //Functia Afisare
    {
        output << "(" << p.prim << "," << p.doi << ")" << endl;
        return output;
    }
    Pereche operator=(const Pereche &p); //Supraincarcare =
    friend class Multime_Pereche;
};
Pereche::Pereche() //Constructor
{
    prim=0; doi=0;
    //cout << "Constructor pt Pereche" << endl;
}
Pereche:: Pereche(int x, int y) //Constructor Parametrii
{
    prim=x; doi=y;
}
Pereche::~Pereche() //Destructor
{
    //cout << "Destructor pt Pereche" << endl;
}
Pereche::Pereche(const Pereche &p) //Constructor Copiere
{
    prim=p.prim; doi=p.doi;
}
Pereche Pereche::operator=(const Pereche &p) //Supraincarcare =
{
    prim=p.prim; doi=p.doi;
    return *this;
}

#endif // PERECHE_H_INCLUDED
