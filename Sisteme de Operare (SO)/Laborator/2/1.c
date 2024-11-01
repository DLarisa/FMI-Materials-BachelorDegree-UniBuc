#include <unistd.h> //pt write
#include <string.h> //pt char
#include <sys/types.h> //urmatoarele 3 pt open
#include <sys/stat.h>
#include <fcntl.h>

int main()
{
    write(1, "Hello World!\n", 13); //0->citire; 1->scriere; 2->eroare

/* SAU
    char *a="Hey World!\n";
    write(1, a, strlen(a));

SAU
    int fin=open("fisier.txt", O_RDWR);
    char *buff="Hello!\n";
    write(fin, buff, strlen(buff));
    close(fin);
*/

	return 0;
}
