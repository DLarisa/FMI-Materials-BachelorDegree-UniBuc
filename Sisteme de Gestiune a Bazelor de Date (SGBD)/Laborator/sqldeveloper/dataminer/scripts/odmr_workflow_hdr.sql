
  CREATE OR REPLACE PACKAGE "ODMRSYS"."ODMR_WORKFLOW" 
AUTHID CURRENT_USER AS

  XML_NAME_SPACE_URL  CONSTANT VARCHAR2(100) := '"http://xmlns.oracle.com/odmr11"';
  XML_NAME_SPACE_URL_NQ  CONSTANT VARCHAR2(100) := 'http://xmlns.oracle.com/odmr11';
  XML_NAME_SPACE      CONSTANT VARCHAR2(100) := 'xmlns="http://xmlns.oracle.com/odmr11"';
  XML_LOCATION        CONSTANT VARCHAR2(100) := 'xsi:schemaLocation="http://xmlns.oracle.com/odmr11 http://xmlns.oracle.com/odmr11/odmr.xsd"';
  RUN_MODE            CONSTANT VARCHAR2(30) := 'RUN';
  RERUN_MODE          CONSTANT VARCHAR2(30) := 'RERUN';
  UPSTREAM            CONSTANT VARCHAR2(30) := 'UPSTREAM';
  DOWNSTREAM          CONSTANT VARCHAR2(30) := 'DOWNSTREAM';

  --c_node_status_invalid   CONSTANT VARCHAR2(30) := 'INVALID';
  c_wf_chain_name_prefix  CONSTANT VARCHAR2(30) := 'ODMR$WFCHAIN';
  c_wf_job_name_prefix    CONSTANT VARCHAR2(30) := 'ODMR$WFJOB';

  SUBTYPE ODMR_LSTMT_REC_TYPE  IS ODMR_INTERNAL_UTIL.LSTMT_REC_TYPE;

  TYPE SUBFLOWRECTYPE IS RECORD (
    SUBFLOW_ENTRY VARCHAR2(30),
    SUBFLOW_EXIT  VARCHAR2(30) );

  TYPE SUBFLOWRECTYPES IS TABLE OF SUBFLOWRECTYPE INDEX BY VARCHAR2(30);

  TYPE WORKFLOWRECTYPE IS RECORD (
    PARENT_ID           VARCHAR2(30),
    PARENT              VARCHAR2(30),
    CHILD_ID            VARCHAR2(30),
    CHILD_TYPE          VARCHAR2(30),
    CHILD               VARCHAR2(30),
    EXPRESSION          CLOB );

  TYPE WORKFLOWRECTYPES is TABLE OF WORKFLOWRECTYPE;

  TYPE LOOKUPTYPE IS TABLE OF VARCHAR2(60) INDEX BY VARCHAR2(60);

  TYPE RULERECTYPE IS RECORD (
    --RULE_NAME   USER_SCHEDULER_CHAIN_RULES.RULE_NAME%TYPE,
    CONDITION   USER_SCHEDULER_CHAIN_RULES.CONDITION%TYPE,
    ACTION      USER_SCHEDULER_CHAIN_RULES.ACTION%TYPE,
    COMMENTS    USER_SCHEDULER_CHAIN_RULES.COMMENTS%TYPE);

  TYPE RULELOOKUPTYPE IS TABLE OF RULERECTYPE INDEX BY VARCHAR2(30);

  TYPE NODERECTYPE IS RECORD (
    TYPE      VARCHAR2(30),
    ID        VARCHAR2(30),
    NAME      VARCHAR2(30),
    STATUS    VARCHAR2(30));
    
  TYPE NODELOOKUPTYPE IS TABLE OF NODERECTYPE INDEX BY VARCHAR2(30);

  /*
  Create an empty workflow using the supplied name
  Parameters:
    p_project_id - project id
    p_workflow_name - workflow id
  Return:
    workflow id
  Validation:
    if workflow name conflict, then error
  */
  FUNCTION WF_CREATE(p_project_id IN NUMBER,
                  p_workflow_name IN VARCHAR2, p_comment IN VARCHAR2,
                  p_timestamp IN OUT TIMESTAMP) RETURN NUMBER;

  /*
  Return the workflow XML definition.  User needs to specify the desired access mode for the returned workflow.  The API will try to honor the access mode if possible; otherwise it will return the available access mode based on the current workflow state.  For example, user specifies the ÿWÿ(read/write) access mode to load the workflow for editing, but the workflow is being used, so the API returns the ÿRÿ(read only) access mode.   In this case, the user should not modify the returned workflow.
  Parameters:
    p_workflowId - workflow id
    p_mode ÿ W ÿ read/write, R ÿ read only
  Return:
    p_mode ÿ W ÿ read/write, R ÿ read only
    workflow XML definition
  Validation:
  */
  --FUNCTION WF_OLD_LOAD(p_workflowId IN NUMBER, p_mode IN OUT CHAR, p_timestamp IN OUT TIMESTAMP) RETURN XMLType;

  FUNCTION WF_LOAD(p_workflowId IN NUMBER, p_mode IN OUT CHAR, p_timestamp IN OUT TIMESTAMP) RETURN CLOB;

  /*
  Save the workflow that was previously loaded in read/write mode.  User can specify the desired access mode after the workflow is saved.  By default after the workflow is saved, it switches to ÿRÿ access mode, so the workflow can be run (lock released).
  The new workflow XML definition will be compared against the persisted one.  If any nodes are deleted, their associated/generated objects (e.g. cache, models, result outputs) will be deleted from the user account.
  If workflow is locked by another client, server throws an exception, as expected.  Otherwise, it compares the previously saved time stamp with p_timestamp.
  If time stamps are equal, server saves the workflow, updates and returns the new time stamp, and (optionally) re-locks the workflow.
  If time stamps differ, server throws an exception allowing the client to prompt the user whether to overwrite the document.  If the user decides to overwrite, the client invokes WF_SAVE with p_force set to 'Y', which saves workflow, updates the time stamp, and (optionally) re-locks the workflow.
  Parameters:
    p_workflowId - workflow id
    p_workflow_data - workflow XML definition
    p_mode ÿ W ÿ read/write, R ÿ read only (default)
  Validation:
    if the workflow was not previously loaded in read/write mode, then error
  */
  PROCEDURE WF_SAVE(p_workflowId IN NUMBER, p_workflow_data IN XMLType,
                  p_timestamp IN OUT TIMESTAMP, p_mode IN CHAR DEFAULT 'R', p_force IN CHAR DEFAULT 'N');

  /*
  Unlock the workflow regardless of any lock on it.
  Parameters:
    p_workflowId - workflow id
  */
  FUNCTION WF_UNLOCK(p_workflowId IN NUMBER) RETURN BOOLEAN;

  /*
  Run the workflow
  Parameters:
    p_project_name - project name
    p_workflow_name - workflow name
    p_node_name - node name
    p_run_mode - RUN_MODE or RERUN_MODE
                 RUN_MODE - only nodes with non-complete status will be run
                 RERUN_MODE - nodes will be run regardless of their status
    p_direction - UPSTREAM or DOWNSTREAM
                  UPSTREAM - run the node and its parents
                  DOWNSTREAM - run the node and its children
    p_max_num_threads - max number of parallel model builds
    p_start_time - scheduled start time, NULL if run immediately
    p_repeat_interval - repeat interval for workflow run
    p_end_date - scheduled end time, NULL if none
    p_job_class - job class, if NULL, default job class will be used
  Return:
    job id - scheduler chain job id
  Validation:
    If the workflow is in either running or edit mode, then error
  */
  FUNCTION WF_RUN(p_project_name      IN VARCHAR2,
                  p_workflow_name     IN VARCHAR2,
                  p_node_name         IN VARCHAR2,
                  p_run_mode          IN VARCHAR2 DEFAULT RUN_MODE,
                  p_direction         IN VARCHAR2 DEFAULT UPSTREAM,
                  p_max_num_threads   IN NUMBER DEFAULT NULL,
                  p_start_date        IN TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP,
                  p_repeat_interval   IN VARCHAR2 DEFAULT NULL,
                  p_end_date          IN TIMESTAMP WITH TIME ZONE DEFAULT NULL,
                  p_job_class         IN VARCHAR2 DEFAULT NULL) RETURN VARCHAR2;

  FUNCTION WF_RUN(p_workflowId IN NUMBER,
               p_nodeId IN VARCHAR2,
               p_run_mode IN VARCHAR2 DEFAULT RUN_MODE,
               p_max_num_threads IN NUMBER DEFAULT NULL,
               p_job_class IN VARCHAR2 DEFAULT NULL,
               p_start_time IN TIMESTAMP WITH TIME ZONE DEFAULT NULL,
               p_direction IN VARCHAR2 DEFAULT UPSTREAM) RETURN VARCHAR2;

  /*
  Stop the workflow (run to completion, then stop)
  Parameters:
    p_workflowId - workflow id
  Validation:
    If the workflow is not in running mode, then error
  */
  PROCEDURE WF_STOP(p_workflowId IN NUMBER);

  /*
  Delete the workflow
  Parameters:
    p_workflowId - workflow id
  Validation:
    If the workflow is in either running or edit mode, then error
  */
  PROCEDURE WF_DELETE(p_workflowId IN NUMBER);

  /*
  Rename the workflow
  Parameters:
    p_workflowId - workflow id
    p_workflow_name - new workflow name
  Validation: if name already existed, then error
  */
  PROCEDURE WF_RENAME(p_workflowId IN NUMBER, p_workflow_name IN VARCHAR2, p_mode IN CHAR DEFAULT 'R');

  PROCEDURE WF_GET_ALL_MODELS(p_models IN OUT NOCOPY ODMR_OBJECT_NAMES);

  PROCEDURE WF_GET_ALL_TABLES(p_tables IN OUT NOCOPY ODMR_OBJECT_NAMES);

  PROCEDURE WF_GET_NODES_BY_TYPE(p_node_type IN VARCHAR2, p_nodes IN OUT NOCOPY ODMR_NODE_REFERENCE_SET);

  FUNCTION WF_GET_NODE_CONTENT(p_node_type IN VARCHAR2, p_project_id IN NUMBER, p_workflow_id IN NUMBER, 
                                p_node_id IN NUMBER) RETURN CLOB;


END ODMR_WORKFLOW;
/
