#include <stdio.h> //Alocare Matrice Dinamic
#include <stdlib.h>
int **matrix(int *n, int *m)
{
    printf("Nr Linii: "); scanf("%d", n);
    printf("Nr Coloane: "); scanf("%d", m);
    int **a, i, j;
    a=(int**)malloc((*n)*sizeof(int*));
    for(i=0; i<(*n); i++)
        a[i]=(int*)malloc((*m)*sizeof(int));
    for(i=0; i<(*n); i++)
        for(j=0; j<(*m); j++) scanf("%d", &a[i][j]);
    return a;
}

int main()
{
   int **a, n ,m, i, j;
   a=matrix(&n, &m);
   for(i=0; i<n; i++)
   {
       for(j=0; j<m; j++) printf("%d ", a[i][j]);
       printf("\n");
   }
   for(i=0; i<n; i++) free(a[i]);
   free(a);

    return 0;
}
