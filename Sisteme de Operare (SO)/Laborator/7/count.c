/*
   Executie: gcc -o w count.c -pthread
*/
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <pthread.h>
#define MAX_RESOURCES 5

int available_resources=MAX_RESOURCES;
pthread_mutex_t mtx; //pt a fi accesibila tuturor firelor de executie

int decrease(int count) //Thread-ul foloseste un Nr de Resurse
{
    pthread_mutex_lock(&mtx); //Blochez zona ca sa intre un singur thread
    if(available_resources<count)
    {
        pthread_mutex_unlock(&mtx); //Deblochez zona ca sa obtin mai multe resurse
        return -1;
    }
    else
    {
        available_resources -= count;
        printf("Got %d resources, remaining %d resources\n", count, available_resources);
    }
    pthread_mutex_unlock(&mtx); //Deblochez zona daca am terminat

    return 0;
}
int increase(int count) //Thread-ul a eliberat Resurse
{
    pthread_mutex_lock(&mtx); //Blochez Zona
    available_resources += count ;
    printf("Release %d resources, remaining %d resources\n", count, available_resources);
    pthread_mutex_unlock(&mtx); //Deblochez Zona

    return 0;
}
void *functie(void *arg) //Ca sa pot folosi thread-uri
{
    int count=(int)arg;
    decrease(count);
    increase(count);

    return NULL;
}

int main()
{
    if(pthread_mutex_init(&mtx, NULL)) //cream mutex-ul
    {
          perror("Eroare Creare Mutex.\n");
          return errno ;
    }

    printf("MAX_RESOURCES = %d\n", available_resources);

    pthread_t tid[7]; //7 fire de executie
    int i, count;
    for(i=0; i<7; i++)
    {
        count=rand()%(MAX_RESOURCES + 1);
        if(pthread_create(&tid[i], NULL, functie, count))
        //se creaza un thread nou - initializeaza thr cu noul fir de executie lansat de functia, ofering argumentul count
        {
            perror("Nu s-a putut crea thread-ul.\n");
            return errno;
        }
    }

    for(i=0; i<7; i++)
    {
        if(pthread_join(tid[i], NULL)) //asteapta finalizarea executiei unui thread
        {
            perror("Eroare.\n");
            return errno;
        }
    }

    pthread_mutex_destroy(&mtx); //Distruge mutex-ul pt ca nu mai avem nevoie de el; eliberam resursele ocupate

    return 0;
}
