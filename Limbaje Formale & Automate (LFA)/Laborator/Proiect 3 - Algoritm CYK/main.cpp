#include <iostream>
#include <string>
#include <iomanip>
using namespace std;

int np; //nr de productii
string gram[100][100]; //gramatica de intrare
string concat(string a, string b) //concateneaza fara a repeta terminalele
{
    int i;
    string aux=a;
    for(i=0; i<b.length(); i++)
        if(aux.find(b[i])==std::string::npos) //==NULL(deci nu se repeta)
            aux+=b[i];
    return aux;
}
string cauta(string p) //cauta litera corespunzatoare unei productii
{
    int j, k;
    string aux="";
    for(j=0; j<np; j++)
        for(k=2; k<2+stoi(gram[j][1]); k++)
            if(gram[j][k]==p) aux=concat(aux, gram[j][0]);
    return aux;
}
string combina(string a, string b) //combina ex:AB*BA= AB, AA, BB, BA
{
    int i, j, k;
    string l,aux="";
    for(i=0; i<a.length(); i++)
        for(j=0; j<b.length(); j++)
        {
            l=""; l=l+a[i]+b[j];
            aux+=cauta(l); //si returneaza litera corespunzatoare productiiei
        }
    return aux;
}

int main()
{
    int i, j, k;

    char start; //simbol de start
    cout << "Simbol de Start: "; cin >> start;
    cout << "Nr de Productii Totale: "; cin >> np;
    //Citire Gramatica
    for(i=0; i<np; i++)
    {
        cout << "Litera: "; cin >> gram[i][0];
        cout << "Nr Productii: "; cin >> gram[i][1];
        for(j=2; j<stoi(gram[i][1])+2; j++) cin >> gram[i][j];
    }

    string matrix[100][100], cuvant; //matrix=matrice pentru cuvant
    cout << "Dati Cuvantul pt Verificare: "; cin >> cuvant;
    string l; //retin literele din cuvant
    string aux; //folosesc pt concatenare terminale

    //Initializare Matrice (voi incepe de la 1 si liniile si coloanele)
    for(i=1; i<=cuvant.length(); i++) //pt fiecare litera a cuvantului
    {
        l=cuvant[i-1]; aux="";
        for(j=0; j<np; j++) //caut in fiecare productie
        {
            for(k=2; k<stoi(gram[j][1])+2; k++)
                if(l==gram[j][k]) {aux=concat(aux, gram[j][0]); break;}
        }
        matrix[1][i]=aux;
    }

    //Construire Matrice Propriu-Zis
    for(j=2; j<=cuvant.length(); j++) //pt fiecare linie
    {
        for(i=1; i<=cuvant.length()-j+1; i++) //pt fiecare coloana
        {
            aux="";
            for(k=1; k<j; k++) //pt k-ul
            {
                l=combina(matrix[k][i], matrix[j-k][i+k]);
                aux=concat(aux, l);
            }
            matrix[j][i]=aux;
        }
    }

    //Afisare Matrice
    cout << endl;
    for(j=1; j<=cuvant.length(); j++)
    {
        for(i=1; i<=cuvant.length()-j+1; i++) cout << setw(5) << matrix[j][i];
        cout<<endl;
    }
    if(matrix[cuvant.length()][1].find(start)!=std::string::npos)
        cout << "Cuvantul este Acceptat de Limbaj." << endl;
    else cout << "Cuvantul nu este Acceptat de Limbaj." << endl;


    return 0;
}
