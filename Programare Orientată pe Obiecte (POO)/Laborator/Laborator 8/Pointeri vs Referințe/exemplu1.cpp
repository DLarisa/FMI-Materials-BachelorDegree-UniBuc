#include<iostream>

using namespace std;

void printPointer(int *pInteger)
{
	cout << *pInteger;
}

void printRef(int &refInteger)
{
	cout << refInteger;
}

void printInt(int integer)
{
	cout << integer;
}

int main() 
{	
	int i = 4;
	
	// Pointer ce tine adresa lui i.
	int *ptr = &i;
	
	// Referinta (sau alias) pentru i.
	int &ref = i;
	
	printPointer(i); 
	printRef(i); 
	printInt(i); 
	
	printPointer(ptr); 
	printRef(ptr); 
	printInt(ptr); 
	
	printPointer(ref); 
	printRef(ref); 
	printInt(ref);
}
