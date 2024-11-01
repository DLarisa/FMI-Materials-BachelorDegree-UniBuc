
  CREATE OR REPLACE PACKAGE "ODMRSYS"."ODMR_ENGINE_MINING" 
AUTHID CURRENT_USER AS

  c_build_lock    CONSTANT VARCHAR2(30) := 'ODMR$BUILD$';

  TYPE LOOKUPTYPE IS TABLE OF NUMBER INDEX BY VARCHAR2(60);

  TYPE WEIGHTS is TABLE OF NUMBER;

  TYPE DU_OBJECT IS RECORD (
    model_type    VARCHAR2(30),      -- model type
    --model_id      NUMBER,
    attr_names    ODMR_OBJECT_NAMES, -- attribute name
    attr_types    ODMR_OBJECT_NAMES, -- DB datatype
    mining_types  ODMR_OBJECT_NAMES, -- Categorical or Numerical
    --auto_preps    ODMR_OBJECT_NAMES, -- auto prep
    input_types   ODMR_OBJECT_NAMES  -- Yes or No
    );
  TYPE DU_OBJECTS IS TABLE OF DU_OBJECT;

  TYPE RS_OBJECT IS RECORD (
    result_name VARCHAR2(30),
    result_type VARCHAR2(30), -- C - classification, R - regression
    model_name  VARCHAR2(30),
    model_id    VARCHAR2(30),
    results     ODMR_INTERNAL_UTIL.DB_OBJECTS,
    creation_date TIMESTAMP
    );
  TYPE RS_OBJECTS IS TABLE OF RS_OBJECT;

  PROCEDURE SUBFLOW_START_PROG(p_job_name IN VARCHAR2, p_chain_step IN VARCHAR2);
  PROCEDURE SUBFLOW_CLEANUP_PROG(p_job_name IN VARCHAR2, p_chain_step IN VARCHAR2);
  PROCEDURE CLASS_BUILD_PROG(p_job_name IN VARCHAR2, p_chain_step IN VARCHAR2);
  PROCEDURE REGRESS_BUILD_PROG(p_job_name IN VARCHAR2, p_chain_step IN VARCHAR2);
  PROCEDURE CLUST_BUILD_PROG(p_job_name IN VARCHAR2, p_chain_step IN VARCHAR2);
  PROCEDURE FEATURE_BUILD_PROG(p_job_name IN VARCHAR2, p_chain_step IN VARCHAR2);
  PROCEDURE ANOMALY_BUILD_PROG(p_job_name IN VARCHAR2, p_chain_step IN VARCHAR2);
  PROCEDURE ASSOC_BUILD_PROG(p_job_name IN VARCHAR2, p_chain_step IN VARCHAR2);
  PROCEDURE MODEL_PROG(p_job_name IN VARCHAR2, p_chain_step IN VARCHAR2);
  PROCEDURE APPLY_PROG(p_job_name IN VARCHAR2, p_chain_step IN VARCHAR2);
  PROCEDURE TEST_PROG(p_job_name IN VARCHAR2, p_chain_step IN VARCHAR2);

END;
/
