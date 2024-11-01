
  CREATE OR REPLACE PACKAGE "ODMRSYS"."ODMR_ENGINE_DATA" 
AUTHID CURRENT_USER AS

  TYPE tab_cols_col_name_type IS TABLE OF all_tab_columns.column_name%TYPE;
  TYPE tab_cols_data_type_type IS TABLE OF all_tab_columns.data_type%TYPE;

  PROCEDURE DATASOURCE_PROG(p_job_name IN VARCHAR2, p_chain_step IN VARCHAR2);
  PROCEDURE CREATETABLE_PROG(p_job_name IN VARCHAR2, p_chain_step IN VARCHAR2);
  PROCEDURE UPDATETABLE_PROG(p_job_name IN VARCHAR2, p_chain_step IN VARCHAR2);
  PROCEDURE DATAPROFILE_PROG(p_job_name IN VARCHAR2, p_chain_step IN VARCHAR2);
  PROCEDURE AGGREGATION_PROG(p_job_name IN VARCHAR2, p_chain_step IN VARCHAR2);

END;
/
