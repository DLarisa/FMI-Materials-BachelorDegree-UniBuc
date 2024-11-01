
  CREATE OR REPLACE PACKAGE "ODMRSYS"."ODMR_INTERNAL_UTIL_SEC" 
AS

  PROCEDURE EVENT_LOG(p_user            IN VARCHAR2,
                      p_job             IN VARCHAR2,
                      p_workflowId      IN NUMBER,
                      p_nodeId          IN VARCHAR2,
                      p_node_name       IN VARCHAR2 DEFAULT NULL,
                      p_subnode_id      IN VARCHAR2,
                      p_subnode_name    IN VARCHAR2 DEFAULT NULL,
                      p_message_type    IN VARCHAR2,
                      p_message_subtype IN VARCHAR2,
                      p_message_task    IN VARCHAR2,
                      p_duration        INTERVAL DAY TO SECOND,
                      p_message         IN NVARCHAR2,
                      p_message_details IN VARCHAR2);

  PROCEDURE GET_INPUT_DATA (
    p_workflowId IN NUMBER,
    p_runNode_id IN VARCHAR,
    p_input_data IN OUT NOCOPY ODMR_INTERNAL_UTIL.LSTMT_REC_TYPE, -- Resulting SQL expression
    p_inclusive IN BOOLEAN DEFAULT TRUE);

  PROCEDURE GET_INPUT_DATA_UTN (
    p_workflowId IN NUMBER,
    p_runNode_id IN VARCHAR,
    p_source_attributes  IN ODMR_OBJECT_NAMES,
    p_input_data IN OUT NOCOPY ODMR_INTERNAL_UTIL.LSTMT_REC_TYPE);-- Resulting SQL expression.

  PROCEDURE GET_INPUT_DATA (
    p_workflowId IN NUMBER,
    p_runNode_id IN VARCHAR,
    p_parentNode_id IN VARCHAR,
    p_input_data IN OUT NOCOPY ODMR_INTERNAL_UTIL.LSTMT_REC_TYPE); -- Resulting SQL expression.

  FUNCTION GET_REPOSITORY_NUM_VALUE(p_property_name IN VARCHAR2) RETURN NUMBER;

  FUNCTION GET_REPOSITORY_STR_VALUE(p_property_name IN VARCHAR2) RETURN VARCHAR2;

  -- DEBUG_ADD_LOG_ROW logs debug trace to ODMR$DEBUG_LOG
  PROCEDURE DEBUG_ADD_LOG_ROW (
    p_workflow_name IN VARCHAR := NULL,
    p_workflowId IN NUMBER := NULL,
    p_nodeId IN VARCHAR2 := NULL,
    p_subnode_id IN NUMBER := NULL,
    p_output_mesg IN VARCHAR := NULL,
    p_output_clob IN CLOB := NULL);

  PROCEDURE INTERNAL_DEBUG (
    p_workflow_name IN VARCHAR := NULL,
    p_workflowId IN NUMBER := NULL,
    p_nodeId IN VARCHAR2 := NULL,
    p_subnode_id IN NUMBER := NULL,
    p_output_mesg IN VARCHAR := NULL,
    p_output_clob IN CLOB := NULL,
    p_workflow_data IN CLOB := NULL);
    
  PROCEDURE AUTO_SQL_TRACE(
    p_job_name IN VARCHAR2,
    p_workflowId IN NUMBER,
    p_nodeId IN VARCHAR2,
    p_modelId IN VARCHAR2 := NULL,
    p_trace_file_suffix IN VARCHAR2 := NULL
    );

  PROCEDURE AUTO_SQL_TRACE_OFF(
    p_job_name IN VARCHAR2 := NULL,
    p_workflowId IN NUMBER := NULL,
    p_nodeId IN VARCHAR2 := NULL,
    p_modelId IN VARCHAR2 := NULL,
    p_trace_file_suffix IN VARCHAR2 := NULL
    );

  PROCEDURE ALTER_SESSION_FIX(
    p_job_name IN VARCHAR2,
    p_workflowId IN NUMBER,
    p_nodeId IN VARCHAR2,
    p_modelId IN VARCHAR2 := NULL
    );

  FUNCTION get_wf_node_id(p_workflowId IN NUMBER, p_nodeName IN VARCHAR2) RETURN VARCHAR2;

  FUNCTION get_wf_node_type(p_workflowId IN NUMBER, p_nodeId IN VARCHAR2) RETURN VARCHAR2;

  FUNCTION get_wf_node_name(p_workflowId IN NUMBER, p_nodeId IN VARCHAR2) RETURN VARCHAR2;

  FUNCTION get_wf_model_type(p_workflowId IN NUMBER, p_modelId IN VARCHAR2) RETURN VARCHAR2;

  FUNCTION get_wf_model_name(p_workflowId IN NUMBER, p_modelId IN VARCHAR2) RETURN VARCHAR2;

  FUNCTION replace_nonstardard_characters(p_value IN VARCHAR2) RETURN VARCHAR2;


END;
/
