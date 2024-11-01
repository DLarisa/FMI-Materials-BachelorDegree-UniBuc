#include <iostream>

using namespace std; 
  
class A { 
  public: 
    void fun() 
    { cout<<"\n A::fun() called ";} 
}; 
  
class B: public A { 
  public:  
    void fun()  
    { cout<<"\n B::fun() called "; }       
}; 
  
int main() 
{ 
   B b; 
   A *a = &b;
   a->fun(); 
   return 0; 
} 
