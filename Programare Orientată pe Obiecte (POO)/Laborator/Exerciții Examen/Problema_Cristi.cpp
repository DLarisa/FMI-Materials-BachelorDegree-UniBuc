#include<iostream>

using namespace std;

// Analizati codul urmator.
// 1. Codul acesta are erori de compilare. Care sunt acelea? Corectati aceste erori
// fara sa stergeti ceva din clase in nici un fel (puteti adauga).
// In main puteti doar sterge (nu puteti adauga).
// 2. Ce afiseaza programul?
// 3. Functia main are niste memory leak-uri. Care sunt acelea?

class A
{
public:
	static int contor;

	A()
	{
		cout << "Constructor A" << endl;
		contor++;
	}

	~A()
	{
		cout << "Destructor A" << endl;
		contor++;
	}

	void DoSomething()
	{
		cout << "A doing something" << endl;
		contor++;
	}

	virtual void DoNothing() = 0; //pt toate clasele derivate tb sa suprascriem
};

int A::contor = 0;

class B : public A
{
public:
	B()
	{
		cout << "Constructor B" << endl;
		contor++;
	}

	~B()
	{
		cout << "Destructor B" << endl;
		contor++;
	}

	void DoSomething() //aici tb virtual
	{
		cout << "B doing something" << endl;
		contor++;
	}
};

class C : public B
{
public:
	C()
	{
		cout << "Constructor C" << endl;
		contor++;
	}

	~C()
	{
		cout << "Destructor C" << endl;
		contor++;
	}

	void DoNothing()
	{
		cout << "C doing nothing" << endl;
		contor++;
	}
};

int main ()
{
	A* pAA = new A; //eroare ca e clasa abstracta
	A* pAB = new B;
	B* pBC = new C;

	pAA->DoNothing(); //nu exista pt ca stergem linia de mai sus
	pAB->DoNothing();
	pBC->DoSomething();

	delete pBC;
	//memory leak pt ca nu am virtual destructor
	//memory leak pt ca nu am delete pAB
	cout << "Contor:" << A::contor << endl;
}
