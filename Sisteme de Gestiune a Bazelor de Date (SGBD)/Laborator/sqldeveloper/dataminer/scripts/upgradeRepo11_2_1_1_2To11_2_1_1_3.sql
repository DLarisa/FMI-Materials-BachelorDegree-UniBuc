ALTER session set current_schema = "ODMRSYS";

EXECUTE dbms_output.put_line('');
EXECUTE dbms_output.put_line('Start repository upgrade from 11.2.1.1.2 to 11.2.1.1.3.');
EXECUTE dbms_output.put_line('');

-- drop tables/views if they exist
DECLARE
sql_text varchar2(256);

BEGIN
  BEGIN
    sql_text := 'drop VIEW ODMRSYS.ODMR_USER_DEFAULT_STOPLISTS' ;
    DBMS_OUTPUT.PUT_LINE (sql_text ); 
    execute immediate sql_text;
    EXCEPTION
    WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE ('Stoplist does not exist' );
  END;
  BEGIN
    sql_text := 'drop TABLE ODMRSYS.ODMR$DEFAULT_STOPLISTS PURGE' ;
    DBMS_OUTPUT.PUT_LINE (sql_text ); 
    execute immediate sql_text;
    EXCEPTION
    WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE ('Stoplist does not exist' );
  END;
END;
/

CREATE TABLE ODMRSYS.ODMR$DEFAULT_STOPLISTS 
(
  WORD NVARCHAR2(2000) NOT NULL 
, LANGUAGE VARCHAR2(30) NOT NULL 
);

CREATE OR REPLACE VIEW ODMRSYS.ODMR_USER_DEFAULT_STOPLISTS AS SELECT 
    WORD, LANGUAGE
FROM
  ODMRSYS.ODMR$DEFAULT_STOPLISTS;

CREATE OR REPLACE PUBLIC SYNONYM ODMR_USER_DEFAULT_STOPLISTS FOR ODMRSYS.ODMR_USER_DEFAULT_STOPLISTS;

GRANT SELECT ON ODMR_USER_DEFAULT_STOPLISTS TO ODMRUSER;

DECLARE
  repos_version VARCHAR2(30);
BEGIN
  SELECT PROPERTY_STR_VALUE INTO repos_version FROM ODMRSYS.ODMR$REPOSITORY_PROPERTIES WHERE PROPERTY_NAME = 'VERSION';
  IF ( repos_version = '11.2.1.1.2' ) THEN
    -- uptick the VERSION
    UPDATE ODMRSYS.ODMR$REPOSITORY_PROPERTIES SET PROPERTY_STR_VALUE = '11.2.1.1.3' WHERE PROPERTY_NAME = 'VERSION';
    COMMIT;  
   dbms_output.put_line('Repository version updated to  11.2.1.1.3.');
  END IF;
END;
/

EXECUTE dbms_output.put_line('');
EXECUTE dbms_output.put_line('End repository upgrade from 11.2.1.1.2 to 11.2.1.1.3.');
EXECUTE dbms_output.put_line('');
