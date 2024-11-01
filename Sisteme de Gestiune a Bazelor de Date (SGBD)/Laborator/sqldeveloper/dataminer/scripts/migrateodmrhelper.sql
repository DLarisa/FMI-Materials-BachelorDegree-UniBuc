
WHENEVER SQLERROR EXIT SQL.SQLCODE;

-- backup XML workflows
alter session set current_schema = "ODMRSYS";
@@createxmlworkflowsbackup.sql;

-- migrate the XML Schema to current version
EXECUTE dbms_output.put_line('');
EXECUTE dbms_output.put_line('Start Data Miner XML Migration Process.');
EXECUTE dbms_output.put_line('');
alter session set current_schema = "SYS";
@@schema11_2_0_1_9to11_2_1_1_1.sql;
EXECUTE dbms_output.put_line('');
EXECUTE dbms_output.put_line('End Data Miner XML Migration Process.');
EXECUTE dbms_output.put_line('');

WHENEVER SQLERROR CONTINUE;

-- upgrade ODMr Repository
alter session set current_schema = "ODMRSYS";
-- upgradeRepository.sql sets WHENEVER SQLERROR EXIT SQL.SQLCODE
-- a failure will result in the db being left in restricted mode
@@upgradeRepository.sql

WHENEVER SQLERROR CONTINUE;

-- install the stopwords used for Oracle Text operations
@@inststopwords.sql

-- install NLS messages
@@instmessages.sql

-- install new packages
@@instpackages.sql

WHENEVER SQLERROR EXIT SQL.SQLCODE;

alter session set current_schema = "SYS";
-- insure there are no invalid objects
@@validateODMRSYS.sql
