/*
   Executie: gcc -o w strrev.c -pthread
   Firele de executie(ale aceluiasi proces) impart resursele si vad modificarile
   facute in spatiul procesului de oricare dintre ele, fara a fi nevoie de o structura
   intermediara (ca la fork).
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include <errno.h>

void *oglinda(void *sir) //pt fire de executie, neaparat functii
{
    char *s=(char *)sir, *aux=(char*)malloc(strlen(s));
	for(int i=strlen(s)-1; i>=0; i--) aux[strlen(s)-1-i]=s[i];
	return aux;
}

int main(int argc, char *argv[])
{
    char *result;

    pthread_t thr;
    if(pthread_create(&thr, NULL, oglinda, argv[1]))
    //se creaza un thread nou - initializeaza thr cu noul fir de executie lansat de functia "oglinda", ofering argumentul argv[1]
    {
        perror("Nu s-a putut crea thread-ul.\n");
        return errno;
    }

    //Asteapta finalizarea executiei thread-ului thr (in mod explicit, nu poate fi alt thread)
    if(pthread_join(thr, &result))
    {
		perror("Eroare.\n");
		return errno;
	}

	printf("%s\n", result);
	free(result); //dezaloc memoria

    return 0;
}
