-- dropRole.sql drops the ODMRUSER role
-- NOTE: ERRORS ARE OK FOR THE DROP ROLE, AS IT CONFIRMS THE ROLE DOES NOT EXIST
--Drop ODMRSUSER role
DECLARE
v_sql varchar2(100); 
role_not_exist EXCEPTION;
PRAGMA EXCEPTION_INIT(role_not_exist, -1919);
BEGIN
v_sql := 'drop role ODMRUSER';
EXECUTE IMMEDIATE v_sql;
DBMS_OUTPUT.PUT_LINE ('drop role ODMRUSER: succeeded ');
EXCEPTION
WHEN role_not_exist THEN
        DBMS_OUTPUT.PUT_LINE ('drop role ODMRUSER: failed as ODMRUSER role does not exist ');
END;
/

