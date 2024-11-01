#include <stdio.h> //Alocare Vector Dinamic + QSort
#include <stdlib.h>
void vector_dinamic(int **v, int *n)
{
    printf("Nr Elemente: "); scanf("%d", n);
    *v=(int*)malloc((*n)*sizeof(int));
    int i;
    for(i=0; i<(*n); i++) scanf("%d", &((*v)[i]));
}
int *vector(int n)
{
    int *v=(int*)malloc(n*sizeof(int));
    int i;
    for(i=0; i<n; i++) scanf("%d", &v[i]);
    return v;
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
    int *v, *v1, n, i;
    vector_dinamic(&v, &n);
    for(i=0; i<n; i++) printf("%d ", v[i]);
    printf("\n");
    qsort(v, n, sizeof(v[0]), cmdCrescator);
    for(i=0; i<n; i++) printf("%d ", v[i]);
    free(v);
    printf("\n");
    v1=vector(5);
    for(i=0; i<5; i++) printf("%d ", v1[i]);
    free(v1);

    return 0;
}
