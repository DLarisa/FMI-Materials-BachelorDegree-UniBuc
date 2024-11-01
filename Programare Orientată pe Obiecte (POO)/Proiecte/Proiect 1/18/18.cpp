#include <iostream>
#include <fstream>
#include <list>
using namespace std;
class Numar
{
    int semn, nr_cifre; //semn=0(negativ)/1(pozitiv)
    //nr_cifre=nr de cifre al Numarului Intreg Mare
    list <int> L; //Lista de Cifre
public:
    friend istream& operator>>(istream &input, Numar &nr) //Functie Citire
    {
        int x;
        input >> nr.semn >> nr.nr_cifre;
        for(int i=0; i<nr.nr_cifre; i++)
        {
            input >> x;
            nr.L.push_back(x);
        }
        return input;
    }
    friend ostream& operator<<(ostream &output, const Numar &nr) //Functie Afisare
    {
        if(nr.semn==0) output << "-";
        for(int p: nr.L) output<<p;
        return output;
    }
    Numar maxim(const Numar a); //Functie Max in Modul
    //Functie care verifica daca 2 module sunt egale
    bool egale(const Numar a)
    {
        //Daca nr de cifre difera
        if(a.nr_cifre!=this->nr_cifre) return false;
        //Altfel
        auto i=a.L.begin();
        auto j=this->L.begin();
        for(; i!= a.L.end() && j!=this->L.end(); ++i, ++j)
            //Se iau cifrele celor 2 liste concomitent si daca una
            //e diferita se returneaza fals (modulele nu sunt egale)
            if(*i!=*j) return false;

        //Modulele sunt Egale
        return true;
    }
    Numar operator+(const Numar &nr); //Functie Adunare
    Numar operator-(const Numar &nr); //Functie Scadere
    Numar operator*(const Numar &nr); //Functie Inmultire
    friend class Vector; //Clasa Prietena Vector
};
Numar Numar::maxim(const Numar a) //Functie Max in Modul
{
    if(a.nr_cifre>this->nr_cifre) return a;
    if(a.nr_cifre<this->nr_cifre) return *this;

    //Daca nr de cifre 'a' = nr cifre al listei pe care o vom compara
    auto i=a.L.begin();
    auto j=this->L.begin();
    for(; i!= a.L.end() && j!=this->L.end(); ++i, ++j)
    {
        //Se iau cifrele celor 2 liste concomitent si daca una
        //e diferita se returneaza nr cu cifra mai mare
        if(*i>*j) return a;
        if(*i<*j) return *this;
    }

    //Daca sunt egale
    return a;
}
Numar Numar::operator+(const Numar &nr) //Functie Adunare
{
    Numar nou, aux, b;
    //Daca semnele sunt identice
    if(this->semn==nr.semn)
    {
        nou.semn=nr.semn;

        //Se face adunare Normala
        aux=nr; //facem copie pt ca nu putem modifica o const
        //Inversam Listele ca sa facem suma de la unitati
        aux.L.reverse();
        this->L.reverse();
        int cifra=0; //va retine ce depaseste 10 la adunare
        nou.nr_cifre=0; //Initial nou are 0 cifre
        //Incepem de la cifra unitatilor
        auto i=aux.L.begin();
        auto j=this->L.begin();
        for(; i!= aux.L.end() && j!=this->L.end(); ++i, ++j)
        {
            cifra=(*i)+(*j)+cifra; //cifra=suma celor 2 cifre din lista + restul
            nou.L.push_back(cifra%10);
            cifra/=10; //1 sau 0
            nou.nr_cifre++; //crestem nr de cifre
        }
        //daca au ramas cifre neverificate din prima lista
        for(; i!= aux.L.end(); ++i)
        {
            cifra=(*i)+cifra;
            nou.L.push_back(cifra%10);
            cifra/=10; //1 sau 0
            nou.nr_cifre++; //crestem nr de cifre
        }
        //daca au ramas cifre neverificate din a doua lista
        for(; j!= this->L.end(); ++j)
        {
            cifra=(*j)+cifra;
            nou.L.push_back(cifra%10);
            cifra/=10; //1 sau 0
            nou.nr_cifre++; //crestem nr de cifre
        }
        //daca a ramas un rest de la adunare
        while(cifra)
        {
            nou.L.push_back(cifra%10);
            cifra/=10; //1 sau 0
            nou.nr_cifre++; //crestem nr de cifre
        }
        //Ca sa revin la lista initiala
        this->L.reverse();
    }
    //Daca avem + si -
    else
    {
        //Daca modulul e egal, nr devine 0
        if(this->egale(nr)==true)
        {
            nou.semn=1; nou.nr_cifre=1;
            nou.L.push_back(0); return nou;
        }
        //Altfel se ia semnul nr cu modulul mai mare
        aux=this->maxim(nr);
        if(aux.egale(nr)) {nou.semn=nr.semn; b=*this;}
        else {nou.semn=this->semn; b=nr;}

        //Acum se face scaderea din nr mai mare (aux)
        //Inversam Listele ca sa facem suma de la unitati
        aux.L.reverse();
        b.L.reverse();
        int cifra=0; //va retine ce depaseste 10 pt scadere
        nou.nr_cifre=0; //Initial nou are 0 cifre
        //Incepem de la cifra unitatilor
        auto i=aux.L.begin(); //aux e MAX
        auto j=b.L.begin();
        for(; i!= aux.L.end() && j!=b.L.end(); ++i, ++j)
        {
            //din calculele anterioare
            if(cifra==1) (*i)--;
            if((*i)<(*j))
            {
                cifra=1;
                (*i)+=10;
                (*i)-=(*j);
                nou.L.push_back((*i));
            }
            else
            {
                cifra=0;
                //cout<<*i<<" "<<*j<<endl;
                (*i)-=(*j);
                nou.L.push_back((*i));
            }
            nou.nr_cifre++; //crestem nr de cifre
        }
        //daca au ramas cifre neverificate din prima lista
        for(; i!= aux.L.end(); ++i)
        {
            //din calculele anterioare
            if(cifra==1) (*i)--;
            if((*i)==-1) nou.L.push_back(9);
            else
            {
                cifra=0; nou.L.push_back(*i);
            }
            nou.nr_cifre++;
        }
        //atunci cand avem prima cifra 1
        if(nou.L.back()==0) nou.L.pop_back();
    }

    //Inversam lista ca sa putem sa o afisam corect
    nou.L.reverse();
    return nou;
}
Numar Numar::operator-(const Numar &nr) //Functie Scadere
//Seamana cu Functia Adunare
{
    Numar nou=nr, aux=*this;
    //Daca semnul lui nr (celui de-al 2-lea nr) este -
    //Semnul se transforma in +
    if(nr.semn==0) nou.semn=1;
        //Se face adunare Normala (definita mai sus)
        //Tb doar sa schimb semnul lui nr ca sa fie adunare

    //Semnul celui de-al 2-lea nr e +
    //Tot adunare dar consideram al 2-lea nr ca avand semnul -
    else nou.semn=0;

    return nou+aux;
}
Numar Numar::operator*(const Numar &nr) //Functie Inmultire
{
    Numar nou, nr1, aux;
    //Daca semnul este identic
    if(this->semn==nr.semn) nou.semn=1; //semnul e mereu +
    //(+)*(-)
    else nou.semn=0; //altfel e -

    aux.semn=nou.semn;
    //Inmultire
    nr1=nr; //facem copie pt ca nu putem modifica o const
    //Inversam Listele ca sa facem inmultirea de la unitati
    nr1.L.reverse();
    this->L.reverse();
    int cifra=0; //va retine ce depaseste la inmultire
    //In nou retinem suma produselor
    nou.nr_cifre=0; //Initial nou are 0 cifre
    //Incepem de la cifra unitatilor
    auto i=nr1.L.begin();
    auto j=this->L.begin();
    int k=1, k1; //ca sa stim cate zerorui adaugam la final nr aux
    for(; i!= nr1.L.end() && k; ++i, ++k)
    {
        j=this->L.begin(); //ca sa luam al 2-lea nr de la inceput mereu
        //In aux retinem produsul cu fiecare cifra in parte
        aux.nr_cifre=0; //Initial aux are 0 cifre
        aux.L.clear(); //golim lista auxiliara
        //Adaugam zerourile finale de la aux
        k1=k-1;
        while(k1)
        {
            aux.L.push_back(0);
            aux.nr_cifre++; k1--;
        }
        for(; j!= this->L.end(); ++j)
        {
            cifra+=(*i)*(*j);
            aux.L.push_back(cifra%10);
            cifra/=10;
        }
        //daca ramane un rest de la adunarea produselor
        while(cifra)
        {
            aux.L.push_back(cifra%10);
            cifra/=10;
        }
        //Nu mai tb sa intoarcem atunci nou
        aux.L.reverse();
        nou=nou+aux;
    }

    this->L.reverse();
    return nou;
}

class Vector
{
private:
    int nr=0; //cate elemente sunt in vector
    Numar *V=new Numar[nr]; //elementele vectorului sunt liste
public:
    friend istream& operator>>(istream &input, Vector &a) //Functie Citire
    {
        input >> a.nr; a.V=new Numar[a.nr];
        for(int i=0; i<a.nr; i++) input >> a.V[i];
        return input;
    }
    friend ostream& operator<<(ostream &output, const Vector &a) //Functie Afisare
    {
        for(int i=0; i<a.nr; i++) output<<a.V[i]<<endl;
        return output;
    }
    ~Vector() //ca sa dezaloc memoria alocata
    {
        delete []V;
    }
    Vector operator*(const Vector &a); //Functie Inmultire 2 Vectori
    Vector maxim(); //Functie Maxim in Modul
};
Vector Vector::operator*(const Vector &a) //Functie Inmultire 2 Vectori
{
    if(this->nr!=a.nr) {cout<<"Eroare. Nr diferit de Elemente";}
    int i;
    Vector nou;
    Numar aux; aux.semn=1; aux.nr_cifre=1; aux.L.push_back(0); //aux=0
    for(i=0; i<a.nr; i++) aux=aux+a.V[i]*this->V[i];
    nou.nr=1; nou.V=new Numar[1]; nou.V[0]=aux;
    return nou;
}
Vector Vector::maxim() //Functie Maxim in Modul
{
    //Creez un nou vector cu un singur element in care se va retine maximul
    Vector nou; nou.nr=1; nou.V=new Numar[1];
    //Daca vectorul are 1 singur element, acela e maximul din vector
    if(this->nr==1) {nou.V[0]=this->V[0]; return nou;}
    //Altfel maxi=max dintre primele 2 elemente ale vectorului
    Numar maxi=this->V[0].maxim(this->V[1]);
    int i;
    //Pt restul, maxi=max dintre el insusi si valoarea din Vector
    for(i=2; i<this->nr; i++) maxi=maxi.maxim(this->V[i]);
    nou.V[0]=maxi;
    return nou;
}

int main()
{
    /*
    ifstream myfile ("numere.txt");
    Numar a, b, c;
    myfile >> a >> b;
    cout<<a.maxim(b)<<endl;
    cout<<b.maxim(a)<<endl;
    cout<<a+b<<endl<<b+a<<endl<<a-b<<endl<<b-a<<endl<<a*b<<endl<<b*a<<endl;
    cout<<a<<endl<<b<<endl;
    myfile.close();
    cin>>c;
    ofstream myfileout ("numere_out.txt");
    myfileout<<c<<" "<<c.maxim(a)<<endl;
    myfileout.close();
    */


    /*
    ifstream fin("vector.txt");
    Vector a, b, c;
    fin>>a>>b;
    cin>>c;
    //cout<<a<<endl<<b<<endl<<c<<endl;
    //cout<<a*b<<endl;
    cout<<a.maxim()<<endl;
    //cout<<b<<endl;
    cout<<b.maxim()<<endl;
    cout<<c.maxim()<<endl;
    cout<<a<<endl;
    cout<<b<<endl;
    ofstream fout("afisare.txt");
    fout<<c.maxim()<<endl;
    fout.close();
    fin.close();
    */

    return 0;
}
