// Putem de asemenea sa facem clase ce au membri template.

template <class T>
class mypair 
{
    T values [2];
  public:
    mypair (T first, T second)
    {
      values[0]=first; 
      values[1]=second;
    }
};

// Clasa asta va tine doua elemente de orice tip valid. 

// Exemple de utilizare:
mypair<int> myobject (115, 36); 
mypair<double> myfloats (3.0, 2.18); 

// Daca vrem sa definim corpul unei metode in afara clasei si nu inline, trebuie 
// sa specificam din nou partea de template<...>

#include <iostream>
using namespace std;

template <class T>
class mypair 
{
    T a, b;
  public:
	mypair (T first, T second)
	{
		a=first; 
		b=second;
	}
    T getmax ();
};

// Ca sa nu ne incurcam intre atatia T, primul este parametrul template-ului adica int, double sau alta clasa,
// al doilea este tipul de return si al treilea specifica faptul ca parametrul template al acestei functii este acelasi
// cu cel al clasei.
template <class T>
T mypair<T>::getmax ()
{
  T retval;
  retval = a>b? a : b;
  return retval;
}

int main () {
  mypair <int> myobject (100, 75);
  cout << myobject.getmax();
  return 0;
}	
