#include <stdio.h>
#include <stdlib.h>
typedef struct
{
    char *nume;
    float temp;
}date;
int cmp(const void *a, const void *b)
{
    date va=*(date*)a;
    date vb=*(date*)b;
    if(va.temp<vb.temp) return 1;
    if(va.temp>vb.temp) return -1;
    return (-strcmp(va.nume, vb.nume));
}
int main()
{
    date *t=(date*)malloc(sizeof(date));
    float suma=0, maxi, i;
    int n=0, j;
    char s[50];
    FILE *fin=fopen("temperaturi.txt", "r");
    while(fscanf(fin, "%s", s)==1)
    {
        t[n].nume=(char*)malloc(strlen(s)+1);
        strcpy(t[n].nume, s);
        fscanf(fin, "%f", &i);
        t[n].temp=i;
        suma+=i;
        if(maxi<i) maxi=i;
        n++;
        void *p=(date*)realloc(t, (n+1)*sizeof(date));
        if(p==NULL) return -1;
        else t=p;
    }
    fclose(fin);
    FILE *fout=fopen("maxime.txt", "w");
    fprintf(fout, "%.2f\n", maxi);
    for(j=0; j<n; j++)
        if(maxi==t[j].temp) fprintf(fout, "%s\n", t[j].nume);
    fclose(fout);
    printf("%.2f", suma/n);
    qsort(t, n, sizeof(date), cmp);
    FILE *f=fopen("temp_sort.txt", "w");
    for(j=0; j<n; j++) fprintf(f, "%s %.2f\n", t[j].nume, t[j].temp);
    fclose(f);

    free(t);

    return 0;
}
