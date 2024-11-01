
-- History ----------------------------
Rem    MODIFIER   (DD/MM/YYYY)  Notes
Rem    dslavov     01/09/2010 - Created
---------------------------------------

SET SERVEROUTPUT ON;
DECLARE 
 v_descr     VARCHAR2(100);
 dest_clob   CLOB;
 src_clob    BFILE;
 
 file_open_failed EXCEPTION;
 PRAGMA EXCEPTION_INIT(file_open_failed, -22288);

BEGIN

  FOR i IN 1..6 LOOP
     IF i = 1 THEN
        v_descr     := 'Single table report';
        src_clob    := BFILENAME('OSDDM_REPORTS_DIR', 'SingleTableDetails.xslt');
     ELSIF i = 2 THEN
        v_descr     := 'All tables report';
        src_clob    := BFILENAME('OSDDM_REPORTS_DIR', 'AllTablesDetails.xslt');
     ELSIF i = 3 THEN
        v_descr     := 'Single entity report';
        src_clob    := BFILENAME('OSDDM_REPORTS_DIR', 'SingleEntityDetails.xslt');
     ELSIF i = 4 THEN
        v_descr     := 'All entities report';
        src_clob    := BFILENAME('OSDDM_REPORTS_DIR', 'AllEntitiesDetails.xslt');
     ELSIF i = 5 THEN
        v_descr     := 'Domains report';
        src_clob    := BFILENAME('OSDDM_REPORTS_DIR', 'AllDomainsDetails.xslt');
     ELSIF i = 6 THEN
        v_descr     := 'Glossary report';
        src_clob    := BFILENAME('OSDDM_REPORTS_DIR', 'GlossaryDetails.xslt');
   END IF;

   INSERT INTO msword_ml_data(id,report_id,xslt_clob,description) VALUES (i,i,EMPTY_CLOB(),v_descr) RETURNING xslt_clob INTO dest_clob;
   
   DBMS_LOB.OPEN(src_clob, DBMS_LOB.LOB_READONLY);

   DBMS_LOB.LoadFromFile( DEST_LOB => dest_clob,
                          SRC_LOB  => src_clob,
                          AMOUNT   => DBMS_LOB.GETLENGTH(src_clob)
                        );
   DBMS_LOB.CLOSE(src_clob);
   COMMIT;

  END LOOP;

EXCEPTION
 WHEN file_open_failed THEN 
  DBMS_Output.Put_Line(SQLERRM);
  DBMS_Output.Put_Line('One or more of the *.xslt files in \datamodeler\reports directory is not found in OS directory mapped to OSDDM_REPORTS_DIR Oracle directory!');
  DBMS_Output.Put_Line('Other possible problem could be that the current user does not have read permission on OSDDM_REPORTS_DIR Oracle directory !');
  DBMS_Output.Put_Line('Make sure you have sufficient privileges and Oracle directory OSDDM_REPORTS_DIR is created. Check the files Reporting_Schema_Upgrade_Readme.txt and Reporting_Schema_Permissions.sql and re-run the script osddm_upgr.sql');
  ROLLBACK;
 WHEN others THEN  
  DBMS_Output.Put_Line(SQLERRM);
  DBMS_Output.Put_Line(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
  ROLLBACK;
END;
/
