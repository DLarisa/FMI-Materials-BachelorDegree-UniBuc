#include <iostream> 
using namespace std; 
  
class Parent 
{ 
    public: 
       
    Parent() 
    { 
        cout << "Baza" << endl; 
    } 
}; 
  
class Child : public Parent 
{ 
    public: 
      
    Child() 
    { 
        cout << "Derivat" << endl; 
    } 
}; 
  
int main() { 
       
    Child obj; 
      
    return 0; 
}  
