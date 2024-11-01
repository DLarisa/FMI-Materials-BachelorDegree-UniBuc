-- Drops the ODMRSYS Repostory and ODMRUSER Role
-- Example: @dropRepository.sql 


-- Drop ODMRSYS user, and ODMRUSER role
-- NOTE: ERRORS ARE OK FOR THESE TWO DROP COMMANDS AS THEY JUST CONFIRM THE USER AND ROLE DO NOT EXIST
EXECUTE dbms_output.put_line('');
EXECUTE dbms_output.put_line('Drop ODMRSYS account.');
EXECUTE dbms_output.put_line('');

--Drop ODMRSYS account
DECLARE
v_sql varchar2(100); 
user_not_exist EXCEPTION;
PRAGMA EXCEPTION_INIT(user_not_exist, -1918);
BEGIN
v_sql := 'drop user ODMRSYS cascade';
EXECUTE IMMEDIATE v_sql;
DBMS_OUTPUT.PUT_LINE ('drop user ODMRSYS cascade: succeeded ');
EXCEPTION
WHEN user_not_exist THEN
        DBMS_OUTPUT.PUT_LINE ('drop user ODMRSYS cascade: failed as ODMRSYS account does not exist ');
END;
/
--drop user ODMRSYS cascade;
EXECUTE dbms_output.put_line('');
EXECUTE dbms_output.put_line('Drop ODMRUSER role.');
EXECUTE dbms_output.put_line('');

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


