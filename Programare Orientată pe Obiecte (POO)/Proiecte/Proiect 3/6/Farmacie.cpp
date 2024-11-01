#include "Farmacie.h"
#include <string.h>

Farmacie::Farmacie()
{
    this->nume[0]='\0';
    this->nr=0;
}
Farmacie::Farmacie(char a[], int x)
{
    strcpy(this->nume, a);
    this->nr=x;
}
Farmacie::~Farmacie()
{
    delete []this->nume;
    this->nume[0]='\0';
    this->nr=0;
}
Farmacie Farmacie::operator=(const Farmacie &f)
{
    strcpy(this->nume, f.nume);
    this->nr=f.nr;
    return *this;
}
std::istream& operator>>(std::istream &input, Farmacie &f)
{
    std::cout << "Dati Nume/Adresa Farmacie: ";
    input.getline(f.nume, 50);
    std::cout << "Dati Nr Angajati/Vizitatori Farmacie: ";
    input >> f.nr;
    std::cin.get(); //ca sa iau enter pt vectori
    return input;
}
std::ostream& operator<<(std::ostream &output, Farmacie &f)
{
    f.afisare(output, f);
    return output;
}
void Farmacie::afisare(std::ostream &output, Farmacie &f)
{
    output << "Nume Farmacie: " << f.getName() << std::endl;
    output << "Nr de Angajati: " << f.getNr() << std::endl;
}
char* Farmacie::getName()
{
    return nume;
}
int Farmacie::getNr()
{
    return nr;
}
