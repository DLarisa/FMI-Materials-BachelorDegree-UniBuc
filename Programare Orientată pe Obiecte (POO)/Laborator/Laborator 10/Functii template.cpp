#include <iostream>
using namespace std;

// Functiile template ne permit sa lucram cu tipuri generice, adica ne permit sa
// cream o functie a carei functionalitate poate fi adaptata usor la mai mult de
// un tip fara sa rescriem codul pentru fiecare tip.

// Sintaxa pentru declararea de functii template este:

// template <class identifier> function_declaration;
// template <typename identifier> function_declaration;

// Desi folosesc doua cuvinte cheie diferite, comportamentul lor este identic, atat
// intern cat si la executie.

template <class T> // template <typename T> este echivalent.
T GetMax(T a, T b)
{
	T result;
	result = (a>b) ? a : b;
	return (result);
}

// Apelam aceasta functie template in urmatorul mod:

// GetMax<int>(x,y);

// Dar putem apela si direct GetMax(x,y); pentru se poate afla in mod
// automat tipul de date cu care este chemata functia template.

// Cand compilatorul ajunge la un apel de functie template, acesta va folosi template-ul
// sau sablonul pentru a genera o functie in care va inlocui fiecare aparatie a lui T cu
// tipul de date dat ca parametru in apelul catre functia template, in acest caz "int".

int main ()
{
	int i=5, j=6, k;
	long long l=10, m=5, n;
	k=GetMax<int>(i,j);
	n=GetMax(l,m);
	cout << k << endl;
	cout << n << endl;
	return 0;
}

// Apelam in main functia pe doi intregi si pe doi long long, o data in modul explicit cand
// dam tipul ca parametru si o data in modul implicit cand lasam compilatorul sa deducam tipul.
// Totul merge bine, dar acum incercati sa schimbati parametrii celor doua apeluri.
// Chemati apelul explicit cu un int si un long long si apelul implicit la fel. Ce observati?

///////////////////////////////////////////////////////////////////////////////////////////////

// Acum sa vedem ce se intampla cu tipurile compuse.
// Ce observati la acest apel al lui GetMax?

class A
{
public:
	int a;
	int b;
	A() { a = 2; b = 3; }
};

int main ()
{
	A a1, a2, a3;
	a2.a = 5;
    	a3 = GetMax(a2, a3);
	cout << a3.a << " " << a3.b << endl;
	return 0;
}

// Hai sa adaugam operatorul de comparare in corpul clasei A.
friend bool operator> (const A &a1, const A &a2)
{
	return a1.a + a1.b > a2.a + a2.b;
}

////////////////////////////////////////////////////////////////////////////////////////////////

// Putem sa dam mai multi parametri intr-o functie template. De exemplu urmatoarea functie GetMin():

template <class T, class U>
T GetMin (T a, U b)
{
  return (a<b?a:b);
}

// Aceasta functie compara doua tipuri diferite de date si returneaza o variabila de tip T. Acum putem face un apel de
// genul urmator:

int main ()
{
	int i, j= 200;
	long l = 500;
	i = GetMin<int, long>(j,l);
	cout << i;
}

// Putem chiar sa apelam GetMin(j,l).
// Chiar daca tipurile de date sunt diferite, compilatorul poate sa isi dea seama de instantierea corecta oricum.
