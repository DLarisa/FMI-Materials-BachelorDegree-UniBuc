#ifndef FARMACIE_H
#define FARMACIE_H
#include <iostream>

class Farmacie
{
    char nume[50]; //nume sau adresa web
    int nr; //nr angajati sau nr vizitatori
    virtual void afisare(std::ostream &output, Farmacie &f);
public:
    Farmacie(); //Constructor
    Farmacie(char*, int); //Constructor Parametrizat
    virtual ~Farmacie(); //Destructor
    Farmacie operator=(const Farmacie &f); //Overload =
    friend std::istream& operator>>(std::istream &input, Farmacie &f); //Citire
    friend std::ostream& operator<<(std::ostream &output, Farmacie &f); //Afisare
    char *getName(); //Iau numele
    int getNr(); //Iau nr
};

#endif // FARMACIE_H
