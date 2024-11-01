#include<iostream>

class Nod //final
{
protected:
    char value;
    Nod* next;
public:
    Nod()
    {
        std::cout << "Constructor Nod" << std::endl;
        value = ' ';
        next = NULL;
    }
    
    virtual ~Nod()
    {
    	std::cout << "Destructor Nod" << std::endl;
    }

    Nod* getNext()
    {
        return next;
    }
   
    void setNext(Nod* nod)
    {
        next = nod;
    }
    
    virtual void metodaMostenitaCeAfiseaza() //final
    {
        std::cout << "Clasa Nod" << std::endl;
    }
};

class Nod_dublu : public Nod
{
public:
    Nod_dublu() : Nod ()
    {
        std::cout << "Constructor Nod_dublu" << std::endl;
        ante = NULL;
    }    
    
    virtual ~Nod_dublu()
    {
    	std::cout << "Destructor Nod_dublu" << std::endl;
    }
protected:
    Nod* ante;
};

class Nod_prioritate : public Nod_dublu 
{
public:
    Nod_prioritate(int prio) : Nod_dublu ()
    {
        std::cout << "Constructor Nod_prioritate" << std::endl;
        this->prio = prio;
    }
    
    ~Nod_prioritate()
    {
    	std::cout << "Destructor Nod_prioritate" << std::endl;
        Nod_prioritate* current = this;
        while(current != NULL) 
        {
            Nod_prioritate* next = dynamic_cast<Nod_prioritate*>(current->next);
            current = next;
            delete current;
        }
    }
    
    int getPrio()
    {
        return prio;
    }
    
    virtual void metodaMostenitaCeAfiseaza() override
    {
        std::cout << "Clasa Nod_Prioritate" << std::endl;
    }
private:
    int prio;
};

int main()
{
    Nod_prioritate* head = new Nod_prioritate(1);
    head->setNext(new Nod_prioritate(2));
    
    std::cout << std::endl;
    
    // Downcasting safe.
    // Nod_prioritate* prioNod = (Nod_prioritate*)head->getNext(); 
    Nod_prioritate* prioNod = dynamic_cast<Nod_prioritate*>(head->getNext()); 
    
    if (prioNod)
    	std::cout << "Valoare prio: " << prioNod->getPrio() << std::endl; 
    
    // Downcasting unsafe.
    prioNod = (Nod_prioritate*)(new Nod);
    
    if (prioNod)
	    std::cout << "Valoare prio: " << prioNod->getPrio() << std::endl; 
    
    // prioNod este pointer la Nod_prioritate, dar va chema destructorul lui Nod.
    delete prioNod;
    
    std::cout << std::endl;
    
    // Upcasting. Nu cere cast explicit sau dinamic_cast.
    Nod* pointerNod = head;
    pointerNod->metodaMostenitaCeAfiseaza();
    
    std::cout << std::endl;
    
    // Distrugere in masa a listei.
    delete head;
}
