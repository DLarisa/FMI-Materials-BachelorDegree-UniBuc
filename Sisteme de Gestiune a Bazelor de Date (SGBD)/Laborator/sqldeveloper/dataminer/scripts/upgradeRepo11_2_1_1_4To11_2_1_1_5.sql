ALTER session set current_schema = "ODMRSYS";

EXECUTE dbms_output.put_line('');
EXECUTE dbms_output.put_line('Start repository upgrade from 11.2.1.1.4 to 11.2.1.1.5.');
EXECUTE dbms_output.put_line('');


DECLARE
  repos_version VARCHAR2(30);
BEGIN
  SELECT PROPERTY_STR_VALUE INTO repos_version FROM ODMRSYS.ODMR$REPOSITORY_PROPERTIES WHERE PROPERTY_NAME = 'VERSION';
  IF ( repos_version = '11.2.1.1.4' ) THEN
    -- uptick the VERSION
    UPDATE ODMRSYS.ODMR$REPOSITORY_PROPERTIES SET PROPERTY_STR_VALUE = '11.2.1.1.5' WHERE PROPERTY_NAME = 'VERSION';
    COMMIT;  
  dbms_output.put_line('Repository version updated to  11.2.1.1.5.');
  END IF;
END;
/

EXECUTE dbms_output.put_line('');
EXECUTE dbms_output.put_line('End repository upgrade from 11.2.1.1.4 to 11.2.1.1.5.');
EXECUTE dbms_output.put_line('');
