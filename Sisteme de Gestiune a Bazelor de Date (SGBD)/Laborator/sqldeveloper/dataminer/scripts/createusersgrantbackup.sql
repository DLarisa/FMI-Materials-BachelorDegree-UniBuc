-- Run this script to backup user accoun names that have been granted privilege to ODMRUSER role.
-- The backup is used as part of the repository upgrade process.
-- All users are revoked access to ODMRUSER as part of the migration.
-- Once the migration is complete, the privilges are restored.
-- This reduces the chance of users acquiring locks on ODMRSYS objects.
-- @createusersgrantbackup.sql
--

-- drop old user backup table if it exists
DECLARE
v_sql varchar2(100);
BEGIN
v_sql := 'drop TABLE "ODMRSYS"."ODMR$USER_GRANTS_BACKUP"';
EXECUTE IMMEDIATE v_sql;
DBMS_OUTPUT.PUT_LINE (v_sql ||': succeeded');
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE (v_sql ||': drop unneccessary - no table/view exists');
END;
/

EXECUTE dbms_output.put_line('When run from SQL Developer a Create Table as select may issue complete with warning message');
-- create new backup
REMARK sql worksheet may issue a completed with warning message for create table as select 
create table "ODMRSYS"."ODMR$USER_GRANTS_BACKUP" as 
select grantee as "USER" from dba_role_privs where granted_role = 'ODMRUSER';

commit;

