
  CREATE OR REPLACE PACKAGE "ODMRSYS"."ODMR_ENGINE" 
AUTHID CURRENT_USER AS

  TYPE lookupType IS TABLE OF VARCHAR2(35) INDEX BY VARCHAR2(30);
  SUBTYPE ODMR_LSTMT_REC_TYPE  IS ODMR_INTERNAL_UTIL.LSTMT_REC_TYPE;

  TYPE COLUMN_SQL_DEFINITION IS RECORD (
    column_name       VARCHAR2(35),
    sql_definition    ODMR_INTERNAL_UTIL.LSTMT_REC_TYPE );
  TYPE SQL_DEFINITION_ARRAY IS TABLE OF COLUMN_SQL_DEFINITION INDEX BY VARCHAR2(35);

  TYPE SIMPLE_STAT_OBJECT IS RECORD (
    attr_name         VARCHAR2(35),
    attr_type         VARCHAR2(30),
    data_type         VARCHAR2(30),
    mining_type       VARCHAR2(30),
    data_length       NUMBER,
    null_percent      NUMBER,
    distinct_count    NUMBER,
    distinct_percent  NUMBER
    );
  TYPE STLOOKUPTYPE IS TABLE OF SIMPLE_STAT_OBJECT INDEX BY VARCHAR2(30);

  TYPE MAP_OUT_TO_OTHER IS TABLE OF  VARCHAR2(4000) INDEX BY VARCHAR2(35);

  TYPE BIN_LABEL_ID IS RECORD (
    labels         ODMR_OBJECT_VALUES,
    bin_numbers    ODMR_OBJECT_IDS);
    
  TYPE BIN_LABEL_ID_MAP IS TABLE OF BIN_LABEL_ID INDEX BY VARCHAR2(35);

  TYPE BINNED_COLUMN IS RECORD (
    out_column_name      VARCHAR2(35),        -- name of the binned column
    src_column_name      VARCHAR2(35),        -- name of the corresponding source column
    v_cut_points         ODMR_OBJECT_IDS,     -- cut points
    bin_categories     ODMR_OBJECT_VALUES  -- bin values
  );
  TYPE BINNED_COLUMNS IS TABLE OF BINNED_COLUMN INDEX BY VARCHAR2(35);

  TYPE BINNED_TIMESTAMP IS RECORD (
    out_column_name      VARCHAR2(35),        -- name of the binned column
    src_column_name      varchar2(35),        -- name of the corresponding source column
    v_cut_points         ODMR_OBJECT_VALUES,     -- cut points
    bin_categories     ODMR_OBJECT_VALUES  -- bin values
  );
  TYPE BINNED_TIMESTAMP_COLUMNS is table of BINNED_TIMESTAMP index by varchar2(35);

  TYPE TOPN_COLUMN IS RECORD (
    out_column_name      VARCHAR2(35),        -- name of the binned column
    src_column_name      VARCHAR2(35),        -- name of the corresponding source column
    is_other             ODMR_OBJECT_IDS,  -- is Other bin
    topn_category        ODMR_OBJECT_VALUES   -- bin values
  );
  TYPE TOPN_COLUMNS IS TABLE OF TOPN_COLUMN INDEX BY VARCHAR2(35);
  
  
  ODMR_CASE_ID          CONSTANT VARCHAR2(30) := 'DMR$CASEID';

  c_start_prog          CONSTANT VARCHAR2(30) := 'ODMRSYS.START_PROG';
  c_end_prog            CONSTANT VARCHAR2(30) := 'ODMRSYS.CLEANUP_PROG';
  c_subflow_start_prog  CONSTANT VARCHAR2(30) := 'ODMRSYS.SUBFLOW_START_PROG';
  c_subflow_end_prog    CONSTANT VARCHAR2(30) := 'ODMRSYS.SUBFLOW_CLEANUP_PROG';

  c_datasource_prog     CONSTANT VARCHAR2(30) := 'ODMRSYS.DATASOURCE_PROG';
  c_createtable_prog    CONSTANT VARCHAR2(30) := 'ODMRSYS.CREATETABLE_PROG';
  c_updatetable_prog    CONSTANT VARCHAR2(30) := 'ODMRSYS.UPDATETABLE_PROG';
  c_dataprofile_prog    CONSTANT VARCHAR2(30) := 'ODMRSYS.DATAPROFILE_PROG';
  c_transform_prog      CONSTANT VARCHAR2(30) := 'ODMRSYS.TRANSFORMATIONS_PROG';
  c_aggregation_prog    CONSTANT VARCHAR2(30) := 'ODMRSYS.AGGREGATION_PROG';
  c_join_prog           CONSTANT VARCHAR2(30) := 'ODMRSYS.JOIN_PROG';
  c_text_prog           CONSTANT VARCHAR2(30) := 'ODMRSYS.BUILDTEXT_REF_PROG';
  c_buildtext_prog      CONSTANT VARCHAR2(30) := 'ODMRSYS.BUILDTEXT_PROG';
  c_applytext_prog      CONSTANT VARCHAR2(30) := 'ODMRSYS.APPLYTEXT_PROG';
  c_sample_prog         CONSTANT VARCHAR2(30) := 'ODMRSYS.SAMPLE_PROG';
  c_columnfilter_prog   CONSTANT VARCHAR2(30) := 'ODMRSYS.COLUMNFILTER_PROG';
  c_rowfilter_prog      CONSTANT VARCHAR2(30) := 'ODMRSYS.ROWFILTER_PROG';
  c_class_build_prog    CONSTANT VARCHAR2(30) := 'ODMRSYS.CLASS_BUILD_PROG';
  c_regress_build_prog  CONSTANT VARCHAR2(30) := 'ODMRSYS.REGRESS_BUILD_PROG';
  c_clust_build_prog    CONSTANT VARCHAR2(30) := 'ODMRSYS.CLUST_BUILD_PROG';
  c_feature_build_prog  CONSTANT VARCHAR2(30) := 'ODMRSYS.FEATURE_BUILD_PROG';
  c_anomaly_build_prog  CONSTANT VARCHAR2(30) := 'ODMRSYS.ANOMALY_BUILD_PROG';
  c_assoc_build_prog    CONSTANT VARCHAR2(30) := 'ODMRSYS.ASSOC_BUILD_PROG';
  c_model_prog          CONSTANT VARCHAR2(30) := 'ODMRSYS.MODEL_PROG';
  c_apply_prog          CONSTANT VARCHAR2(30) := 'ODMRSYS.APPLY_PROG';
  c_test_prog           CONSTANT VARCHAR2(30) := 'ODMRSYS.TEST_PROG';
  c_modeldetails_prog   CONSTANT VARCHAR2(30) := 'ODMRSYS.MODELDETAILS_PROG';
  c_testdetails_prog    CONSTANT VARCHAR2(30) := 'ODMRSYS.TESTDETAILS_PROG';
  c_filterdetails_prog  CONSTANT VARCHAR2(30) := 'ODMRSYS.FILTERDETAILS_PROG';

  c_timestamp_no_tz     CONSTANT VARCHAR2(30) := 'DD.MM.YYYY HH24:MI:SS';
  c_timestamp_no_tz_xml     constant varchar2(30) := 'YYYY-MM-DD HH24:MI:SS';
  c_timestamp_with_tz   CONSTANT VARCHAR2(30) := 'DD.MM.YYYY HH24:MI:SS TZH:TZM';
  c_timestamp_with_tz_xml   constant varchar2(30) := 'YYYY-MM-DD HH24:MI:SS TZH:TZM';
  c_to_timestamp_f      CONSTANT VARCHAR2(30) := 'TO_TIMESTAMP';
  c_to_timestamp_tz_f   CONSTANT VARCHAR2(30) := 'TO_TIMESTAMP_TZ';
  c_other_value         CONSTANT VARCHAR2(30) := 'Other';
  
  FUNCTION get_program_name(p_node_type IN VARCHAR2) RETURN VARCHAR2;

  FUNCTION create_cache_table(
      p_workflowId    IN NUMBER,
      p_nodeId        IN VARCHAR2 ) RETURN VARCHAR2;

  FUNCTION create_sample_table(
      p_workflowId    IN NUMBER,
      p_nodeId        IN VARCHAR2,
      p_inlcusive     IN BOOLEAN DEFAULT TRUE) RETURN VARCHAR2;

  FUNCTION create_sample_table2(p_workflowId         IN NUMBER,
                                p_nodeId             IN VARCHAR2,
                                p_inlcusive          IN BOOLEAN DEFAULT TRUE,
                                p_input_data         IN VARCHAR2 DEFAULT NULL,
                                p_useNumberOfRows    IN BOOLEAN DEFAULT TRUE,
                                p_numberOfRows       IN NUMBER DEFAULT 2000,
                                p_usePercentOfTotal  IN BOOLEAN DEFAULT FALSE,
                                p_percentOfTotal     IN NUMBER DEFAULT 0,
                                p_caseId             IN VARCHAR2 DEFAULT NULL,
                                p_targetAttr         IN VARCHAR2 DEFAULT NULL,
                                p_primary_set        IN BOOLEAN DEFAULT TRUE) RETURN VARCHAR2;

  PROCEDURE get_generate_cache_info(p_workflowId IN NUMBER, p_nodeId IN VARCHAR2, 
                                    p_generate_cache OUT NUMBER, p_cache_data OUT VARCHAR2);

  FUNCTION create_cache_table2(
      p_workflowId    IN NUMBER,
      p_nodeId        IN VARCHAR2,
      p_input_sql     IN OUT VARCHAR2 ) RETURN VARCHAR2;

  PROCEDURE skip_children(p_job_name IN VARCHAR2, p_parentId IN VARCHAR2);

  PROCEDURE START_PROG(p_job_name IN VARCHAR2, p_chain_step IN VARCHAR2);

  PROCEDURE CLEANUP_PROG(p_job_name IN VARCHAR2, p_chain_step IN VARCHAR2);

  FUNCTION create_simple_statistics_table (
    p_workflowId  IN NUMBER,
    p_nodeId      IN VARCHAR2,
    p_input_table IN VARCHAR2,
    p_gen_constant_percent IN BOOLEAN DEFAULT FALSE,
    p_skip_uni_percent_for_numeric IN BOOLEAN DEFAULT TRUE) RETURN VARCHAR2;

  FUNCTION create_simple_statistics_table(
    p_workflowId IN NUMBER,
    p_nodeId      IN VARCHAR2,
    p_input_table IN VARCHAR2 DEFAULT NULL,
    p_sample_stat IN BOOLEAN DEFAULT TRUE,
    p_caseId      IN VARCHAR2 DEFAULT NULL,
    p_target      IN VARCHAR2 DEFAULT NULL,
    p_attributes  IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_attrDataTypes  IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_attrDataLengths  IN OUT NOCOPY ODMR_OBJECT_IDS,
    p_attrMiningTypes  IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_gen_constant_percent  IN BOOLEAN DEFAULT FALSE,
    p_skip_uni_percent_for_numeric IN BOOLEAN DEFAULT FALSE) RETURN VARCHAR2;

  FUNCTION create_statistics_table(
    p_workflowId IN NUMBER,
    p_nodeId      IN VARCHAR2,
    p_input_table IN VARCHAR2,
    p_use_full    IN VARCHAR2,
    p_attributes  IN ODMR_OBJECT_NAMES,
    p_attrDataTypes  IN ODMR_OBJECT_NAMES,
    p_inclusive     IN BOOLEAN DEFAULT TRUE) RETURN VARCHAR2;

  PROCEDURE calculate_histograms (
    p_workflowId IN NUMBER,
    p_nodeId      IN VARCHAR2,
    p_cache_table IN VARCHAR2,
    p_stats_table_name IN VARCHAR2,
    p_use_full    IN VARCHAR2,
    p_num_bins    IN INTEGER,
    p_cat_bins    IN INTEGER,
    p_date_bins   IN INTEGER,
    p_grouping_attr IN VARCHAR2,
    p_grouping_attr_type IN VARCHAR2,
    p_attributes  IN ODMR_OBJECT_NAMES,
    p_attrDataTypes  IN ODMR_OBJECT_NAMES,
    p_inclusive     IN BOOLEAN DEFAULT TRUE);

  PROCEDURE get_profile_sample_table_info (
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
    p_attrDataTypes  IN OUT NOCOPY ODMR_OBJECT_NAMES);

  PROCEDURE get_create_table_node_info (
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

  PROCEDURE get_update_table_node_info (
    p_workflowId          IN NUMBER,
    p_nodeId              IN VARCHAR2,
    p_use_full            OUT VARCHAR2,
    p_drop_existing       OUT VARCHAR2,
    p_target_table_name   OUT VARCHAR2,
    p_target_schema_name  OUT VARCHAR2,
    p_target_attributes  IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_source_attributes  IN OUT NOCOPY ODMR_OBJECT_NAMES);

  PROCEDURE create_table_from_spec(
    p_workflowId     IN NUMBER,
    p_nodeId          IN VARCHAR2,
--    p_cache_table     IN VARCHAR2,
    p_use_full        IN VARCHAR2,
    p_table           IN VARCHAR2,
    p_table_name      IN VARCHAR2,
    p_attributes      IN ODMR_OBJECT_NAMES,
    p_types           IN ODMR_OBJECT_NAMES,
    p_primary_keys    IN ODMR_OBJECT_NAMES,
    p_indices         IN ODMR_OBJECT_NAMES );

  PROCEDURE update_target_table(
    p_workflowId         IN NUMBER,
    p_nodeId             IN VARCHAR2,
    p_drop_existing      IN VARCHAR2,
    p_target_table_name  IN VARCHAR2,
    p_target_schema_name IN VARCHAR2,
    p_target_attributes  IN ODMR_OBJECT_NAMES,
    p_source_attributes  IN ODMR_OBJECT_NAMES);

  FUNCTION validate_target_attrs(
    p_target_table_name  IN VARCHAR2,
    p_target_schema_name IN VARCHAR2,
    p_target_attributes  IN ODMR_OBJECT_NAMES) RETURN VARCHAR2;

  PROCEDURE create_topn_categories_table(
    p_topn_categories_table  IN VARCHAR2 ); -- result bin boundary table

  PROCEDURE create_topn_cat_table_nc(
    p_topn_categories_table  IN VARCHAR2 ); -- result bin boundary table

  PROCEDURE insert_topn_categories(
    p_input_table_name       IN VARCHAR2,-- input data
    p_topn_categories_table  IN VARCHAR2, -- result bin boundary table
    p_out_columns            IN ODMR_OBJECT_NAMES, -- list of output column names
    p_src_columns            IN ODMR_OBJECT_NAMES, -- list of source column names
    p_bin_counts             IN ODMR_OBJECT_IDS,   -- list of bins for each of categorical columns
    p_other_values           IN ODMR_OBJECT_VALUES ); -- list of 'Other' values

  PROCEDURE insert_topn_categories_nc(
    p_input_table_name       IN VARCHAR2,-- input data
    p_topn_categories_table  IN VARCHAR2, -- result bin boundary table
    p_out_columns            IN ODMR_OBJECT_NAMES, -- list of output column names
    p_src_columns            IN ODMR_OBJECT_NAMES, -- list of source column names
    p_bin_counts             IN ODMR_OBJECT_IDS,   -- list of bins for each of categorical columns
    p_other_values           IN ODMR_OBJECT_VALUES ); -- list of 'Other' values

  PROCEDURE create_bin_boundary_table(
    p_bin_boundary_table  IN VARCHAR2 );

  PROCEDURE create_date_bin_boundary_table(
    p_bin_boundary_table  IN VARCHAR2 ); 
    
  PROCEDURE create_tz_bin_boundary_table(
    p_bin_boundary_table  IN VARCHAR2 );

  PROCEDURE insert_eqw_bins(
    p_input_table_name       IN VARCHAR2,-- input data
    p_bin_boundary_table     IN VARCHAR2, -- result bin boundary table
    p_out_columns            IN ODMR_OBJECT_NAMES, -- list of output column names
    p_src_columns            IN ODMR_OBJECT_NAMES, -- list of source column names
    p_src_col_types          IN ODMR_OBJECT_NAMES, -- list of source column types
    p_bin_counts             IN ODMR_OBJECT_IDS,  -- list of bins for each of columns
    p_bin_auto               IN ODMR_OBJECT_IDS, -- auto bin generation
    p_bin_man                IN ODMR_OBJECT_IDS, -- manual bin generation
    p_bin_num_seq            IN ODMR_OBJECT_IDS); -- bin labels - number sequence

  PROCEDURE insert_date_bins(
    p_input_table_name       IN VARCHAR2,-- input data
    p_bin_boundary_table     IN VARCHAR2, -- result bin boundary table
    p_out_columns            IN ODMR_OBJECT_NAMES, -- list of output column names
    p_src_columns            IN ODMR_OBJECT_NAMES, -- list of source column names
    p_bin_counts             IN ODMR_OBJECT_IDS,  -- list of bin counts for each of columns
    p_bin_auto               IN ODMR_OBJECT_IDS, -- auto bin generation
    p_bin_man                IN ODMR_OBJECT_IDS, -- manual bin generation
    p_bin_num_seq            IN ODMR_OBJECT_IDS); -- bin labels - number sequence

  PROCEDURE insert_tz_bins(
    p_input_table_name       IN VARCHAR2,-- input data
    p_bin_boundary_table     IN VARCHAR2, -- result bin boundary table
    p_out_columns            IN ODMR_OBJECT_NAMES, -- list of output column names
    p_src_columns            IN ODMR_OBJECT_NAMES, -- list of source column names
    p_bin_counts             IN ODMR_OBJECT_IDS,  -- list of bin counts for each of columns
    p_bin_auto               IN ODMR_OBJECT_IDS, -- auto bin generation
    p_bin_man                IN ODMR_OBJECT_IDS, -- manual bin generation
    p_bin_num_seq            IN ODMR_OBJECT_IDS); -- bin labels - number sequence

  FUNCTION prepare_binning_sql (
    p_input_table             IN VARCHAR2, -- actual data
    p_all_xformed_attrs       IN ODMR_OBJECT_NAMES, -- list of all transformed columns
    p_topn_bin_boundary_table IN VARCHAR2, -- previously created topN categories
    p_topn_bin_boundary_table_nc IN VARCHAR2, -- previously created topN categories NCHAR, NVARCHAR2 only
    p_eqw_bin_boundary_table  IN VARCHAR2, -- previously created numeric bin boundaries
    p_date_bin_boundary_table IN VARCHAR2, -- previously created DATE bin boundaries
    p_tz_bin_boundary_table   IN VARCHAR2,   -- previously created TIMESTAMP WITH TIME ZONE bin boundaries
    p_stats_table_name        IN VARCHAR2, -- name of the stats table - used only if p_grouping_attr is NULL
    p_other_values            in map_out_to_other, -- list of 'Other' values
    p_sql_definitions         IN OUT SQL_DEFINITION_ARRAY, -- sql definition for each transformed column
    p_workflow_id             in number default null,
    p_chain_step              in varchar2 default null
    ) RETURN VARCHAR2;

  FUNCTION prepare_binning_sql_ex (
    p_workflow_id             IN NUMBER,
    p_chain_step              IN VARCHAR2,
    p_input_table             IN VARCHAR2, -- actual data
    p_all_xformed_attrs       IN ODMR_OBJECT_NAMES, -- list of all transformed columns
    p_topn_bin_boundary_table IN VARCHAR2, -- previously created topN categories
    p_topn_bin_boundary_table_nc IN VARCHAR2, -- previously created topN categories NCHAR, NVARCHAR2 only
    p_eqw_bin_boundary_table  IN VARCHAR2, -- previously created numeric bin boundaries
    p_date_bin_boundary_table IN VARCHAR2, -- previously created DATE bin boundaries
    p_tz_bin_boundary_table   IN VARCHAR2,   -- previously created TIMESTAMP WITH TIME ZONE bin boundaries
    p_stats_table_name        IN VARCHAR2, -- name of the stats table - used only if p_grouping_attr is NULL
    p_other_values            IN MAP_OUT_TO_OTHER, -- list of 'Other' values
    p_sql_definitions         IN OUT SQL_DEFINITION_ARRAY  -- sql definition for each transformed column
    ) RETURN VARCHAR2;

  PROCEDURE add_binned_cols_to_stats_table(
    p_binned_table     IN VARCHAR2,
    p_statistics_table IN VARCHAR2,
    p_workflow_id      in number default null);

  PROCEDURE xform_quantile_binning(
    p_input_table_name       IN VARCHAR2,-- input data
    p_stats_table_name       IN VARCHAR2, -- name of the stats table
    p_out_columns            IN ODMR_OBJECT_NAMES, -- list of output column names
    p_src_columns            IN ODMR_OBJECT_NAMES, -- list of source column names
    p_bin_counts             IN ODMR_OBJECT_IDS,  -- list of bins for each of columns
    p_bin_auto               IN ODMR_OBJECT_IDS, -- auto bin generation
    p_bin_man                IN ODMR_OBJECT_IDS, -- manual bin generation
    p_bin_num_seq            IN ODMR_OBJECT_IDS, -- bin labels - number sequence
    p_sql_definitions        IN OUT SQL_DEFINITION_ARRAY,
    p_workflow_id             in number default null,
    p_chain_step              in varchar2 default null
    );

  PROCEDURE xform_cust_num_binning(
    p_input_table_name       IN VARCHAR2,-- input data
    p_stats_table_name       IN VARCHAR2, -- name of the stats table
    p_out_columns            IN ODMR_OBJECT_NAMES, -- list of output column names
    p_src_columns            IN ODMR_OBJECT_NAMES, -- list of source column names
    p_bin_num_seq            IN ODMR_OBJECT_IDS,
    p_cust_num_bin_names     IN ODMR_OBJECT_VALUES, -- list of bin names
    p_cust_num_low_bnds      IN ODMR_OBJECT_IDS,  -- list of lower bounds
    p_sql_definitions        IN OUT SQL_DEFINITION_ARRAY,
    p_workflow_id            IN NUMBER DEFAULT NULL);

--  PROCEDURE xform_cust_date_times_bin(
--    p_input_table_name       IN VARCHAR2,-- input data
--    p_stats_table_name       IN VARCHAR2, -- name of the stats table
--    p_out_columns            IN ODMR_OBJECT_NAMES, -- list of output column names
--    p_src_columns            IN ODMR_OBJECT_NAMES, -- list of source column names
--    p_bin_date_seq           IN ODMR_OBJECT_IDS,
--    p_cust_date_bin_names    IN ODMR_OBJECT_VALUES, -- list of bin names
--    p_cust_date_low_bnds     IN ODMR_OBJECT_VALUES,  -- list of lower bounds
--    p_timestamp_function     IN VARCHAR2, -- to_timestamp or to_timestamp_tz
--    p_timestamp_format       IN VARCHAR2, -- format to use
--    p_sql_definitions        IN OUT SQL_DEFINITION_ARRAY );

  PROCEDURE xform_cust_date_binning(
    p_input_table_name       IN VARCHAR2,-- input data
    p_stats_table_name       IN VARCHAR2, -- name of the stats table
    p_out_columns            IN ODMR_OBJECT_NAMES, -- list of output column names
    p_src_columns            IN ODMR_OBJECT_NAMES, -- list of source column names
    p_bin_date_seq           IN ODMR_OBJECT_IDS,
    p_cust_date_bin_names    IN ODMR_OBJECT_VALUES, -- list of bin names
    p_cust_date_low_bnds     IN ODMR_OBJECT_VALUES,  -- list of lower bounds
    p_sql_definitions        IN OUT SQL_DEFINITION_ARRAY,
    p_workflow_id            IN NUMBER DEFAULT NULL);

  PROCEDURE xform_cust_ts_tz_binning(
    p_input_table_name       IN VARCHAR2,-- input data
    p_stats_table_name       IN VARCHAR2, -- name of the stats table
    p_out_columns            IN ODMR_OBJECT_NAMES, -- list of output column names
    p_src_columns            IN ODMR_OBJECT_NAMES, -- list of source column names
    p_bin_date_seq           IN ODMR_OBJECT_IDS,
    p_cust_date_bin_names    IN ODMR_OBJECT_VALUES, -- list of bin names
    p_cust_date_low_bnds     IN ODMR_OBJECT_VALUES,  -- list of lower bounds,
    p_sql_definitions        IN OUT SQL_DEFINITION_ARRAY,
    p_workflow_id            IN NUMBER DEFAULT NULL);

  PROCEDURE xform_cust_cat_binning(
    p_input_table_name       IN VARCHAR2,-- input data
    p_stats_table_name       IN VARCHAR2, -- name of the stats table
    p_out_columns            IN ODMR_OBJECT_NAMES, -- list of output column names
    p_src_columns            IN ODMR_OBJECT_NAMES, -- list of source column names
    p_cust_cat_bin_names     IN ODMR_OBJECT_VALUES,  -- list of bin names
    p_is_others              IN ODMR_OBJECT_IDS,     -- list flags where other or not
    p_bin_values             IN ODMR_OBJECT_VALUES,  -- list of bin_values
    p_sql_definitions        IN OUT SQL_DEFINITION_ARRAY,
    p_workflow_id            IN NUMBER DEFAULT NULL);

  PROCEDURE add_histogram_points( p_stats_table_name IN VARCHAR2, 
                                  p_map_bin_to_labels IN BIN_LABEL_ID_MAP,
                                  p_lstmt IN OUT NOCOPY ODMR_INTERNAL_UTIL.LSTMT_REC_TYPE );

  PROCEDURE add_histogram_points( p_stats_table_name IN VARCHAR2, 
                                  p_lstmt IN OUT NOCOPY ODMR_INTERNAL_UTIL.LSTMT_REC_TYPE );

  PROCEDURE xform_missing_values_cat(
    p_input_table_name       IN VARCHAR2,-- input data
    p_stats_table_name       IN VARCHAR2, -- name of the stats table
    p_out_columns            IN ODMR_OBJECT_NAMES, -- list of output column names
    p_src_columns            IN ODMR_OBJECT_NAMES, -- list of source column names
    p_mv_cat_funtion         IN ODMR_OBJECT_VALUES, -- Mode
    p_mv_cat_replace         IN ODMR_OBJECT_VALUES,  -- categorical replacement value
    p_cat_bins               IN NUMBER, -- number of bins to produce histogram
    p_sql_definitions        IN OUT SQL_DEFINITION_ARRAY,
    p_workflow_id            in number default null,   -- Generate For Apply
    p_chain_step             in varchar2 default null -- Generate For Apply
    );

  PROCEDURE xform_missing_values_cat_nc(
    p_input_table_name       IN VARCHAR2,-- input data
    p_stats_table_name       IN VARCHAR2, -- name of the stats table
    p_out_columns            IN ODMR_OBJECT_NAMES, -- list of output column names
    p_src_columns            IN ODMR_OBJECT_NAMES, -- list of source column names
    p_mv_cat_funtion         IN ODMR_OBJECT_VALUES, -- Mode
    p_mv_cat_replace         IN ODMR_OBJECT_VALUES,  -- categorical replacement value
    p_cat_bins               IN NUMBER, -- number of bins to produce histogram
    p_sql_definitions        IN OUT SQL_DEFINITION_ARRAY,
    p_workflow_id            in number default null,   -- Generate For Apply
    p_chain_step             in varchar2 default null -- Generate For Apply
    );
    
  PROCEDURE xform_missing_values_num(
    p_input_table_name       IN VARCHAR2,-- input data
    p_stats_table_name       IN VARCHAR2, -- name of the stats table
    p_out_columns            IN ODMR_OBJECT_NAMES, -- list of output column names
    p_src_columns            IN ODMR_OBJECT_NAMES, -- list of source column names
    p_mv_num_funtion         IN ODMR_OBJECT_VALUES, -- Min, Max etc
    p_mv_num_replace         IN ODMR_OBJECT_IDS,  -- num replacement value
    p_num_bins               IN NUMBER, -- number of bins to produce histogram
    p_sql_definitions        IN OUT SQL_DEFINITION_ARRAY,
    p_workflow_id            in number default null,   -- Generate For Apply
    p_chain_step             in varchar2 default null  -- Generate For Apply
    );

  PROCEDURE xform_missing_values_date(
    p_input_table_name       IN VARCHAR2,-- input data
    p_stats_table_name       IN VARCHAR2, -- name of the stats table
    p_out_columns            IN ODMR_OBJECT_NAMES, -- list of output column names
    p_src_columns            IN ODMR_OBJECT_NAMES, -- list of source column names
    p_mv_num_funtion         IN ODMR_OBJECT_VALUES, -- Min, Max etc
    p_mv_date_replace        IN ODMR_OBJECT_VALUES,  -- date replacement value
    p_date_bins              IN NUMBER, -- number of bins to produce histogram
    p_sql_definitions        IN OUT SQL_DEFINITION_ARRAY,
    p_workflow_id            in number default null,   -- Generate For Apply
    p_chain_step             in varchar2 default null  -- Generate For Apply
    );
    
  PROCEDURE xform_missing_values_tz(
    p_input_table_name       IN VARCHAR2,-- input data
    p_stats_table_name       IN VARCHAR2, -- name of the stats table
    p_out_columns            IN ODMR_OBJECT_NAMES, -- list of output column names
    p_src_columns            IN ODMR_OBJECT_NAMES, -- list of source column names
    p_mv_num_funtion         IN ODMR_OBJECT_VALUES, -- Min, Max etc
    p_mv_date_replace        IN ODMR_OBJECT_VALUES,  -- date replacement value
    p_date_bins              IN NUMBER, -- number of bins to produce histogram
    p_sql_definitions        IN OUT SQL_DEFINITION_ARRAY,
    p_workflow_id            in number default null,   -- Generate For Apply
    p_chain_step             in varchar2 default null  -- Generate For Apply
    );
    
  PROCEDURE xform_outlier(
    p_input_table_name       IN VARCHAR2,-- input data
    p_stats_table_name       IN VARCHAR2, -- name of the stats table
    p_meta_stats_table_name  IN VARCHAR2, -- name of the stats table in the metadata (because of single
    --                                       column refresh this table maybe different from p_stats_table_name)
    p_out_columns            IN ODMR_OBJECT_NAMES, -- list of output column names
    p_src_columns            IN ODMR_OBJECT_NAMES, -- list of source column names
    p_outlier_type           IN ODMR_OBJECT_VALUES, -- StandardDeviation, Value, Percent
    p_replace_with           IN ODMR_OBJECT_VALUES, -- EdgeValues or Nulls
    p_outlier_multiple_value IN ODMR_OBJECT_IDS,  -- outlier multiple
    p_outlier_lower_value    IN ODMR_OBJECT_IDS,  -- outlier lower value 
    p_outlier_upper_value    IN ODMR_OBJECT_IDS,  -- outlier upper value
    p_outlier_lower_percent  IN ODMR_OBJECT_IDS, -- outlier lower percent
    p_outlier_upper_percent  IN ODMR_OBJECT_IDS, -- outlier lower percent
    p_num_bins               IN NUMBER, -- number of bins to produce histogram
    p_sql_definitions        IN OUT SQL_DEFINITION_ARRAY,
    p_workflow_id            in number default null,
    p_chain_step             in varchar2 default null
    );

  PROCEDURE xform_normalization(
    p_input_table_name       IN VARCHAR2,-- input data
    p_stats_table_name       IN VARCHAR2, -- name of the stats table
    p_out_columns            IN ODMR_OBJECT_NAMES, -- list of output column names
    p_src_columns            IN ODMR_OBJECT_NAMES, -- list of source column names
    p_norm_type              IN ODMR_OBJECT_VALUES, -- MinMax, ZScore, LinearScale
    p_norm_custom_shift      IN ODMR_OBJECT_IDS,
    p_norm_custom_scale      IN ODMR_OBJECT_IDS,
    p_num_bins               IN NUMBER, -- number of bins to produce histogram
    p_sql_definitions        IN OUT SQL_DEFINITION_ARRAY, 
    p_workflow_id            in number default null,   -- Generate For Apply
    p_chain_step             in varchar2 default null -- Generate For Apply
    );

  PROCEDURE xform_custom(
    p_input_table_name       IN VARCHAR2,-- input data
    p_stats_table_name       IN VARCHAR2, -- name of the stats table
    p_out_columns            IN ODMR_OBJECT_NAMES, -- list of output column names
    p_out_column_types       IN OUT ODMR_OBJECT_NAMES,
    p_src_columns            IN ODMR_OBJECT_NAMES, -- list of source column names
    p_custom_xforms          IN ODMR_OBJECT_VALUES, -- list of custom transformations
    p_num_bins               IN NUMBER, -- number of bins to produce histogram
    p_cat_bins               IN NUMBER, -- number of bins to produce histogram
    p_date_bins              IN NUMBER, -- number of bins to produce histogram
    p_sql_definitions        IN OUT SQL_DEFINITION_ARRAY,
    p_workflow_id            IN NUMBER DEFAULT NULL);


  FUNCTION ISTIMESTAMP_WITH_TIME_ZONE (p_datatype IN VARCHAR2) RETURN BOOLEAN;

  PROCEDURE INSERT_BIN_TIMESTAMP_EQWIDTH(
    p_input_table_name       IN VARCHAR2,-- input data
    p_bin_boundary_table     IN VARCHAR2, -- result bin boundary table
    p_src_column             IN VARCHAR2, -- column to bin
    p_bin_count              IN NUMBER );  -- bin counts for the column

  PROCEDURE add_src_columns_to_stats_table(
    p_input_table_name       IN VARCHAR2,-- input data
    p_stats_table_name       IN VARCHAR2, -- name of the stats table
    p_src_columns            IN ODMR_OBJECT_NAMES, -- list of source column names
                                      -- for which we need to add stats
    p_src_column_types       IN ODMR_OBJECT_NAMES,                                  
    p_num_bins               IN NUMBER, -- number of bins to produce histogram
    p_cat_bins               IN NUMBER, -- number of bins to produce histogram
    p_date_bins              IN NUMBER); -- number of bins to produce histogram

  PROCEDURE create_profile_stas_table(
    p_workflowId IN NUMBER,
    p_nodeId      IN VARCHAR2,
    p_cache_table IN VARCHAR2,
    p_statistics_table IN VARCHAR2,
    p_use_full    IN VARCHAR2,
    p_attributes  IN ODMR_OBJECT_NAMES,
    p_attrDataTypes  IN ODMR_OBJECT_NAMES,
    p_inclusive     IN BOOLEAN DEFAULT TRUE);

  PROCEDURE get_profile_stats_table (
    p_workflowId  IN NUMBER,
    p_nodeId      IN VARCHAR2,
    p_stats_table OUT VARCHAR2);

  FUNCTION add_quotes_if_none (p_column_name IN VARCHAR2)
    RETURN VARCHAR2;
  
END;
/
 
