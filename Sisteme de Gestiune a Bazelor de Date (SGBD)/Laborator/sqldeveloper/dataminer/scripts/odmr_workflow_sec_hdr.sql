
  CREATE OR REPLACE PACKAGE "ODMRSYS"."ODMR_WORKFLOW_SEC" 
AUTHID DEFINER AS

  c_wf_lock    CONSTANT VARCHAR2(30) := 'ODMR$WF';

  FUNCTION get_workflow_run_mode(p_workflowId IN NUMBER) RETURN VARCHAR2;

  FUNCTION get_workflow_status(p_workflowId IN NUMBER) RETURN VARCHAR2;

  FUNCTION is_workflow_running(p_workflowId IN NUMBER) RETURN BOOLEAN;

  PROCEDURE update_workflow_status(p_workflowId IN NUMBER, p_status IN VARCHAR2);

  FUNCTION workflow_exist(p_project_id IN NUMBER, p_workflow_name IN VARCHAR2) RETURN BOOLEAN;

  FUNCTION workflow_exist(p_workflowId NUMBER) RETURN BOOLEAN;

  PROCEDURE set_timestamp(p_workflowId IN NUMBER, p_last_updated_time IN TIMESTAMP);

  FUNCTION get_timestamp(p_workflowId IN NUMBER) RETURN TIMESTAMP;

  --FUNCTION lock_workflow(p_user_session IN VARCHAR2, p_workflowId IN NUMBER) RETURN BOOLEAN;

  FUNCTION is_server_lock(wf_id IN NUMBER) RETURN BOOLEAN;

  FUNCTION server_lock(wf_id IN NUMBER) RETURN BOOLEAN;

  FUNCTION server_unlock(wf_id IN NUMBER) RETURN BOOLEAN;

  FUNCTION session_lock(wf_id IN NUMBER) RETURN BOOLEAN;

  --PROCEDURE clear_workflow_lock(p_workflowId IN NUMBER);

  FUNCTION is_workflow_valid(p_workflowId IN NUMBER) RETURN BOOLEAN;

  PROCEDURE find_children_node(p_workflowId IN NUMBER,
                          p_runNode IN VARCHAR2,
                          p_children_nodes IN OUT NOCOPY ODMR_OBJECT_NAMES,
                          p_node_lookup IN OUT NOCOPY ODMR_WORKFLOW.NODELOOKUPTYPE);

  PROCEDURE find_source_node(p_workflowId IN NUMBER,
                             p_run_mode IN VARCHAR2,
                             p_node_lookup IN OUT NOCOPY ODMR_WORKFLOW.NODELOOKUPTYPE,
                             p_workflow IN OUT NOCOPY ODMR_WORKFLOW.WORKFLOWRECTYPES,
                             p_runNodes IN OUT NOCOPY ODMR_OBJECT_NAMES);

  PROCEDURE getBuildNodeModels(p_workflowId IN NUMBER, p_buildNodeId IN VARCHAR2, p_buildNodeType IN VARCHAR2, p_models IN OUT NOCOPY ODMR_OBJECT_NAMES);

  PROCEDURE WF_GET_ALL_MODELS(p_user_session IN VARCHAR2, p_models IN OUT NOCOPY ODMR_OBJECT_NAMES);

  PROCEDURE WF_GET_ALL_TABLES(p_user_session IN VARCHAR2, p_tables IN OUT NOCOPY ODMR_OBJECT_NAMES);

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
                  p_workflow_name IN VARCHAR2,
                  p_comment IN VARCHAR2) RETURN NUMBER;

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
  PROCEDURE WF_LOAD(p_workflowId IN NUMBER, p_workflow IN OUT XMLType, p_timestamp IN OUT TIMESTAMP);

  PROCEDURE WF_LOAD2(p_workflowId IN NUMBER, p_workflow IN OUT CLOB, p_timestamp IN OUT TIMESTAMP);

  PROCEDURE WF_SAVE(p_workflowId IN NUMBER, p_workflow_data IN XMLType,
                    p_db_objects IN OUT NOCOPY ODMR_INTERNAL_UTIL.DB_OBJECTS);

  /*
  Run the workflow
  Starting from the destination node(s), it walks up the lineage to the immediate valid data source node(s).
  From the data source node(s), it walks down the lineage to create chain steps for all non-COMPLETE nodes as it builds the scheduler chain.
  All children nodes of a non-COMPLETE parent will be considered non-COMPLETE regardless of their own states.
  The workflow run may overwrite any existing objects (model, test, apply results).
  As the workflow runs, it updates the node status in the XML definition.
  The client SHOULD NOT modify the XML definition during the workflow run.
  The client may want to reload the XML definition (via LOAD) when the workflow completes.
  The client can use the workflow VIEW to monitor the workflow status and individual node status.
  Parameters:
    p_workflowId - workflow id
    p_nodeIds - destination node id(s) - only one node is supported:2
    p_max_num_threads - max number of parallel threads for the workflow execution
    p_job_class - user defined job class, where the Chain job will be based, NULL if no user defined class
    p_start_time - scheduled start time, NULL if run immediately
  Return:
    job id - scheduler chain job id
  Validation:
    If the workflow is in either running or edit mode, then error
  */
  PROCEDURE WF_RUN(p_workflowId IN NUMBER,
                p_run_mode IN VARCHAR2,
                p_chain_name IN VARCHAR2,
                p_job_name IN VARCHAR2,
                p_start_time IN TIMESTAMP);

  PROCEDURE WF_RENAME(p_workflowId IN NUMBER, p_workflow_name IN VARCHAR2);

  /*
  Delete the workflow
  Parameters:
    p_workflowId - workflow id
  Validation:
    If the workflow is in either running or edit mode, then error
  */
  PROCEDURE WF_DELETE(p_workflowId IN NUMBER, p_db_objects IN OUT NOCOPY ODMR_INTERNAL_UTIL.DB_OBJECTS);

  PROCEDURE SET_COMMENT(p_workflowId IN NUMBER, p_comment IN VARCHAR2);

  PROCEDURE WF_GET_NODES_BY_TYPE(p_node_type IN VARCHAR2, p_user IN VARCHAR2, p_nodes IN OUT NOCOPY ODMR_NODE_REFERENCE_SET);

  FUNCTION WF_GET_NODE_CONTENT(p_user IN VARCHAR2, p_node_type IN VARCHAR2, p_project_id IN NUMBER,
            p_workflow_id IN NUMBER, p_node_id IN NUMBER)
            RETURN CLOB;

  PROCEDURE init_node_lookup(p_workflowId IN NUMBER, p_node_lookup IN OUT NOCOPY ODMR_WORKFLOW.NODELOOKUPTYPE);
  
  PROCEDURE get_node_info(p_node_lookup IN OUT NOCOPY ODMR_WORKFLOW.NODELOOKUPTYPE, p_nodeId IN VARCHAR2, p_nodeType OUT VARCHAR2, p_nodeName OUT VARCHAR2, p_nodeStatus OUT VARCHAR2);

  FUNCTION getOutputTablesOrViews(p_workflowId IN NUMBER) RETURN ODMR_OBJECT_NAMES;

  ALL_NODES_XPATH CONSTANT VARCHAR2(32767) := '
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_DATASOURCE||',
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_CREATETABLE||',
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_UPDATETABLE||',
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_DATAPROFILE||',
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_TRANSFORMATION||',
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_AGGREGATION||',
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_JOIN||',
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_TEXT||',
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_BUILDTEXT||',
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_APPLYTEXT||',
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_SAMPLE||',
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_COLUMNFILTER||',
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_ROWFILTER||',
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_CLASS_BUILD||',
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_REGRESS_BUILD||',
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_CLUST_BUILD||',
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_ASSOC_BUILD||',
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_FEATURE_BUILD||',
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_ANOMALY_BUILD||',
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_MODEL||',
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_APPLY||',
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_TEST||',
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_MODELDETAILS||',
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_TESTDETAILS||',
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_FILTERDETAILS||'
  ';

  ALL_CLASS_MODELS_XPATH CONSTANT VARCHAR2(32767) := '
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_CLASS_BUILD||'/Models/'||ODMR_CONSTANT.WF_NODE_BUILD_NB||',
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_CLASS_BUILD||'/Models/'||ODMR_CONSTANT.WF_NODE_BUILD_DT||',
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_CLASS_BUILD||'/Models/'||ODMR_CONSTANT.WF_NODE_BUILD_SVMC||',
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_CLASS_BUILD||'/Models/'||ODMR_CONSTANT.WF_NODE_BUILD_GLMC||'
  ';
  
  ALL_REGRESS_MODELS_XPATH CONSTANT VARCHAR2(32767) := '
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_REGRESS_BUILD||'/Models/'||ODMR_CONSTANT.WF_NODE_BUILD_SVMR||',
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_REGRESS_BUILD||'/Models/'||ODMR_CONSTANT.WF_NODE_BUILD_GLMR||'
  ';
  
  ALL_CLUST_MODELS_XPATH CONSTANT VARCHAR2(32767) := '
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_CLUST_BUILD||'/Models/'||ODMR_CONSTANT.WF_NODE_BUILD_OC||',
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_CLUST_BUILD||'/Models/'||ODMR_CONSTANT.WF_NODE_BUILD_KM||'
  ';
  
  ALL_ASSOC_MODELS_XPATH CONSTANT VARCHAR2(32767) := '
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_ASSOC_BUILD||'/Models/'||ODMR_CONSTANT.WF_NODE_BUILD_AR||'
  ';
  
  ALL_FEATURE_MODELS_XPATH CONSTANT VARCHAR2(32767) := '
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_FEATURE_BUILD||'/Models/'||ODMR_CONSTANT.WF_NODE_BUILD_NMF||'
  ';
  
  ALL_ANOMALY_MODELS_XPATH CONSTANT VARCHAR2(32767) := '
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_ANOMALY_BUILD||'/Models/'||ODMR_CONSTANT.WF_NODE_BUILD_SVMO||'
  ';
/*  
  ALL_TABLES_XPATH CONSTANT VARCHAR2(32767) := '
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_DATASOURCE||'/CacheSettings/OutputTable,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_CREATETABLE||'/CacheSettings/OutputTable,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_UPDATETABLE||'/CacheSettings/OutputTable,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_UPDATETABLE||'/UpdateTargetTable,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_DATAPROFILE||'/CacheSettings/OutputTable,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_TRANSFORMATION||'/CacheSettings/OutputTable,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_AGGREGATION||'/CacheSettings/OutputTable,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_JOIN||'/CacheSettings/OutputTable,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_TEXT||'/CacheSettings/OutputTable,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_BUILDTEXT||'/CacheSettings/OutputTable,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_APPLYTEXT||'/CacheSettings/OutputTable,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_SAMPLE||'/CacheSettings/OutputTable,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_COLUMNFILTER||'/CacheSettings/OutputTable,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_ROWFILTER||'/CacheSettings/OutputTable,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_APPLY||'/CacheSettings/OutputTable,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_MODELDETAILS||'/CacheSettings/OutputTable,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_TESTDETAILS||'/CacheSettings/OutputTable,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_FILTERDETAILS||'/CacheSettings/OutputTable,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_TRANSFORMATION||'/SampleSettings/OutputTable,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_DATAPROFILE||'/StatisticTable,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_SAMPLE||'/StatisticTable,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_BUILDTEXT||'/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Token/Token/StatisticTable,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_BUILDTEXT||'/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Theme/Token/StatisticTable,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_BUILDTEXT||'/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Token/Token/FeatureTable,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_BUILDTEXT||'/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Theme/Token/FeatureTable,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_APPLYTEXT||'/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Token/Token/FeatureTable,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_APPLYTEXT||'/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Theme/Token/FeatureTable,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_TRANSFORMATION||'/InputStatisticTable,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_TRANSFORMATION||'/TransformedStatisticTable,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_CLASS_BUILD||'/Results/ClassificationResult/TestMetrics,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_CLASS_BUILD||'/Results/ClassificationResult/ConfusionMatrix,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_CLASS_BUILD||'/Results/ClassificationResult/Lifts/Lift,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_CLASS_BUILD||'/Results/ClassificationResult/ROCs/ROC,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_TEST||'/Results/ClassificationResult/TestMetrics,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_TEST||'/Results/ClassificationResult/ConfusionMatrix,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_TEST||'/Results/ClassificationResult/Lifts/Lift,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_TEST||'/Results/ClassificationResult/ROCs/ROC,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_REGRESS_BUILD||'/Results/RegressionResult/TestMetrics,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_REGRESS_BUILD||'/Results/RegressionResult/ResidualPlot,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_TEST||'/Results/RegressionResult/TestMetrics,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_TEST||'/Results/RegressionResult/ResidualPlot
  ';

  CREATETABLE_TABLE_XPATH CONSTANT VARCHAR2(32767) := '
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_CREATETABLE;
    
  COLUMN_FILTER_TABLES_XPATH CONSTANT VARCHAR2(32767) := '
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_COLUMNFILTER||'/ColumnFilterResults
  ';

  ALL_DIAGNOSTICS_TABLES_XPATH CONSTANT VARCHAR2(32767) := '
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_CLASS_BUILD||'/Models/'||ODMR_CONSTANT.WF_NODE_BUILD_GLMC||'/CGeneralizedLinearAlgo/GLMS_DIAGNOSTICS_TABLE_NAME,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_REGRESS_BUILD||'/Models/'||ODMR_CONSTANT.WF_NODE_BUILD_GLMR||'/RGeneralizedLinearModelAlgo/GLMS_DIAGNOSTICS_TABLE_NAME
  ';
  
  ALL_STOPLISTS_XPATH CONSTANT VARCHAR2(32767) := '
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_TEXT||'/Stoplists/Stoplist,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_BUILDTEXT||'/Stoplists/Stoplist,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_APPLYTEXT||'/Stoplists/Stoplist
  ';

  ALL_LEXERS_XPATH CONSTANT VARCHAR2(32767) := '
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_BUILDTEXT||'/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Token/Token/Lexer,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_BUILDTEXT||'/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Theme/Token/Lexer,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_APPLYTEXT||'/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Token/Token/Lexer,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_APPLYTEXT||'/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Theme/Token/Lexer,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_TEXT||'/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Token/Token/Lexer,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_TEXT||'/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Theme/Token/Lexer
  ';

  ALL_POLICY_XPATH CONSTANT VARCHAR2(32767) := '
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_BUILDTEXT||'/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Token/Token,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_BUILDTEXT||'/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Theme/Token,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_APPLYTEXT||'/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Token/Token,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_APPLYTEXT||'/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Theme/Token,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_TEXT||'/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Token/Token,
    /WorkflowProcess/Nodes/'||ODMR_CONSTANT.WF_NODE_TYPE_TEXT||'/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Theme/Token
  ';
*/
END;
/
