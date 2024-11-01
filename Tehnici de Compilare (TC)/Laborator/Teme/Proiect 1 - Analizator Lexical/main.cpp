/*
	PENTRU A RULA DIN TERMINAL:
	1. g++ main.cpp
	2. ./a.out aici.txt
*/

/*
	Analizator Lexical pentru Subset C
	Nu conține <<=; >>=; <<; >>; numere hexa, binare și toate caracterele speciale.
*/


#include <iostream>
#include <fstream>
#include <string>
#include <cstring>

#define MAX_VALUE 100000
using namespace std;





// Token
struct Token
{
    int tip; // un întreg care primește un anumit tip. Ex: operator; cuv cheie etc...
    string valoare; // luată din text (care este token-ul)
    int poz[100];  // pt poziția în tabela de string-uri (tabela de stringuri nu are voie să conțină duplicate -> rețin pozițiile unde apare token-ul în text ca să pot să fac afișarea)
    int nr_poz = 0; // nr de duplicate ale unui token (Ex: de câte ori apare "int" în program)
}TabelaStringuri[MAX_VALUE];  // tabela de stringuri
int nrValoriDinTabelaStringuri = 0;  // câte token-uri unice există în tot programul


// Listă Tipuri de Token
static int Operator = 0;
static int CuvCheie = 1;
static int LiteralInt = 2;
static int LiteralFloat = 3;
static int LiteralChar = 4;
static int LiteralString = 5;
static int Identificator = 6;
static int Delimitator = 7;
static int Spatiu = 8;       // -> nu tb să apară în tabela de stringuri (tb sărite)
static int Comentariu = 9;   // -> nu tb să apară în tabela de stringuri (tb sărite)
static int Eroare = 10; // și finalul de fișier va fi interpretat ca eroare, de aceea va tb să fac verificări suplimentare

// Afișare Tip Token -> după int (tip)
string afisareTipToken(int id)
{
    string tip;
    switch(id)
    {
        case 0: tip = "Operator: "; break;
        case 1: tip = "Cuvant Cheie: "; break;
        case 2: tip = "Literal Intreg: "; break;
        case 3: tip = "Literal Flotant: "; break;
        case 4: tip = "Literal Caracter: "; break;
        case 5: tip = "Literal Sir de Caractere: "; break;
        case 6: tip = "Identificator: "; break;
        case 7: tip = "Delimitator: "; break;
        case 8: tip = "Spatiu: "; break;
        case 9: tip = "Comentariu: "; break;
        case 10: tip = "Eroare: "; break;
    }

    return tip;
}

// Dacă un cuvânt este specific c++
int isKeyword(string input)
{
    string keywords[30] = {"int", "float", "double", "char", "string", "bool", "long",
                           "short", "unsigned", "if", "else", "switch", "case", "default",
                           "void", "main", "return", "while", "do", "for", "union", "enum",
                           "goto", "continue", "break", "const", "static", "sizeof", "auto"};
    int ok = 0, i;
    for(i = 0; i < 29; i++)
        if(input == keywords[i]) { ok = 1; break; }

    return ok;
}





// Clasă Abstractă Stare -> la baza Token-urile (~ AFD)
class Stare
{
public:
    virtual Stare *Tranzitie(char c) // în funcție de ce caracter am
    { return nullptr; }
    virtual bool StareFinala() // dacă trebuie să mai aștept caractere noi
    { return false; }
    virtual int TipToken() // tipul de token (din cele definite mai sus)
    { return -1; }
};



/* ------------           CLASE PENTRU TIPURILE DE TOKEN-URI       ------------------- */
// Pentru Constante (Numere)
class Cifra: public Stare
{
public:
    Stare *Tranzitie(char c) override
    {
        if('0' <= c && c <= '9') return this;
        return nullptr;
    }

    bool StareFinala() override
    { return true; }
    int TipToken() override
    { return LiteralFloat; }
};
class SemnExpresie: public Stare
{
public:
    Stare *Tranzitie(char c) override
    {
        if('0' <= c && c <= '9') return new Cifra();
        return nullptr;
    }

    bool StareFinala() override
    { return false; }
    int TipToken() override
    { return -1; }
};
class Expresie: public Stare
{
public:
    Stare *Tranzitie(char c) override
    {
        if('0' <= c && c <= '9') return new Cifra(); // fac distincție între const (int) și cifră (float) -> la ce tip de token am
        else if(c == '-' || c == '+') return new SemnExpresie();  // ex: 12e-10

        return nullptr;
    }

    bool StareFinala() override
    { return false; }
    int TipToken() override
    { return -1; }
};
class Punct: public Stare
{
public:
    Stare *Tranzitie(char c) override
    {
        if('0' <= c && c <= '9') return this; // ex: 12.25
        else if(c == 'e') return new Expresie();

        return nullptr;
    }

    bool StareFinala() override
    { return true; }
    int TipToken() override
    { return LiteralFloat; }
};
class ClasaConstanta: public Stare
{
public:
    Stare *Tranzitie(char c) override
    {
        if('0' <= c && c <= '9') return this;
        else if(c == 'e') return new Expresie(); // ex: 12e-3
        else if(c == '.') return new Punct();    // nr float: 12.25

        return nullptr; // altfel, final de token
    }

    bool StareFinala() override
    { return true; }
    int TipToken() override
    { return LiteralInt; }
};



// Identificator (variabile...)
class ClasaIdentificator: public Stare
{
public:
    Stare *Tranzitie(char c) override
    {
        if(('0' <= c && c <= '9') || ('A' <= c && c <= 'Z') ||
           ('a' <= c && c <= 'z') || c == '_') return this;

        return nullptr;
    }

    bool StareFinala() override
    { return true; }
    int TipToken() override
    { return Identificator; }
};



// Char
class ClasaLiteralCharFinal: public Stare
{
public:
    Stare *Tranzitie(char c) override
    { return nullptr; }
    bool StareFinala() override
    { return true; }
    int TipToken() override
    { return LiteralChar; }
};
class ClasaLiteralCharAux: public Stare
{
public:
    Stare *Tranzitie(char c) override
    {
        // Forțez să pot să am doar un singur caracter în char
        // în momentul în care am o literă, nu mai pot să am decât simbol de final, altfel am eroare
        if(c == '\'') return new ClasaLiteralCharFinal();
        return nullptr;
    }
    bool StareFinala() override
    { return false; }
    int TipToken() override
    { return -1; }
};
class ClasaLiteralChar: public Stare
{
public:
    Stare *Tranzitie(char c) override
    {
        if(c == '\'') return new ClasaLiteralCharFinal();
        else return new ClasaLiteralCharAux();
    }

    bool StareFinala() override
    { return false; }
    int TipToken() override
    { return -1; }
};



// String
class ClasaLiteralStringFinal: public Stare
{
public:
    Stare *Tranzitie(char c) override
    { return nullptr; }
    bool StareFinala() override
    { return true; }
    int TipToken() override
    { return LiteralString; }
};
class ClasaLiteralStringAux: public Stare
{
public:
    Stare *Tranzitie(char c) override;

    bool StareFinala() override
    { return false; }
    int TipToken() override
    { return -1; }
};
class ClasaLiteralString: public Stare
{
public:
    Stare *Tranzitie(char c) override
    {
        if(c == '"') return new ClasaLiteralStringFinal();
        else if(c == '\\') return new ClasaLiteralStringAux();
        else if(c == ' ') return this;
        else if(c != '\n') return this;

        return nullptr;
    }

    bool StareFinala() override
    { return false; }
    int TipToken() override
    { return -1; }
};
Stare *ClasaLiteralStringAux::Tranzitie(char c)
{
    if(c == '\n') return new ClasaLiteralString();
    else if(c == '"') return new ClasaLiteralString();
    else if(int(c) == 13 || int(c) == 10 || c == ' ' || c == '\\') return this;

    return nullptr;
}



// Operator .
class ClasaPunct2: public Stare   // ex: pt functii (s[30].get)
{
public:
    Stare *Tranzitie(char c) override
    { return nullptr; }
    bool StareFinala() override
    { return true; }
    int TipToken() override
    { return Operator; }
};



// Whitespaces -> nu tb să apară în tabela de stringuri (tb sărite)
class ClasaSpatiu: public Stare
{
public:
    Stare *Tranzitie(char c) override
    {
        if(c == ' ' || c == '\n' ||
           c == '\t' || c == '\r' ||
           c == '\v' || c == '\b') return this;

        return nullptr;
    }

    bool StareFinala() override
    { return true; }
    int TipToken() override
    { return Spatiu; }
};



// Delimitatori
class ClasaDelimitator: public Stare
{
public:
    Stare *Tranzitie(char c) override
    { return nullptr; }
    bool StareFinala() override
    { return true; }
    int TipToken() override
    { return Delimitator; }
};



// Operator / -> comentarii sau împărțire (comentariile -> nu tb să apară în tabela de stringuri (tb sărite))
class ClasaComentariuFinal: public Stare
{
public:
    Stare *Tranzitie(char c) override
    { return nullptr; }
    bool StareFinala() override
    { return true; }
    int TipToken() override
    { return Comentariu; }
};
class ClasaComentariuSimplu: public Stare
{
public:
    Stare *Tranzitie(char c) override
    {
        if(c != '\n') return this;
        else return new ClasaComentariuFinal();
    }

    bool StareFinala() override
    { return true; }
    int TipToken() override
    { return Operator;}
};
class ClasaComentariuCompusAux: public Stare
{
public:
    Stare *Tranzitie(char c) override;

    bool StareFinala() override
    { return false; }
    int TipToken() override
    { return -1; }
};
class ClasaComentariuCompus: public Stare
{
public:
    Stare *Tranzitie(char c) override
    {
        if(c != '*') return this;
        else return new ClasaComentariuCompusAux();
    }

    bool StareFinala() override
    { return false; }
    int TipToken() override
    { return -1; }
};
class OperatorFinal: public Stare // pt ?, :, =, ++, -- (adică ultimul operator)
{
public:
    Stare *Tranzitie(char c) override
    { return nullptr; }
    bool StareFinala() override
    { return true; }
    int TipToken() override
    { return Operator; }
};
class ClasaSlash: public Stare
{
public:
    Stare *Tranzitie(char c) override
    {
        if(c == '*') return new ClasaComentariuCompus();
        else if(c == '/') return new ClasaComentariuSimplu();
        else if(c == '=') return new OperatorFinal();

        return nullptr;
    }

    bool StareFinala() override
    { return true; }     // pt că pot să am operația de împărțire
    int TipToken() override
    { return Operator; }
};
Stare *ClasaComentariuCompusAux::Tranzitie(char c)
{
    if(c == '/') return new ClasaComentariuFinal();
    else if(c == '*') return this;
    else return new ClasaComentariuCompus();
}



// != / <= / >= / *= / %= / ==
class ClasaOpDupaEgal: public Stare
{
public:
    Stare *Tranzitie(char c) override
    {
        if(c == '=') return new OperatorFinal();
        return nullptr;
    }

    bool StareFinala() override
    { return true; }
    int TipToken() override
    { return Operator; }
};



// +; +=; ++
class ClasaPlus: public Stare
{
public:
    Stare *Tranzitie(char c) override
    {
        if(c == '=' || c == '+') return new OperatorFinal();
        return nullptr;
    }

    bool StareFinala() override
    { return true; }
    int TipToken() override
    { return Operator; }
};



// -; -=; --
class ClasaMinus: public Stare
{
public:
    Stare *Tranzitie(char c) override
    {
        if(c == '=' || c == '-') return new OperatorFinal();
        return nullptr;
    }

    bool StareFinala() override
    { return true; }
    int TipToken() override
    { return Operator; }
};



// &; &=; &&
class ClasaConjunctie: public Stare
{
public:
    Stare *Tranzitie(char c) override
    {
        if(c == '&' || c == '=') return new OperatorFinal();
        return nullptr;
    }

    bool StareFinala() override
    { return true; }
    int TipToken() override
    { return Operator; }
};



// |; |=; ||
class ClasaDisjunctie: public Stare
{
public:
    Stare *Tranzitie(char c) override
    {
        if(c == '|' || c == '=') return new OperatorFinal();
        return nullptr;
    }

    bool StareFinala() override
    { return true; }
    int TipToken() override
    { return Operator; }
};
/* ------------       FINAL CLASE PENTRU TIPURILE DE TOKEN-URI     ------------------- */





// Meniu pt toate tipurile de Token-uri (în funcție de PRIMUL CARACTER din Token,
// returnez o clasă specifică; apoi, din clasa specifică voi returna alte clase,
// în funcție de ce voi întâlni, până la finalul token-ului.)
// MeniuInițial e doar pt primul caracter din Token
class MeniuInitial: public Stare
{
public:
    Stare *Tranzitie(char c) override
    {
        if('0' <= c && c <= '9') return new ClasaConstanta();
        else if(('A' <= c && c <= 'Z') || ('a' <= c && c <= 'z') || c == '_') return new ClasaIdentificator();
        else if(c == '\'') return new ClasaLiteralChar();
        else if(c == '"') return new ClasaLiteralString();
        else if(c == '.') return new ClasaPunct2();
        else if(c == ' ' || c == '\n' || c == '\t' || c == '\r' || c == '\v' || c == '\b') return new ClasaSpatiu();
        else if(c == ';' || c == ',' || c == '(' || c == ')' || c == '{' || c == '}' || c == '[' || c == ']') return new ClasaDelimitator();
        else if(c == '/') return new ClasaSlash();
        else if(c == '*' || c == '%' || c == '=' || c == '!' || c == '<' || c == '>') return new ClasaOpDupaEgal();
        else if(c == '?' || c == ':') return new OperatorFinal();
        else if(c == '+') return new ClasaPlus();
        else if(c == '-') return new ClasaMinus();
        else if(c == '&') return new ClasaConjunctie();
        else if(c == '|') return new ClasaDisjunctie();

        return nullptr;
    }

    bool StareFinala() override
    { return false; }
    int TipToken() override
    { return -1; }
};

// Analizator Lexical
class Analizator
{
private:
    bool isEroare; // dacă întâlnim eroare lexicală în text sau dacă ajung la final text
    int Index;  // la ce caracter am rămas din text
    char Text[MAX_VALUE]; // unde încarc fișierul original și parcurg cu Index
    int NrCaractere;      // nr caractere din fișier original + 1 ('\0')
public:
    Stare *Initiala;

    // Constructor (Inițializez Analizatorul)
    Analizator(char textOriginal[])
    {
        isEroare = false; Index = 0;
        Initiala = new MeniuInitial();

        NrCaractere = strlen(textOriginal);
        for(int i = 0; i < NrCaractere; i++)
            Text[i] = textOriginal[i];
    }


    Token *getToken()
    {
        // whitespaces și comentariile nu se adaugă la tabela de stringuri, se sare peste ele
        jump:
        if(isEroare) return nullptr;

        Stare *current = Initiala, *next, *lastFinal = nullptr;
        Token *token = new Token();
        int start = Index, lungime = 0, lungimeFinalaToken = 0;

        while(Index < NrCaractere - 1 && (next = current->Tranzitie(Text[Index])) != nullptr)
        {
            if(current->StareFinala())
            {
                lastFinal = current;
                lungimeFinalaToken = lungime;
            }
            current = next;
            Index++;
            lungime++;
        }


        // Dacă nu am ajuns într-o stare finală
        if(!current->StareFinala())
        {
            if(lastFinal == nullptr)
            {
                isEroare = true;

                // pentru final de filă, ca să nu fie considerată eroare
                if(int(Text[Index]) == -1 && lungime == 0) return token;


                // altfel sunt erori
                token->tip = Eroare;
                token->valoare = to_string(Index); // poziția din text unde am întâmpinat eroarea
                token->poz[token->nr_poz] = Index;
                TabelaStringuri[nrValoriDinTabelaStringuri].tip = token->tip;
                TabelaStringuri[nrValoriDinTabelaStringuri].poz[TabelaStringuri[nrValoriDinTabelaStringuri].nr_poz] = token->poz[token->nr_poz];
                TabelaStringuri[nrValoriDinTabelaStringuri].valoare = token->valoare;
                TabelaStringuri[nrValoriDinTabelaStringuri].nr_poz++;
                nrValoriDinTabelaStringuri++;
            }
            else
            {
                // dacă la final de fișier am /* -> i.e. nu închid comentariul
                if(Text[start] == '/' && Text[start + 1] == '*')
                {
                    token->tip = Eroare;
                    token->valoare = to_string(Index); // poziția din text unde am întâmpinat eroarea
                    token->poz[0] = Index;
                    TabelaStringuri[nrValoriDinTabelaStringuri].tip = token->tip;
                    TabelaStringuri[nrValoriDinTabelaStringuri].poz[0] = token->poz[0];
                    TabelaStringuri[nrValoriDinTabelaStringuri].valoare = token->valoare;
                    TabelaStringuri[nrValoriDinTabelaStringuri].nr_poz++;
                    nrValoriDinTabelaStringuri++;
                }
                else
                {
                    token = AdaugaToken(Text, start, lungimeFinalaToken, lastFinal);
                    Index -= lungime - lungimeFinalaToken;
                }
            }
        }
        else
        {
            // sar peste whitespaces sau comentarii
            if(current->TipToken() == Spatiu || current->TipToken() == Comentariu) goto jump;
            token = AdaugaToken(Text, start, lungime, current);
        }


        // să verific dacă identificatorul e cuv cheie
        if(Identificator == token->tip)
            if (isKeyword(token->valoare))
                token->tip = CuvCheie;

        return token;
    }


    Token *AdaugaToken(char Text[], int start, int lungime, Stare *vechi)
    {
        int position;
        Token *token = new Token();
        string value(Text, start, lungime);
        if((position = IndexOfValue(Text, start, lungime, vechi, value)) != -1)
        {
            token->tip = vechi->TipToken();
            if(token->tip == Spatiu || token->tip == Comentariu) return token;
            token->valoare = TabelaStringuri[position].valoare;
            token->poz[token->nr_poz++] = position;
        }
        else
        {
            token->tip = vechi->TipToken();
            if(token->tip == Spatiu || token->tip == Comentariu) return token;
            token->valoare = value;
            token->poz[token->nr_poz++] = nrValoriDinTabelaStringuri - 1;
        }


        return token;
    }

    int IndexOfValue(char arr[], int start, int length, Stare *vechi, string value)
    {
        bool equal = false;
        if (nrValoriDinTabelaStringuri == 0)
        {
            TabelaStringuri[nrValoriDinTabelaStringuri].tip = vechi->TipToken();
            TabelaStringuri[nrValoriDinTabelaStringuri].valoare = value;
            TabelaStringuri[nrValoriDinTabelaStringuri].poz[0] = start;
            TabelaStringuri[nrValoriDinTabelaStringuri].nr_poz++;
            nrValoriDinTabelaStringuri++;

            return -1;
        }
        else
        {
            for (int i = 0; i < nrValoriDinTabelaStringuri; i++)
            {
                if (length != TabelaStringuri[i].valoare.length()) continue;


                equal = true;
                if(TabelaStringuri[i].valoare != value) equal = false;

                if (equal)
                {
                    TabelaStringuri[i].poz[TabelaStringuri[i].nr_poz++] = start;
                    return i;
                }
            }
        }

        if(equal == false)
        {
            TabelaStringuri[nrValoriDinTabelaStringuri].tip = vechi->TipToken();
            TabelaStringuri[nrValoriDinTabelaStringuri].valoare = value;
            TabelaStringuri[nrValoriDinTabelaStringuri].poz[0] = start;
            TabelaStringuri[nrValoriDinTabelaStringuri].nr_poz++;
            nrValoriDinTabelaStringuri++;
        }
        return -1;
    }

};


int main(int argc, char *argv[])
{
    int i = 0, j;
    char c, text[MAX_VALUE]; // unde voi pune textul inițial, care tb token-izat
    string numeFisier(argv[1]); // primesc ca parametru numele fișierului care tb token-izat


    ifstream fin(numeFisier); // deschid fișier
    if(!fin.is_open())
    {
        cout << "Eroare la deschiderea fișierului!" << endl;
        return -1;
    }

    // Citesc din fișier și pun caracter cu caracter în vectorul meu -> text
    while(!fin.eof())
    {
        c = fin.get();
        text[i++] = c;
    }
    text[i] = '\0'; // ultimul caracter ca să închid șirul
    fin.close(); // închid fișierul

    // Inițializez analizatorul
    Analizator *analizator = new Analizator(text);
    Token *token;
    string aux;
    // Parcurg fiecare token
    while((token = analizator->getToken()) != nullptr) continue;

    /*
    for(i = 0; i < nrValoriDinTabelaStringuri; i++)
        for(j = 0; j < TabelaStringuri[i].nr_poz; j++)
        cout << afisareTipToken(TabelaStringuri[i].tip) << TabelaStringuri[i].valoare << " poz: "<<TabelaStringuri[i].poz[j]<<endl;
    */

    int sum = 0; // nr total de token (cu duplicate)
    for(i = 0; i < nrValoriDinTabelaStringuri; i++) sum += TabelaStringuri[i].nr_poz;

    // fac tabelă finală unde voi avea și duplicatele, doar pt afișare
    Token TabelaFinala[sum];
    int z = 0;
    for(i = 0; i < nrValoriDinTabelaStringuri; i++)
        for(j = 0; j < TabelaStringuri[i].nr_poz; j++)
    {
        //cout << afisareTipToken(TabelaStringuri[i].tip) << TabelaStringuri[i].valoare <<endl;
        int a = TabelaStringuri[i].poz[j];
        TabelaFinala[z].poz[0] = a;
        TabelaFinala[z].tip = TabelaStringuri[i].tip;
        TabelaFinala[z].valoare = TabelaStringuri[i].valoare;
        z++;
    }

    // sortez după poziția tokenurilor în text
    for (i = 0; i < z - 1; i++)
    {
        int min_idx = i;
        for (j = i + 1; j < z; j++)
            if(TabelaFinala[j].poz[0] < TabelaFinala[min_idx].poz[0])
                min_idx = j;

        swap(TabelaFinala[min_idx], TabelaFinala[i]);
    }

    for(i = 0; i < sum; i++)
        cout << afisareTipToken(TabelaFinala[i].tip) << TabelaFinala[i].valoare <<endl;

    return 0;
}
