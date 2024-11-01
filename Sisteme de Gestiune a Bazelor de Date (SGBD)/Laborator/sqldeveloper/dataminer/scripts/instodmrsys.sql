-- Do not run this script directly. If you are not using the UI to install the repository
-- then you should be running the installodmr.sql script
-- @instodmrsys.sql <P1> <P2> 
--    P1: Default tablespace
--    P2: Default temporary tablespace
-- Example: @instodmrsys.sql USER TEMP
WHENEVER SQLERROR EXIT SQL.SQLCODE;

SET SERVEROUTPUT ON;

EXECUTE dbms_output.put_line('');
EXECUTE dbms_output.put_line('Create ODMRSYS account.');
EXECUTE dbms_output.put_line('');

-- CREATE ODMRSYS
create user ODMRSYS identified by Alxv19x default tablespace &&1 temporary tablespace &&2 quota UNLIMITED on &&1 PASSWORD EXPIRE;

--Lock ODMRSYS
ALTER USER ODMRSYS ACCOUNT LOCK;
ALTER USER ODMRSYS PASSWORD EXPIRE;

COMMIT;

EXECUTE dbms_output.put_line('');
EXECUTE dbms_output.put_line('Grant required privileges to ODMRSYS account.');
EXECUTE dbms_output.put_line('');

grant
  CREATE TABLE, 
  CREATE VIEW, 
  CREATE TRIGGER, 
  CREATE PROCEDURE, 
  CREATE SYNONYM,
  CREATE SEQUENCE,
  CREATE TYPE,
  CREATE JOB,
  CREATE PUBLIC SYNONYM,
  CREATE RULE,
  CREATE RULE SET,
  CREATE EVALUATION CONTEXT,
  DROP PUBLIC SYNONYM to ODMRSYS;
grant EXECUTE ON CTX_DDL to ODMRSYS;
grant EXECUTE ON SYS.DBMS_LOCK to ODMRSYS;
grant EXECUTE ON SYS.DBMS_RANDOM to ODMRSYS;
-- added the additional grants to cover remove of grants on public synonyms
grant EXECUTE ON SYS.DBMS_OUTPUT to ODMRSYS;
grant EXECUTE ON SYS.DBMS_SCHEDULER to ODMRSYS;
grant EXECUTE ON SYS.DBMS_UTILITY to ODMRSYS;
grant EXECUTE ON SYS.DBMS_SQL to ODMRSYS;
grant EXECUTE ON SYS.DBMS_DATA_MINING_TRANSFORM to ODMRSYS;
grant EXECUTE ON SYS.DBMS_ASSERT to ODMRSYS;
grant EXECUTE ON SYS.DBMS_DATA_MINING to ODMRSYS;
grant EXECUTE ON SYS.DBMS_XMLGEN to ODMRSYS;
grant EXECUTE ON SYS.DBMS_LOB to ODMRSYS;

EXECUTE dbms_output.put_line('');
EXECUTE dbms_output.put_line('Create ODMRUSER role.');
EXECUTE dbms_output.put_line('');

-- CREATE ODMRUSER ROLE
CREATE ROLE ODMRUSER NOT IDENTIFIED;

EXECUTE dbms_output.put_line('');
EXECUTE dbms_output.put_line('Grant required privileges to ODMRUSER role.');
EXECUTE dbms_output.put_line('');

grant 
    CREATE TABLE, 
    CREATE VIEW,
    CREATE MINING MODEL,
    CREATE PROCEDURE, -- added for loading procedures used for vertical demos
    CREATE SEQUENCE,   -- ODMr Classic compatibility 
    CREATE TYPE,       -- ODMr Classic compatibility 
    CREATE SYNONYM,    -- ODMr Classic compatibility
    CREATE ANY INDEX,
    CREATE JOB,
    CREATE RULE,
    CREATE RULE SET,
    CREATE EVALUATION CONTEXT,
    CREATE SESSION
    to ODMRUSER;
grant EXECUTE ON SYS.DBMS_RANDOM to ODMRUSER;
grant EXECUTE ON CTX_DDL to ODMRUSER;
grant EXECUTE ON SYS.DBMS_LOCK to ODMRUSER;
-- added the additional grants to cover remove of grants on public synonyms
grant EXECUTE ON SYS.DBMS_OUTPUT to ODMRUSER;
grant EXECUTE ON SYS.DBMS_SCHEDULER to ODMRUSER;
grant EXECUTE ON SYS.DBMS_UTILITY to ODMRUSER;
grant EXECUTE ON SYS.DBMS_SQL to ODMRUSER;
grant EXECUTE ON SYS.DBMS_DATA_MINING_TRANSFORM to ODMRUSER;
grant EXECUTE ON SYS.DBMS_ASSERT to ODMRUSER;
grant EXECUTE ON SYS.DBMS_DATA_MINING to ODMRUSER;
grant EXECUTE ON SYS.DBMS_XMLGEN to ODMRUSER;
grant EXECUTE ON SYS.DBMS_LOB to ODMRUSER;

-- Revoke role from sys to avoid locks when dropping repository
EXECUTE dbms_output.put_line('');
EXECUTE dbms_output.put_line('Revoke ODMRUSER role from sys account to avoid locks with dropping repository.');
EXECUTE dbms_output.put_line('');
revoke ODMRUSER from sys;
