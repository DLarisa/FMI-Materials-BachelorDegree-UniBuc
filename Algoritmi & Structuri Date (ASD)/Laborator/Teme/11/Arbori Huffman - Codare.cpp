#include <iostream> //Arbori Huffman
#include <string.h>
using namespace std;

struct MinHeapNod
{
    char info;
    int frecventa;
    MinHeapNod *st, *dr;
};
struct MinHeap
{
    int nr_noduri;
    int capacitate;
    MinHeapNod **vector;
};
MinHeapNod *nod_nou(char informatie, int val)
{
    MinHeapNod *aux=new MinHeapNod;
    aux->st=aux->dr=NULL;
    aux->info=informatie;
    aux->frecventa=val;
    return aux;
}
MinHeap *MinHeap_Void(int marime)
{
    MinHeap *arb=new MinHeap;
    arb->nr_noduri=0;
    arb->capacitate=marime;
    arb->vector=
        (MinHeapNod**)malloc(arb->capacitate*sizeof(MinHeapNod*));
    return arb;
}
void minHeapify(MinHeap *arb, int index)
{
    int mini=index;
    int st=2*index+1, dr=2*index+2;
    if(st<arb->nr_noduri &&
       arb->vector[st]->frecventa<arb->vector[mini]->frecventa)
        mini=st;
    if(dr<arb->nr_noduri &&
       arb->vector[dr]->frecventa<arb->vector[mini]->frecventa)
        mini=dr;
    if(mini!=index)
    {
        swap(arb->vector[mini], arb->vector[index]);
        minHeapify(arb, mini);
    }
}
MinHeapNod *minim(MinHeap *arb)
{
    MinHeapNod *aux=arb->vector[0];
    arb->vector[0]=arb->vector[arb->nr_noduri-1];
    --arb->nr_noduri;
    minHeapify(arb, 0);
    return aux;
}
void ins_MinHeap(MinHeap *arb, MinHeapNod *nod)
{
    ++arb->nr_noduri;
    int i=arb->nr_noduri-1;
    while(i && nod->frecventa<arb->vector[(i - 1) / 2]->frecventa)
    {
        arb->vector[i]=arb->vector[(i-1)/2];
        i=(i-1)/2;
    }
    arb->vector[i]=nod;
}
void buildMinHeap(MinHeap *arb)
{

    int n=arb->nr_noduri-1;
    for(int i=(n-1)/2; i>=0; --i)
        minHeapify(arb, i);
}
void afisare(int v[], int n)
{
    for(int i=0; i<n; ++i) cout<< v[i];
    cout<<endl;
}
int frunza(MinHeapNod *radacina)
{
    return !(radacina->st) && !(radacina->dr);
}
MinHeap *creaza_MinHeap(char info[], int frecventa[], int nr)
{
    MinHeap *minHeap=MinHeap_Void(nr);
    for(int i=0; i<nr; ++i)
        minHeap->vector[i]=nod_nou(info[i], frecventa[i]);
    minHeap->nr_noduri=nr;
    buildMinHeap(minHeap);
    return minHeap;
}
MinHeapNod *construire_arb_Huffman(char info[], int frecventa[], int nr)
{
    MinHeapNod *st, *dr, *top;
    MinHeap *minHeap=creaza_MinHeap(info, frecventa, nr);
    while(minHeap->nr_noduri!=1)
    {
        st=minim(minHeap);
        dr=minim(minHeap);
        top=nod_nou('$', st->frecventa+dr->frecventa);
        top->st=st;
        top->dr=dr;
        ins_MinHeap(minHeap, top);
    }
    return minim(minHeap);
}
void codare(MinHeapNod *radacina, int v[], int top)
{
    if(radacina->st)
    {
        v[top]=0;
        codare(radacina->st, v, top+1);
    }
    if(radacina->dr)
    {
        v[top]=1;
        codare(radacina->dr, v, top+1);
    }
    if(frunza(radacina))
    {
        cout<<radacina->info<<": ";
        afisare(v, top);
    }
}
void Huffman(char info[], int frecventa[], int nr)
{
    MinHeapNod *radacina=construire_arb_Huffman(info, frecventa, nr);
    int v[100],top=0;
    codare(radacina, v, top);
}

int main()
{

    char v[] = {'a', 'b', 'c', 'd', 'e', 'f'};
    int frecventa[] = {15, 90, 12, 23, 10, 35};
    int nr_noduri=sizeof(v)/sizeof(v[0]);
    Huffman(v, frecventa, nr_noduri);

	return 0;
}
