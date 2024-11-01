
  CREATE OR REPLACE PACKAGE "ODMRSYS"."ODMR_ENGINE_DATA_SEC" 
AS

  PROCEDURE get_cache_table_info(
    p_workflowId IN NUMBER, 
    p_nodeId      IN VARCHAR2, 
    p_schema      OUT VARCHAR2, 
    p_table       OUT VARCHAR2, 
    p_attributes  IN OUT NOCOPY ODMR_OBJECT_NAMES, 
    p_attr_types  IN OUT NOCOPY ODMR_OBJECT_NAMES);

  PROCEDURE get_profile_sample_table_info(
    p_workflowId IN NUMBER, 
    p_nodeId      IN VARCHAR2, 
    p_use_full    OUT VARCHAR2,
    p_num_bins    OUT INTEGER,
    p_cat_bins    OUT INTEGER,
    p_date_bins   OUT INTEGER,
    p_grouping_attr OUT VARCHAR2, 
    p_grouping_attr_type OUT VARCHAR2, 
    p_attributes  IN OUT NOCOPY ODMR_OBJECT_NAMES, 
    p_aliases  IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_attr_types  IN OUT NOCOPY ODMR_OBJECT_NAMES);

  PROCEDURE get_profile_output_columns(
    p_workflowId  IN NUMBER, 
    p_nodeId      IN VARCHAR2, 
    p_attributes  IN OUT NOCOPY ODMR_OBJECT_NAMES);

  PROCEDURE update_attribute_status(
    p_workflowId IN NUMBER, 
    p_nodeType IN VARCHAR2, 
    p_chain_step  IN VARCHAR2, 
    p_attribute   IN VARCHAR2, 
    p_status      IN VARCHAR2, 
    p_commit IN BOOLEAN);

  PROCEDURE delete(
    p_workflowId IN NUMBER, 
    p_nodeId      IN VARCHAR2, 
    p_db_objects  IN OUT NOCOPY ODMR_INTERNAL_UTIL.DB_OBJECTS);
    
  PROCEDURE get_create_table_node_info(
    p_workflowId IN NUMBER, 
    p_nodeId      IN VARCHAR2, 
    p_use_full    OUT VARCHAR2,
    p_table       OUT VARCHAR2,
    p_table_name  OUT VARCHAR2,
    p_attributes  IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_aliases     IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_types       IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_primary_keys IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_indices      IN OUT NOCOPY ODMR_OBJECT_NAMES );

  PROCEDURE get_update_table_node_info(
    p_workflowId          IN NUMBER, 
    p_nodeId              IN VARCHAR2, 
    p_use_full            OUT VARCHAR2,
    p_drop_existing       OUT VARCHAR2,
    p_target_table_name   OUT VARCHAR2,
    p_target_schema_name  OUT VARCHAR2,
    p_target_attributes  IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_source_attributes  IN OUT NOCOPY ODMR_OBJECT_NAMES);

  PROCEDURE drop_create_table_node_tables(p_workflowId IN NUMBER, 
                                          p_nodeId      IN VARCHAR2, 
                                          p_db_objects IN OUT NOCOPY ODMR_INTERNAL_UTIL.DB_OBJECTS);
  
  PROCEDURE drop_profile_tables(p_workflowId IN NUMBER, 
                                p_nodeId      IN VARCHAR2, 
                                p_db_objects  IN OUT NOCOPY ODMR_INTERNAL_UTIL.DB_OBJECTS);
                                
  PROCEDURE drop_aggr_table_node_tables(p_workflowId IN NUMBER, 
                                        p_nodeId      IN VARCHAR2, 
                                        p_db_objects IN OUT NOCOPY ODMR_INTERNAL_UTIL.DB_OBJECTS);

  PROCEDURE drop_update_node_tables(p_workflowId IN NUMBER, 
                                p_nodeId      IN VARCHAR2, 
                                p_db_objects  IN OUT NOCOPY ODMR_INTERNAL_UTIL.DB_OBJECTS);

  PROCEDURE update_attribute_data_types (p_workflowId IN NUMBER, 
                                         p_nodeId     IN VARCHAR2,
                                         p_attributes IN ODMR_OBJECT_NAMES,
                                         p_data_types IN ODMR_OBJECT_NAMES);


  PROCEDURE get_profile_stats_table(
    p_workflowId  IN NUMBER, 
    p_nodeId      IN VARCHAR2, 
    p_stats_table OUT VARCHAR2);

END;
/
 
