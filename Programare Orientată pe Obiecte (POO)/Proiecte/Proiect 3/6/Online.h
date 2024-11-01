#ifndef ONLINE_H
#define ONLINE_H
#include <Farmacie.h>

class Online : public Farmacie
{
    double discount; //discount
    virtual void afisare(std::ostream &output, Online &fo);
public:
    Online(); //Constructor
    Online(char*, int, double); //Constructor Parametrizat
    ~Online(); //Destructor
    Online operator=(const Online &fo); //Overload =
    friend std::istream& operator>>(std::istream &input, Online &fo); //Citire
    friend std::ostream& operator<<(std::ostream &output, Online &fo); //Afisare
};

#endif // ONLINE_H
