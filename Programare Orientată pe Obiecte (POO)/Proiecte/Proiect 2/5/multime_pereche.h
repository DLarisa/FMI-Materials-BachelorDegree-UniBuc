#ifndef MULTIME_PERECHE_H_INCLUDED
#define MULTIME_PERECHE_H_INCLUDED

#include <iostream>
#include <new>
#include "pereche.h"
using namespace std;
class Multime_Pereche
{
    int n;
    Pereche *p;
public:
    Multime_Pereche(); //Constructor
    Multime_Pereche(int, Pereche*); //Constructor Parametrii
    virtual ~Multime_Pereche(); //Destructor
    Multime_Pereche(const Multime_Pereche &mp); //Constructor Copiere
    friend std::istream& operator>>(std::istream &input, Multime_Pereche &mp) //Functie Citire
    {
        cout << "Nr de perechi: ";
        input >> mp.n;
        try
        {
            mp.p=new Pereche[mp.n];
        }catch(bad_alloc xa)
        {
            cout << "Alocare Nereusita" << endl;
            exit(EXIT_FAILURE);
        }
        for(int i=0; i<mp.n; i++) input >> mp.p[i];
        return input;
    }
    friend std::ostream& operator<<(std::ostream &output, Multime_Pereche &mp) //Functie Afisare
    {
        for(int i=0; i<mp.n; i++) output << mp.p[i];
        if(mp.n==0) cout << "Multime Vida" << endl;
        return output;
    }
    Multime_Pereche operator=(const Multime_Pereche &mp); //Supraincarcare =
    virtual Multime_Pereche push(const Pereche a); //Adaugare Pereche in Multime
    virtual Multime_Pereche pop(int i); //Stergere Pereche din Multime
    virtual Pereche el_pop(int i); //Returneaza Perechea eliminata de pe pozitia i
    int last(); //Pozitie Pereche Adaugata Ultima
    int first(); //Pozitite Pereche Adaugata Prima
    Get_n() const; //Pt Functia cu 2 Cozi ca sa Aflu Lungimea Cozii
};
Multime_Pereche::Multime_Pereche() //Constructor
{
    n=0; p=NULL;
    //cout << "Constructor Multime_Pereche" <<endl;
}
Multime_Pereche::Multime_Pereche(int x, Pereche *y) //Constructor Parametrii
{
    n=x;
    try
    {
        p=new Pereche[n];
    }catch(bad_alloc xa)
    {
        cout << "Alocare Nereusita" << endl;
        exit(EXIT_FAILURE);
    }
    for(int i=0; i<n; i++) p[i]=y[i];
}
Multime_Pereche::~Multime_Pereche() //Destructor
{
    n=0;
    delete []p;
    //cout << "Destructor Multime_Pereche" << endl;
}
Multime_Pereche::Multime_Pereche(const Multime_Pereche &mp) //Constructor Copiere
{
    n=mp.n;
    try
    {
        p=new Pereche[n];
    }catch(bad_alloc xa)
    {
        cout << "Alocare Nereusita" << endl;
        exit(EXIT_FAILURE);
    }
    for(int i=0; i<n; i++) p[i]=mp.p[i];
}
Multime_Pereche Multime_Pereche::operator=(const Multime_Pereche &mp) //Supraincarcare =
{
    n=mp.n;
    try
    {
        p=new Pereche[n];
    }catch(bad_alloc xa)
    {
        cout << "Alocare Nereusita" << endl;
        exit(EXIT_FAILURE);
    }
    for(int i=0; i<n; i++) p[i]=mp.p[i];
    return *this;
}
Multime_Pereche Multime_Pereche::push(const Pereche a) //Adugare Pereche in Multime
{
    if(this->n==0)
    {
        this->n++;
        try
        {
            this->p=new Pereche[this->n];
        }catch(bad_alloc xa)
        {
            cout << "Alocare Nereusita" << endl;
            exit(EXIT_FAILURE);
        }
        this->p[0]=a; return *this;
    }
    Multime_Pereche aux(this->n+1, this->p);
    aux.p[aux.n-1]=a;
    *this=aux;
    return *this;
}
Multime_Pereche Multime_Pereche::pop(int i) //Stergere Pereche de pe Pozitia i
{
    if(this->n==0) {delete []this->p; return *this;}
    Multime_Pereche aux(this->n, this->p);
    for(int j=i; j<aux.n-1; j++) aux.p[j]=aux.p[j+1];
    aux.n--;
    *this=aux;
    return *this;
}
Pereche Multime_Pereche::el_pop(int i)
{
    if(this->n==0)
    {
        cout<<"Multime vida. Nu pot Elimina nicio Pereche."<<endl;
        Pereche x; return x;
    }
    cout<<"Elementul Eliminat: "<<this->p[i]<<endl;
    return this->p[i];
}
int Multime_Pereche::last() //Pozitie Pereche Adaugata Ultima
{
    return this->n-1;
}
int Multime_Pereche::first() //Pozitie Pereche Adaugata Prima
{
    return 0;
}
int Multime_Pereche::Get_n() const
{
    return this->n;
}


#endif // MULTIME_PERECHE_H_INCLUDED
