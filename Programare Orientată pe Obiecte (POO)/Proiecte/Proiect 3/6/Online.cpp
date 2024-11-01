#include "Online.h"

Online::Online():Farmacie()
{
    this->discount=0.0;
}
Online::Online(char a[], int x, double y):Farmacie(a, x)
{
    this->discount=y;
}
Online::~Online()
{
    this->discount=0.0;
}
Online Online::operator=(const Online &fo)
{
    static_cast<Farmacie&>(*this)=static_cast<Farmacie>(fo);
    this->discount=fo.discount;
    return *this;
}
std::istream& operator>>(std::istream &input, Online &fo)
{
    input >> static_cast<Farmacie&>(fo);
    std::cout << "Dati Discount-ul: ";
    input >> fo.discount;
    std::cin.get(); //pt vectori ca sa ia enter
    return input;
}
std::ostream& operator<<(std::ostream &output, Online &fo)
{
    fo.afisare(output, fo);
    return output;
}
void Online::afisare(std::ostream &output, Online &fo)
{
    output << "Nume Farmacie Online: " << fo.getName() << std::endl;
    output << "Nr de Vizitattori: " << fo.getNr() << std::endl;
    output << "Discount-ul Folosit: " << fo.discount << std::endl;
    std::cout << std::endl;
}
