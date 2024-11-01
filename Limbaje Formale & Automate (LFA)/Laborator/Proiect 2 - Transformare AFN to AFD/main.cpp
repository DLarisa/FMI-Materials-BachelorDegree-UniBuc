#include <iostream> //AFN -> AFD
#include <fstream>
#include <cstring>
using namespace std;

struct automat1
{
    int q; //nr total de stari
    int nr_si; //nr stari initiale
    int si[20]; //care sunt starile initiale
    int nr_sf; //nr stari finale
    int sf[20]; //care sunt starile finale
    int l; //nr de litere
    char L[30]; //alfabetul de intrare
    int t; //nr de tranzitii ale delta_AFN ---> t=q*l
    struct tranzitie //structura tranzitie din delta_AFN
    {
        int s1; //stare
        char c; //litera tranzitiei
        int nr_s2; //cate stari primesc litera
        int s2[20]; //care sunt starile care primesc litera
    }T[50]; //vector de tranzitii
}AFN;
void initializare_AFN()
{
    int i, j, a, b;

    ifstream fin("automat.txt");
    fin >> AFN.q; //nr total de stari
    fin >> AFN.nr_si; //nr stari initiale
    for(i=0; i<AFN.nr_si; i++) fin >> AFN.si[i]; //care sunt starile initiale
    fin >> AFN.nr_sf; //nr stari finale
    for(i=0; i<AFN.nr_sf; i++) fin >> AFN.sf[i]; //care sunt starile finale
    fin >> AFN.l; //nr litere
    for(i=0; i<AFN.l; i++) fin >> AFN.L[i]; //alfabetul de intrare
    AFN.t=AFN.q*AFN.l; //nr de tranzitii ale delta_AFN
    for(i=0; i<AFN.t; i++) //tranzitiile delta_AFN
    {
        fin >> AFN.T[i].s1 >> AFN.T[i].c >> AFN.T[i].nr_s2;
        for(j=0; j<AFN.T[i].nr_s2; j++) fin >> AFN.T[i].s2[j];

        //Sortez s2 pt ca imi tb ordine la comparatii
        for(a=0; a<AFN.T[i].nr_s2-1; a++)
            for(b=a+1; b<AFN.T[i].nr_s2; b++)
                if(AFN.T[i].s2[a]>AFN.T[i].s2[b]) swap(AFN.T[i].s2[a], AFN.T[i].s2[b]);
    }
    fin.close();

    //Sortez tranzitiile pt ca am nevoie de ordine --> primele vor fi tranzitiile cu si (incep de la 0 la un n; de la n la t sunt restul)
    for(a=0; a<AFN.t-1; a++)
        for(b=a+1; b<AFN.t; b++)
            //daca s1 sunt diferite
            if(AFN.T[a].s1>AFN.T[b].s1) swap(AFN.T[a], AFN.T[b]);
            else if (AFN.T[a].s1==AFN.T[b].s1) //daca s1 sunt egale comparam literele
                    if(AFN.T[a].c>AFN.T[b].c) swap(AFN.T[a], AFN.T[b]);
}
void afisare_AFN()
{
    int i, j;
    cout << "AFN introdus: " << endl;
    cout << "Nr total de Stari: " << AFN.q << endl;
    cout << "Nr Stari Initiale: " << AFN.nr_si << endl;
    cout << "   Starile Initiale: ";
    for(i=0; i<AFN.nr_si; i++) cout << AFN.si[i] << " ";
    cout << endl;
    cout << "Nr Stari Finale: " << AFN.nr_sf << endl;
    cout << "   Starile Finale: ";
    for(i=0; i<AFN.nr_sf; i++) cout << AFN.sf[i] << " ";
    cout << endl;
    cout << "Tranzitiile:" << endl;
    for(i=0; i<AFN.t; i++)
    {
        cout << AFN.T[i].s1 << ":" << endl;
        cout << "   " << AFN.T[i].c << ": ";
        if(AFN.T[i].nr_s2==0) cout << "Multime Vida";
        else for(j=0; j<AFN.T[i].nr_s2; j++) cout << AFN.T[i].s2[j] << " ";
        cout << endl;
    }
}

struct automat2
{
    int q; //nr total de stari
    int nr_si; //nr stari initiale
    int si[20]; //care sunt starile initiale
    int nr_sf; //nr stari finale
    int sf[20]; //care sunt starile finale
    int t; //nr de tranzitii ale delta_AFD
    struct tranzitie //structura tranzitie din delta_AFD
    {
        int nr_s1; //nr stari din care porneste litera
        int s1[20]; //care sunt starile din care porneste litera
        char c; //litera tranzitiei
        int nr_s2; //cate stari primesc litera
        int s2[20]; //care sunt starile care primesc litera
    }T[50]; //vector de tranzitii
}AFD;
void initializare_AFD()
{
    int i, j, k, z;
    AFD.nr_sf=0; //momentan avem 0 stari finale
    //Starile Initiale Coincid in ambele Automate
    //Nr total de stari ale AFD este, momentan, egal cu nr stari initiale
    AFD.q=AFD.nr_si=AFN.nr_si;
    for(i=0; i<AFD.nr_si; i++) AFD.si[i]=AFN.si[i];
    //Copiem Tranzitiile de la starile Initiale pt ca ajung in AFD
    //Initializez nr de Tranzitii cu 0
    AFD.t=0;
    for(i=0; i<AFD.nr_si; i++) //pt fiecare stare initiala
        for(j=0; j<AFN.l; j++) //pt fiecare litera a alfabetului
        {
            z=i*AFN.l+j; //Pozitie Tranzitie in Vectorul de AFD
            AFD.T[z].nr_s1=1; AFD.T[z].s1[0]=AFD.si[i]; //Pt ca sunt si ale AFN au o singura cifra
            AFD.T[z].c='a'+j;
            AFD.T[z].nr_s2=AFN.T[z].nr_s2;
            for(k=0; k<AFD.T[z].nr_s2; k++) AFD.T[z].s2[k]=AFN.T[z].s2[k];
            AFD.t++; //crestem nr de tranzitii ale AFD
        }
}
void afisare_AFD()
{
    ofstream fout("AFD Rezultat.txt");

    int i, j, k;
    fout << "AFD Rezultat:" << endl << endl;
    fout << "Nr total de Stari: " << AFD.q << endl;
    fout << "Nr Stari Initiale: " << AFD.nr_si << endl;
    fout << "       Starile Initiale: ";
    for(i=0; i<AFD.nr_si; i++) fout << AFD.si[i] << " ";
    fout << endl;
    fout << "Nr Stari Finale: " << AFD.nr_sf << endl;
    fout << "       Starile Finale: ";
    for(i=0; i<AFD.nr_sf; i++)
    {
        for(j=0; j<AFD.T[AFD.sf[i]].nr_s1; j++) fout << AFD.T[AFD.sf[i]].s1[j];
        fout << ", ";
    }
    fout << endl << endl << "Tranzitiile:" << endl;
    for(i=0; i<AFD.t; i+=AFN.l)
    {
        fout << "Starea ";
        for(j=0; j<AFD.T[i].nr_s1; j++) fout << AFD.T[i].s1[j];
        fout << ":" << endl;
        for(k=0; k<AFN.l; k++)
        {
            fout << "       " << AFD.T[i+k].c << ": ";
            if(AFD.T[i+k].nr_s2==0) fout << "Multime Vida";
            else for(j=0; j<AFD.T[i+k].nr_s2; j++) fout << AFD.T[i+k].s2[j];
            fout << endl;
        }
    }
    fout.close();
}
int egale(int i)
//Verifica daca o anumita stare (care e s2 in tranzitiile AFD)
//a aparut deja in tabelul de tranzitii; i --> AFD.T[i]; nr tranzitiei
{
    int j, k;
    for(j=0; j<AFD.t; j++) //verifica fiecare tranzitie care exista pana in acel moment
        if(AFD.T[j].nr_s1==AFD.T[i].nr_s2)
        {
            for(k=0; k<AFD.T[i].nr_s2; k++)
                if(AFD.T[i].s2[k]!=AFD.T[j].s1[k]) break;
            if(k==AFD.T[i].nr_s2) return 1; //sunt egale
        }
    return 0; //nu am gasit nimic egal in tranzitii
}
void reuniune(int i) //cream s2 pt o litera facand reuniune fiecare cifra din s1
{
    int j, k, z=AFD.T[i].c-'a', poz, nr=0;
    //z=valoare litera din tranzitie
    //nr=nr stari finale pt tranzitia noastra
    for(j=0; j<AFD.T[i].nr_s1; j++)
    {
        poz=AFD.T[i].s1[j]*AFN.l+z; //pozitia tranzitiei la care ne uitam
        for(k=0; k<AFN.T[poz].nr_s2; k++)
        {
            AFD.T[i].s2[nr]=AFN.T[poz].s2[k], nr++;
        }
    }

    //Sortam si stergem duplicatele
    for(j=0; j<nr-1; j++)
        for(k=j+1; k<nr; k++)
            if(AFD.T[i].s2[j]>AFD.T[i].s2[k]) swap(AFD.T[i].s2[j], AFD.T[i].s2[k]);
    for(j=0; j<nr-1; )
        if(AFD.T[i].s2[j]==AFD.T[i].s2[j+1])
        {
            for(k=j+1; k<nr-1; k++) AFD.T[i].s2[k]=AFD.T[i].s2[k+1];
            nr--;
        }
        else j++;
    AFD.T[i].nr_s2=nr;
}
void tranz(int i)
//creare tranzitii pt fiecare lit (daca  T[i].s2 are mai mult de o stare)
{
    if(AFD.T[i].nr_s2==0) return; //in cazul in care avem multime vida
    int j, k, z=AFD.t, l=AFN.l;
    for(j=0; j<l; j++) //pt fiecare lit creez o noua tranzitie
    {
        AFD.T[z+j].nr_s1=AFD.T[i].nr_s2; //nr stari initiale noua tranzitie = nr stari finale tranzitie i
        for(k=0; k<AFD.T[i].nr_s2; k++)
            AFD.T[z+j].s1[k]=AFD.T[i].s2[k]; //copiem starile

        AFD.T[z+j].c='a'+j; //pun litera in tranzitie
        reuniune(z+j);
    }
    AFD.t=z+j; //cresc nr de tranzitii
}
void stari_finale() //marcheaza starile finale
{
    int i, j, k, z=0;
    int ok;
    for(i=0; i<AFD.t; i+=AFN.l) //pt fiecare stare a AFD
    {
        ok=0;
        for(j=0; j<AFD.T[i].nr_s1; j++) //pt fiecare cifra dintr-o stare
        {
            for(k=0; k<AFN.nr_sf; k++) //pt fiecare stare finala din AFN
                if(AFN.sf[k]==AFD.T[i].s1[j])
                {
                    //retin pozitia tranzitiei si la afisare afisez s1 din tranzitie
                    AFD.sf[z]=i; z++; ok=1; break;
                }
            if(ok==1) break;
        }
    }
    AFD.nr_sf=z;
}
void creare_AFD()
{
    int i;
    for(i=0; i<AFD.t; i++) //luam s2 din fiecare tranzitie
    {
        if(egale(i)==0) //verificam sa nu mai avem tranzitia inca o data
            tranz(i);
    }
    stari_finale();
    AFD.q=AFD.t/AFN.l; //nr stari totale=nr tranzitii/nr litere
}

int main()
{
    initializare_AFN();
    afisare_AFN();
    initializare_AFD();
    creare_AFD();
    afisare_AFD();

    return 0;
}
