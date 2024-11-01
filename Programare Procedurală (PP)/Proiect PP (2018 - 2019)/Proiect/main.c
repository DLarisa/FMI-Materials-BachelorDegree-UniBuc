#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define max(x, y) (((x) > (y)) ? (x) : (y)) //Pentru Maximul dintre 2 Numere
#define min(x, y) (((x) < (y)) ? (x) : (y)) //Pentru Minimul dintre 2 Numere
typedef unsigned int ui;
typedef unsigned char uc;

//Punct 1: XORSHIFT32
ui *XORSHIFT32(ui w, ui h, ui seed) //Creeaza Vectorul cu Numere Generate Aleator
//Parametrii: Inaltimea si Lungimea Imaginii, Cheia Secreta
{
    ui i, n=2*w*h, x=seed;
    //Seed=cheia de criptare
    ui *r=(ui*)malloc(n*sizeof(ui)); //Vectorul declarat Dinamic
    r[0]=x; //Primul Element al Vectorului este "seed"=cheia secreta
    for(i=1; i<n; i++) //Generam restul numerelor
    {
        x=x^(x<<13);
        x=x^(x>>17);
        x=x^(x<<5);
        r[i]=x;
    }
    return r; //Returnam Vectorul
}

//Punct 2: Liniarizare Imagine
typedef struct //Structura Pixel cu 3 Octeti de Culoare
//little-endian: (inversat) BGR
{
    uc B;
    uc G;
    uc R;
}Pixel;
//Functia care Liniarizeaza o Imagine Sursa
Pixel *liniarizare(char *sursa)
{
    Pixel *L, aux; //Vectorul de Liniarizare cu Pixeli
    ui w, h, padding, i, j, z, n;

    FILE *f=fopen(sursa, "rb"); //Deschid Fisierul
    if(f==NULL)
    {printf("Nu am gasit Imaginea. Eroare."); return 0;}

    fseek(f, 18, SEEK_SET); //Pozitionam in Header
    fread(&w, sizeof(ui), 1, f); //Citim Latimea Imaginii
    fread(&h, sizeof(ui), 1, f); //Citim Inaltimea Imaginii

    //Calculam Paddingul
    if(w%4!=0) padding=4-(3*w)%4;
    else padding=0;

    n=w*h; //Nr de Elemente al Vectorului de Liniarizare
    L=(Pixel*)malloc(n*sizeof(Pixel)); //Vectorul de Pixeli declarat Dinamic

    fseek(f, 54, SEEK_SET); //Pozitionam la inceputul imaginii (skip header)
    for(i=0; i<h; i++)
    {
        for(j=0; j<w; j++)
        {
            fread(&aux, sizeof(Pixel), 1, f);
            z=(h-1-i)*w+j; //Pozitia Corecta in Vectorul de Liniarizare
            L[z]=aux;
        }
        fseek(f, padding, SEEK_CUR); //Skip Padding
    }
    fclose(f);
    return L;
}

//Punct 3: Transformare in Imagine dintr-un Vector de Pixeli(Liniarizat)
void Imagine(char *destinatie, Pixel L[], uc header[], ui h, ui w, ui padding)
{
    FILE *f=fopen(destinatie, "wb");
    fwrite(header, 54, 1, f); //Copiem Headerul Imaginii Initiale
    ui i, j, k, z;
    Pixel aux;
    uc c=0; //Pt Padding

    //Cream Noua Imagine
    for(i=0; i<h; i++)
    {
        for(j=0; j<w; j++)
        {
            z=(h-1-i)*w+j; //Pozitia Corecta in Imaginea Finala
            aux=L[z];
            fwrite(&aux, sizeof(Pixel), 1, f);
        }
        for(k=0; k<padding; k++) //Punem Octetii de Padding
            fwrite(&c, 1, 1, f);
    }
    fclose(f);
}

//Punct 4: Criptare Imagine
//Functie care genereaza o Permutare pornind de la Vectorul cu Nr Generate Aleator
ui *permutare(ui w, ui h, ui R[]) //Generare Permutare - Algoritm Durstenfeld
{
    ui n=w*h, i, j=1, rand, aux, *p;
    p=(ui*)malloc(n*sizeof(ui)); //Declarare Dinamic cu n Elemente
    for(i=0; i<n; i++)
        p[i]=i; //Initializam Permutarea (1, 2, 3, ..., n)
    //cu j parcurgem R; R[0]=seed=cheia secreta; sarim peste acest element
    for(i=n-1; i>0; i--)
    {
        rand=R[j]%(i+1); //Generare Nr Random
        j++; //Indice pentru Numerele Aleatoare Generate cu functia XORSHIFT32
        aux=p[rand]; p[rand]=p[i]; p[i]=aux; //Interschimbare
    }
    return p; //permutare
}
//Pentru a accesa fiecare Octet dintr-un "int" pe 32 de biti (4 Octeti)
union Intreg32
{
    ui x; //Valoarea Citita
    struct //Fiecare Octet
    {
        uc Octet0;
        uc Octet1;
        uc Octet2;
        uc Octet3;
    }
};
//XOR-area a 2 Pixeli pentru fiecare canal de Culoare (Pentru Codificare)
Pixel P_XOR_P(Pixel P1, Pixel P2) //P1^P2 (XOR)
{
    Pixel P;
    P.B=P1.B^P2.B;
    P.G=P1.G^P2.G;
    P.R=P1.R^P2.R;
    return P;
}
//XOR-area a unui Pixel si a unui Nr Intreg (Pentru Codificare)
Pixel P_XOR_Nr(Pixel P1, union Intreg32 SV) //P1^Nr (XOR)
{
    Pixel P;
    P.B=P1.B^SV.Octet0;
    P.G=P1.G^SV.Octet1;
    P.R=P1.R^SV.Octet2;
    return P;
}
//Functia de Criptare a Imaginii Sursa
//In Destinatie se va salva Imaginea Criptata
void criptare(char *sursa, char *destinatie, char *fisier_txt)
{
    ui seed; //Cheia Secreta=R[0]
    union Intreg32 SV; //Starting Value pt Codificare din fisier_txt (a 2-a val)
    FILE *f=fopen(fisier_txt, "r"); //Deschidem Fisierul Secret
    if(f==NULL)
    {printf("Nu am gasit Fisierul Text. Eroare."); return;}
    fscanf(f, "%u%u", &seed, &SV); //Citim seed si SV
    fclose(f);

    FILE *f_sursa=fopen(sursa, "rb"); //Deschidem Imaginea Sursa
    if(f_sursa==NULL)
   	{printf("Nu exista Imaginea Sursa. Eroare."); return;}

   	//Copiem Header
   	uc *header;
    header=(uc*)malloc(54); //Header Dinamic
   	fread(header, sizeof(uc), 54, f_sursa);

    ui w, h, padding, n, i;
   	w=*(ui*)&header[18]; //Latimea Imaginii
   	h=*(ui*)&header[22]; //Inaltimea Imaginii
   	n=w*h; //Nr Pixeli
   	//Calculam Paddingul
    if(w%4!=0) padding=4-(3*w)%4;
    else padding=0;

    ui *R=XORSHIFT32(w, h, seed); //Vectorul cu Nr Generate Aleator
    ui *Permutare=permutare(w, h, R); //Permutarea pt Criptare

    Pixel *L, *L_perm;
    L=liniarizare(sursa); //Imaginea Liniarizata
    L_perm=(Pixel*)malloc(n*sizeof(Pixel)); //Imaginea Liniarizata Permutata
    for(i=0; i<n; i++)
        L_perm[Permutare[i]]=L[i]; //Obtinem Imaginea Liniarizata Permutata
    free(L); //Dezalocam Memoria pt Vectorul de Liniarizare
    free(Permutare); //Dezalocam Memoria pt Vectorul de Permutare

    //Imaginea Criptata
    for(i=0; i<n; i++)
    {
        if(i==0)
        {
            L_perm[0]=P_XOR_Nr(L_perm[0], SV);
            SV.x=R[n];
            L_perm[0]=P_XOR_Nr(L_perm[0], SV);
        }
        else
        {
            L_perm[i]=P_XOR_P(L_perm[i-1], L_perm[i]);
            SV.x=R[n+i];
            L_perm[i]=P_XOR_Nr(L_perm[i], SV);
        }
    }
    //Creeaza Imaginea Criptata pornind de la cea Originala
    Imagine(destinatie, L_perm, header, h, w, padding);

    free(R); //Dezalocam Memoria
    free(L_perm); //Dezalocam Memoria
    free(header); //Dezalocam Memoria
    fclose(f_sursa);
}

//Punct 5: Decriptare Imagine
void decriptare(char *sursa, char *imag_decriptata, char *fisier_txt)
{
    ui seed; //Cheia Secreta=R[0]
    union Intreg32 SV, aux; //Starting Value pt Decodificare
    FILE *f=fopen(fisier_txt, "r"); //Deschidem Fisierul Secret
    if(f==NULL)
    {printf("Nu am gasit Fisierul Text. Eroare."); return;}
    fscanf(f, "%u%u", &seed, &SV); //Citim seed si SV
    fclose(f);
    aux=SV;

    FILE *f_sursa=fopen(sursa, "rb");
    if(f_sursa==NULL)
    {printf("Nu exista Imaginea Criptata Sursa. Eroare."); return;}

    //Copiem Header
   	uc *header;
    header=(uc*)malloc(54); //Header Dinamic
   	fread(header, sizeof(uc), 54, f_sursa);

    ui w, h, padding, n;
    int i;
   	w=*(ui*)&header[18]; //Latimea Imaginii
   	h=*(ui*)&header[22]; //Inaltimea Imaginii
   	n=w*h; //Nr Pixeli
   	//Calculam Paddingul
    if(w%4!=0) padding=4-(3*w)%4;
    else padding=0;

    ui *R=XORSHIFT32(w, h, seed); //Vectorul cu Nr Generate Aleator
    ui *Permutare=permutare(w, h, R); //Permutare Initiala de la Criptare

    //Calcul Inversa Permutarii (pentru Decriptare)
    ui *perm_inv=(ui*)malloc(n*sizeof(ui));
    for(i=0; i<n; i++)
        perm_inv[Permutare[i]]=i;
    free(Permutare); //Dezaloc Memoria

    //Liniarizare Imagine Criptata
    Pixel *C=liniarizare(sursa);

    //Intoarcem Pixelii la Valorile Initiale
    for(i=n-1; i>=0; i--)
    {
        if(i==0)
        {
            //Aux pt ca SV isi pierde val initiala deoarece ia valorile Pixelilor de la coada spre inceput
            C[0]=P_XOR_Nr(C[0], aux);
            SV.x=R[n+i];
            C[0]=P_XOR_Nr(C[0], SV);
        }
        else
        {
            C[i]=P_XOR_P(C[i-1], C[i]);
            SV.x=R[n+i];
            C[i]=P_XOR_Nr(C[i], SV);
        }
    }

    //Decriptare
    Pixel *D=(Pixel*)malloc(n*sizeof(Pixel));
    for(i=0; i<n; i++)
        D[perm_inv[i]]=C[i];

    //Returnam Imaginea Decriptata
    Imagine(imag_decriptata, D, header, h, w, padding);

    free(C); //Dezaloc Memoria
    free(header); //Dezaloc Memoria
    free(R); //Dezaloc Memoria
    free(perm_inv); //Dezaloc Memoria
    free(D); //Dezaloc Memoria
    fclose(f);
}

//Punct 6: Histograma Culorilor - Testul chi-patrat
void histrograma(char *sursa)
{
    FILE *f=fopen(sursa, "rb"); //Deschidem Imaginea Sursa
    if(sursa==NULL)
   	{printf("Nu exista Imaginea Sursa pentru Textul x-patrat. Eroare."); return;}

   	ui w, h, n, i;
   	fseek(f, 18, SEEK_SET);
    fread(&w, sizeof(ui), 1, f); //Latimea Imaginii
    fread(&h, sizeof(ui), 1, f); //Inaltimea Imaginii
   	n=w*h; //Nr Pixeli
   	float f0=(float)n/256; //Frecventa Estimata

   	Pixel *L=liniarizare(sursa); //Imaginea Liniarizata
   	fclose(f); //Inchidem Imaginea

   	double x=0, aux;
   	ui *frecv; //Vectori de Frecventa
   	frecv=(ui*)malloc(256*sizeof(ui)); //Alocam Dinamic
   	for(i=0; i<256; i++) frecv[i]=0; //Initializam cu 0
   	for(i=0; i<n; i++) //Calculam Frecventa Red
        frecv[L[i].R]++;
    for(i=0; i<256; i++)
    {
        aux=(double)frecv[i]-f0;
        aux=(double)aux*aux;
        aux=(double)aux/f0;
        x=(double)x+aux;
    }
    printf("Red: %.2f\n", x); //Afisare Red

    x=0;
    for(i=0; i<256; i++) frecv[i]=0; //Initializam cu 0
   	for(i=0; i<n; i++) //Calculam Frecventa Green
        frecv[L[i].G]++;
    for(i=0; i<256; i++)
    {
        aux=(double)frecv[i]-f0;
        aux=(double)aux*aux;
        aux=(double)aux/f0;
        x=(double)x+aux;
    }
    printf("Green: %.2f\n", x); //Afisare Green

    x=0;
    for(i=0; i<256; i++) frecv[i]=0; //Initializam cu 0
   	for(i=0; i<n; i++) //Calculam Frecventa Blue
        frecv[L[i].B]++;
    for(i=0; i<256; i++)
    {
        aux=(double)frecv[i]-f0;
        aux=(double)aux*aux;
        aux=(double)aux/f0;
        x=(double)x+aux;
    }
    printf("Blue: %.2f\n", x); //Afisare Blue

    free(L); //Dezaloc Memoria
   	free(frecv); //Dezaloc Memoria
}

//Punct 7: Template Matching
//Functie Grayscale
void grayscale(char *sursa, char *destinatie)
{
    FILE *f=fopen(sursa, "rb"); //Deschidem Imaginea Sursa
    if(f==NULL)
   	{printf("Nu exista Imaginea Sursa pt Grayscale. Eroare."); return;}

   	//Copiem Header
   	uc *header;
    header=(uc*)malloc(54); //Header Dinamic
   	fread(header, sizeof(uc), 54, f);

    ui w, h, padding, n, i;
   	w=*(ui*)&header[18]; //Latimea Imaginii
   	h=*(ui*)&header[22]; //Inaltimea Imaginii
   	n=w*h; //Nr Pixeli
   	//Calculam Paddingul
    if(w%4!=0) padding=4-(3*w)%4;
    else padding=0;
    fclose(f);

    Pixel *L;
    L=liniarizare(sursa); //Imaginea Liniarizata
    char aux;
    //Transformam Valorile Initiale ale Pixelilor in Valori Grayscale
    for(i=0; i<n; i++)
    {
        aux=0.299*L[i].R+0.587*L[i].G+0.114*L[i].B;
        L[i].R=L[i].G=L[i].B=aux;
    }
    //Creez Noua Imagine Alb-Negru
    Imagine(destinatie, L, header, h, w, padding);

    free(L); free(header); //Dezaloc Memoria
}
//Creeaza Matrice de Pixeli pentru Imaginea Sursa cu contur in functie de dimensiunile Sablonului
Pixel **Matrice(char *sursa, ui wS, ui hS, ui *w, ui *h)
{
    FILE *f=fopen(sursa, "rb");
    if(f==NULL)
    {printf("Nu am gasit Imaginea Sursa pt Matrice. Eroare."); return 0;}
    ui wM, hM, n, i, j, padding;

    fseek(f, 18, SEEK_SET); //Pozitionam in Header
    fread(&wM, sizeof(ui), 1, f); //Citim Latimea Imaginii
    wM+=2*(wS-1); //Noua Latime a Matricei cu Conturul (adaugam dimensiunile Sablonului)
    fread(&hM, sizeof(ui), 1, f); //Citim Inaltimea Imaginii
    hM+=2*(hS-1); //Noua Inaltime a Matricei cu Conturul (adaugam dimensiunile Sablonului)
    (*w)=wM; (*h)=hM; //Retinem Latimea si Inaltimea Matricei

    //Calculam Paddingul
    if(wM%4!=0) padding=4-(3*wM)%4;
    else padding=0;

    //Alocam Dinamic Matrice
    Pixel **matrix=(Pixel**)malloc(hM*sizeof(Pixel*));
    for(i=0; i<hM; i++)
        matrix[i]=(Pixel*)malloc(wM*sizeof(Pixel));
    Pixel negru={0, 0, 0}; //Pixel de Culoare Neagra pt Contur
    for(i=0; i<hM; i++)
        for(j=0; j<wM; j++) matrix[i][j]=negru; //Coloram Toata Matricea Neagra

    Pixel aux;
    fseek(f, 54, SEEK_SET); //Pozitionam la inceputul imaginii (skip header)
    //Matricea este Imaginea Inversa (asa cum e retinuta in memorie)
    for(i=hS-1; i<=hM-hS; i++)
    {
        for(j=wS-1; j<=wM-wS; j++)
        {
            fread(&aux, sizeof(Pixel), 1, f);
            matrix[i][j]=aux;
        }
        fseek(f, padding, SEEK_CUR); //Skip Padding
    }
    fclose(f);
    return matrix;
}
//Matrice pentru Sablon
Pixel **M_Sablon(char *sablon, ui *wS, ui *hS)
{
    FILE *f=fopen(sablon, "rb");
    if(f==NULL)
    {printf("Nu am gasit Sablonul. Eroare."); return 0;}
    ui w, h, n, i, j, padding;

    fseek(f, 18, SEEK_SET); //Pozitionam in Header
    fread(&w, sizeof(ui), 1, f); //Citim Latimea Sablonului
    fread(&h, sizeof(ui), 1, f); //Citim Inaltimea Sablonului

    //Calculam Paddingul
    if(w%4!=0) padding=4-(3*w)%4;
    else padding=0;

    //Alocam Dinamic Matrice
    Pixel **matrix=(Pixel**)malloc(h*sizeof(Pixel*)), aux;
    for(i=0; i<h; i++)
        matrix[i]=(Pixel*)malloc(w*sizeof(Pixel));
    fseek(f, 54, SEEK_SET); //Pozitionam la inceputul imaginii (skip header)
    //Matricea este Imaginea Inversa (asa cum e retinuta in memorie)
    for(i=0; i<h; i++)
    {
        for(j=0; j<w; j++)
        {
            fread(&aux, sizeof(Pixel), 1, f);
            matrix[i][j]=aux;
        }
        fseek(f, padding, SEEK_CUR); //Skip Padding
    }
    (*wS)=w; //Retinem Latimea Sablonului
    (*hS)=h; //Retinem Inaltimea Sablonului
    fclose(f);
    return matrix;
}
//Calcul Formula Corelatie
double corelatie(Pixel **Imagine, Pixel **Sablon, ui wS, ui hS, ui wM, ui hM, ui l, ui c)
{
    ui i, j, nS=wS*hS;
    //nS=Nr Pixeli Sablon=Nr Pixeli Fereastra
    double cor=0, f_bar=0, s_bar=0, ofI=0, oS=0, aux;
    for(i=0; i<hS; i++)
        for(j=0; j<wS; j++)
        {
            s_bar=(double)s_bar+Sablon[i][j].R;
            f_bar=(double)f_bar+Imagine[l+i][c+j].R;
        }
    s_bar=(double)s_bar/nS;
    f_bar=(double)f_bar/nS;
    for(i=0; i<hS; i++)
        for(j=0; j<wS; j++)
        {
            oS=(double)oS+(Sablon[i][j].R-s_bar)*(Sablon[i][j].R-s_bar);
            ofI=(double)ofI+(Imagine[l+i][c+j].R-f_bar)*(Imagine[l+i][c+j].R-f_bar);
        }
    aux=(double)nS-1;
    aux=(double)1/aux;
    oS=(double)oS*aux; oS=sqrt(oS);
    ofI=(double)ofI*aux; ofI=sqrt(ofI);
    for(i=0; i<hS; i++)
        for(j=0; j<wS; j++)
        {
            aux=(double)(oS*ofI);
            aux=(double)1/aux;
            cor=(double)cor+(Imagine[l+i][c+j].R-f_bar)*(Sablon[i][j].R-s_bar)*aux;
        }
    cor=(double)cor/nS;
    return cor;
}
typedef struct //Fereastra fI
{
    ui X, Y; //Linie si Coloana - Coordonate Pixel de Inceput al Ferestrei
    double cor; //Corelatia Corespunzatoare Ferestrei
    Pixel C; //Culoarea Bordurii Ferestrei
} fI;
//Functia returneaza vectorul de ferestre pentru un Sablon si Imaginea_gri
fI *v_detectie_cifra(char *Imagine_Gri, char *Sablon, double pS, ui *nr, Pixel Culoare, ui *w, ui *h)
{
    ui i, j, wS, hS, wM, hM;

    //Transformam Sablonul in Imagine Alb-Negru
    char Sablon_gri[101];
    printf("Numele Sablon_Gri: ");
    fgets(Sablon_gri, 101, stdin);
    Sablon_gri[strlen(Sablon_gri)-1]='\0';
    grayscale(Sablon, Sablon_gri);

    Pixel **s=M_Sablon(Sablon_gri, &wS, &hS); //Matrice cum e Stocat Sablonul_Gri in Memorie
    (*w)=wS; (*h)=hS;
    Pixel **m=Matrice(Imagine_Gri, wS, hS, &wM, &hM); //Matrice cum e Stocata Imaginea_Gri in Memorie

    (*nr)=0; //Nr de Detectii pt un Sablon
    fI *v=(fI*)malloc(10000*sizeof(fI)); //Alocam Vectorul de Detectii Dinamic pt un Sablon
    fI aux;
    double corr;
    for(i=0; i<=hM-hS; i++)
    {
        for(j=0; j<=wM-wS; j++)
        {
            corr=corelatie(m, s, wS, hS, wM, hM, i, j);
            //printf("%u-%u: %.2f\n", i, j, corr);
            if(corr>=pS)
            {
                aux.cor=corr; aux.X=i; aux.Y=j; aux.C=Culoare;
                v[(*nr)]=aux;
                //printf("Vector:%u-%u: %.2f\n", v[nr].X, v[nr].Y, v[nr].cor);
                (*nr)++;
            }
        }
    }
    //printf("%u\n", *nr);
    if(*nr)
    {
        //Realocam Vectorul de Detectii ca sa aiba "nr" Elemente
        void *p=(fI*)realloc(v, (*nr)*sizeof(fI));
        if(p==NULL) {printf("Eroare la Realocare!"); return -1;}
        else v=p;
    }
    free(*m); free(m); //Dezaloc Memoria
    free(*s); free(s); //Dezaloc Memoria
    return v;
}

//Punct 8: Desenare Contur Pentru Fiecare Detectie
//Functie Care Intoarce Culoarea unui Pixel in functie de Cifra Introdusa
Pixel Culoare(ui cifra)
{
    Pixel C;
    switch(cifra)
    {
        case 0: {C.R=255; C.G=0; C.B=0; return C;}
        case 1: {C.R=255; C.G=255; C.B=0; return C;}
        case 2: {C.R=0; C.G=255; C.B=0; return C;}
        case 3: {C.R=0; C.G=255; C.B=255; return C;}
        case 4: {C.R=255; C.G=0; C.B=255; return C;}
        case 5: {C.R=0; C.G=0; C.B=255; return C;}
        case 6: {C.R=192; C.G=192; C.B=192; return C;}
        case 7: {C.R=255; C.G=140; C.B=0; return C;}
        case 8: {C.R=128; C.G=0; C.B=128; return C;}
        case 9: {C.R=128; C.G=0; C.B=0; return C;}
        default: {printf("A fost introdusa o valoare gresita pentru cifra.\n"); return;}
    }
}
//Functie care Deseneaza Conturul unei Ferestre in Imaginea Sursa
void desenare(char *Imagine, fI Fereastra, ui wS, ui hS)
{
    FILE *f=fopen(Imagine, "rb"); //Deschidem Imaginea Sursa
    if(f==NULL)
   	{printf("Nu exista Imaginea Sursa pentru Desenare. Eroare."); return;}

   	//Copiem Header
   	uc *header;
    header=(uc*)malloc(54); //Header Dinamic
   	fread(header, sizeof(uc), 54, f);
   	fclose(f);

    ui wM, hM, padding, n, i, j, k, w, h;
    uc c=0;
    Pixel **m=Matrice(Imagine, wS, hS, &wM, &hM), aux; //Matrice Imagine+Contur
    w=wM-2*(wS-1); //Latimea Imagine Originala
    h=hM-2*(hS-1); //Inaltime Imagine Originala
   	//Calculam Paddingul
    if(w%4!=0) padding=4-(3*w)%4;
    else padding=0;

    //Desenam Conturul pentru o Fereastra
    for(i=Fereastra.X; i<Fereastra.X+hS; i++)
        m[i][Fereastra.Y]=m[i][Fereastra.Y+wS-1]=Fereastra.C;
    for(j=Fereastra.Y+1; j<Fereastra.Y+wS-1; j++)
        m[Fereastra.X][j]=m[Fereastra.X+hS-1][j]=Fereastra.C;

    FILE *f_scrie=fopen(Imagine, "wb");
    fwrite(header, 54, 1, f_scrie); //Copiem Headerul Imaginii Initiale
    //Cream Noua Imagine in care se afla Fereastra cu Contur
    for(i=0; i<h; i++)
    {
        for(j=0; j<w; j++)
        {
            aux=m[i+hS-1][j+wS-1];
            fwrite(&aux, sizeof(Pixel), 1, f);
        }
        for(k=0; k<padding; k++) //Punem Octetii de Padding
            fwrite(&c, 1, 1, f);
    }
    free(*m); free(m); //Dezaloc Memoria
    fclose(f);
}

//Punct 9: QSort
int cmp(const void *a, const void *b)
{
    fI va=*(fI*)a;
    fI vb=*(fI*)b;
    if(va.cor<vb.cor) return 1;
    if(va.cor>vb.cor) return -1;
    return 0;
}
//Functia care sorteazã Descrescãtor vectorul de Detectii
fI *sort_desc(fI *v, ui n)
{
    fI *aux=v;
    qsort(aux, n, sizeof(fI), cmp);
    return aux;
}

//Punct 10: Non-maxime
//Functie care Verifica daca 2 Ferestre se Suprapun
ui da_nu(fI P1, fI P2, ui wS, ui hS)
{
    //Ferestrele au coordonatele numite invers fata de Punctele din Plan
    ui l1x=P1.Y,      l1y=P1.X+hS-1, l2x=P2.Y,      l2y=P2.X+hS-1,
       r1x=P1.Y+wS-1, r1y=P1.X,      r2x=P2.Y+wS-1, r2y=P2.X;
    if (l1x>r2x || l2x>r1x) return 0;
    if (l1y<r2y || l2y<r1y) return 0;

    return 1;
}
//Calcul Suprapunere
double suprapunere(fI P1, fI P2, ui wS, ui hS)
{
    if(da_nu(P1, P2, wS, hS)==0) return 0;
    ui l1x=P1.Y,      l1y=P1.X,      l2x=P2.Y,      l2y=P1.X,
       r1x=P1.Y+wS-1, r1y=P1.X+hS-1, r2x=P2.Y+wS-1, r2y=P2.X+hS-1;

    ui a1=abs(l1x-r1x)*abs(l1y-r1y);
    ui a2=abs(l2x-r2x)*abs(l2y-r2y);
    ui aI=(min(r1x, r2x)- max(l1x, l2x)) * (min(r1y, r2y) - max(l1y, l2y));

    double sup=(double)a1+a2-aI;
    sup=(double)aI/sup;
    return sup;
}
//Eliminarea Non-Maximelor din Vectorul de Detectii
fI *detectii(ui nr_sab, char *Imagine, double pS, ui *n, ui *w, ui *h)
{
    //Creearea Imaginii Alb-Negru din cea Originala
    char nume_img_gri[101]; fflush(stdin);
    printf("Numele Imaginii Sursa Gri pe care se aplica Template-Matching: ");
    fgets(nume_img_gri, 101, stdin);
    nume_img_gri[strlen(nume_img_gri)-1]='\0';
    grayscale(Imagine, nume_img_gri);
    fflush(stdin);

    ui i, j, nr, z=0, wS, hS;
    (*n)=0; //Nr Elemente Vector de Detectii
    fI **m=(fI**)malloc(10*sizeof(fI*)); //Matrice cu 10 Linii(pt 10 cifre)
    ui *numere=(ui*)malloc(10*sizeof(ui)); //Vector care retine nr de elemente pentru fiecare linie a Matricei
    for(i=0; i<nr_sab; i++) //In functie de cate Sabloane Introducem de la Tastatura
    {
        ui nr=0, cifra;
        printf("Cifra: "); scanf("%u", &cifra);
        Pixel C=Culoare(cifra); //Culoare in Functie de Cifra Citita

        //Creez Sablon Alb-Negru
        char Sablon[101];
        printf("Numele Sablon pentru Cifra %u: ", cifra);
        fflush(stdin);
        fgets(Sablon, 101, stdin);
        Sablon[strlen(Sablon)-1]='\0';

        //O Linie a Matricei contine Vectorul de Detectii pentru un Sablon
        m[i]=v_detectie_cifra(nume_img_gri, Sablon, pS, &nr, C, &wS, &hS);
        (*n)+=nr; //Nr Detectii Totale
        numere[i]=nr; //Retinem Nr de Elemente de pe Linia i a Matricei
    }

    //Aloc Dinamic Vector cu n Elemente pentru Detectii
    fI *v=(fI*)malloc((*n)*sizeof(fI));
    //Copiem Detectiile in Vector
    for(i=0; i<nr_sab; i++)
        for(j=0; j<numere[i]; j++) v[z]=m[i][j], z++;
    free(*m); free(m); free(numere); //Dezaloc Memoria
    nr=(*n); (*w)=wS; (*h)=hS;
    v=sort_desc(v, nr); //Ordonam Descrescator

    //Pastram doar ferestrele cu suprapunere mai mare de 0.2
    double sup;
    for(i=0; i<nr-1; i++)
    {
        for(j=i+1; j<nr; j++)
        {
            sup=suprapunere(v[i], v[j], wS, hS);
            if(sup>0.2)
            {
                for(z=j; z<nr-1; z++) v[z]=v[z+1];
                nr--; j--;
            }
        }
    }

    (*n)=nr;
    return v;
}

int main()
{
    //Prima Parte: Criptarea
    char nume_img_originala[101];
    char nume_img_criptata[101];
    char nume_img_decriptata[101];
    char fisier_secret[101];

    printf("Numele Imaginii care se doreste Criptata: ");
    fgets(nume_img_originala, 101, stdin);
    nume_img_originala[strlen(nume_img_originala)-1]='\0';
    fflush(stdin);

    printf("Numele Imaginii Criptate: ");
    fgets(nume_img_criptata, 101, stdin);
    nume_img_criptata[strlen(nume_img_criptata)-1]='\0';
    fflush(stdin);

    printf("Numele Imaginii Decriptate: ");
    fgets(nume_img_decriptata, 101, stdin);
    nume_img_decriptata[strlen(nume_img_decriptata)-1]='\0';
    fflush(stdin);

    printf("Numele Fisier care Contine Cheia de Criptare: ");
    fgets(fisier_secret, 101, stdin);
    fisier_secret[strlen(fisier_secret)-1]='\0';
    fflush(stdin);

    criptare(nume_img_originala, nume_img_criptata, fisier_secret);
    decriptare(nume_img_criptata, nume_img_decriptata, fisier_secret);
    printf("Valori Test Chi-Patrat pentru Poza Originala:\n");
    histrograma(nume_img_originala);
    printf("\nValori Test Chi-Patrat pentru Poza Criptata:\n");
    histrograma(nume_img_criptata);


    //Partea a II-a: Template Matching
    char nume_img_tm[101];

    fflush(stdin);
    printf("Numele Imaginii pentru Pattern Recognition: ");
    fgets(nume_img_tm, 101, stdin);
    nume_img_tm[strlen(nume_img_tm)-1]='\0';
    fflush(stdin);

    ui i, n, nr_sab, wS, hS;
    printf("Numarul de Sabloane Citite: "); scanf("%u", &nr_sab);
    fI *v=detectii(nr_sab, nume_img_tm, 0.5, &n, &wS, &hS);
    for(i=0; i<n; i++)
        desenare(nume_img_tm, v[i], wS, hS);
    free(v);

    return 0;
}
