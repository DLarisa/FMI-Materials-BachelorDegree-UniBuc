-- Checks to see if any workflows are in a state other than INACTIVE or STOPPED.
-- If there are any workflows that pass this query filter, the script
-- will issue a message and raise an exception.
-- Example:
-- @insureWorkflowsInactive.sql 


set serveroutput on
set verify off


DECLARE
w_count integer; 
sql_text varchar2(256);
Dynamic_Cursor integer; 
v_err_msg  VARCHAR2(4000);


cursor workflow_cursor is
SELECT count(*) WORKFLOWS_NOT_INACTIVE from "ODMRSYS"."ODMR$WORKFLOWS" where status not in ('INACTIVE', 'STOPPED');

BEGIN
DBMS_OUTPUT.ENABLE(NULL);
dbms_output.put_line('Determine if any workflows are running or queued.');
open workflow_cursor;
fetch workflow_cursor into w_count;
IF (w_count != 0) THEN
  DBMS_OUTPUT.PUT_LINE('Workflow are either running or queued to run. Number of workflows in this state: ' || to_char(w_count));
  DBMS_OUTPUT.PUT_LINE('Workflows must be canceled before process can proceed. Exception will be raised.');
  RAISE_APPLICATION_ERROR(-20000, 'Process can not proceed until all queued or active workflows are either completed or canceled.');
ELSE
  DBMS_OUTPUT.PUT_LINE('All workflows are inactive.');
END IF;
close workflow_cursor;
END;
/
