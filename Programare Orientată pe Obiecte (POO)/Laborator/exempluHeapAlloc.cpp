#include <iostream>
#include <string>

using namespace std;

class Vector
{
public: 
    static int counter;
    int size;
    int *elements;

    Vector(int, int);
    void pushback(int);
    void Resize(int);
};

int Vector::counter = 0;

void Vector::pushback(int value)
{
    size++;
    //Resize(size);
    elements[size-1]=value;
}

Vector::Vector(int number, int value)
{
    counter++;

    size=number;
    elements=new int[size];

    int i;
    for(i=0; i<size; i++)
        elements[i]=value;

    cout<<"Vector number "<<counter<<" has been created."<<endl;
}

void Vector::Resize(int newsize)
{
    int *vcopy=new int[size];
    int i;

    for(i=0; i<size; i++)
        vcopy[i]=elements[i];

    elements=new int[newsize];

    for(i=0; i<size; i++)
        elements[i]=vcopy[i];

    delete[] vcopy;
    size=newsize;
}

int main()
{
    Vector vector(5, 1);
    for(int i=5; i < 20000; i++)
    {
        vector.pushback(i);
        cout << vector.elements[i] << endl;
    }
}
