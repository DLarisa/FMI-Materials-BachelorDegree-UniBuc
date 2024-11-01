alter session set current_schema = "ODMRSYS";
--@updateRepositoryProperty.sql VERSION 11.2.0.1.12

-- copy of insertNewRepositoryProperties.sql 
BEGIN
INSERT INTO ODMRSYS.ODMR$REPOSITORY_PROPERTIES (PROPERTY_NAME, PROPERTY_STR_VALUE, "COMMENT") VALUES ('WORKFLOW_JOB_CLASS', 'DEFAULT_JOB_CLASS', 'Job class used to run the workflow.');
COMMIT;
EXCEPTION WHEN DUP_VAL_ON_INDEX THEN
DBMS_OUTPUT.PUT_LINE('Property: WORKFLOW_JOB_CLASS already exists. Value left unchanged.');
END;
/

EXECUTE dbms_output.put_line('');
EXECUTE dbms_output.put_line('Start repository upgrade from 11.2.0.1.11 to 11.2.0.1.12.');
EXECUTE dbms_output.put_line('');

-- update the repository status
DECLARE
  repos_version VARCHAR2(30);
BEGIN
  SELECT PROPERTY_STR_VALUE INTO repos_version FROM ODMRSYS.ODMR$REPOSITORY_PROPERTIES WHERE PROPERTY_NAME = 'VERSION';
  IF ( repos_version = '11.2.0.1.11' ) THEN
    dbms_output.put_line('Upgrade will be performed.');
    -- uptick the VERSION
    UPDATE ODMRSYS.ODMR$REPOSITORY_PROPERTIES SET PROPERTY_STR_VALUE = '11.2.0.1.12' WHERE PROPERTY_NAME = 'VERSION';
    COMMIT; 
    dbms_output.put_line('Repository version updated to  11.2.0.1.12.');
  ELSE
    dbms_output.put_line('Upgrade is not necessary.');
  END IF;
END;
/

EXECUTE dbms_output.put_line('');
EXECUTE dbms_output.put_line('End repository upgrade from 11.2.0.1.11 to 11.2.0.1.12.');
EXECUTE dbms_output.put_line('');
