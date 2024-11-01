-- Run this script to install a brand new ODMRSYS account
-- @installodmr.sql DMUSER TEMP
-- Parameters
-- 1: default table space
-- 2: temp table space
-- Example:
-- @installodmr.sql USER TEMP 

SET SERVEROUTPUT ON;
--Defines required to avoid SQL WORKSHEET BUG
DEFINE D_TABLESPACE = &1
DEFINE T_TABLESPACE = &2


WHENEVER OSERROR EXIT;
WHENEVER SQLERROR EXIT SQL.SQLCODE;

EXECUTE dbms_output.put_line('Start Data Miner Repository Install Process.');
EXECUTE dbms_output.put_line('');

DECLARE
v_user_name VARCHAR2(30);
BEGIN
    EXECUTE IMMEDIATE 'select username from DBA_USERS where username = ''ODMRSYS''' INTO v_user_name;
    RAISE_APPLICATION_ERROR(-20000, 'An existing repository is already installed. Please review documenation on how to migrate or drop a repository.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE
       ('Verified that ODMRSYS is not installed.');
END;
/


--install odmrsys account
@@instodmrsys.sql &D_TABLESPACE &T_TABLESPACE

--register ODMr XMLschema.xsd with XML DB
alter session set current_schema = "ODMRSYS";
EXECUTE dbms_output.put_line('');
EXECUTE dbms_output.put_line('Install the Data Miner Workflow XML Schema.');
EXECUTE dbms_output.put_line('');
@@instschema_g.sql

--install repository objects into odmrsys
alter session set current_schema = "ODMRSYS";
@@instobjects.sql 

-- required to insure inserts performed in instobjects.sql are commited
commit;

--install the stopwords used for Oracle Text operations
alter session set current_schema = "ODMRSYS";
@@inststopwords.sql

--install the repository pl/sql packages
alter session set current_schema = "ODMRSYS";
@@instpackages.sql

--create public synonyms on packages/types etc. and grant rights to public
alter session set current_schema = "ODMRSYS";
@@instgrants.sql

--install the repository messages
alter session set current_schema = "ODMRSYS";
@@instmessages.sql


--validate install
@@validateODMRSYS.sql

--update repository status completion
UPDATE ODMRSYS.ODMR$REPOSITORY_PROPERTIES SET PROPERTY_STR_VALUE = 'LOADED' WHERE PROPERTY_NAME = 'REPOSITORY_STATUS';

commit;
--end of installodmr.sql script

EXECUTE dbms_output.put_line('End Data Miner Repository Install Process.');
EXECUTE dbms_output.put_line('');

exit;