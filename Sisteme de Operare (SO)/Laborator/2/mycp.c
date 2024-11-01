#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h> //read, write
#include <sys/types.h> //open
#include <sys/stat.h> //open, stat
#include <fcntl.h> //open
#include <errno.h> //errno

int main(int argc, char **argv)
{
    if(argc!=3) {printf("Numar Gresit de Argumente. Incercati din Nou.\n"); return 0;}
    printf("Fisier Sursa: %s\n", argv[1]);
    printf("Fisier Copie: %s\n", argv[2]);

    int f1=open(argv[1], O_RDONLY);
    int f2=open(argv[2], O_WRONLY | O_CREAT, 200);
    /*
      daca fisierul exista, am declarat sa fie deschis doar pentru scriere (pana la |)
      daca nu exista, tb creat si permisiunea de acces este 200 (adica scriere doar pt owner). Remember: -rwx-rwx-rwx
    */
    if(f2 < 0)
    {
        perror("Eroare Deschidere Fisier Copie\n");
        return errno;
    }
    else
    {
        struct stat sb;
        if(stat(argv[1], &sb)) //stat intoarce informatii despre un obiect (aici, fisier)
        {
            perror("Eroare Fisier de Intrare.\n");
            return errno;
        }
        printf("Fisierul de intrare ocupa %jd biti pe disk.\n", sb.st_size);
        int size = sb.st_size; //marime biti fisier intrare
        char buffer[size];
        read(f1, buffer, size); //citesc intreg continutul fisierului in buffer
        write(f2, buffer, size); //scriu in copie din buffer
    }
    close(f1); close(f2);

    return 0;
}
