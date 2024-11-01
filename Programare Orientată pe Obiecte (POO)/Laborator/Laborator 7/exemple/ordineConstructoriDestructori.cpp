#include <iostream> 
using namespace std; 
  
class Mama 
{ 
    public: 
       
    Mama() 
    { 
        cout << "constructor Mama" << endl; 
    } 

    ~Mama() 
    { 
        cout << "destructor Mama" << endl; 
    } 
}; 

class Tata 
{ 
    public: 
       
    Tata() 
    { 
        cout << "constructor Tata" << endl; 
    } 

    ~Tata() 
    { 
        cout << "destructor Tata" << endl; 
    } 
}; 
  
class Copil : public Mama, Tata 
{ 
    public: 
      
    Copil() 
    { 
        cout << "constructor Copil" << endl; 
    } 

    ~Copil() 
    { 
        cout << "destructor Copil" << endl; 
    } 
}; 
  
int main() { 
       
    Copil obj; 
      
    return 0; 
}  
