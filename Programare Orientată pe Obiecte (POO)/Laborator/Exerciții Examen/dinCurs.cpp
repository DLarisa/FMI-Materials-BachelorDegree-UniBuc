1.

#include <iostream>
using namespace std;

class problema
{  
    int i;
public: 
    problema (int j=5) {i=j;}
    void schimba() {i++;}
    void afiseaza() {cout<<"starea curenta "<<i<<"\n";}
};

problema mister1() { return problema(6); }

void mister2(problema &o) 
{  
    o.afiseaza(); 
    o.schimba(); 
    o.afiseaza();
}

int main()
{  
    mister2(mister1()); 
    return 0;
}

2.

#include<iostream>

class B
{ int i;
  public: B() { std::cout << "B"; i=1; }
  virtual int get_i() { return i; } 
};
          
class D: virtual public B
{ int j;
  public: D() { std::cout << "D"; j=2; }
  int get_i() {return B::get_i()+j; } 
};
          
class D2: virtual public B
{ int j2;
  public: D2() { std::cout << "D2"; j2=3; }
  int get_i() {return B::get_i()+j2; } 
};
  
class MM: public D, public D2
{ int x;
  public: MM() {std::cout << "MM" << std::endl; x=D::get_i()+D2::get_i(); }
  int get_i() {return x; } 
};
  
int main()
{ 
  B *o= new MM();
  std::cout<<o->get_i()<<"\n";
  MM *p= dynamic_cast<MM*>(o);
  if (p) std::cout<<p->get_i()<<"\n";
  D *p2= dynamic_cast<D*>(o);
  if (p2) std::cout<<p2->get_i()<<"\n";
  return 0;
}

3.

#include<iostream>
template<class T, class U>
T f(T x, U y)
{ 
	return x+y;
}

int f(int x, int y)
{ 
	return x-y;
}

int main()
{ 
  int *a=new int(3), b(23);
  std::cout<<*f(a,b);
  return 0;
}
