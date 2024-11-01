#include <stdio.h>  //Matrice Dinamic+Qsort
#include <stdlib.h>
void matrice_dinamic(int ***a, int *n, int *m)
{
    printf("Nr Linii: "); scanf("%d", n);
    printf("Nr Coloane: "); scanf("%d", m);
    *a=(int**)malloc((*n)*sizeof(int*));
    int i, j;
    for(i=0; i<(*n); i++)
        (*a)[i]=(int*)malloc((*m)*sizeof(int));
    for(i=0; i<(*n); i++)
        for(j=0; j<(*m); j++) scanf("%d", &((*a)[i][j]));
}
int cmdCrescator(const void *a, const void *b)
{
    int va=*(int*)a;
    int vb=*(int*)b;
    if(va<vb) return -1;
    if(va>vb) return 1;
    return 0;
}
int main()
{
    int **a, n, m, i, j;
    matrice_dinamic(&a, &n, &m);
    for(i=0; i<n; i++)
    {
        for(j=0; j<m; j++) printf("%d ", a[i][j]);
        printf("\n");
    }
    for(i=0; i<n; i++)
    {
        for(j=0; j<m; j++)
        {   qsort(a[i], m, sizeof(int), cmdCrescator);
            printf("%d ", a[i][j]);
        }
        printf("\n");
    }

    return 0;
}
