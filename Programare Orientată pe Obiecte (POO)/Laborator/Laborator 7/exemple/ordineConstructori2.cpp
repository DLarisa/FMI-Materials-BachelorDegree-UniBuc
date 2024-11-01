#include <iostream> 
using namespace std; 
  
class Mama 
{ 
    public: 
       
    Mama() 
    { 
        cout << "Mama" << endl; 
    } 
}; 

class Tata 
{ 
    public: 
       
    Tata() 
    { 
        cout << "Tata" << endl; 
    } 
}; 
  
class Copil : public Mama, Tata 
{ 
    public: 
      
    Copil() 
    { 
        cout << "Copil" << endl; 
    } 
}; 
  
int main() { 
       
    Copil obj; 
      
    return 0; 
}  
