#include <iostream> //AFN
#include <fstream>
#include <cstring>
using namespace std;

struct automat //Structura unui AFN
{
    //Declar Datele
    int q; //Nr total stari
    int f; //Nr stari finale
    int F[100]; //Starile finale
    int t; //Nr tranzitii
    int l; //Nr litere
    char A[50]; //Alfabetul
    struct tranz //Structura unei Tranzitii
    {
        int s1, s2; //starea 1, starea 2
        char c;    //litera
    }T[100]; //Vectorul de Tranzitii
    int ok=0; //Daca Cuvantul Verificat e Acceptat sau Nu
}AFN;
//Verificam daca cuvantul este acceptat de AFN
//Un fel de Backtracking, unde se incearca toate combinatiile posibile
bool verificare(char cuvant[], int pozitia_din_cuvant, int stare_curenta)
{
    int i;
    //Daca am ajuns la finalul Cuvantului, i.e. am parcurs toate literele
    if(pozitia_din_cuvant==strlen(cuvant))
    {
        //Verific daca starea_curenta se afla intr-o stare finala
        for(i=0; i<AFN.f; i++)
            if(stare_curenta==AFN.F[i])
                {AFN.ok=1; return true;} //Atunci Cuvantul este Acceptat
    }
    else//Daca mai avem de verificat sau am revenit la o litera anterioara
    {
       for(i=0; i<AFN.t; i++)
       {
           //daca ok=1, nu mai las sa se apeleze recursiv si fortez sa se termine programul
           if(AFN.ok==1) return true;
           //daca sar peste if, verific daca exista vreo tranzitie care sa contina starea mea curenta
           // si litera din cuvant la care ma aflu
           if(AFN.T[i].s1==stare_curenta && AFN.T[i].c==cuvant[pozitia_din_cuvant])
            verificare(cuvant, pozitia_din_cuvant+1, AFN.T[i].s2);
       }
       return false;
    }
}
int main()
{
    //Citesc Datele
    ifstream fin("automat.txt");
    cout<<"Nr total de stari: "; fin>>AFN.q; cout<<AFN.q<<endl;
    cout<<"Nr stari finale: "; fin>>AFN.f; cout<<AFN.f<<endl;
    int i;
    cout<<"Starile Finale: "<<endl;
    for(i=0; i<AFN.f; i++) {fin>>AFN.F[i]; cout<<AFN.F[i]<<" ";}
    cout<<endl<<"Nr de Litere: "; fin>>AFN.l; cout<<AFN.l<<endl;
    cout<<"Litere: "<<endl;
    for(i=0; i<AFN.l; i++) {fin>>AFN.A[i]; cout<<AFN.A[i]<<" ";}
    cout<<endl<<"Nr de Tranzitii: "; fin>>AFN.t; cout<<AFN.t<<endl;
    cout<<"Tranzitiile: "<<endl;
    for(i=0; i<AFN.t; i++)
    {
        fin>>AFN.T[i].s1>>AFN.T[i].s2>>AFN.T[i].c;
        cout<<AFN.T[i].s1<<" "<<AFN.T[i].s2<<" "<<AFN.T[i].c<<endl;
    }
    fin.close();

    //Verificam Cuvantul
    if(verificare("ababbaab", 0, 0)==true) cout<<"Cuvantul este Acceptat.";
    else cout<<"Cuvantul NU este acceptat.";

    return 0;
}
