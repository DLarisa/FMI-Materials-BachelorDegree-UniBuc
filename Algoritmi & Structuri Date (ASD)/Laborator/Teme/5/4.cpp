#include <iostream>
using namespace std;
struct nod
{
    int info;
    nod *next;
};
void afisare(nod *p)
{
	if (p)
	{
		cout << p->info << " ";
		afisare(p->next);
	}
}
nod *ins(nod *L, int x)
{
	nod *p = new nod;
	p->info = x;
	p->next = L;
}
nod *lista()
{
	nod *L = new nod;
	int x; cin >> x;
	if (x) L = ins(lista(), x);
	else L = NULL;
}
nod *insert1(nod *L, int x)
{
	if (!L || x<L->info)
		L = ins(L, x);
	else
		L->next = insert1(L->next, x);
	return L;
}
nod *interclasare(nod *L1, nod *L2)
{
	if (L2)
	{
		insert1(L1, L2->info);
		interclasare(L1, L2->next);
	}
	return L2;
}


int main()
{
    nod *a, *b; a = b = NULL;
	cout << "Lista1: "; a = lista();
	cout << "Lista2: "; b = lista();
	interclasare(a, b); cout << endl;
	afisare(a); cout << endl;

    return 0;
}
