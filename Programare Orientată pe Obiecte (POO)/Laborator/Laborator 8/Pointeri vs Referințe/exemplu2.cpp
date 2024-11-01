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
	
	//printPointer(i); // Compilatorul da eroare pentru ca (int) nu se converteste natural la (int*).
	printRef(i); // Referintele sunt vazute ca si alias la o variabila, deci merge.
	printInt(i); // Cazul normal.
	
	printPointer(ptr); // Cazul normal.
	//printRef(ptr); // Iar nu merge...referintele sunt vazute tot ca (int), pentru ca sunt un alias.
	//printInt(ptr); // Evident, printPointer(int) nu merge, deci nici acesta nu merge.
	
	// printPointer(ref); // printRef(ptr) nu merge, deci nici invers nu merge.
	printRef(ref); // Cazul normal.
	printInt(ref); // Evident, merge, pentru ca si printRef(i) merge.
}
