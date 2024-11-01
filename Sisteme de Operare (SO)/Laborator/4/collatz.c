#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/errno.h>

int main(int argc, char *argv[])
{
    pid_t pid=fork();
    if(pid<0) {perror("Problema cu PID-ul.\n"); return errno;}
    else if(pid==0) //Proces Fiu
    {
        if(argc!=2) {printf("Numar insuficient de argumente.\n"); perror(NULL); }
        else
        {
            int x=atoi(argv[1]);
            printf("%d: %d ", x, x);
            while(x!=1)
            {
                if(x%2==0) x/=2;
                else x=3*x+1;
                printf("%d ", x);
            }
            printf("\n");
        }
    }
    else //Proces Parinte
    {
        wait(NULL);
        printf("Child %d finished.\n", getpid());
    }

    return 0;
}
