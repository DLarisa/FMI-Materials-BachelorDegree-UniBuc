-- validated that all objects are valid in ODMRSYS
-- If there are any invalid objects, raise an exception.
set serveroutput on
set verify off

EXECUTE dbms_output.put_line('');
EXECUTE dbms_output.put_line('Validate ODMRSYS to insure all objects are valid.');
EXECUTE dbms_output.put_line('');

DECLARE
w_object_type varchar2(200);
w_object_name varchar2(200);
w_owner varchar2(200); 
w_status varchar2(50); 
countObjects integer := 0;
--SELECT owner,
--       object_type,
--       object_name,
--       status
--FROM   dba_objects
--WHERE  status = 'INVALID' AND
--       owner = 'ODMRSYS'
--ORDER BY owner, object_type, object_name
cursor objects_cursor is
SELECT owner,
       object_type,
       object_name,
       status
FROM   dba_objects
WHERE  status = 'INVALID' AND
       owner = 'ODMRSYS'
ORDER BY owner, object_type, object_name;

BEGIN
 DBMS_OUTPUT.ENABLE(NULL);
 DBMS_OUTPUT.PUT_LINE (' ' );     
 DBMS_OUTPUT.PUT_LINE ('Invalid ODMRSYS Objects Report ' );    
 DBMS_OUTPUT.PUT_LINE (' ' );     

 open objects_cursor;
 fetch objects_cursor into w_owner,w_object_type,w_object_name,w_status;
 while objects_cursor%FOUND loop
   countObjects := countObjects + 1;
   DBMS_OUTPUT.PUT_LINE ('Type: ' || w_object_type || ' Name: ' || w_object_name || ' Status: ' || w_status );     
   fetch objects_cursor into w_owner,w_object_type,w_object_name,w_status;
 end loop;
 close objects_cursor;
 DBMS_OUTPUT.PUT_LINE (' ' );     
 DBMS_OUTPUT.PUT_LINE ('Total Number of Invalid Objects: ' || countObjects );  
 if countObjects > 0 then
   RAISE_APPLICATION_ERROR(-20000, 'Invalid objects detected in ODMRSYS repository account. Review install log.');
 end if;
END;
/
/*
DECLARE
  countObjects integer := 0;
BEGIN
  FOR wf IN (
    SELECT x.WORKFLOW_NAME, x.WORKFLOW_DATA FROM ODMRSYS.ODMR$WORKFLOWS x)
  LOOP
    BEGIN
      wf.WORKFLOW_DATA.schemaValidate(); -- should raise exception with validation info
      dbms_output.put_line('Workflow: ' || wf.WORKFLOW_NAME || ' is valid');
    EXCEPTION WHEN OTHERS THEN
      countObjects := countObjects + 1;
      dbms_output.put_line('Workflow: ' || wf.WORKFLOW_NAME || ' is invalid because '||DBMS_UTILITY.FORMAT_ERROR_STACK());
    END;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE ('Total Number of Invalid Workflows: ' || countObjects );  
END;
*/