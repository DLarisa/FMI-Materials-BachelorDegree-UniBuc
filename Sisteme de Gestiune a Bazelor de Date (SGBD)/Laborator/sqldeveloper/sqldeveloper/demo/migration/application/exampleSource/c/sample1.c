#include <stdio.h>
#include <string.h>
#include <sybfront.h>

#define USER     "scott"
#define PASSWORD "tiger"
#define TYPELEN   45
#define DATELEN   45

int main()
{
  DBPROCESS *dbproc;
  LOGINREC  *login;
  RETCODE    result_code;
  DBINT      deptno;
  DBINT      sal;
  DBCHAR     name[DBMAXNAME+1];
  DBCHAR     job[TYPELEN+1];
  if (dbinit() == FAIL)
    exit(ERREXIT);
  login = dblogin();
  DBSETLUSER(login, USER);
  DBSETLPWD(login, PASSWORD);
  DBSETLAPP(login, "sample1");
  dbproc = dbopen(login, "");
  dbloginfree(login);
  dbcmd(dbproc, "select ename, job, sal, deptno from emp");
  dbsqlexec(dbproc);
  while((result_code = dbresults(dbproc)) != NO_MORE_RESULTS)
  {
    if (result_code == SUCCEED)
    {
      dbbind(dbproc, 1, NTBSTRINGBIND, (DBINT)(DBMAXNAME+1), (BYTE DBFAR *)name);
      dbbind(dbproc, 2, NTBSTRINGBIND, (DBINT)(TYPELEN+1), (BYTE DBFAR *)job);
      dbbind(dbproc, 3, INTBIND, (DBINT)0, (BYTE *)&sal);
      dbbind(dbproc, 4, INTBIND, (DBINT)0, (BYTE DBFAR *)&deptno);
      printf ("Current Command number is %d\n", DBCURCMD(dbproc));
      while(dbnextrow(dbproc) != NO_MORE_ROWS)
        printf("%s %s %d %d\n", name, job, sal, deptno);
    }
  }
  //dbexit();
  exit(STDEXIT);
}


/* Taken the older one from our previous prototype.
 */
int CS_PUBLIC
err_handler(DBPROCESS *dbproc, int severity, int dberr, int oserr,
            char *dberrstr, char *oserrstr)
{
  if ((dbproc == NULL) )//|| (DBDEAD(dbproc)))
  {
    return (INT_EXIT);
  }
  else
  {
    fprintf(ERR_CH, "DB-Library error:\n\t%s\n", dberrstr);

    if (oserr != DBNOERR)
    {
      fprintf(ERR_CH, "Operating-system error:\n\t%s\n", oserrstr);
    }

    return (INT_CANCEL);
  }
}


int CS_PUBLIC
msg_handler(DBPROCESS *dbproc, DBINT msgno, int msgstate, int severity,
            char *msgtext, char *srvname, char *procname, int line)
{
  /*
  ** Ignore the 'Changed database to' and 'Changed language to'
  ** messages.
  */
  if (msgno == 5701 || msgno == 5703)
  {
                return (0);
  }

  fprintf(ERR_CH, "Msg %d, Level %d, State %d\n",
          msgno, severity, msgstate);

  if (strlen(srvname) > 0)
  {
    fprintf(ERR_CH, "Server '%s', ", srvname);
  }

  if (strlen(procname) > 0)
  {
    fprintf(ERR_CH, "Procedure '%s', ", procname);
  }

  if (line > 0)
  {
    fprintf(ERR_CH, "Line %d", line);
  }

  fprintf(ERR_CH, "\n\t%s\n", msgtext);
  return (0);
}
