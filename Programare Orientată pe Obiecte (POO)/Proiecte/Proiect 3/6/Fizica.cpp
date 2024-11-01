#include "Fizica.h"

void numeLuni(int i)
{
    switch(i+1)
    {
        case 1: std::cout << "Ianuarie: "; break;
        case 2: std::cout << "Februarie: "; break;
        case 3: std::cout << "Martie: "; break;
        case 4: std::cout << "Aprilie: "; break;
        case 5: std::cout << "Mai: "; break;
        case 6: std::cout << "Iunie: "; break;
        case 7: std::cout << "Iulie: "; break;
        case 8: std::cout << "August: "; break;
        case 9: std::cout << "Septembrie: "; break;
        case 10: std::cout << "Octombrie: "; break;
        case 11: std::cout << "Noiembrie: "; break;
        case 12: std::cout << "Decembrie: "; break;
    }
}

Fizica::Fizica():Farmacie()
{
    for(int i=0; i<12; i++) this->profit[i]=0;
}
Fizica::Fizica(char a[], int x, int y[]):Farmacie(a, x)
{
    for(int i=0; i<12; i++) this->profit[i]=y[i];
}
Fizica::~Fizica()
{
    for(int i=0; i<12; i++) this->profit[i]=0;
}
Fizica Fizica::operator=(const Fizica &ff)
{
    static_cast<Farmacie&>(*this)=static_cast<Farmacie>(ff);
    for(int i=0; i<12; i++) this->profit[i]=ff.profit[i];
    return *this;
}
std::istream& operator>>(std::istream &input, Fizica &ff)
{
    input >> static_cast<Farmacie&>(ff);
    std::cout << "Dati Profitul pt Fiecare Luna: " << std::endl;
    for(int i=0; i<12; i++)
    {
        numeLuni(i);
        input >> ff.profit[i];
    }
    std::cin.get(); //pt vectori ca sa ia enter
    return input;
}
std::ostream& operator<<(std::ostream &output, Fizica &ff)
{
    ff.afisare(output, ff);
    return output;
}
void Fizica::afisare(std::ostream &output, Fizica &ff)
{
    output << "Nume Farmacie Fizica: " << ff.getName() << std::endl;
    output << "Nr de Angajati: " << ff.getNr() << std::endl;
    output << "Profitul in Ultimele 12 Luni: " << std::endl;
    for(int i=0; i<12; i++)
    {numeLuni(i); std::cout << ff.profit[i] << std::endl;}
}
