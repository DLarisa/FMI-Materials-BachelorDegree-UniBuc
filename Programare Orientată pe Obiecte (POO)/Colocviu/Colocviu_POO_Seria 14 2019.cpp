#include <iostream>
#include <typeinfo>
#include <vector>
#include <string>
using namespace std;

class Bilet_R
{
    string statiep, staties;
    int zi, luna, an;
    double ora;
    int timp;
    int cod;
    double km;
    double pret;
    int tip; //0-cls II, 1- cls I
    string serie; int nr_serie;
public:
    Bilet_R(){statiep=staties=""; zi=luna=an=ora=timp=cod=km=pret=tip=0;}
    virtual ~Bilet_R() {statiep.clear(); staties.clear(); cod=zi=luna=an=ora=timp=km=pret=tip=0;}
    void citire()
    {
        cout<<"Statie Plecare: "; cin>>statiep; cin.get();
        cout<<"Statie Sosire: "; cin>>staties; cin.get();
        cout<<"Data: Zi-Luna-An: "; cin>>zi>>luna>>an;
        cout<<"Ora: "; cin>>ora;
        cout<<"Durata Calatorie: "; cin>>timp;
        cout<<"Cod Tren: "; cin>>cod; cin.get();
        cout<<"Distanta: "; cin>>km;
        cout<<"Tip Bilet (0-II; 1-I): "; cin>>tip;
        if(tip==0) serie="RII-";
        else serie="RI-";
    }
    friend istream& operator>>(istream &input, Bilet_R &b)
    {b.citire(); return input;}
    void afisare()
    {
        cout<<"Statie Plecare: "<<statiep<<endl;
        cout<<"Statie Sosire: "<<staties<<endl;
        cout<<"Data: Zi-Luna-An: "<<zi<<"."<<luna<<"."<<an<<endl;
        cout<<"Ora: "<<ora<<endl;
        cout<<"Durata Calatorie: "<<timp<<" (min)"<<endl;
        cout<<"Cod Tren: "<<cod<<endl;
        cout<<"Distanta: "<<km<<" (km)"<<endl;
        if(tip==0) cout<<"Clasa II"<<endl;
        else cout<<"Clasa I"<<endl;
        cout<<"Pret: "<<pret<<endl;
        cout<<"Serie Bilet: "<<serie<<nr_serie<<endl;
    }
    virtual void calcul()
    {
        pret=0.39*km;
        if(tip==1) pret+=(pret*20)/100;
    }
    friend ostream& operator<<(ostream &output, Bilet_R &r)
    {
        r.calcul(); r.afisare();
        return output;
    }
    void setPret(double x) {pret=x;}
    double getKm() {return km;}
    int getTip() {return tip;}
    friend class Gestionare;
};

class Bilet_IR: public Bilet_R
{
    int nr_loc;
public:
    Bilet_IR(): Bilet_R(){nr_loc=0;}
    ~Bilet_IR() {nr_loc=0;}
    void citire1()
    {
        this->citire();
        cout<<"Nr Loc: "; cin>>nr_loc;
    }
    void calcul() override
    {
        double aux=0.7*getKm();
        if(getTip()==1) aux+=(20*aux)/100;
        setPret(aux);
    }
    friend istream& operator>>(istream &input, Bilet_IR &b)
    {
        b.citire1(); return input;
    }
    void afisare1()
    {
        this->afisare();
        cout<<"Nr_loc: "<<nr_loc<<endl;
    }
    friend ostream& operator<<(ostream &output, Bilet_IR &b)
    {
        b.calcul(); b.afisare1();
        return output;
    }
    friend class Gestionare;
};
class Gestionare
{
    int static nr;
    vector<Bilet_R*> v;
public:
    Gestionare(){}
    ~Gestionare(){v.clear();}
    void add()
    {
        Bilet_R *aux;
        cout<<"1)Bilet R\n2)Bilet IR\nInput: "; int input; cin>>input;
        switch(input)
        {
            case 1: aux=new Bilet_R; break;
            case 2: aux=new Bilet_IR; break;
            default: cout<<"Eroare"; break;
        }
        nr++; aux->nr_serie=nr;
        if(typeid(aux)==typeid(Bilet_R)) aux->citire();
        else static_cast<Bilet_IR&>(*aux).citire1();
        v.push_back(aux);
    }
    void afis_cod(int x)
    {
        for(auto i: v)
            if(i->cod==x) cout<<(*i)<<endl;
    }
    void afis_d(double d)
    {
        for(auto i: v)
            if(i->km>=d) cout<<(*i)<<endl;
    }
    void anulare(int poz)
    {
        vector<Bilet_R*> aux;
        for(int i=1; i<poz; i++)
            aux.push_back(v[i]);
        for(int i=poz+1; i<v.size(); i++) aux.push_back(v[i]);
        v=aux;
    }
};
int Gestionare::nr=0;

int main()
{
    Gestionare a;
    cout<<"Meniu: \n1)Adaugare \n2)Listare Tren Cod \n3)Listare Tren Distanta \n4)Anulare \n5)Iesire\n";
    int in;
    do
    {
        cin>>in;
        switch(in)
        {
            case 1: a.add(); break;
            case 2: {int x; cout<<"Cod Tren Dorit: "; cin>>x; a.afis_cod(x); break;}
            case 3: {double x; cout<<"Distanta Dorita: "; cin>>x; a.afis_d(x); break;}
            case 4: {int poz; cout<<"Pozitie Bilet: "; cin>>poz; a.anulare(poz);break;}
            case 5: return 0;
        }
        cout<<"Input: ";
    }while(in!=5);

    return 0;
}
