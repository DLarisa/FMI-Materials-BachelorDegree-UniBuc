/*
	Pentru Rulare:
	1. g++ "Nu Recursiv".cpp
	2. ./a.out < 0.in
	
	Programul afișează First, Follow și Tabelul de Parsare Predictivă
	
	Enunț 1.2:
		Analizor sintactic recursiv descendent pentru gramatici LL(1). Programul va citi gramatica si 
		un cuvant si va afisa derivarea sa, iar in cazul unei erori se va opri si va semnala eroarea respectiva.
*/



#include <iostream>
#include <vector>
#include <map>
#include <set>
#include <stack>
#include <string>
using namespace std;




/* -------   Declarări Predefinitorii pt Funcționarea Programului   ------- */
// Forma unei Producții -> Avem Gramatică LL(1), deci L = Left
struct Productie
{
    char stanga;
    vector<char> dreapta;
};



// Forma Gramaticii Introduse -> conform cerinței trebuie să fie LL(1)
struct Gramatica
{
    int nr;  // nr de productii
    vector<char> T;   // simbolurile terminale (litere mici, cifre, semne, lambda)
    vector<char> N;   // simboluri neterminale (majuscule) -> !!! NEAPĂRAT, se dă mai întâi simbolul de start (restul, în ordine)
    vector<Productie> p;  // producțiile (pot fi date în orice ordine)
}gramatica;



// FIRST, FOLLOW
map<char, set<char>> First;  // cheia este neterminalul, iar setul păstrează elementele unice, în ordinea introdusă (terminalele)
map<char, set<char>> Follow; // EOF = $, conform documentației



// Stiva de analiză, unde vom reține neterminalele (atunci când validăm cuvintele)
stack<char> stiva;
string str;
// Tabela de Parsare Predictivă (cu terminali și neterminali)
vector<char> Tabela[50][50];  // ea conține producții (pt că am gramatică LL(1) -> o celulă poate să conțina 0 sau 1 valoare maxim)





/* -------   Funcții Auxiliare   -------*/
// Verifică dacă un caracter este simbol terminal și îi întorc poziția (mă ajută la tabelă)
int esteTerminal(char ch)
{
    for(int i = 0; i < gramatica.T.size(); i++)
        if(ch == gramatica.T[i]) return i + 1;

    return 0;
}

// Verifică dacă un caracter este simbol neterminal și îi întorc poziția (mă ajută la tabelă)
int esteNeterminal(char ch)
{
    for(int i = 0; i < gramatica.N.size(); i++)
        if(ch == gramatica.N[i]) return i + 1;

    return 0;
}





/* -------   Construirea First, Follow, Tabelă Predictivă   -------*/
// Funcție pentru a construi vectorii First
void getFirst()
{
    // Pentru simbolurile terminale, First = cu ele însele
    for(int i = 0; i < gramatica.T.size(); i++)
    {
        char ch = gramatica.T[i];
        set<char> aux; aux.insert(ch);
        First[ch] = aux;
    }

    // Cât timp se produc schimbări în vectorii First, voi relua toate producțiile ca să mă asigur că nu voi mai avea nicio schimbare
    bool ok = true;
    while(ok)
    {
        ok = false;

        // Iau fiecare producție
        for(int i = 0; i < gramatica.p.size(); i++)
        {
            Productie &productie = gramatica.p[i];
            char X = productie.stanga;
            set<char> &FX = First[X];

            // Dacă primul simbol este terminatal sau &, adaug la First direct (ex: S-> a | & | +AS)
            if(esteTerminal(productie.dreapta[0]) || productie.dreapta[0] == '&')
            {
                // Verific dacă există deja în vectorul First
                auto it = FX.find(productie.dreapta[0]);
                // Dacă nu există deja în vectorul First
                if(it == FX.end())
                {
                    ok = true;  // s-a produs o schimbare, deci va tb să continuăm să verificăm restul producțiilor
                    FX.insert(productie.dreapta[0]);
                }
            }
            // Simbolul nu este terminal, deci am ex: A->SAB și atunci trebuie să fac recursie
            else
            {
                bool next = true;
                int indice = 0; // cu care parcurg fiecare neterminal din partea dreaptă a producției (SAB), dacă este cazul

                // parcurg până întâlnesc simbol terminal sau se termină neterminalele
                while(next && indice < productie.dreapta.size())
                {
                    next = false; // verific dacă apare &
                    char Y = productie.dreapta[indice]; // iau din dreapta un neterminal
                    set<char> &FY = First[Y];           // mă uit la vectorul First al acestuia
                    // adaug toate elementele terminale (!= &) din First(literă Dreapta) în First(literă inițială)
                    for(auto it = FY.begin(); it != FY.end(); it++)
                    {
                        if(*it != '&')
                        {
                            // verific să nu am duplicate
                            auto itAux = FX.find(*it);
                            if(itAux == FX.end())
                            {
                                ok = true;   // am făcut modificare, trebuie să reparcurg
                                FX.insert(*it);
                            }
                        }
                    }

                    // mă uit să văd dacă am &(lambda); dacă da, atunci trebuie să trec la următoarele litere din dreapta celei inițiale (pot să am S->ABC; A->& | ...; deci: S->&BC și atunci tb să verific pt B, până dau de o literă care nu are în First pe &)
                    auto it = FY.find('&');
                    if(it != FY.end())
                    {
                        next = true;
                        indice++;
                    }
                }
            }
        }
    }


    // Afișez Vectorii First
    cout << "FIRST: " << endl;
    for(int i = 0; i < gramatica.N.size(); i++)
    {
        char ch = gramatica.N[i];
        cout << ch << ": ";
        for(auto it: First[ch]) cout << it << " ";
        cout << endl;
    }
    cout << endl;
}

// Funcție Auxiliară pt Follow și Tabela de Predicții -> Face First pt un subset Alpha
// întorc First(alpha) în FA
void getFirstAux(vector<char> &alpha, set<char> &FA)
{
    // Asemănător cu ce am mai sus
    // Simbolul inițial e unul neterminal; dacă acesta are o producție lambda(&), atunci tb să mă uit la următorul și tot așa
    bool next = true;
    int indice = 0; // cu care parcurg fiecare neterminal, dacă este cazul

    // parcurg până întâlnesc simbol terminal sau se termină neterminalele
    while(indice < alpha.size() && next)
    {
        next = false;

        // Dacă primul simbol este terminatal sau &, adaug la First direct (ex: S-> a | & | +AS)
        if(esteTerminal(alpha[indice]) || alpha[indice] == '&')
        {
            // Verific dacă există deja în vectorul First
            auto it = FA.find(alpha[indice]);
            // Dacă nu există deja în vectorul First
            if(it == FA.end()) FA.insert(alpha[indice]);
        }
        // trebuie să fac recursie
        else
        {
            char Y = alpha[indice];      // iau neterminal
            set<char> &FY = First[Y];    // mă uit la vectorul First al acestuia

            for(auto it = FY.begin(); it != FY.end(); it++)
            {
                // dacă am labda, skip
                if(*it == '&')
                {
                    next = true;
                    continue;
                }

                // restul de elemente le adaug la vectorul inițial, dacă nu sunt deja
                auto itAux = FA.find(*it);
                if(itAux == FA.end()) FA.insert(*it);
            }
        }
        indice++;
    }

    // dacă next = true la final, înseamnă ca pot să am &
    if(next) FA.insert('&');
}

// Funcție pentru a construi vectorii Follow
void getFollow()
{
	for(int i = 0; i < gramatica.N.size(); i++)
	{
		char ch = gramatica.N[i];
		Follow[ch] = set<char>();
	}
    Follow[gramatica.N[0]].insert('$');

    bool ok = true;
    while(ok)
    {
        ok = false;

        // pt fiecare producție
        for(int i = 0; i < gramatica.p.size(); i++)
        {
            Productie &productie = gramatica.p[i];
            for(int j = 0; j < productie.dreapta.size(); j++)
            {
                char X = productie.dreapta[j];

                // iau doar neterminalele
                if(esteNeterminal(X))
                {
                    set<char> &FX = Follow[X];
                    set<char> FA;

                    // alpha = subșirul care începe cu următorul caracter față de j
                    vector<char> alpha(productie.dreapta.begin() + j + 1, productie.dreapta.end());
                    // caut First pentru alpha
                    getFirstAux(alpha, FA);

                    // toate elementele (!= &) din FA le adaug în Follow
                    for(auto it = FA.begin(); it != FA.end(); it++)
                    {
                        if(*it == '&') continue;

                        auto itAux = FX.find(*it);
                        if(itAux == FX.end())
                        {
                            ok = true;
                            FX.insert(*it);
                        }
                    }

                    // Dacă alpha poate fi împins afară, sau simbolul curent este capătul din dreapta al producției, setul FOLLOW al simbolului din stânga al gramaticii este adăugat la setul FOLLOW al simbolului curent
                    auto it = FA.find('&');
                    if(it != FA.end() || (j + 1) >= productie.dreapta.size())
                    {
                        char st = productie.stanga; // simbolul din stânga
                        for(auto itAux = Follow[st].begin(); itAux != Follow[st].end(); itAux++)
                        {
                            auto q = FX.find(*itAux);
                            if(q == FX.end())
                            {
                                ok = true;
                                FX.insert(*itAux);
                            }
                        }
                    }
                }
            }
        }
    }

    // Afișez Vectorii First
    cout << "FOLLOW: " << endl;
    for(int i = 0; i < gramatica.N.size(); i++)
    {
        char ch = gramatica.N[i];
        cout << ch << ": ";
        for(auto it: Follow[ch]) cout << it << " ";
        cout << endl;
    }
    cout << endl;
}

// Funcție Auxiliară pentru a insera în Tabelă
void inserareInTabela(char A, char ch, Productie &productie)
{
    // găsesc pozițiile pe linie și coloana tabelei
    int i = esteNeterminal(A) - 1;
    int j = esteTerminal(ch) - 1;

    // Introduc Producția (ex: A->a)
    Tabela[i][j].push_back(productie.stanga);
    Tabela[i][j].push_back('-');
    Tabela[i][j].push_back('>');
    for(auto it = productie.dreapta.begin(); it != productie.dreapta.end(); it++) 
		Tabela[i][j].push_back(*it);
}

// Funcție Auxiliară de unde iau o producție din tabela productivă
void getProductieDinTabela(char A, char ch, vector<char> &productie)
{
    // găsesc pozițiile pe linie și coloana tabelei
    int i = esteNeterminal(A) - 1;
    int j = esteTerminal(ch) - 1;

    // scot din tabelă producția
    productie.assign(Tabela[i][j].begin(), Tabela[i][j].end());
}

// Funcție pentru Tabela de Predicție
void getTabela()
{
    // pt fiecare producție
    for(int i = 0; i < gramatica.p.size(); i++)
    {
        Productie &productie = gramatica.p[i];
        set<char> F;
        getFirstAux(productie.dreapta, F);

        for(auto it = F.begin(); it != F.end(); it++) 
			inserareInTabela(productie.stanga, *it, productie);

        auto it = F.find('&');
        if(it != F.end())
            for(auto itAux = Follow[productie.stanga].begin(); itAux != Follow[productie.stanga].end(); itAux++) 
				inserareInTabela(productie.stanga, *itAux, productie);

        //for(auto it: F) inserareInTabela(productie.stanga, it, productie);

    }

    // Afișez Tabela
    cout << "Tabela: " << endl << "\t";
    for(int i = 0; i < gramatica.T.size(); i++)
        cout << gramatica.T[i] << "\t\t";
    cout << endl;
    for(int i = 0; i < gramatica.N.size(); i++)
    {
        cout << gramatica.N[i] << "\t";
        for(int j = 0; j < gramatica.T.size(); j++)
        {
            for(auto k: Tabela[i][j]) cout << k;

            cout << "\t\t";
        }
        cout << endl;
    }
}





/* -------   Analiză Top-Down Cuvânt   -------*/
void procesareCuvant(string cuvant)
{
    // pt eroare
    int ok = 1;

    // pozitia caractrului curent
    int pozitie = 0;

    // X = vârf stivă; a = simbolul curent din cuv
    char X, a;
    cout << "Derivare: " << endl;
    do
    {
        X = stiva.top();
        a = cuvant[pozitie];

        if(esteTerminal(X))
        {
            if(X == a || (X == '$' && a == '&'))
            {
                stiva.pop();
                pozitie++;
            }
            else { ok = 0, cout << "Eroare1" << endl; break; }
        }
        else
        {
            vector<char> productie;
            getProductieDinTabela(X, a, productie);
            if(!productie.empty())
            {
                stiva.pop();
                for(int i = productie.size() - 1; i >= 3; i--)
                    if(productie[i] != '&') stiva.push(productie[i]);

                for(int i = 0; i < productie.size(); i++) cout << productie[i];
                cout << endl;
            }
            else { ok = 0, cout << "Eroare2" <<endl; break; }
        }
    }while(X != '$');

    if(ok) cout << "Ok" << endl;
}


int main()
{
    // Inițializare Gramatică LL(1)
    cout << "Introduceti numarul de productii: "; cin >> gramatica.nr;

    cout << "Introduceti Productiile (Ex: A->aC. Observatie: lambda = &, in acest program): " << endl;
    string productie_citita;
    for(int i = 0; i < gramatica.nr; i++)
    {
        cin >> productie_citita;
        Productie aux;
        aux.stanga = productie_citita[0];
        for(int j = 3; j < productie_citita.size(); j++)
            aux.dreapta.push_back(productie_citita[j]);

        gramatica.p.push_back(aux);
    }

    // PRIMUL neterminal introdus TREBUIE să fie cel de START
    cout << "Introduceti simbolurile Neterminale (inchideti cu #): " << endl;
    char ch; cin >> ch;
    while(ch != '#')
    {
        gramatica.N.push_back(ch);
        cin >> ch;
    }

    cout << "Introduceti simbolurile Terminale, fara lambda(&) (inchideti cu #): " << endl;
    cin >> ch;
    while(ch != '#')
    {
        gramatica.T.push_back(ch);
        cin >> ch;
    }
    // Adaug automat EOF în lista simbolurilor terminale
    gramatica.T.push_back('$');



    /* ----- Procesez Gramatica ----- */
    cout << endl << endl << "-------   Rezultate   -------" << endl;
    getFirst();
    getFollow();
    getTabela();



    /* ----- Analiză Cuvânt Introdus ----- */
    cout << endl << endl << "-------   Analiza Cuvant   -------" << endl;
    cout << "Introduceti cuvantul: ";
    string cuvant; cin >> cuvant; cuvant += '$';
    stiva.push('$'); stiva.push(gramatica.N[0]);
    procesareCuvant(cuvant);
	
    return 0;
}