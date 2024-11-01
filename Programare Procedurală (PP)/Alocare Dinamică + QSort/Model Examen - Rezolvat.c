#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdarg.h>

typedef struct
{
    char cuv_romana[21], cuv_ls[21];
}Cuvant;

typedef enum {TRADUCTIBIL, PARTIAL_TRADUCTIBIL, INTRADUCTIBIL} Categorie;

int cmpCuvinte(const void *a, const void *b)
{
    Cuvant va = *(Cuvant*)a;
    Cuvant vb = *(Cuvant*)b;

    return strlen(va.cuv_romana) - strlen(vb.cuv_romana);
}

void incarcareDictionar(char *nume_dictionar, Cuvant **v, int *n)
{
    int i;

    FILE *f = fopen(nume_dictionar, "r");

    fscanf(f, "%d", n);

    *v = malloc(*n * sizeof(Cuvant));

    for(i = 0; i < *n; i++)
        fscanf(f, "%s %s", (*v)[i].cuv_romana, (*v)[i].cuv_ls);

    qsort(*v, *n, sizeof(Cuvant), cmpCuvinte);

    fclose(f);
}
//--------------------------------------------------------------
void traducereCuvant(char* cuvant, char* limba){

Cuvant *v;
int n;
char numeDictionar[100] = "dictionar_";
strcat(numeDictionar, limba);
strcat(numeDictionar, ".txt");
incarcareDictionar(numeDictionar, &v,&n);

int i;

for(i = 0 ; i < n; i++)
  if(strcmp(v[i].cuv_romana, cuvant)==0)
  {
     printf("%s", v[i].cuv_ls);
     break;
  }

}
//------------------------------------------------------------

Categorie determinareCategorieCuvant(char *cuvant_romana, char *nume_dictionar)
{
    Cuvant *v;
    int i, n, lc;

    incarcareDictionar(nume_dictionar, &v, &n);

    lc = strlen(cuvant_romana);

    for(i = 0; i < n; i++)
    {
        if(strcmp(cuvant_romana, v[i].cuv_romana) == 0)
            return TRADUCTIBIL;

        if(((strlen(v[i].cuv_romana) + 1 == lc) || (strlen(v[i].cuv_romana) + 2 == lc)) && (strncmp(cuvant_romana, v[i].cuv_romana, strlen(v[i].cuv_romana)) == 0))
            return PARTIAL_TRADUCTIBIL;
    }

    return INTRADUCTIBIL;
}

//--------------

void calculNumarCuvinteCategorii(char *nume_fisier_text_romana, char *nume_dictionar, int *nct, int *ncpt, int *nci)
{
    FILE *f = fopen(nume_fisier_text_romana, "r");
    char linie[1001], *p;
    int cc;

    *nct = *ncpt = *nci = 0;
    while(fgets(linie, 1001, f) != NULL)
    {
        p = strtok(linie, " \n");
        while(p != NULL)
        {
            cc = determinareCategorieCuvant(p, nume_dictionar);

            if( cc== TRADUCTIBIL)
                (*nct)++;
            else
                if(cc == PARTIAL_TRADUCTIBIL)
                    (*ncpt)++;
                else
                    (*nci)++;

            p = strtok(NULL, " \n");
        }
    }

    printf("%s %d %d %d\n", nume_dictionar, *nct, *ncpt, *nci);

    fclose(f);
}

//----------------------------------------------------------------------------

float calculIndiceTraductibilitate(char *nume_fisier_text_romana, char *nume_dictionar)
{
    int nct, ncpt, nci;

    calculNumarCuvinteCategorii(nume_fisier_text_romana, nume_dictionar, &nct, &ncpt, &nci);

    return (float)(nct + ncpt)/(nct + ncpt + nci);
}

//---------------------------------------------------------------------------------

char* determinareLimbaStrainaIndiceMaxim(char *nume_fisier_text_romana, ...)
{
    float it_max, it_crt;
    char *nume_dictionar_curent, *nume_dictionar_itmax;
    va_list nume_dictionare;

    va_start(nume_dictionare, nume_fisier_text_romana);

    it_max = 0.0;
    nume_dictionar_itmax = malloc(51);
    strcpy(nume_dictionar_itmax, "");
    strcpy(nume_dictionar_itmax, "");
    do
    {
        nume_dictionar_curent = va_arg(nume_dictionare, char*);
        if(nume_dictionar_curent != NULL)
        {
            it_crt = calculIndiceTraductibilitate(nume_fisier_text_romana, nume_dictionar_curent);
            printf("%s %.2f\n", nume_dictionar_curent, it_crt);
            if(it_crt > it_max)
            {
                it_max = it_crt;
                strcpy(nume_dictionar_itmax, nume_dictionar_curent);
            }
        }
    }
    while(nume_dictionar_curent != NULL);

    va_end(nume_dictionare);

    return nume_dictionar_itmax;
}

int main()
{
    char *nume_dictionar_itmax, *p, nume_fisier_traducere[51], linie[1001];
    int i, n, cc, lc;
    float it_max;
    FILE *fin, *fout;
    Cuvant *dictionar;

    nume_dictionar_itmax = determinareLimbaStrainaIndiceMaxim("text_romana.txt", "dictionar_engleza.txt",
                                                              "dictionar_franceza.txt", "dictionar_germana.txt", NULL);
    it_max = calculIndiceTraductibilitate("text_romana.txt", nume_dictionar_itmax);

    if(it_max < 0.4)
    {
        printf("Imposibil");
        free(nume_dictionar_itmax);
        return 0;
    }

    p = strchr(nume_dictionar_itmax, '_');
    strcpy(nume_fisier_traducere, "text");
    strcat(nume_fisier_traducere, p);

    incarcareDictionar(nume_dictionar_itmax, &dictionar, &n);

    fin = fopen("text_romana.txt", "r");
    fout = fopen(nume_fisier_traducere, "w");

    while(fgets(linie, 1001, fin) != NULL)
    {
        p = strtok(linie, " \n");
        while(p != NULL)
        {
            cc = determinareCategorieCuvant(p, nume_dictionar_itmax);
            lc = strlen(p);

            if(cc == INTRADUCTIBIL)
                fprintf(fout, "[%s] ", p);
            else
                for(i = 0; i < n; i++)
                {
                    if(strcmp(p, dictionar[i].cuv_romana) == 0)
                    {
                        fprintf(fout, "%s ", dictionar[i].cuv_ls);
                        break;
                    }

                    if((strlen(dictionar[i].cuv_romana) + 1 == lc) && (strncmp(p, dictionar[i].cuv_romana, strlen(dictionar[i].cuv_romana)) == 0))
                    {
                        fprintf(fout, "%s? ", dictionar[i].cuv_ls);
                        break;
                    }

                    if((strlen(dictionar[i].cuv_romana) + 2 == lc) && (strncmp(p, dictionar[i].cuv_romana, strlen(dictionar[i].cuv_romana)) == 0))
                    {
                        fprintf(fout, "%s?? ", dictionar[i].cuv_ls);
                        break;
                    }
                }

            p = strtok(NULL, " \n");
        }
    }

    free(nume_dictionar_itmax);

    fclose(fin);
    fclose(fout);

    return 0;
}
