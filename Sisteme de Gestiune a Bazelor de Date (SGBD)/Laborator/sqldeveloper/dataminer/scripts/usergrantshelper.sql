-- Usage @usergrantshelper.sql <P1> <P2>
--    P1: Privilge Action
--        Option 1: GRANT
--        Option 2: REVOKE
--    P2: User Account or ODMRUSER role
--        Option 1: A user account, example: DMUSER
--        Option 2: ODMRUSER - used to query all accounts that have ODMRUSER role assigned.
--                  Only acceptable for the REVOKE operation
--        Option 3: USE_BACKUP_TABLE - used to query the ODMR$USER_GRANTS_BACKUP table generated
--                  prior to migration, to backup all the user account names that were granted access 
--                  to ODMRUSER role. Only acceptable for the GRANT operation.
--        
-- Description: This is a helper script used to both grant and revoke rights to ODMRUSER role and
-- object types that have to be granted/revoked to a user directly.
-- This also includes granting/revoking rights to the ODMRUSER role and, in the case when granting rights,
-- the script will add ODMRUSER to the users list of default roles.
-- This script is currently not called directly but called by other documented scripts such as usergrants.sql and
-- dropusergrants.sql
--
-- Example of granting rights to a user: @usergrantshelper.sql GRANT DMUSER
-- Example of revoking rights to a user: @usergrantshelper.sql REVOKE DMUSER
-- Example of revoking rights to all users with role ODMUSER: @usergrantshelper.sql REVOKE ODMRUSER

WHENEVER SQLERROR EXIT SQL.SQLCODE;

DEFINE ACTION = &&1
DEFINE USER_ACCOUNT = &&2

EXECUTE dbms_output.put_line('');
EXECUTE dbms_output.put_line('User Privilege action to be performed:' || TO_CHAR('&ACTION'));
EXECUTE dbms_output.put_line('Affected User (if ODMRUSER then all accounts with that role):' || TO_CHAR('&USER_ACCOUNT'));
EXECUTE dbms_output.put_line('');


DECLARE
TYPE ObjectNames IS VARRAY(300) OF VARCHAR2(30);
objects_array ObjectNames := ObjectNames();  
priv_action varchar2(30) := '&1';
user_account_value varchar2(120) := '&2';
odmruser_cursor    number; 
user_fetch_value varchar2(120);
ignore INTEGER;
from_to_clause varchar2(10);
sql_string varchar2(200);
odmr_user_role varchar2(20) := 'ODMRUSER';

--Define nested subprogram add_default_role to use for adding ODMRUSER role as a default role for a user

procedure add_default_role(p_user VARCHAR2) is

TYPE roles IS TABLE OF VARCHAR2(100)
    INDEX BY PLS_INTEGER;            
v_newuser varchar2(30) := p_user;
v_username varchar2(30);
v_default_role varchar2 (100);
v_granted_role varchar2 (100);
v_list_of_roles varchar2 (5000);
sql_text varchar2(6000);
Dynamic_Cursor integer; 
dummy integer; 
v_err_msg  VARCHAR2(4000);
v_roles_query_result roles;
v_odmruser_default VARCHAR2(1000);
v_all_default_roles VARCHAR2(1000);
 
BEGIN
 DBMS_OUTPUT.ENABLE(NULL);

v_odmruser_default :=
'select default_role from dba_role_privs 
 where granted_role = ''ODMRUSER''
 and grantee = :1';

v_all_default_roles :=
'select granted_role from dba_role_privs 
 where default_role = ''YES''
 and grantee = :1';

-- Is ODMRUSER one of the default roles, if so, no work required
EXECUTE IMMEDIATE v_odmruser_default INTO v_default_role USING v_newuser;
-- ODMRUSER is not one of the default roles so add it.
if v_default_role = 'NO' THEN
  -- create list of all existing default roles
  EXECUTE IMMEDIATE v_all_default_roles BULK COLLECT INTO v_roles_query_result USING v_newuser;
  FOR i IN 1..v_roles_query_result.COUNT LOOP
     v_list_of_roles := v_list_of_roles  || v_roles_query_result(i) || ',' ; 
  END LOOP;
  -- add ODMRUSER to that list
  v_list_of_roles := v_list_of_roles || 'ODMRUSER'; 
  -- alter user to have a new set of default roles
  sql_text := 'ALTER USER ' || '"' || v_newuser || '" DEFAULT ROLE ' || v_list_of_roles;
  DBMS_OUTPUT.PUT_LINE('Command: ' || sql_text);
  Dynamic_Cursor := dbms_sql.open_cursor;
  dbms_sql.parse(Dynamic_Cursor, sql_text, dbms_sql.native);
  dummy := dbms_sql.execute(Dynamic_Cursor);
  dbms_sql.close_cursor(Dynamic_Cursor); 
  DBMS_OUTPUT.PUT_LINE('ODMUSER added to list of default roles for user: ' || v_newuser);
ELSE
  DBMS_OUTPUT.PUT_LINE
       ('Validated ODMRUSER is a default role of user: ' || v_newuser);  
END IF;
EXCEPTION 
 WHEN OTHERS THEN 
   dbms_output.put_line('Exception in add_default_role routine');
   IF DBMS_SQL.IS_OPEN(Dynamic_Cursor) THEN 
     DBMS_SQL.CLOSE_CURSOR(Dynamic_Cursor); 
   END IF; 
   RAISE; 
END add_default_role;


BEGIN
     objects_array := ObjectNames('ODMR_ENGINE_TEXT', ----Text APIs require direct grant of ODMR_ENGINE_TEXT to user account, not role
         'ODMRSYS.START_PROG ',
         'ODMRSYS.CLEANUP_PROG',
         'ODMRSYS.SUBFLOW_START_PROG',
         'ODMRSYS.SUBFLOW_CLEANUP_PROG',
         'ODMRSYS.DATASOURCE_PROG',
         'ODMRSYS.DATAPROFILE_PROG',
         'ODMRSYS.CLASS_BUILD_PROG',
         'ODMRSYS.REGRESS_BUILD_PROG',
         'ODMRSYS.CLUST_BUILD_PROG',
         'ODMRSYS.ASSOC_BUILD_PROG',
         'ODMRSYS.ANOMALY_BUILD_PROG',
         'ODMRSYS.MODEL_PROG',
         'ODMRSYS.TEST_PROG',
         'ODMRSYS.APPLY_PROG',
         'ODMRSYS.MODELDETAILS_PROG',
         'ODMRSYS.CREATETABLE_PROG',
         'ODMRSYS.UPDATETABLE_PROG',
         'ODMRSYS.TRANSFORMATIONS_PROG',
         'ODMRSYS.JOIN_PROG',
         'ODMRSYS.AGGREGATION_PROG',
         'ODMRSYS.COLUMNFILTER_PROG',
         'ODMRSYS.FILTERDETAILS_PROG',
         'ODMRSYS.SAMPLE_PROG',
         'ODMRSYS.ROWFILTER_PROG',
         'ODMRSYS.FEATURE_BUILD_PROG',
         'ODMRSYS.TEXT_PROG',
         'ODMRSYS.BUILDTEXT_PROG',
         'ODMRSYS.APPLYTEXT_PROG',
         'ODMRSYS.BUILDTEXT_REF_PROG',
         'CTX_DDL'); -- ctx_ddl is for ODMr Classic compatibility
     --Validate input parameters
     dbms_output.put_line('Start validation tests');
     IF ((priv_action != 'GRANT') AND (priv_action != 'REVOKE')) THEN
      RAISE_APPLICATION_ERROR(-20000, 'Invalid privilege option passed in: ' || priv_action || '. Value must be GRANT or REVOKE.');
     END IF;
     IF ((user_account_value != 'ODMRUSER') AND (priv_action = '')) THEN
      RAISE_APPLICATION_ERROR(-20000, 'Invalid user account option passed in: ' || user_account_value || '. Value must be ODMRUSER or a user account name.');
     END IF;   
     IF ((user_account_value = 'ODMRUSER' ) AND (priv_action != 'REVOKE')) THEN 
      RAISE_APPLICATION_ERROR(-20000, 'ODMRUSER account value can only be passed in when action is REVOKE. Action was: ' || priv_action || '.');
     END IF; 
     IF ((user_account_value = 'USE_BACKUP_TABLE' ) AND (priv_action != 'GRANT')) THEN 
      RAISE_APPLICATION_ERROR(-20000, 'USE_BACKUP_TABLE account value can only be passed in when action is GRANT. Action was: ' || priv_action || '.');
     END IF;      
     dbms_output.put_line('End validation tests');

     --Setup from_to_clause for grant command
     IF (priv_action = 'GRANT') THEN
      from_to_clause := 'TO';
     ELSE
      from_to_clause := 'FROM';
     END IF;

     
     odmruser_cursor := dbms_sql.open_cursor; 
     IF (user_account_value = 'ODMRUSER') THEN
       --dbms_output.put_line('Parse 1');
       DBMS_SQL.PARSE(odmruser_cursor, 
           'select grantee as "USER" from dba_role_privs where granted_role = ''ODMRUSER''', 
            DBMS_SQL.NATIVE); 
     ELSIF (user_account_value = 'USE_BACKUP_TABLE') THEN
       --dbms_output.put_line('Parse 2');
       DBMS_SQL.PARSE(odmruser_cursor, 
           'select "USER" from "ODMRSYS"."ODMR$USER_GRANTS_BACKUP"', 
            DBMS_SQL.NATIVE); 
     ELSE       
       --dbms_output.put_line('Parse 3');
       DBMS_SQL.PARSE(odmruser_cursor, 
           'select ''&USER_ACCOUNT'' as "USER" from dual', 
            DBMS_SQL.NATIVE);       
     END IF;
     --dbms_output.put_line('define columns');
     DBMS_SQL.DEFINE_COLUMN(odmruser_cursor, 1, user_fetch_value, 120); 
     --dbms_output.put_line('execute cursor');
     ignore := DBMS_SQL.EXECUTE(odmruser_cursor); 
     --dbms_output.put_line('retrieve values');
     LOOP 
       IF DBMS_SQL.FETCH_ROWS(odmruser_cursor)>0 THEN 
         -- get column values of the row 
         DBMS_SQL.COLUMN_VALUE (odmruser_cursor, 1, user_fetch_value);
         dbms_output.put_line(priv_action || ' user: ' || user_fetch_value);
         -- Grant/Revoke access to list of objects
         FOR step IN 1..(objects_array.COUNT) LOOP
            sql_string := priv_action || ' EXECUTE ON '  || objects_array(step) || ' ' || from_to_clause || ' ' || '"' || user_fetch_value || '"';
            --dbms_output.put_line('invoke: ' || sql_string);
            BEGIN
              EXECUTE IMMEDIATE sql_string;
            EXCEPTION
              WHEN OTHERS THEN 
                  dbms_output.put_line('sql error, command failed: ' || sql_string);   
                  IF (priv_action = 'GRANT') THEN   
                    raise;
                  END IF;
            END;
         END LOOP;
         -- Grant/Revoke access to ODMRUSER role
         sql_string := priv_action || ' ' || odmr_user_role || ' ' || from_to_clause || ' ' || '"' || user_fetch_value || '"';
         dbms_output.put_line('invoke: ' || sql_string);
         BEGIN
            EXECUTE IMMEDIATE sql_string;
            IF (priv_action = 'GRANT') THEN
              add_default_role(user_fetch_value);
            END IF;
          EXCEPTION
            WHEN OTHERS THEN 
                dbms_output.put_line('sql error, command failed: ' || sql_string);   
                IF (priv_action = 'GRANT') THEN   
                  raise;
                END IF;
          END;         
       ELSE
         EXIT;
       END IF;
      END LOOP;
     --dbms_output.put_line('close cursor');
     dbms_sql.close_cursor(odmruser_cursor);
   EXCEPTION 
     WHEN OTHERS THEN 
       dbms_output.put_line('Exception in userhelpergrants.sql routine');
       IF DBMS_SQL.IS_OPEN(odmruser_cursor) THEN 
         DBMS_SQL.CLOSE_CURSOR(odmruser_cursor); 
       END IF; 
       RAISE; 
END;
/
