CLEAR SCREEN;

SET DEFINE ON
SET SERVEROUTPUT ON
SET VERIFY OFF;
set feedback off;
spool off;

-- History ----------------------------
Rem    MODIFIER   (DD/MM/YYYY)  Notes
Rem    dslavov     01/09/2010 - Created
Rem    dslavov     19/01/2011 - Different scripts called upon DB versions
---------------------------------------

col SCRIPT_COL new_val SCRIPT NOPRINT;
col foo new_val  LOG1 ;
var check_result varchar2(3);
var db_version   varchar2(5);

select 'osddm_upgr_'||to_char(sysdate,'DD.MM.YYYY_HH24.MI.SS')||'.log' foo from dual;
spool &LOG1;

DECLARE
 TYPE rp IS VARRAY(4) OF VARCHAR2(20);
 required_privs rp;
 v_current_p    VARCHAR2(20);
 v_p            VARCHAR2(20);
 v_db_version   VARCHAR2(100);
BEGIN

  DBMS_Output.Put_Line('===========================================');
  DBMS_Output.Put_Line('Oracle SQL Developer Data Modeling');
  DBMS_Output.Put_Line('Reporting repository upgrade utility');
  DBMS_Output.Put_Line('===========================================');
  DBMS_Output.Put_Line(CHR(13)||CHR(10));
  DBMS_Output.Put_Line(CHR(13)||CHR(10));

  DBMS_Output.Put_Line('================================');
  DBMS_Output.Put_Line('I. Check required prerequisites');
  DBMS_Output.Put_Line('================================');

 	required_privs := rp('CREATE TABLE','CREATE VIEW', 'CREATE SEQUENCE','CREATE PROCEDURE');

  FOR i IN 1..required_privs.COUNT LOOP
   v_current_p := required_privs(i);
   SELECT privilege INTO v_p FROM session_privs WHERE privilege = v_current_p;
  END LOOP;

  :check_result := 'ok';

   SELECT banner 
   INTO   v_db_version
   FROM 	v$version
   WHERE  banner LIKE 'Oracle%';

   IF (INSTR(v_db_version, '11.2') > 0) THEN
     :db_version := '11gR2';
   ELSE
     :db_version := '';
   END IF;
       
EXCEPTION
 WHEN no_data_found THEN
  :check_result := 'err';
END;
/

SELECT CASE
       WHEN :check_result = 'ok' THEN 
          'osddm_upgrrun.sql'
       ELSE 
          'osddm_upgrerr.sql'
       END
AS     SCRIPT_COL
FROM   dual;

@ &SCRIPT;

spool off;
