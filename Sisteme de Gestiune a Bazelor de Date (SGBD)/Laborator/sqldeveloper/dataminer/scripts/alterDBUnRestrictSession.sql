-- disable the restriction for new sessions to just sys type accounts
-- Run after removing or migrating ODMR Repository
EXECUTE dbms_output.put_line('');
EXECUTE dbms_output.put_line('Set the db back to unrestricted session mode.');
EXECUTE dbms_output.put_line('');
alter system disable restricted session;