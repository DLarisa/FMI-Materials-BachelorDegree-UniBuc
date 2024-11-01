WHENEVER SQLERROR EXIT SQL.SQLCODE;

EXECUTE dbms_output.put_line('');
EXECUTE dbms_output.put_line('Create public synonyms on views, packages and types and grant to access to public.');
EXECUTE dbms_output.put_line('');

-- grant rights on OBJECT TYPEs
CREATE OR REPLACE PUBLIC SYNONYM ODMR_TRANSFORM_SETTING FOR ODMRSYS.ODMR_TRANSFORM_SETTING;
/
GRANT EXECUTE ON ODMR_TRANSFORM_SETTING TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_TRANSFORM_SETTINGS FOR ODMRSYS.ODMR_TRANSFORM_SETTINGS;
/
GRANT EXECUTE ON ODMR_TRANSFORM_SETTINGS TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_OBJECT_IDS FOR ODMRSYS.ODMR_OBJECT_IDS;
/
GRANT EXECUTE ON ODMR_OBJECT_IDS TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_OBJECT_NAMES FOR ODMRSYS.ODMR_OBJECT_NAMES;
/
GRANT EXECUTE ON ODMR_OBJECT_NAMES TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_OBJECT_VALUES FOR ODMRSYS.ODMR_OBJECT_VALUES;
/
GRANT EXECUTE ON ODMR_OBJECT_VALUES TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_WORKFLOW_OBJECT_NAME_SEQ FOR ODMRSYS.ODMR$WORKFLOW_OBJECT_NAME_SEQ;
/
GRANT SELECT ON ODMR_WORKFLOW_OBJECT_NAME_SEQ TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_HISTOGRAM_POINT FOR ODMRSYS.ODMR_HISTOGRAM_POINT;
/
GRANT EXECUTE ON ODMR_HISTOGRAM_POINT TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_HISTOGRAMS FOR ODMRSYS.ODMR_HISTOGRAMS;
/
GRANT EXECUTE ON ODMR_HISTOGRAMS TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_PREDICTION_CAT FOR ODMRSYS.ODMR_PREDICTION_CAT;
/
GRANT EXECUTE ON ODMR_PREDICTION_CAT TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_PREDICTION_SET_CAT FOR ODMRSYS.ODMR_PREDICTION_SET_CAT;
/
GRANT EXECUTE ON ODMR_PREDICTION_SET_CAT TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_PREDICTION_CAT_COST FOR ODMRSYS.ODMR_PREDICTION_CAT_COST;
/
GRANT EXECUTE ON ODMR_PREDICTION_CAT_COST TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_PREDICTION_SET_CAT_COST FOR ODMRSYS.ODMR_PREDICTION_SET_CAT_COST;
/
GRANT EXECUTE ON ODMR_PREDICTION_SET_CAT_COST TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_PREDICTION_NUM FOR ODMRSYS.ODMR_PREDICTION_NUM;
/
GRANT EXECUTE ON ODMR_PREDICTION_NUM TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_PREDICTION_SET_NUM FOR ODMRSYS.ODMR_PREDICTION_SET_NUM;
/
GRANT EXECUTE ON ODMR_PREDICTION_SET_NUM TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_PREDICTION_NUM_COST FOR ODMRSYS.ODMR_PREDICTION_NUM_COST;
/
GRANT EXECUTE ON ODMR_PREDICTION_NUM_COST TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_PREDICTION_SET_NUM_COST FOR ODMRSYS.ODMR_PREDICTION_SET_NUM_COST;
/
GRANT EXECUTE ON ODMR_PREDICTION_SET_NUM_COST TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_FEATURE_CAT FOR ODMRSYS.ODMR_FEATURE_CAT;
/
GRANT EXECUTE ON ODMR_FEATURE_CAT TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_FEATURE_SET_CAT FOR ODMRSYS.ODMR_FEATURE_SET_CAT;
/
GRANT EXECUTE ON ODMR_FEATURE_SET_CAT TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_FEATURE_NUM FOR ODMRSYS.ODMR_FEATURE_NUM;
/
GRANT EXECUTE ON ODMR_FEATURE_NUM TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_FEATURE_SET_NUM FOR ODMRSYS.ODMR_FEATURE_SET_NUM;
/
GRANT EXECUTE ON ODMR_FEATURE_SET_NUM TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_CLUSTER_CAT FOR ODMRSYS.ODMR_CLUSTER_CAT;
/
GRANT EXECUTE ON ODMR_CLUSTER_CAT TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_CLUSTER_SET_CAT FOR ODMRSYS.ODMR_CLUSTER_SET_CAT;
/
GRANT EXECUTE ON ODMR_CLUSTER_SET_CAT TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_CLUSTER_NUM FOR ODMRSYS.ODMR_CLUSTER_NUM;
/
GRANT EXECUTE ON ODMR_CLUSTER_NUM TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_CLUSTER_SET_NUM FOR ODMRSYS.ODMR_CLUSTER_SET_NUM;
/
GRANT EXECUTE ON ODMR_CLUSTER_SET_NUM TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_PREDICTION_NUM_COSTF FOR ODMRSYS.ODMR_PREDICTION_NUM_COSTF;
/
GRANT EXECUTE ON ODMR_PREDICTION_NUM_COSTF TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_PREDICTION_NUM_COSTD FOR ODMRSYS.ODMR_PREDICTION_NUM_COSTD;
/
GRANT EXECUTE ON ODMR_PREDICTION_NUM_COSTD TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_PREDICTION_NUM_COSTN FOR ODMRSYS.ODMR_PREDICTION_NUM_COSTN;
/
GRANT EXECUTE ON ODMR_PREDICTION_NUM_COSTN TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_PREDICTION_NUM_F FOR ODMRSYS.ODMR_PREDICTION_NUM_F;
/
GRANT EXECUTE ON ODMR_PREDICTION_NUM_F TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_PREDICTION_NUM_D FOR ODMRSYS.ODMR_PREDICTION_NUM_D;
/
GRANT EXECUTE ON ODMR_PREDICTION_NUM_D TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_PREDICTION_NUM_N FOR ODMRSYS.ODMR_PREDICTION_NUM_N;
/
GRANT EXECUTE ON ODMR_PREDICTION_NUM_N TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_PREDICTION_SET_NUM_COSTF FOR ODMRSYS.ODMR_PREDICTION_SET_NUM_COSTF;
/
GRANT EXECUTE ON ODMR_PREDICTION_SET_NUM_COSTF TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_PREDICTION_SET_NUM_COSTD FOR ODMRSYS.ODMR_PREDICTION_SET_NUM_COSTD;
/
GRANT EXECUTE ON ODMR_PREDICTION_SET_NUM_COSTD TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_PREDICTION_SET_NUM_COSTN FOR ODMRSYS.ODMR_PREDICTION_SET_NUM_COSTN;
/
GRANT EXECUTE ON ODMR_PREDICTION_SET_NUM_COSTN TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_PREDICTION_SET_NUM_F FOR ODMRSYS.ODMR_PREDICTION_SET_NUM_F;
/
GRANT EXECUTE ON ODMR_PREDICTION_SET_NUM_F TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_PREDICTION_SET_NUM_D FOR ODMRSYS.ODMR_PREDICTION_SET_NUM_D;
/
GRANT EXECUTE ON ODMR_PREDICTION_SET_NUM_D TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_PREDICTION_SET_NUM_N FOR ODMRSYS.ODMR_PREDICTION_SET_NUM_N;
/
GRANT EXECUTE ON ODMR_PREDICTION_SET_NUM_N TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_PREDICTION_CAT_COSTPD FOR ODMRSYS.ODMR_PREDICTION_CAT_COSTPD;
/
GRANT EXECUTE ON ODMR_PREDICTION_CAT_COSTPD TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_PREDICTION_CATPD FOR ODMRSYS.ODMR_PREDICTION_CATPD;
/
GRANT EXECUTE ON ODMR_PREDICTION_CATPD TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_PREDICTION_SET_CAT_COSTPD FOR ODMRSYS.ODMR_PREDICTION_SET_CAT_COSTPD;
/
GRANT EXECUTE ON ODMR_PREDICTION_SET_CAT_COSTPD TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_PREDICTION_SET_CATPD FOR ODMRSYS.ODMR_PREDICTION_SET_CATPD;
/
GRANT EXECUTE ON ODMR_PREDICTION_SET_CATPD TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_FEATURE_NUMVD FOR ODMRSYS.ODMR_FEATURE_NUMVD;
/
GRANT EXECUTE ON ODMR_FEATURE_NUMVD TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_FEATURE_SET_NUMVD FOR ODMRSYS.ODMR_FEATURE_SET_NUMVD;
/
GRANT EXECUTE ON ODMR_FEATURE_SET_NUMVD TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_FEATURE_CATVD FOR ODMRSYS.ODMR_FEATURE_CATVD;
/
GRANT EXECUTE ON ODMR_FEATURE_CATVD TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_FEATURE_SET_CATVD FOR ODMRSYS.ODMR_FEATURE_SET_CATVD;
/
GRANT EXECUTE ON ODMR_FEATURE_SET_CATVD TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_CLUSTER_NUMPD FOR ODMRSYS.ODMR_CLUSTER_NUMPD;
/
GRANT EXECUTE ON ODMR_CLUSTER_NUMPD TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_CLUSTER_SET_NUMPD FOR ODMRSYS.ODMR_CLUSTER_SET_NUMPD;
/
GRANT EXECUTE ON ODMR_CLUSTER_SET_NUMPD TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_CLUSTER_CATPD FOR ODMRSYS.ODMR_CLUSTER_CATPD;
/
GRANT EXECUTE ON ODMR_CLUSTER_CATPD TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_CLUSTER_SET_CATPD FOR ODMRSYS.ODMR_CLUSTER_SET_CATPD;
/
GRANT EXECUTE ON ODMR_CLUSTER_SET_CATPD TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_NODE_REFERENCE FOR ODMRSYS.ODMR_NODE_REFERENCE;
/
GRANT EXECUTE ON ODMR_NODE_REFERENCE TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_NODE_REFERENCE_SET FOR ODMRSYS.ODMR_NODE_REFERENCE_SET;
/
GRANT EXECUTE ON ODMR_NODE_REFERENCE_SET TO PUBLIC;
/
-- grant rights on VIEWs

CREATE OR REPLACE PUBLIC SYNONYM ODMR_USER_DEFAULT_STOPLISTS FOR ODMRSYS.ODMR_USER_DEFAULT_STOPLISTS;
/
GRANT SELECT ON ODMR_USER_DEFAULT_STOPLISTS TO ODMRUSER;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_USER_PROJECT_WORKFLOW FOR ODMRSYS.ODMR_USER_PROJECT_WORKFLOW;
/
GRANT SELECT ON ODMR_USER_PROJECT_WORKFLOW TO ODMRUSER;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_USER_WORKFLOW_JOBS FOR ODMRSYS.ODMR_USER_WORKFLOW_JOBS;
/
GRANT SELECT ON ODMR_USER_WORKFLOW_JOBS TO ODMRUSER;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_USER_WORKFLOW_LOG FOR ODMRSYS.ODMR_USER_WORKFLOW_LOG;
/
GRANT SELECT ON ODMR_USER_WORKFLOW_LOG TO ODMRUSER;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_REPOSITORY_PROPERTIES FOR ODMRSYS.ODMR_REPOSITORY_PROPERTIES;
/
-- Only grant to PUBLIC, allows ODMR to check for installation of repository
-- from an account that does not have ODMRUSER role.
GRANT SELECT ON ODMR_REPOSITORY_PROPERTIES TO PUBLIC;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_USER_WORKFLOW_RUNNING FOR ODMRSYS.ODMR_USER_WORKFLOW_RUNNING;
/
GRANT SELECT ON ODMR_USER_WORKFLOW_RUNNING TO ODMRUSER;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_USER_WORKFLOW_COMPLETE FOR ODMRSYS.ODMR_USER_WORKFLOW_COMPLETE;
/
GRANT SELECT ON ODMR_USER_WORKFLOW_COMPLETE TO ODMRUSER;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_USER_WORKFLOW_ALL FOR ODMRSYS.ODMR_USER_WORKFLOW_ALL;
/
GRANT SELECT ON ODMR_USER_WORKFLOW_ALL TO ODMRUSER;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_ALL_WORKFLOW_MODELS FOR ODMRSYS.ODMR_ALL_WORKFLOW_MODELS;    
/
GRANT SELECT ON ODMR_ALL_WORKFLOW_MODELS TO ODMRUSER;
/
-- grant rights on Packages
CREATE OR REPLACE PUBLIC SYNONYM ODMR_CONSTANT FOR ODMRSYS.ODMR_CONSTANT;
/
GRANT EXECUTE ON ODMR_CONSTANT TO ODMRUSER;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_PROJECT FOR ODMRSYS.ODMR_PROJECT;
/
GRANT EXECUTE ON ODMR_PROJECT TO ODMRUSER;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_WORKFLOW FOR ODMRSYS.ODMR_WORKFLOW;
/
GRANT EXECUTE ON ODMR_WORKFLOW TO ODMRUSER;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_UTIL FOR ODMRSYS.ODMR_UTIL;
/
GRANT EXECUTE ON ODMR_UTIL TO ODMRUSER;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_ENGINE FOR ODMRSYS.ODMR_ENGINE;
/
GRANT EXECUTE ON ODMR_ENGINE TO ODMRUSER;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_ENGINE_DATA FOR ODMRSYS.ODMR_ENGINE_DATA;
/
GRANT EXECUTE ON ODMR_ENGINE_DATA TO ODMRUSER;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_ENGINE_MINING FOR ODMRSYS.ODMR_ENGINE_MINING;
/
GRANT EXECUTE ON ODMR_ENGINE_MINING TO ODMRUSER;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_ENGINE_OUTPUT FOR ODMRSYS.ODMR_ENGINE_OUTPUT;
/
GRANT EXECUTE ON ODMR_ENGINE_OUTPUT TO ODMRUSER;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_ENGINE_TRANSFORMS FOR ODMRSYS.ODMR_ENGINE_TRANSFORMS;
/
GRANT EXECUTE ON ODMR_ENGINE_TRANSFORMS TO ODMRUSER;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_ENGINE_TEXT FOR ODMRSYS.ODMR_ENGINE_TEXT;
/
GRANT EXECUTE ON ODMR_ENGINE_TEXT TO ODMRUSER;
/
CREATE OR REPLACE PUBLIC SYNONYM ODMR_MESSAGES FOR ODMRSYS.ODMR_MESSAGES;
/
GRANT SELECT ON ODMR_MESSAGES TO ODMRUSER;
/

EXECUTE dbms_output.put_line('');
EXECUTE dbms_output.put_line('Create Scheduler Job definitions.');
EXECUTE dbms_output.put_line('');

-- grant rights for dbms scheduler use
BEGIN
  BEGIN
    DBMS_SCHEDULER.DROP_PROGRAM('ODMRSYS.START_PROG', TRUE);
  EXCEPTION WHEN OTHERS THEN
    NULL;
  END;
  BEGIN
    DBMS_SCHEDULER.DROP_PROGRAM('ODMRSYS.CLEANUP_PROG', TRUE);
  EXCEPTION WHEN OTHERS THEN
    NULL;
  END;
  BEGIN
    DBMS_SCHEDULER.DROP_PROGRAM('ODMRSYS.SUBFLOW_START_PROG', TRUE);
  EXCEPTION WHEN OTHERS THEN
    NULL;
  END;
  BEGIN
    DBMS_SCHEDULER.DROP_PROGRAM('ODMRSYS.SUBFLOW_CLEANUP_PROG', TRUE);
  EXCEPTION WHEN OTHERS THEN
    NULL;
  END;
  BEGIN
    DBMS_SCHEDULER.DROP_PROGRAM('ODMRSYS.DATASOURCE_PROG', TRUE);
  EXCEPTION WHEN OTHERS THEN
    NULL;
  END;
  BEGIN
    DBMS_SCHEDULER.DROP_PROGRAM('ODMRSYS.DATAPROFILE_PROG', TRUE);
  EXCEPTION WHEN OTHERS THEN
    NULL;
  END;
  BEGIN
    DBMS_SCHEDULER.DROP_PROGRAM('ODMRSYS.CLASS_BUILD_PROG', TRUE);
  EXCEPTION WHEN OTHERS THEN
    NULL;
  END;
  BEGIN
    DBMS_SCHEDULER.DROP_PROGRAM('ODMRSYS.REGRESS_BUILD_PROG', TRUE);
  EXCEPTION WHEN OTHERS THEN
    NULL;
  END;
  BEGIN
    DBMS_SCHEDULER.DROP_PROGRAM('ODMRSYS.CLUST_BUILD_PROG', TRUE);
  EXCEPTION WHEN OTHERS THEN
    NULL;
  END;
  BEGIN
    DBMS_SCHEDULER.DROP_PROGRAM('ODMRSYS.ASSOC_BUILD_PROG', TRUE);
  EXCEPTION WHEN OTHERS THEN
    NULL;
  END;
  BEGIN
    DBMS_SCHEDULER.DROP_PROGRAM('ODMRSYS.ANOMALY_BUILD_PROG', TRUE);
  EXCEPTION WHEN OTHERS THEN
    NULL;
  END;
  BEGIN
    DBMS_SCHEDULER.DROP_PROGRAM('ODMRSYS.MODEL_PROG', TRUE);
  EXCEPTION WHEN OTHERS THEN
    NULL;
  END;
  BEGIN
    DBMS_SCHEDULER.DROP_PROGRAM('ODMRSYS.TEST_PROG', TRUE);
  EXCEPTION WHEN OTHERS THEN
    NULL;
  END;
  BEGIN
    DBMS_SCHEDULER.DROP_PROGRAM('ODMRSYS.APPLY_PROG', TRUE);
  EXCEPTION WHEN OTHERS THEN
    NULL;
  END;
  BEGIN
    DBMS_SCHEDULER.DROP_PROGRAM('ODMRSYS.MODELDETAILS_PROG', TRUE);
  EXCEPTION WHEN OTHERS THEN
    NULL;
  END;
  BEGIN
    DBMS_SCHEDULER.DROP_PROGRAM('ODMRSYS.CREATETABLE_PROG', TRUE);
  EXCEPTION WHEN OTHERS THEN
    NULL;
  END;
  BEGIN
    DBMS_SCHEDULER.DROP_PROGRAM('ODMRSYS.TRANSFORMATIONS_PROG', TRUE);
  EXCEPTION WHEN OTHERS THEN
    NULL;
  END;
  BEGIN
    DBMS_SCHEDULER.DROP_PROGRAM('ODMRSYS.JOIN_PROG', TRUE);
  EXCEPTION WHEN OTHERS THEN
    NULL;
  END;
  BEGIN
    DBMS_SCHEDULER.DROP_PROGRAM('ODMRSYS.UPDATETABLE_PROG', TRUE);
  EXCEPTION WHEN OTHERS THEN
    NULL;
  END;
  BEGIN
    DBMS_SCHEDULER.DROP_PROGRAM('ODMRSYS.AGGREGATION_PROG', TRUE);
  EXCEPTION WHEN OTHERS THEN
    NULL;
  END;
  BEGIN
    DBMS_SCHEDULER.DROP_PROGRAM('ODMRSYS.COLUMNFILTER_PROG', TRUE);
  EXCEPTION WHEN OTHERS THEN
    NULL;
  END;
  BEGIN
    DBMS_SCHEDULER.DROP_PROGRAM('ODMRSYS.FILTERDETAILS_PROG', TRUE);
  EXCEPTION WHEN OTHERS THEN
    NULL;
  END;
  BEGIN
    DBMS_SCHEDULER.DROP_PROGRAM('ODMRSYS.SAMPLE_PROG', TRUE);
  EXCEPTION WHEN OTHERS THEN
    NULL;
  END;
  BEGIN
    DBMS_SCHEDULER.DROP_PROGRAM('ODMRSYS.ROWFILTER_PROG', TRUE);
  EXCEPTION WHEN OTHERS THEN
    NULL;
  END;
  BEGIN
    DBMS_SCHEDULER.DROP_PROGRAM('ODMRSYS.FEATURE_BUILD_PROG', TRUE);
  EXCEPTION WHEN OTHERS THEN
    NULL;
  END;
  BEGIN
    DBMS_SCHEDULER.DROP_PROGRAM('ODMRSYS.TEXT_PROG', TRUE);
  EXCEPTION WHEN OTHERS THEN
    NULL;
  END;
  BEGIN
    DBMS_SCHEDULER.DROP_PROGRAM('ODMRSYS.BUILDTEXT_PROG', TRUE);
  EXCEPTION WHEN OTHERS THEN
    NULL;
  END;
  BEGIN
    DBMS_SCHEDULER.DROP_PROGRAM('ODMRSYS.APPLYTEXT_PROG', TRUE);
  EXCEPTION WHEN OTHERS THEN
    NULL;
  END;
  BEGIN
    DBMS_SCHEDULER.DROP_PROGRAM('ODMRSYS.BUILDTEXT_REF_PROG', TRUE);
  EXCEPTION WHEN OTHERS THEN
    NULL;
  END;  
  
  DBMS_SCHEDULER.CREATE_PROGRAM (
    program_name        => 'ODMRSYS.START_PROG',
    program_type        => 'STORED_PROCEDURE',
    program_action      => 'ODMR_ENGINE.START_PROG',
    number_of_arguments => 2,
    enabled             => FALSE,
    comments            => 'Startup Program');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.START_PROG',
    metadata_attribute => 'job_name',
    argument_position  => 1,
    argument_name      => 'p_job_name');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.START_PROG',
    metadata_attribute => 'job_subname',
    argument_position  => 2,
    argument_name      => 'p_chain_step');
  DBMS_SCHEDULER.ENABLE('ODMRSYS.START_PROG');

  DBMS_SCHEDULER.CREATE_PROGRAM (
    program_name        => 'ODMRSYS.CLEANUP_PROG',
    program_type        => 'STORED_PROCEDURE',
    program_action      => 'ODMR_ENGINE.CLEANUP_PROG',
    number_of_arguments => 2,
    enabled             => FALSE,
    comments            => 'Cleanup Program');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.CLEANUP_PROG',
    metadata_attribute => 'job_name',
    argument_position  => 1,
    argument_name      => 'p_job_name');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.CLEANUP_PROG',
    metadata_attribute => 'job_subname',
    argument_position  => 2,
    argument_name      => 'p_chain_step');
  DBMS_SCHEDULER.ENABLE('ODMRSYS.CLEANUP_PROG');

  DBMS_SCHEDULER.CREATE_PROGRAM (
    program_name        => 'ODMRSYS.SUBFLOW_START_PROG',
    program_type        => 'STORED_PROCEDURE',
    program_action      => 'ODMR_ENGINE_MINING.SUBFLOW_START_PROG',
    number_of_arguments => 2,
    enabled             => FALSE,
    comments            => 'Subflow Startup Program');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.SUBFLOW_START_PROG',
    metadata_attribute => 'job_name',
    argument_position  => 1,
    argument_name      => 'p_job_name');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.SUBFLOW_START_PROG',
    metadata_attribute => 'job_subname',
    argument_position  => 2,
    argument_name      => 'p_chain_step');
  DBMS_SCHEDULER.ENABLE('ODMRSYS.SUBFLOW_START_PROG');

  DBMS_SCHEDULER.CREATE_PROGRAM (
    program_name        => 'ODMRSYS.SUBFLOW_CLEANUP_PROG',
    program_type        => 'STORED_PROCEDURE',
    program_action      => 'ODMR_ENGINE_MINING.SUBFLOW_CLEANUP_PROG',
    number_of_arguments => 2,
    enabled             => FALSE,
    comments            => 'Subflow Cleanup Program');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.SUBFLOW_CLEANUP_PROG',
    metadata_attribute => 'job_name',
    argument_position  => 1,
    argument_name      => 'p_job_name');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.SUBFLOW_CLEANUP_PROG',
    metadata_attribute => 'job_subname',
    argument_position  => 2,
    argument_name      => 'p_chain_step');
  DBMS_SCHEDULER.ENABLE('ODMRSYS.SUBFLOW_CLEANUP_PROG');

  DBMS_SCHEDULER.CREATE_PROGRAM (
    program_name        => 'ODMRSYS.DATASOURCE_PROG',
    program_type        => 'STORED_PROCEDURE',
    program_action      => 'ODMR_ENGINE_DATA.DATASOURCE_PROG',
    number_of_arguments => 2,
    enabled             => FALSE,
    comments            => 'Data Source Program');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.DATASOURCE_PROG',
    metadata_attribute => 'job_name',
    argument_position  => 1,
    argument_name      => 'p_job_name');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.DATASOURCE_PROG',
    metadata_attribute => 'job_subname',
    argument_position  => 2,
    argument_name      => 'p_chain_step');
  DBMS_SCHEDULER.ENABLE('ODMRSYS.DATASOURCE_PROG');

  DBMS_SCHEDULER.CREATE_PROGRAM (
    program_name        => 'ODMRSYS.DATAPROFILE_PROG',
    program_type        => 'STORED_PROCEDURE',
    program_action      => 'ODMR_ENGINE_DATA.DATAPROFILE_PROG',
    number_of_arguments => 2,
    enabled             => FALSE,
    comments            => 'Data Profile Program');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.DATAPROFILE_PROG',
    metadata_attribute => 'job_name',
    argument_position  => 1,
    argument_name      => 'p_job_name');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.DATAPROFILE_PROG',
    metadata_attribute => 'job_subname',
    argument_position  => 2,
    argument_name      => 'p_chain_step');
  DBMS_SCHEDULER.ENABLE('ODMRSYS.DATAPROFILE_PROG');

  DBMS_SCHEDULER.CREATE_PROGRAM (
    program_name        => 'ODMRSYS.CREATETABLE_PROG',
    program_type        => 'STORED_PROCEDURE',
    program_action      => 'ODMR_ENGINE_DATA.CREATETABLE_PROG',
    number_of_arguments => 2,
    enabled             => FALSE,
    comments            => 'Create Table Program');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.CREATETABLE_PROG',
    metadata_attribute => 'job_name',
    argument_position  => 1,
    argument_name      => 'p_job_name');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.CREATETABLE_PROG',
    metadata_attribute => 'job_subname',
    argument_position  => 2,
    argument_name      => 'p_chain_step');
  DBMS_SCHEDULER.ENABLE('ODMRSYS.CREATETABLE_PROG');

  DBMS_SCHEDULER.CREATE_PROGRAM (
    program_name        => 'ODMRSYS.UPDATETABLE_PROG',
    program_type        => 'STORED_PROCEDURE',
    program_action      => 'ODMR_ENGINE_DATA.UPDATETABLE_PROG',
    number_of_arguments => 2,
    enabled             => FALSE,
    comments            => 'Update Table Program');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.UPDATETABLE_PROG',
    metadata_attribute => 'job_name',
    argument_position  => 1,
    argument_name      => 'p_job_name');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.UPDATETABLE_PROG',
    metadata_attribute => 'job_subname',
    argument_position  => 2,
    argument_name      => 'p_chain_step');
  DBMS_SCHEDULER.ENABLE('ODMRSYS.UPDATETABLE_PROG');

  DBMS_SCHEDULER.CREATE_PROGRAM (
    program_name        => 'ODMRSYS.AGGREGATION_PROG',
    program_type        => 'STORED_PROCEDURE',
    program_action      => 'ODMR_ENGINE_DATA.AGGREGATION_PROG',
    number_of_arguments => 2,
    enabled             => FALSE,
    comments            => 'Aggregation Program');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.AGGREGATION_PROG',
    metadata_attribute => 'job_name',
    argument_position  => 1,
    argument_name      => 'p_job_name');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.AGGREGATION_PROG',
    metadata_attribute => 'job_subname',
    argument_position  => 2,
    argument_name      => 'p_chain_step');
  DBMS_SCHEDULER.ENABLE('ODMRSYS.AGGREGATION_PROG');

  DBMS_SCHEDULER.CREATE_PROGRAM (
    program_name        => 'ODMRSYS.CLASS_BUILD_PROG',
    program_type        => 'STORED_PROCEDURE',
    program_action      => 'ODMR_ENGINE_MINING.CLASS_BUILD_PROG',
    number_of_arguments => 2,
    enabled             => FALSE,
    comments            => 'Class Build Program');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.CLASS_BUILD_PROG',
    metadata_attribute => 'job_name',
    argument_position  => 1,
    argument_name      => 'p_job_name');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.CLASS_BUILD_PROG',
    metadata_attribute => 'job_subname',
    argument_position  => 2,
    argument_name      => 'p_chain_step');
  DBMS_SCHEDULER.ENABLE('ODMRSYS.CLASS_BUILD_PROG');

  DBMS_SCHEDULER.CREATE_PROGRAM (
    program_name        => 'ODMRSYS.REGRESS_BUILD_PROG',
    program_type        => 'STORED_PROCEDURE',
    program_action      => 'ODMR_ENGINE_MINING.REGRESS_BUILD_PROG',
    number_of_arguments => 2,
    enabled             => FALSE,
    comments            => 'Regress Build Program');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.REGRESS_BUILD_PROG',
    metadata_attribute => 'job_name',
    argument_position  => 1,
    argument_name      => 'p_job_name');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.REGRESS_BUILD_PROG',
    metadata_attribute => 'job_subname',
    argument_position  => 2,
    argument_name      => 'p_chain_step');
  DBMS_SCHEDULER.ENABLE('ODMRSYS.REGRESS_BUILD_PROG');

  DBMS_SCHEDULER.CREATE_PROGRAM (
    program_name        => 'ODMRSYS.CLUST_BUILD_PROG',
    program_type        => 'STORED_PROCEDURE',
    program_action      => 'ODMR_ENGINE_MINING.CLUST_BUILD_PROG',
    number_of_arguments => 2,
    enabled             => FALSE,
    comments            => 'Clust Build Program');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.CLUST_BUILD_PROG',
    metadata_attribute => 'job_name',
    argument_position  => 1,
    argument_name      => 'p_job_name');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.CLUST_BUILD_PROG',
    metadata_attribute => 'job_subname',
    argument_position  => 2,
    argument_name      => 'p_chain_step');
  DBMS_SCHEDULER.ENABLE('ODMRSYS.CLUST_BUILD_PROG');

  DBMS_SCHEDULER.CREATE_PROGRAM (
    program_name        => 'ODMRSYS.ASSOC_BUILD_PROG',
    program_type        => 'STORED_PROCEDURE',
    program_action      => 'ODMR_ENGINE_MINING.ASSOC_BUILD_PROG',
    number_of_arguments => 2,
    enabled             => FALSE,
    comments            => 'Assoc Build Program');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.ASSOC_BUILD_PROG',
    metadata_attribute => 'job_name',
    argument_position  => 1,
    argument_name      => 'p_job_name');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.ASSOC_BUILD_PROG',
    metadata_attribute => 'job_subname',
    argument_position  => 2,
    argument_name      => 'p_chain_step');
  DBMS_SCHEDULER.ENABLE('ODMRSYS.ASSOC_BUILD_PROG');

  DBMS_SCHEDULER.CREATE_PROGRAM (
    program_name        => 'ODMRSYS.ANOMALY_BUILD_PROG',
    program_type        => 'STORED_PROCEDURE',
    program_action      => 'ODMR_ENGINE_MINING.ANOMALY_BUILD_PROG',
    number_of_arguments => 2,
    enabled             => FALSE,
    comments            => 'Anomaly Build Program');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.ANOMALY_BUILD_PROG',
    metadata_attribute => 'job_name',
    argument_position  => 1,
    argument_name      => 'p_job_name');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.ANOMALY_BUILD_PROG',
    metadata_attribute => 'job_subname',
    argument_position  => 2,
    argument_name      => 'p_chain_step');
  DBMS_SCHEDULER.ENABLE('ODMRSYS.ANOMALY_BUILD_PROG');

  DBMS_SCHEDULER.CREATE_PROGRAM (
    program_name        => 'ODMRSYS.MODEL_PROG',
    program_type        => 'STORED_PROCEDURE',
    program_action      => 'ODMR_ENGINE_MINING.MODEL_PROG',
    number_of_arguments => 2,
    enabled             => FALSE,
    comments            => 'Model Program');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.MODEL_PROG',
    metadata_attribute => 'job_name',
    argument_position  => 1,
    argument_name      => 'p_job_name');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.MODEL_PROG',
    metadata_attribute => 'job_subname',
    argument_position  => 2,
    argument_name      => 'p_chain_step');
  DBMS_SCHEDULER.ENABLE('ODMRSYS.MODEL_PROG');

  DBMS_SCHEDULER.CREATE_PROGRAM (
    program_name        => 'ODMRSYS.TEST_PROG',
    program_type        => 'STORED_PROCEDURE',
    program_action      => 'ODMR_ENGINE_MINING.TEST_PROG',
    number_of_arguments => 2,
    enabled             => FALSE,
    comments            => 'Test Program');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.TEST_PROG',
    metadata_attribute => 'job_name',
    argument_position  => 1,
    argument_name      => 'p_job_name');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.TEST_PROG',
    metadata_attribute => 'job_subname',
    argument_position  => 2,
    argument_name      => 'p_chain_step');
  DBMS_SCHEDULER.ENABLE('ODMRSYS.TEST_PROG');

  DBMS_SCHEDULER.CREATE_PROGRAM (
    program_name        => 'ODMRSYS.APPLY_PROG',
    program_type        => 'STORED_PROCEDURE',
    program_action      => 'ODMR_ENGINE_MINING.APPLY_PROG',
    number_of_arguments => 2,
    enabled             => FALSE,
    comments            => 'Apply Program');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.APPLY_PROG',
    metadata_attribute => 'job_name',
    argument_position  => 1,
    argument_name      => 'p_job_name');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.APPLY_PROG',
    metadata_attribute => 'job_subname',
    argument_position  => 2,
    argument_name      => 'p_chain_step');
  DBMS_SCHEDULER.ENABLE('ODMRSYS.APPLY_PROG');

  DBMS_SCHEDULER.CREATE_PROGRAM (
    program_name        => 'ODMRSYS.MODELDETAILS_PROG',
    program_type        => 'STORED_PROCEDURE',
    program_action      => 'ODMR_ENGINE_OUTPUT.MODELDETAILS_PROG',
    number_of_arguments => 2,
    enabled             => FALSE,
    comments            => 'ModelDetails Program');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.MODELDETAILS_PROG',
    metadata_attribute => 'job_name',
    argument_position  => 1,
    argument_name      => 'p_job_name');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.MODELDETAILS_PROG',
    metadata_attribute => 'job_subname',
    argument_position  => 2,
    argument_name      => 'p_chain_step');
  DBMS_SCHEDULER.ENABLE('ODMRSYS.MODELDETAILS_PROG');
  
  DBMS_SCHEDULER.CREATE_PROGRAM (
    program_name        => 'ODMRSYS.JOIN_PROG',
    program_type        => 'STORED_PROCEDURE',
    program_action      => 'ODMR_ENGINE_TRANSFORMS.JOIN_PROG',
    number_of_arguments => 2,
    enabled             => FALSE,
    comments            => 'Join Program');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.JOIN_PROG',
    metadata_attribute => 'job_name',
    argument_position  => 1,
    argument_name      => 'p_job_name');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.JOIN_PROG',
    metadata_attribute => 'job_subname',
    argument_position  => 2,
    argument_name      => 'p_chain_step');
  DBMS_SCHEDULER.ENABLE('ODMRSYS.JOIN_PROG');

  DBMS_SCHEDULER.CREATE_PROGRAM (
    program_name        => 'ODMRSYS.TRANSFORMATIONS_PROG',
    program_type        => 'STORED_PROCEDURE',
    program_action      => 'ODMR_ENGINE_TRANSFORMS.TRANSFORMATIONS_PROG',
    number_of_arguments => 2,
    enabled             => FALSE,
    comments            => 'Transformations Program');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.TRANSFORMATIONS_PROG',
    metadata_attribute => 'job_name',
    argument_position  => 1,
    argument_name      => 'p_job_name');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.TRANSFORMATIONS_PROG',
    metadata_attribute => 'job_subname',
    argument_position  => 2,
    argument_name      => 'p_chain_step');
  DBMS_SCHEDULER.ENABLE('ODMRSYS.TRANSFORMATIONS_PROG');

  DBMS_SCHEDULER.CREATE_PROGRAM (
    program_name        => 'ODMRSYS.COLUMNFILTER_PROG',
    program_type        => 'STORED_PROCEDURE',
    program_action      => 'ODMR_ENGINE_TRANSFORMS.COLUMNFILTER_PROG',
    number_of_arguments => 2,
    enabled             => FALSE,
    comments            => 'Column Filter Program');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.COLUMNFILTER_PROG',
    metadata_attribute => 'job_name',
    argument_position  => 1,
    argument_name      => 'p_job_name');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.COLUMNFILTER_PROG',
    metadata_attribute => 'job_subname',
    argument_position  => 2,
    argument_name      => 'p_chain_step');
  DBMS_SCHEDULER.ENABLE('ODMRSYS.COLUMNFILTER_PROG');

  DBMS_SCHEDULER.CREATE_PROGRAM (
    program_name        => 'ODMRSYS.SAMPLE_PROG',
    program_type        => 'STORED_PROCEDURE',
    program_action      => 'ODMR_ENGINE_TRANSFORMS.SAMPLE_PROG',
    number_of_arguments => 2,
    enabled             => FALSE,
    comments            => 'Column Filter Program');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.SAMPLE_PROG',
    metadata_attribute => 'job_name',
    argument_position  => 1,
    argument_name      => 'p_job_name');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.SAMPLE_PROG',
    metadata_attribute => 'job_subname',
    argument_position  => 2,
    argument_name      => 'p_chain_step');
  DBMS_SCHEDULER.ENABLE('ODMRSYS.SAMPLE_PROG');

  DBMS_SCHEDULER.CREATE_PROGRAM (
    program_name        => 'ODMRSYS.FILTERDETAILS_PROG',
    program_type        => 'STORED_PROCEDURE',
    program_action      => 'ODMR_ENGINE_OUTPUT.FILTERDETAILS_PROG',
    number_of_arguments => 2,
    enabled             => FALSE,
    comments            => 'FilterDetails Program');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.FILTERDETAILS_PROG',
    metadata_attribute => 'job_name',
    argument_position  => 1,
    argument_name      => 'p_job_name');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.FILTERDETAILS_PROG',
    metadata_attribute => 'job_subname',
    argument_position  => 2,
    argument_name      => 'p_chain_step');
  DBMS_SCHEDULER.ENABLE('ODMRSYS.FILTERDETAILS_PROG');

  DBMS_SCHEDULER.CREATE_PROGRAM (
    program_name        => 'ODMRSYS.ROWFILTER_PROG',
    program_type        => 'STORED_PROCEDURE',
    program_action      => 'ODMR_ENGINE_TRANSFORMS.ROWFILTER_PROG',
    number_of_arguments => 2,
    enabled             => FALSE,
    comments            => 'Row Filter Program');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.ROWFILTER_PROG',
    metadata_attribute => 'job_name',
    argument_position  => 1,
    argument_name      => 'p_job_name');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.ROWFILTER_PROG',
    metadata_attribute => 'job_subname',
    argument_position  => 2,
    argument_name      => 'p_chain_step');
  DBMS_SCHEDULER.ENABLE('ODMRSYS.ROWFILTER_PROG');

  DBMS_SCHEDULER.CREATE_PROGRAM (
    program_name        => 'ODMRSYS.FEATURE_BUILD_PROG',
    program_type        => 'STORED_PROCEDURE',
    program_action      => 'ODMR_ENGINE_MINING.FEATURE_BUILD_PROG',
    number_of_arguments => 2,
    enabled             => FALSE,
    comments            => 'Feature Build Program');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.FEATURE_BUILD_PROG',
    metadata_attribute => 'job_name',
    argument_position  => 1,
    argument_name      => 'p_job_name');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.FEATURE_BUILD_PROG',
    metadata_attribute => 'job_subname',
    argument_position  => 2,
    argument_name      => 'p_chain_step');
  DBMS_SCHEDULER.ENABLE('ODMRSYS.FEATURE_BUILD_PROG');

  DBMS_SCHEDULER.CREATE_PROGRAM (
    program_name        => 'ODMRSYS.TEXT_PROG',
    program_type        => 'STORED_PROCEDURE',
    program_action      => 'ODMR_ENGINE_TEXT.TEXT_PROG',
    number_of_arguments => 2,
    enabled             => FALSE,
    comments            => 'Text Program');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.TEXT_PROG',
    metadata_attribute => 'job_name',
    argument_position  => 1,
    argument_name      => 'p_job_name');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.TEXT_PROG',
    metadata_attribute => 'job_subname',
    argument_position  => 2,
    argument_name      => 'p_chain_step');
  DBMS_SCHEDULER.ENABLE('ODMRSYS.TEXT_PROG');

  DBMS_SCHEDULER.CREATE_PROGRAM (
    program_name        => 'ODMRSYS.BUILDTEXT_PROG',
    program_type        => 'STORED_PROCEDURE',
    program_action      => 'ODMR_ENGINE_TEXT.BUILDTEXT_PROG',
    number_of_arguments => 2,
    enabled             => FALSE,
    comments            => 'Build Text Program');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.BUILDTEXT_PROG',
    metadata_attribute => 'job_name',
    argument_position  => 1,
    argument_name      => 'p_job_name');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.BUILDTEXT_PROG',
    metadata_attribute => 'job_subname',
    argument_position  => 2,
    argument_name      => 'p_chain_step');
  DBMS_SCHEDULER.ENABLE('ODMRSYS.BUILDTEXT_PROG');

  DBMS_SCHEDULER.CREATE_PROGRAM (
    program_name        => 'ODMRSYS.APPLYTEXT_PROG',
    program_type        => 'STORED_PROCEDURE',
    program_action      => 'ODMR_ENGINE_TEXT.APPLYTEXT_PROG',
    number_of_arguments => 2,
    enabled             => FALSE,
    comments            => 'Apply Text Program');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.APPLYTEXT_PROG',
    metadata_attribute => 'job_name',
    argument_position  => 1,
    argument_name      => 'p_job_name');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.APPLYTEXT_PROG',
    metadata_attribute => 'job_subname',
    argument_position  => 2,
    argument_name      => 'p_chain_step');
  DBMS_SCHEDULER.ENABLE('ODMRSYS.APPLYTEXT_PROG');

  DBMS_SCHEDULER.CREATE_PROGRAM (
    program_name        => 'ODMRSYS.BUILDTEXT_REF_PROG',
    program_type        => 'STORED_PROCEDURE',
    program_action      => 'ODMR_ENGINE_TEXT.BUILDTEXT_REF_PROG',
    number_of_arguments => 2,
    enabled             => FALSE,
    comments            => 'Build Text Reference Program');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.BUILDTEXT_REF_PROG',
    metadata_attribute => 'job_name',
    argument_position  => 1,
    argument_name      => 'p_job_name');

  DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT (
    program_name       => 'ODMRSYS.BUILDTEXT_REF_PROG',
    metadata_attribute => 'job_subname',
    argument_position  => 2,
    argument_name      => 'p_chain_step');
  DBMS_SCHEDULER.ENABLE('ODMRSYS.BUILDTEXT_REF_PROG');

END;
/

