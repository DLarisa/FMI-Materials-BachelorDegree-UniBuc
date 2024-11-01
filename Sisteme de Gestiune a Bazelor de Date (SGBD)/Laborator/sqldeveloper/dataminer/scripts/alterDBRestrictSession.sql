-- restrict new sessions to just sys type accounts
-- Necessary to run before removing or migrating ODMR Repository
EXECUTE dbms_output.put_line('Set the db to restricted session mode to avoid deadload during upgrade.');
EXECUTE dbms_output.put_line('');
alter system enable restricted session;