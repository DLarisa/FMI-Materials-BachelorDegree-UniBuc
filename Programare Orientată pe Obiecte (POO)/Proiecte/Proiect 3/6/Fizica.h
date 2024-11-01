#ifndef FIZICA_H
#define FIZICA_H
#include "Farmacie.h"

class Fizica: virtual public Farmacie
{
    int profit[12]; //profitul in ultimele 12 luni
    virtual void afisare(std::ostream &output, Fizica &ff);
public:
    Fizica(); //Constructor
    Fizica(char*, int, int*); //Constructor Parametrizat
    ~Fizica(); //Destructor
    Fizica operator=(const Fizica &ff); //Overload =
    friend std::istream& operator>>(std::istream &input, Fizica &ff); //Citire
    friend std::ostream& operator<<(std::ostream &output, Fizica &ff); //Afisare
};

#endif // FIZICA_H
