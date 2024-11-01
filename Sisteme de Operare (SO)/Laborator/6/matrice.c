#include <pthread.h>
#include <errno.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int **matrixA, **matrixB;
struct mat
{
	// poz i curent, poz j curent, dimensiunea p
	int i, j, p;
};

void *produs(void *v)
{
    struct mat *arg=v;
    int *sum=(int *)malloc(sizeof(int));
    *sum=0;
    for(int k=0; k<arg->p; k++)
        *sum+=matrixA[arg->i][k] * matrixB[k][arg->j];

	return sum;
}

int main()
{
	int m, n, p, i, j, k=0;
	void *result;

	//Citire Matrice A
	printf("Dimensiune matrice 1: ");
	scanf("%d %d", &m, &p);
	matrixA=(int**)malloc(sizeof(int*)*m);
	for(i=0; i<m; i++)
    {
		matrixA[i]=(int *)malloc(sizeof(int)*p);
		for(j=0; j<p; j++)
		{
			int x;
			scanf("%d", &x);
            matrixA[i][j]=x;
		}
	}

	//Citire Matrice B
	printf("Dimensiune matrice 2 (primul arg sa fie acelasi ca ultimul arg de la prima matrice) : ");
	scanf("%d %d", &p, &n);
    matrixB=(int**)malloc(sizeof(int*)*p);
    for(i=0; i<p; i++)
    {
        matrixB[i]=(int *) malloc(sizeof(int)*n);
        for(j=0; j<n; j++)
        {
            int x;
            scanf("%d", &x);
            matrixB[i][j]=x;
        }
    }

    pthread_t thr[n*m];
	int resMatrix[m][n];
	for(i=0; i<m; i++)
    {
		for(j=0; j<n; j++)
		{
		    struct mat *arg=(struct mat*)malloc(sizeof(struct mat));
            arg->i=i;
            arg->j=j;
            arg->p=p;
			if(pthread_create(&thr[k++], NULL, produs, arg))
			{
				perror(NULL);
                return errno;
			}
		}
	}

	k=0;
	for(i=0; i<m; i++)
		for(j=0; j<n; j++)
        {
            if(pthread_join(thr[k++], &result))
            {
				perror(NULL);
				return errno;
			}
			resMatrix[i][j]=*((int*)result);
        }

	//Afisare Matrice Rezultata
    printf("\n\nREZULTAT:\n");
    for(i=0; i<m; i++)
    {
        for(j=0; j<n; j++) printf("%d ", resMatrix[i][j]);
        printf("\n");
    }

    //Dezaloc Memoria
    for(i=0; i<m; i++) free(matrixA[i]);
    for(i=0; i<p; i++) free(matrixB[i]);

    return 0;
}
