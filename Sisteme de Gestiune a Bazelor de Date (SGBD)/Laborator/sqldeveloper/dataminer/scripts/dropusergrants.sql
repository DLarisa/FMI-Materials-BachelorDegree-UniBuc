-- Usage @dropusergrants.sql <P1>
--    P1: User account will have all grants associated with ODMr revoked
-- Example: @dropusergrants.sql DMUSER

DEFINE USER_ACCOUNT = &&1

EXECUTE dbms_output.put_line('');
EXECUTE dbms_output.put_line('Revoke access to Data Miner repository objects from specified user.');
EXECUTE dbms_output.put_line('');

@@usergrantshelper.sql REVOKE &USER_ACCOUNT

exit;
