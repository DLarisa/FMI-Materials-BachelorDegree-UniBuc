// Daca vrem sa definim o anumita implementare pentru un template cand un anumit tip de date
// se preteaza pentru o abordare specifica, putem declara o specializare a acelui template.

// Un exemplu bun este daca avem o clasa de tip container ce tine un singur element si are o
// metoda increase(). A incrementa o variabila este un concept oarecum diferit pentru diferite tipuri de date.
// Sa zicem ca pentru char nu vrem sa incrementam valoarea din tabelul ASCII cu 1. Daca input-ul este o litera
// mica atunci vrem ca litera mica sa devina litera mare.

#include <iostream>
using namespace std;

template <class T>
class mycontainer 
{
    T element;
  public:
    mycontainer (T arg) 
	{
		element=arg;
	}
	
    T increase () {return ++element;}
};

template <>
class mycontainer <char> 
{
    char element;
public:
	mycontainer (char arg) 
	{
		element=arg;
	}
	char uppercase ()
	{
		if ((element>='a')&&(element<='z'))
			element+='A'-'a';
		return element;
	}
};

int main () 
{
	mycontainer<int> myint (7);
	mycontainer<char> mychar ('j');
	cout << myint.increase() << endl;
	cout << mychar.uppercase() << endl;
	return 0;
}

// Deci sintaxa pentru o specializare este template <> class mycontainer <char> { ... };
// Prima oara, trebuie sa punem un template <> gol. Aceasta sintaxa specifica faptul ca urmeaza o specializare.
// Apoi urmeaza parametrul pentru care scriem specializarea. Observati diferenta de sintaxa intre definitia 
// unei clase template si definitia unei specializari:

// template <class T> class mycontainer { ... };
// template <> class mycontainer <char> { ... };

// Nota importanta: cand definim o specializare, trebuie sa definim fiecare membru, chiar si cei care erau
// de acelasi tip cu cel pentru care scriem specializarea. Practic nu se mosteneste nimic din template-ul general
// catre specializare.
