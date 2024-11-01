#include <stdio.h>
#include <stdlib.h>
int **matrix(int n)
{
    int **aux, i, j, x=0;
    aux=(int**)malloc(n*sizeof(int*));
    for(i=n; i>0; i--)
    {
       aux[x]=(int*)malloc(i*sizeof(int));
       for(j=0; j<i; j++) scanf("%d", &aux[x][j]);
       x++;
    }
    for(i=2; i<=n; i++)
    {
       aux[x]=(int*)malloc(i*sizeof(int));
       for(j=0; j<i; j++) scanf("%d", &aux[x][j]);
       x++;
    }
    return aux;
}
void afis(char *f_bin, int **aux, int n)
{
    int i, j;
    FILE *f=fopen(f_bin, "wb");
    for(i=0; i<n; i++)
        for(j=0; j<n-i; j++) fwrite(&aux[i][j], sizeof(int), 1, f);
    for(i=n; i<2*n-1; i++)
        for(j=0; j<i-n+2; j++) fwrite(&aux[i][j], sizeof(int), 1, f);
    fclose(f);
}
int modific(char *f_bin)
{
    FILE *f=fopen(f_bin, "rb+");
    int x, maxi;
    fread(&maxi, sizeof(maxi), 1, f);
    fseek(f, 0, SEEK_SET);
    while(fread(&x, sizeof(x), 1, f)==1)
        if(maxi<x) maxi=x;
    fseek(f, 0, SEEK_SET);
    while(fread(&x, sizeof(x), 1, f)==1)
    {
        if(x<=3) x=maxi;
        fseek(f, -sizeof(x), SEEK_CUR);
        fwrite(&x, sizeof(x), 1, f);
        fflush(f);
    }
    fclose(f);
}
void bin2txt(char *f_bin, char *f_txt)
{
    FILE *fin=fopen(f_bin, "rb");
    if(fin==NULL) {printf("Eroare!\n"); return;}
    FILE *fout=fopen(f_txt, "w");
    int x;
    while(fread(&x, sizeof(x), 1, fin)==1)
        fprintf(fout, "%d ", x);
    fclose(fin); fclose(fout);
}

int main()
{
    int **a, n, i, j;
    printf("n: "); scanf("%d", &n);
    a=matrix(n);
    afis("destinatie.txt", a, n);
    modific("destinatie.txt");
    bin2txt("destinatie.txt", "sursa.txt");

    return 0;
}
