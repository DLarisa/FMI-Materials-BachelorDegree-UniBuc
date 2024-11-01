//Pt apel: gcc -o w babyshell.c -lreadline
/*
    Studenți:   AB Mihaela
                DLarisa

    Grupa:      241

    An:         2020

    Proiect:    BabyShell © 2020
*/
/*
    I want to be the Baby in your Shell. ;)
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/stat.h> //pt stat; S_ISDIR etc(permisiuni)
#include <pwd.h> //pt ls -l -> getpwuid
#include <grp.h> //pt ls -l -> getgrgid
#include <time.h> //pt timp
#include <readline/readline.h> //citire linie input user
#include <readline/history.h> //istoric comenzi
#include <dirent.h> //pt ls
#include <fcntl.h> //O_Rdwr etc
#include <signal.h> // pentru SIGTSTP - suspendarea unui program
#include <pthread.h>
#include <stdbool.h> // pentru tipul bool
//Stergem Ecran Shell cu o Secventa de Evacuare
#define clear() printf("\033[H\033[J")
//Numar Maxim de Caractere
#define MAXIMC 1000
//Culori
#define GREEN "\x1b[92m"
#define BLUE "\x1b[94m"
#define CYAN "\x1b[96m"
#define MAX_PROC 64
int proc_pid[MAX_PROC];
pthread_mutex_t mtx;

bool apel = 1;

/*
   Lista Comenzi:
   0.  --- > Conditionale: && si ||
   2.  --- > Pipe | (se poate introduce cate o comanda pe rand)
   3.  --- > Redirect Input/Output <, > (no limits)
   4.  --- > Normale, de la noi sau le ia din sistem, daca nu exista
   exit, pwd, echo, ls -arl, cd, mkdir, rmdir, cp
*/

void setup() {

    int i;
    for (i = 0; i < MAX_PROC; i++) {
        proc_pid[i] = -1;
    }

}

void assignPID(int childPid) {

   int i;
   for (i = 0; i < MAX_PROC; i++) {
        if (proc_pid[i] == -1) {
            proc_pid[i] = childPid;
        }
   }

}

void intro() //Intro BabyShell
{
    clear(); //sterge tot ce e deasupra
    printf("\n\n\n            Welcome to the BabyShell!\n\n\n   Autori: AB Mihaela, DLarisa\n   Disclaimer: Use at your own Risk!\n   2020\n\n");
    sleep(3); //doarme 3 secunde
    clear(); //sterge mesajul de bun venit pt a astepta comanda
}

void printDir() //Scrie Linia de Intrare inainte de a scrie comanda (contine path si numele shell-ului)
{
    char cwd[1000], aux[1000] = "BabyShell:";
    if(getcwd(cwd, sizeof(cwd)) == NULL) //getcwd intoarce un pointer la buffer-ul nostru, aka cwd, care acum contine numele path-ului; altfel, daca avem eroare, intoarce NULL
        perror("getcwd() Eroare.\n");
    else
    {
        strcat(aux, cwd); strcat(aux, "\n");
        printf("%s", aux);
    }
}

void get_input(char *input) //Input de la Utilizator
{
    /*
        Ce e in paranteza la readline e un promt, adica ce va afisa BabyShell la inceput,
        inainte sa scrii comanda propriu-zisa. Readline intoarce ce am introdus de la tastatura.
        Promt-ul nostru va afisa textul custom "BabyShell" si calea unde ne aflam in PC.
    */
    char *aux;
    aux = readline("$ "); //In input avem comanda data de la tastatura; trebuie sa o separam dupa spatii
    //printf("input = %s\n", aux);
    if(strlen(aux))
    {
        add_history(aux);
        strcpy(input, aux);
    }
    free(aux);
}

int tip(char *input) //Determinam tipul Comenzii date de Utilizator
/*
    0: Logice, ||, &&
    2: Pipe
    3: Redirect Input/Output <, >
    4: Simple sau de sistem
*/
{
    if(strstr(input, "&&") || strstr(input, "||")) {
        return 0; //expresii logice
    }
    if(strchr(input, '&')) return 1; //in Background
    if(strchr(input, '|')) return 2; //Pipe
    if(strchr(input, '<') || strchr(input, '>')) return 3;
    return 4;
}

void funct_exit()
{
    printf("La Revedere!\n\n");
    exit(0);
}

void funct_pwd()
{
    char cwd[1000];
    if(getcwd(cwd, sizeof(cwd)) == NULL) perror("getcwd() Eroare.\n");
    else if (!apel) {
        printf("%s", cwd);
        printf("\n");
    }

    apel = 1;
}

void funct_echo(char *input)
{
    if(input[4]!=' ') {printf("Eroare la Introducerea comenzii Echo!\n\n"); return;}

        for(int i=5; i<=strlen(input); i++) printf("%c", input[i]);
        printf("\n\n");


   // apel = 1;

}

void nume_file(struct dirent *name) //dirent -> directoare;  Pentru NUME FISIERE LS --- Functie Auxiliara
/*
struct dirent
{
    ino_t             d_ino;          //inode number
    off_t             d_off;          //offset to the next dirent
    unsigned short    d_reclen;       //length of this record
    unsigned char     d_type;         //type of file
    char              d_name[256];    //filename
};
*/
{
    if(name->d_type == DT_REG)          // regular file
        printf("%s%s\n", BLUE, name->d_name);
    else if(name->d_type == DT_DIR)    // directory
        printf("%s%s\n", GREEN, name->d_name);
    else                              // unknown files
        printf("%s%s\n", CYAN, name->d_name);
}

void funct_ls(int ok, int a) //ls simplu, ls -a (a=1), -r (ok=0, atunci nu avem reversed; ok=1 -> reversed)
{
    int i;
    struct dirent **namelist;
    int nr = scandir(".", &namelist, NULL, alphasort); //. -> path; ce avem in part si le sorteaza
    if(nr==-1)
    {perror ("Eroare ls.\n"); return;}

    //Altfel, nu avem eroare

    if(ok==0) //Nu avem -r
        if(a==1) //Avem -a
            for(i=0; i<nr; i++) nume_file(namelist[i]);
        else //Nu avem -a
        {
            for(i=0; i<nr; i++)
            {
                if(strcmp(namelist[i]->d_name, ".")==0 || strcmp(namelist[i]->d_name, "..")==0)
                    continue;
                else nume_file(namelist[i]);
            }
        }
    else  //Avem -r
        if(a==1) //Avem -a
            for(i=nr-1; i>=0; i--) nume_file(namelist[i]);
        else //Nu avem -a
        {
            for(i=nr-1; i>=0; i--)
            {
                if(strcmp(namelist[i]->d_name, ".")==0 || strcmp(namelist[i]->d_name, "..")==0)
                    continue;
                else nume_file(namelist[i]);
            }
        }
    printf("%sTotal: %d\n", CYAN, nr-2); //Total Elemente (fara "." si "..")
    printf("\n");

    printf("\033[0m"); //ca sa avem alb -> revenim la normal
}

void afisare_l(struct stat detalii) //Auxiliar pt ls -l
/*
    struct stat
    {
        dev_t        st_dev;     // ID of device containing file
        ino_t        st_ino;     // inode number
        mode_t       st_mode;    // protection
        nlink_t      st_nlink;   // number of hard links
        uid_t        st_uid;     // user ID of owner
        gid_t        st_gid;     // group ID of owner
        dev_t        st_rdev;    // device ID (if special file)
        off_t        st_size;    // total size, in bytes
        blksize_t    st_blksize; // blocksize for file system I/O
        blkcnt_t     st_blocks;  // number of 512B blocks allocated
        time_t       st_atime;   // time of last access
        time_t       st_mtime;   // time of last modification
        time_t       st_ctime;   // time of last status change
    };
*/
{
    /*
        Ex: drwxrwxrwx 1 root root 4586 Jan 2 05:34 'a.txt'
            d -> director (da sau nu)
            owner permission - group - other
            links associated - owner name - group name
            file size (bytes) - time modified - name
    */

    //E director sau nu?
    printf("%1s", (S_ISDIR(detalii.st_mode)) ? "d" : "-");

    //Permisiuni Owner -> read/write/execute
    printf("%1s", (detalii.st_mode & S_IRUSR) ? "r" : "-");
    printf("%1s", (detalii.st_mode & S_IWUSR) ? "w" : "-");
    printf("%1s", (detalii.st_mode & S_IXUSR) ? "x" : "-");

    //Permisiuni Group -> read/write/execute
    printf("%1s", (detalii.st_mode & S_IRGRP) ? "r" : "-");
    printf("%1s", (detalii.st_mode & S_IWGRP) ? "w" : "-");
    printf("%1s", (detalii.st_mode & S_IXGRP) ? "x" : "-");

    //Permisiuni Other -> read/write/execute
    printf("%1s", (detalii.st_mode & S_IROTH) ? "r" : "-");
    printf("%1s", (detalii.st_mode & S_IWOTH) ? "w" : "-");
    printf("%1s", (detalii.st_mode & S_IXOTH) ? "x" : "-");

    //Links Associated - User ID of Owner - Group ID of Owner
    printf("%2ld ", (unsigned long)(detalii.st_nlink));
    printf("%s ", (getpwuid(detalii.st_uid))->pw_name); //getpwuid -> search user database for a user ID (pw_name: User name; pw_uid:User ID (UID) number; pw_gid: Group ID (GID) number; pw_dir: Initial working directory; pw_shell: Initial user program)
    printf("%s ", (getgrgid(detalii.st_gid))->gr_name); //getgrgid -> struct group {char   *gr_name;       /* group name */   char   *gr_passwd;     /* group password */   gid_t   gr_gid;        /* group ID */    char  **gr_mem;        /* group members */

    //File Size(bytes) - Time Modified
    char timp[14];
    printf("%5lld ", (unsigned long long)(detalii.st_size));
    strftime(timp, 14, "%h %d %H:%M", localtime(&detalii.st_mtime)); printf("%s ", timp);
}

void funct_lsl(int ok, int a) //ok->-r; a->-a (1=da; 0=nu)
{
    int i, total=0;
    struct dirent **namelist;
    struct stat detalii;
    int nr = scandir(".", &namelist, 0, alphasort); //scanam pt directoare

    //Caz Eroare
    if(nr==-1)
    {perror ("Eroare ls -l.\n\n"); return;}

    //Caz Director gol
    if(nr==0)
    {printf("Director Gol.\n\n"); return;}

    //Caz altfel
    printf("%sTotal din Director: %d.\n", CYAN, nr-2); //cate avem in director
    printf("\033[0m");

    if(ok==0) //Nu avem -r
    {
        if(a==1) //avem -a
        {
            for(i=0; i<nr; i++)
            {
                if(stat(namelist[i]->d_name, &detalii)) //avem eroare -> la unkniwn files
                    continue;

                total += detalii.st_blocks;
                afisare_l(detalii);
                nume_file(namelist[i]); printf("\033[0m");
            }
        }
        else //nu avem -a
        {
            for(i=0; i<nr; i++)
            {
                if(strcmp(namelist[i]->d_name, ".")==0 || strcmp(namelist[i]->d_name, "..")==0) continue;
                else
                {
                    if(stat(namelist[i]->d_name, &detalii)) //avem eroare
                        continue;

                    total += detalii.st_blocks;
                    afisare_l(detalii);
                    nume_file(namelist[i]); printf("\033[0m");
                }
            }
        }
    }
    else //Avem -r
    {
        if(a==1) //avem -a
        {
            for(i=nr-1; i>=0; i--)
            {
                if(stat(namelist[i]->d_name, &detalii)) //avem eroare
                    continue;

                total += detalii.st_blocks;
                afisare_l(detalii);
                nume_file(namelist[i]); printf("\033[0m");
            }
        }
        else //nu avem -a
        {
            for(i=nr-1; i>=0; i--)
            {
                if(strcmp(namelist[i]->d_name, ".")==0 || strcmp(namelist[i]->d_name, "..")==0) continue;
                else
                {
                    if(stat(namelist[i]->d_name, &detalii)) //avem eroare
                        continue;

                    total += detalii.st_blocks;
                    afisare_l(detalii);
                    nume_file(namelist[i]); printf("\033[0m");
                }
            }
        }
    }
    printf("%sTotal (object contents): %d.\n", CYAN, total/2);
    printf("\n");

    printf("\033[0m");
}

void funct_cd(char *path)
{
    //chdir -> changes the current working directory of the calling process to the directory specified in path
    if(chdir(path)==0) //path-ul poate fi schimbat daca chdir are succes
    {
        char aux[MAXIMC];
        char *path=getcwd(aux, sizeof(aux));
        if(path!=NULL)  {strcpy(path, aux); printf("\n"); return;}
        else {perror("Eroare la getcwd()\n\n"); return;}
    }
    else perror("Eroare la cd");
}

void funct_mkdir(char *nume)
{
    if(mkdir(nume, 0777)==-1) // toate permisiunile necesare
        perror("Eroare la mkdir\n\n");
    printf("\n");
}

void funct_rmdir(char *nume)
{
    if(rmdir(nume)==-1)
        perror("Eroare la rmdir\n\n");
    printf("\n");
}

void funct_cp(char *fila, char *copie)
{
    FILE *f1, *f2;
    struct stat s1, s2;

    f1 = fopen(fila, "r"); //deschis pt read
    if(f1 == NULL)
    {perror("Eroare la citire fila.\n\n"); return;}

    f2 = fopen(copie, "ab+"); //creez copia daca nu exista; append binary
    fclose(f2);

    f2 = fopen(copie, "w+"); //deschid pt scris
    if(f2==NULL)
    {
        perror("Eroare in CP la copie.\n\n");
        fclose(f1); return;
    }

    if(open(copie, O_WRONLY)<0 || open(fila, O_RDONLY)<0)
    {perror("Eroare la accesarea CP"); return;}

    char cp;
    while((cp=getc(f1))!=EOF)  putc(cp,f2);

    printf("\n");
    fclose(f1); fclose(f2);
}

void implicit(char **cuvinte)
{
    int i = 0; ///////
	pid_t pid = fork();
	if(pid==-1) //Eroare
    {printf("Eroare FORK.\n\n"); return;}
    else if(pid==0) //Copil
    {
        if(execvp(cuvinte[0], cuvinte)<0)  printf("Nu poate executa comanda.\n\n");
		return;
	}
	else //Parinte
	{
    pthread_mutex_lock(&mtx);
    //printf("PID = %d\n", pid);
    //assignPID(pid);
    for (i = 0; i < MAX_PROC; i++) {

        proc_pid[i] = pid;
        //printf("pid = %d\n", proc_pid[i]);
    }
    pthread_mutex_unlock(&mtx);
    wait(NULL);

	return;}
}

int comanda4(char *input) //Comanda 4 (Simple)
{
    int nr = 12;
    char *lista[12];
    lista[0]="exit"; lista[1]="clear"; lista[2]="pwd"; lista[3]="echo"; lista[4]="ls";
    lista[5]="cd"; lista[6]="mkdir"; lista[7]="rmdir"; lista[8]="cp";

    if(strstr(input, lista[0])) {funct_exit(); return 0;}
    if(strstr(input, lista[1])) {clear(); return 0;}
    if(strstr(input, lista[2])) {funct_pwd();  return 0;}
    if(strstr(input, lista[3])) {funct_echo(input); return 0;}
    if(strstr(input, lista[4]) && input[0]=='l')
    {
        if(strstr(input, "-lar") || strstr(input, "-ral") || strstr(input, "-rla")
           || strstr(input, "-lra") || strstr(input, "-arl") || strstr(input, "-alr"))
        {
            if(input[2]!=' ' && strlen(input)>7) printf("Comanda nu a fost introdusa corect.\n\n");
            else funct_lsl(1, 1);
        }
        else if(strstr(input, "-lr") || strstr(input, "-rl"))
        {
            if(input[2]!=' ' && strlen(input)>6) printf("Comanda nu a fost introdusa corect.\n\n");
            else funct_lsl(1, 0);
        }
        else if(strstr(input, "-la") || strstr(input, "-al"))
        {
            if(input[2]!=' ' && strlen(input)>6) printf("Comanda nu a fost introdusa corect.\n\n");
            else funct_lsl(0, 1);
        }
        else if(strstr(input, "-ar") || strstr(input, "-ra"))
        {
            if(input[2]!=' ' && strlen(input)>6) printf("Comanda nu a fost introdusa corect.\n\n");
            else funct_ls(1, 1);
        }
        else if(strstr(input, "-a"))
        {
            if(input[2]!=' ' && strlen(input)>5) printf("Comanda nu a fost introdusa corect.\n\n");
            else funct_ls(0, 1);
        }
        else if(strstr(input, "-r"))
        {
            if(input[2]!=' ' && strlen(input)>5) printf("Comanda nu a fost introdusa corect.\n\n");
            else funct_ls(1, 0);
        }
        else if(strstr(input, "-l"))
        {
            if(input[2]!=' ' && strlen(input)>5) printf("Comanda nu a fost introdusa corect.\n\n");
            else funct_lsl(0, 0);
        }
        else if(strlen(input)>3 ||(input[2]!=' ') && strlen(input)==3) printf("Comanda nu a fost introdusa corect.\n\n");
             else funct_ls(0, 0);
        return 0;
    }
    if(strstr(input, lista[5]))
    {
        char *token = strtok(input, " ");
        while(token!=NULL)
        {
            if(strstr(token, "cd")==0) funct_cd(token);
            token = strtok(NULL, " ");
        }
        free(token);
        return 0;
    }
    if(strstr(input, lista[6]))
    {
        char *token = strtok(input, " ");
        while(token!=NULL)
        {
            if(strstr(token, "mkdir")==0) funct_mkdir(token);
            token = strtok(NULL, " ");
        }
        free(token);
        return 0;
    }
    if(strstr(input, lista[7]))
    {
        char *token = strtok(input, " ");
        while(token!=NULL)
        {
            if(strstr(token, "rmdir")==0) funct_rmdir(token);
            token = strtok(NULL, " ");
        }
        free(token);
        return 0;
    }
    if(strstr(input, "cp"))
    {
        char **cuvinte = malloc(8*sizeof(char *)), *rezultat;
        int index = 0;

        rezultat = strtok(input, " ");
        while (rezultat != NULL)
        {
            cuvinte[index] = rezultat;
            index++;

            rezultat = strtok(NULL, " ");
        }

        funct_cp(cuvinte[1], cuvinte[2]);

        return 0;
    }

    //Luam Functiile din Sistem, altfel
    char **cuvinte = malloc(8*sizeof(char *));
    for(int i=0; i<50; i++)
    {
		cuvinte[i] = strsep(&input, " ");

		if(cuvinte[i]==NULL) break;
		if(strlen(cuvinte[i])==0) i--;
	}
    implicit(cuvinte); printf("\n");

    return 0;
}

int comanda3(char *input) //Comanda 3 (Redirecting Input/Output)
{
    int pid, i, j, err;
    char *token, *separator = " \t\n", **aux, **aux2, *cp, *ifile, *ofile;

    aux = malloc(8 * sizeof(char *));
    aux2 = malloc(8 * sizeof(char *));

    //Input -> impartim
    i = 0;
    while(1)
    {
        token = strtok((i==0) ? input : NULL, separator);
        if(token==NULL) break;
        aux[i++] = token;
    }
    aux[i] = NULL;

    ofile = NULL; ifile = NULL;
    j = 0; i = 0; err = 0;
    while(1)
    {
        cp = aux[i++];
        if(cp==NULL) break;

        switch(*cp)
        {
            case '<':
                if(cp[1]==0)      cp = aux[i++];
                else              ++cp;

                ifile = cp;
                if(cp==NULL)      err = 1;
                else if(cp[0]==0) err = 1;
                break;

            case '>':
                if(cp[1]==0)      cp = aux[i++];
                else              ++cp;

                ofile = cp;
                if(cp==NULL)      err = 1;
                else if(cp[0]==0) err = 1;
                break;

            default:
                aux2[j++] = cp;
                break;
        }
    }
    aux2[j] = NULL;

    switch(pid=fork())
    {
        case 0:
            if(ifile!=NULL)
            {
                int fd = open(ifile, O_RDONLY);
                if(dup2(fd, STDIN_FILENO)==-1) {perror("DUP2 Eroare.\n\n"); return 0;}

                close(fd);
            }

            if(ofile!=NULL)
            {
                int fd2;
                if((fd2=open(ofile, O_WRONLY | O_CREAT, 0644))<0)
                {perror("FIsier Iesire nu a putut fi deschis.\n\n"); return 0;}
                dup2(fd2, STDOUT_FILENO);
                close(fd2);
            }

            execvp(aux2[0], aux2);
            signal(SIGTSTP, SIG_DFL);
            fprintf(stderr, "EROARE: %s nu e program\n\n", input);
            exit(1);
            break;

        case -1:
            perror("EROARE PROCES COPIL!\n\n");
            return 0;

        default:
            //printf("pid = %d\n", pid);
            assignPID(pid);
            wait(NULL);

    }

    return 0;
}

void separare(char *input, char **rezultat) //Functie Auxiliara pt Comanda2 -> sparge inputul dupa " "
{
	int i;

	for(i=0; i<50; i++)
    {
        rezultat[i] = strsep(&input, " ");

		if(rezultat[i]==NULL) break;
		if(strlen(rezultat[i])==0) i--;
	}
}

void comanda2(char *input) //Comanda 2 (Pipe)
{
    char **cuv1 = malloc(8*sizeof(char *)), **cuv2 = malloc(8*sizeof(char *)), *strpiped[2];
    int i;

    for(i=0; i<2; i++)
    {
		strpiped[i] = strsep(&input, "|");
		if(strpiped[i] == NULL) break;
	}
    separare(strpiped[0], cuv1);
    separare(strpiped[1], cuv2);

    int pipefd[2];
	pid_t p1, p2;

	if(pipe(pipefd)<0)
    {printf("Eroare Initializare Pipe.\n\n"); return;}

	p1 = fork();
	if(p1<0)
    {printf("Eroare FORK in Pipe.\n\n"); return;}

	if(p1==0) //Copil 1
    {
		//Scrie la write_end
		close(pipefd[0]);
		dup2(pipefd[1], STDOUT_FILENO);
		close(pipefd[1]);

		if(execvp(cuv1[0], cuv1)<0) {printf("Comanda 1 EROARE.\n\n"); return;}
	}
	else
    {
        //Parinte 1

		p2 = fork();

		if(p2<0)
        {printf("FORK 2 Eroare.\n\n"); return;}

		if(p2==0) //Copil 2
        {
            //Citeste doar la read_end
            close(pipefd[1]);
            dup2(pipefd[0], STDIN_FILENO);
            close(pipefd[0]);
            if(execvp(cuv2[0], cuv2)<0) {printf("COMANDA 2 EROARE.\n\n"); return;}
        }
        else
        {
            assignPID(p2);
			wait(NULL); //pt Parinte 2
			close(pipefd[0]);
            close(pipefd[1]);
		}

		//pt Parinte 1
		assignPID(p1);
		wait(NULL);
    }

    printf("\n");
}

// Operatorul &&
void conditional1(char *input) {

    char *cmnd1 = strtok(input, "&");
    cmnd1[strlen(cmnd1) - 1] = '\0';
    char *aux = strtok(NULL, "&\n");

    char cmnd2[strlen(aux -1)];
    strcpy(cmnd2, aux + 1);

    char echo[5];
    strncpy(echo, cmnd1, 4);
    apel = 1;
    if (strstr("clear pwd echo ls cd mkdir rmdir cp", cmnd1) || strstr("clear pwd echo ls cd mkdir rmdir cp", echo)) {
        if (comanda4(cmnd1) == 0) {
            apel = !apel;
            comanda4(cmnd2);
        }
    }
    else {
        if (strcmp("true", cmnd1) == 0) {
            apel = 0;
            comanda4(cmnd2);
        }
    }
}

// Operatorul ||
void conditional2(char *input) {

    char *cmnd1 = strtok(input, "|");
    cmnd1[strlen(cmnd1) - 1] = '\0';
    char *aux = strtok(NULL, "|\n");
    char cmnd2[strlen(aux -1)];

    char echo[5];
    strncpy(echo, cmnd1, 4);

    strcpy(cmnd2, aux + 1);
    apel = 1;
    if (strstr("clear pwd echo ls cd mkdir rmdir cp", cmnd1)) {
        if (comanda4(cmnd1) != 0) {
            //apel = !apel;
            comanda4(cmnd2);
        }
    }
    else {
        if (strcmp("false", cmnd1) == 0) {
            //apel = 0;
            comanda4(cmnd2);
        }
    }
}

// Conditionale : &&, ||
void comanda0(char *input) {

    if (strstr(input, "&&")) {
        conditional1(input);
    }
    else {
        conditional2(input);
    }

}

// Suspendarea proceselor care ruleaza
void sigHandler(int sig_num)
{
    // Reset handler to catch SIGTSTP next time
    signal(SIGTSTP, sigHandler);
    int i;
    if (proc_pid[0] != -1) {
        printf("\nProcess with pid %d suspended\n", proc_pid[0]);
    }
    for (i = 0; i < MAX_PROC; i++) {
        if (proc_pid[i] != -1) {
            kill(proc_pid[i],SIGKILL);
            proc_pid[i] = -1;
        }

    }
}

int main(int argv, char *argc[])
{
    intro();
    printf("Poti Iesi folosind CTRL+C sau comanda EXIT.\n");
    char input[MAXIMC];

    setup();

    // catch SIGTSTP and suspend the running processes
    signal(SIGTSTP, sigHandler);

    while(1)
    {
        printDir();
        get_input(input);
        int t = tip(input);
        if (t == 0) {
            comanda0(input);
        }
        if(t==2) comanda2(input);
        else if(t==3) comanda3(input);
        else if(t==4) comanda4(input);

    }

    return 0;
}
