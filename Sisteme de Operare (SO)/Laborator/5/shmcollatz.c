/*
    Se va apela: gcc -o w shmcollatz.c -lrt
*/
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <sys/errno.h>
#include <sys/mman.h>

int main(int argc, char *argv[])
{
    int i;
    printf("Starting Parent: %d\n", getpid());

    //Parintele creeaza obiectul de memorie partajata
    char *shm_name="my_shm"; //Nume Memorie Partajata
    int shm_fd=shm_open(shm_name, O_RDWR|O_CREAT, 600);
    /*
       Se creeaza propriu-zis obiectul de MP. Daca exista, proprietarul are drepturi
       de citire/scriere, altfel se creeaza un obiect cu aceste drepturi.
    */
    if(shm_fd<0)
    {
        perror("Eroare la Crearea Memoriei Partajate.\n");
        return errno;
    }

    size_t page_size=getpagesize(); //functia returneaza nr de bytes al unei pagini, unde pagina este o dimensiune fixa, unitatea de masura folosita de mmap pt alocari de memorie sau pt file mapping
    size_t shm_size=page_size*argc; //fiecare copil va avea acces la cate o "pag" din memoria partajata
    if(ftruncate(shm_fd, shm_size)==-1) //ftruncate mareste sau micsoreaza MP in functie de dimensiunea pe care o dam
	{
		perror("Eroare la Alocarea de Memorie.\n");
		shm_unlink(shm_name); //sterge memoria creata cu shm_open, in caz de eroare
		return errno;
	}

	char *shm_ptr; //folosit pt a incarca MP in spatiul procesului
	for(i=1; i<argc; i++)
    {
        shm_ptr=mmap(0, page_size, PROT_WRITE, MAP_SHARED, shm_fd, (i-1)*page_size);
        /*
           0 - adresa la care sa fie incarcata in proces. 0 ca sa lasam decizia kernelului
           shm_ptr va indica catre catre o parte din MP, de dimensiunea unei pag (adica,
           atat cat ii tb unui proces-copil), care incepe de la bite-ul (i-1)*page_size
           din zona de memorie aferenta descriptorului shm_fd (cu dimensiunea totala shm_size);
           ce va fi doar scrisa si impartita cu restul proceselor (MAP_SHARED - modificarile
           vor fi vazute si de celelalte procese).
        */
        if(shm_ptr==MAP_FAILED)
		{
			perror("Nu s-a putut efectua impartirea memoriei in cadrul procesului.\n");
			shm_unlink(shm_name); //sterge memoria creata cu shm_open, in caz de eroare
			return errno;
		}

		pid_t pid=fork(); //creez un proces nou
        if(pid<0) {perror("Problema la PID.\n"); return errno;}
        else if(pid==0) //Proces Fiu - Copil
        {
            int x=atoi(argv[i]);
            shm_ptr+=sprintf(shm_ptr, "%d: %d ", x, x); //incarcam in zona de memorie nr din ipoteza collatz
            while(x!=1)
            {
                if(x%2==0) x/=2;
                else x=3*x+1;
                shm_ptr+=sprintf(shm_ptr, "%d ", x);
            }
            printf("Done Parent %d Me %d\n",  getppid(), getpid());
            return 1;
        }

        munmap(shm_ptr, page_size); //nu mai am nevoie de zona de memorie incarcata
    }

    for(i=1; i<argc; i++) wait(NULL); //Parintele asteapta

    //Afisare Procese-Copil (fiecare zona de memorie)
    for(i=1; i<argc; i++)
    {
        shm_ptr=mmap(0, page_size, PROT_READ, MAP_SHARED, shm_fd, (i-1)*page_size);
		printf("%s\n", shm_ptr);
		munmap(shm_ptr, page_size);
	}

	shm_unlink(shm_name);  //sterge memoria creata cu shm_open
	printf("Done Parent %d Me %d\n", getppid(), getpid());

    return 0;
}
