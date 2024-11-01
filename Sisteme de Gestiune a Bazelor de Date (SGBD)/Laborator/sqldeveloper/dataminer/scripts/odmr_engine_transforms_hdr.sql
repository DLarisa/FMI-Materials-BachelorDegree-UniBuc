
  CREATE OR REPLACE PACKAGE "ODMRSYS"."ODMR_ENGINE_TRANSFORMS" 
AUTHID CURRENT_USER AS

  GENERATE_SQL_INLINE_HINT  CONSTANT BOOLEAN := TRUE;

  TYPE FILTER_STAT_OBJECT IS RECORD (
    attr_name               VARCHAR2(30),
    attr_type               VARCHAR2(30),
    null_percent            NUMBER,
    constant_percent        NUMBER,
    distinct_percent        NUMBER,
    importance              NUMBER,
    rank                    NUMBER
    );
  TYPE FTLOOKUPTYPE IS TABLE OF FILTER_STAT_OBJECT INDEX BY VARCHAR2(30);

  TYPE FILTER_RESULT_OBJECT IS RECORD (
    attr_name               VARCHAR2(30),
    include                 BOOLEAN, -- output this attribute?
    null_percent_valid      BOOLEAN, -- filter test is passed?
    constant_percent_valid  BOOLEAN,
    distinct_percent_valid  BOOLEAN,
    importance_valid        BOOLEAN,
    rank_valid              BOOLEAN
    );
  TYPE FRLOOKUPTYPE IS TABLE OF FILTER_RESULT_OBJECT INDEX BY VARCHAR2(30);

  TYPE NAME_TYPE_ENTRY IS RECORD (
    name         VARCHAR2(30),
    type         VARCHAR2(100));

  TYPE NAME_TYPE_ARRAY IS TABLE OF NAME_TYPE_ENTRY INDEX BY VARCHAR2(30);

--  PROCEDURE TRANSFORM_PROG(p_job_name IN VARCHAR2, p_chain_step IN VARCHAR2);
--  PROCEDURE AGGREGATION_PROG(p_job_name IN VARCHAR2, p_chain_step IN VARCHAR2);
  PROCEDURE JOIN_PROG(p_job_name IN VARCHAR2, p_chain_step IN VARCHAR2);
  PROCEDURE TEXT_PROG(p_job_name IN VARCHAR2, p_chain_step IN VARCHAR2);
  PROCEDURE SPLIT_PROG(p_job_name IN VARCHAR2, p_chain_step IN VARCHAR2);
  PROCEDURE SAMPLE_PROG(p_job_name IN VARCHAR2, p_chain_step IN VARCHAR2);
  PROCEDURE COLUMNFILTER_PROG(p_job_name IN VARCHAR2, p_chain_step IN VARCHAR2);
  PROCEDURE ROWFILTER_PROG(p_job_name IN VARCHAR2, p_chain_step IN VARCHAR2);
  PROCEDURE TRANSFORMATIONS_PROG(p_job_name IN VARCHAR2, p_chain_step IN VARCHAR2);

  FUNCTION prepare_eqw_xform(
    p_workflow_id         IN NUMBER,
    p_chain_step          IN VARCHAR2,
    p_input_sample_table  IN VARCHAR2,
    p_all_xformed_attrs   IN OUT NAME_TYPE_ARRAY,
    p_unique_xformed_names IN OUT ODMR_OBJECT_NAMES) RETURN VARCHAR2;

  FUNCTION prepare_date_xform(
    p_workflow_id         IN NUMBER,
    p_chain_step          IN VARCHAR2,
    p_input_sample_table  IN VARCHAR2,
    p_src_attributes      IN ODMR_OBJECT_NAMES,
    p_src_attr_data_types IN ODMR_OBJECT_NAMES,
    p_all_xformed_attrs   IN OUT NAME_TYPE_ARRAY,
    p_unique_xformed_names IN OUT ODMR_OBJECT_NAMES ) RETURN VARCHAR2;

  FUNCTION prepare_tz_xform(
    p_workflow_id         IN NUMBER,
    p_chain_step          IN VARCHAR2,
    p_input_sample_table  IN VARCHAR2,
    p_src_attributes      IN ODMR_OBJECT_NAMES,
    p_src_attr_data_types IN ODMR_OBJECT_NAMES,
    p_all_xformed_attrs   IN OUT NAME_TYPE_ARRAY,
    p_unique_xformed_names IN OUT ODMR_OBJECT_NAMES ) RETURN VARCHAR2;

  PROCEDURE xform_quantile_binning(
    p_workflow_id         IN NUMBER,
    p_chain_step          IN VARCHAR2,
    p_input_sample_table  IN VARCHAR2,
    p_stats_table         IN VARCHAR2,
    p_all_xformed_attrs   IN OUT NAME_TYPE_ARRAY,
    p_unique_xformed_names IN OUT ODMR_OBJECT_NAMES,-- combined list of all transformed column types
    p_prepare_binning_sql IN OUT ODMR_ENGINE.SQL_DEFINITION_ARRAY );

  PROCEDURE xform_cust_num_binning(
    p_workflow_id         IN NUMBER,
    p_chain_step          IN VARCHAR2,
    p_input_sample_table  IN VARCHAR2,
    p_stats_table         IN VARCHAR2,
    p_all_xformed_attrs   IN OUT NAME_TYPE_ARRAY,
    p_unique_xformed_names IN OUT ODMR_OBJECT_NAMES,  -- combined list of all transformed column types
    p_prepare_binning_sql IN OUT ODMR_ENGINE.SQL_DEFINITION_ARRAY );

  PROCEDURE xform_cust_date_binning(
    p_workflow_id         IN NUMBER,
    p_chain_step          IN VARCHAR2,
    p_input_sample_table  IN VARCHAR2,
    p_stats_table         IN VARCHAR2,
    p_all_xformed_attrs   IN OUT NAME_TYPE_ARRAY,
    p_unique_xformed_names IN OUT ODMR_OBJECT_NAMES,  -- combined list of all transformed column types
    p_prepare_binning_sql IN OUT ODMR_ENGINE.SQL_DEFINITION_ARRAY );

  PROCEDURE xform_cust_ts_tz_binning(
    p_workflow_id         IN NUMBER,
    p_chain_step          IN VARCHAR2,
    p_input_sample_table  IN VARCHAR2,
    p_stats_table         IN VARCHAR2,
    p_all_xformed_attrs   IN OUT NAME_TYPE_ARRAY,
    p_unique_xformed_names IN OUT ODMR_OBJECT_NAMES,  -- combined list of all transformed column types
    p_prepare_binning_sql IN OUT ODMR_ENGINE.SQL_DEFINITION_ARRAY );

  PROCEDURE xform_cust_cat_binning(
    p_workflow_id         IN NUMBER,
    p_chain_step          IN VARCHAR2,
    p_input_sample_table  IN VARCHAR2,
    p_stats_table         IN VARCHAR2,
    p_all_xformed_attrs   IN OUT NAME_TYPE_ARRAY,
    p_unique_xformed_names IN OUT ODMR_OBJECT_NAMES,  -- combined list of all transformed column types
    p_prepare_binning_sql IN OUT ODMR_ENGINE.SQL_DEFINITION_ARRAY );

  PROCEDURE xform_missing_values_cat(
    p_workflow_id         IN NUMBER,
    p_chain_step          IN VARCHAR2,
    p_input_sample_table  IN VARCHAR2,
    p_stats_table         IN VARCHAR2,
    p_all_xformed_attrs   IN OUT NAME_TYPE_ARRAY, -- combined list of all transformed column types
    p_cat_bins            IN NUMBER, -- number of bins to produce histogram
    p_unique_xformed_names IN OUT ODMR_OBJECT_NAMES,
    p_prepare_binning_sql IN OUT ODMR_ENGINE.SQL_DEFINITION_ARRAY ); -- resulting SQL expressions

  PROCEDURE xform_missing_values_num(
    p_workflow_id         IN NUMBER,
    p_chain_step          IN VARCHAR2,
    p_input_sample_table  IN VARCHAR2,
    p_stats_table         IN VARCHAR2,
    p_all_xformed_attrs   IN OUT NAME_TYPE_ARRAY, -- combined list of all transformed column types
    p_num_bins            INTEGER,
    p_unique_xformed_names IN OUT ODMR_OBJECT_NAMES,
    p_prepare_binning_sql IN OUT ODMR_ENGINE.SQL_DEFINITION_ARRAY);-- resulting SQL expressions

  PROCEDURE xform_missing_values_date(
    p_workflow_id         IN NUMBER,
    p_chain_step          IN VARCHAR2,
    p_input_sample_table  IN VARCHAR2,
    p_stats_table         IN VARCHAR2,
    p_all_xformed_attrs   IN OUT NAME_TYPE_ARRAY, -- combined list of all transformed column types
    p_date_bins           INTEGER,
    p_unique_xformed_names IN OUT ODMR_OBJECT_NAMES,
    p_prepare_binning_sql IN OUT ODMR_ENGINE.SQL_DEFINITION_ARRAY ); -- resulting SQL expressions

  PROCEDURE xform_outlier(
    p_workflow_id         IN NUMBER,
    p_chain_step          IN VARCHAR2,
    p_input_sample_table  IN VARCHAR2,
    p_stats_table         IN VARCHAR2,
    p_all_xformed_attrs   IN OUT NAME_TYPE_ARRAY, -- combined list of all transformed column types
    p_num_bins            INTEGER,
    p_unique_xformed_names IN OUT ODMR_OBJECT_NAMES,
    p_prepare_binning_sql IN OUT ODMR_ENGINE.SQL_DEFINITION_ARRAY ); -- resulting SQL expressions

  PROCEDURE xform_normalization(
    p_workflow_id         IN NUMBER,
    p_chain_step          IN VARCHAR2,
    p_input_sample_table  IN VARCHAR2,
    p_stats_table         IN VARCHAR2,
    p_all_xformed_attrs   IN OUT NAME_TYPE_ARRAY, -- combined list of all transformed column types
    p_num_bins            IN INTEGER,
    p_unique_xformed_names IN OUT ODMR_OBJECT_NAMES,
    p_prepare_binning_sql IN OUT ODMR_ENGINE.SQL_DEFINITION_ARRAY ); -- resulting SQL expressions

  PROCEDURE xform_custom(
    p_workflow_id          IN NUMBER,
    p_chain_step           IN VARCHAR2,
    p_input_sample_table   IN VARCHAR2,
    p_stats_table          IN VARCHAR2,
    p_all_xformed_attrs    IN OUT NAME_TYPE_ARRAY, -- combined list of all transformed column types
    p_num_bins             IN INTEGER,
    p_cat_bins             IN INTEGER,
    p_date_bins            IN INTEGER,
    p_unique_xformed_names IN OUT ODMR_OBJECT_NAMES,
    p_prepare_binning_sql  IN OUT ODMR_ENGINE.SQL_DEFINITION_ARRAY ); -- resulting SQL expressions

  PROCEDURE CLIENT_TOPN(
    p_input_sample_table  VARCHAR2, -- name of the input sample table
    p_stats_table         VARCHAR2, -- name of the statistics table
    p_out_atrs            ODMR_OBJECT_NAMES, -- list of output names for transformed columns
    p_src_atrs            ODMR_OBJECT_NAMES, -- list of source columns for transformed columns
    p_topn_bin_counts     ODMR_OBJECT_IDS,  -- topn bin number
    p_topn_other          ODMR_OBJECT_VALUES  ); -- topn "other" value

  PROCEDURE CLIENT_TOPN_NC(
    p_input_sample_table  VARCHAR2, -- name of the input sample table
    p_stats_table         VARCHAR2, -- name of the statistics table
    p_out_atrs            ODMR_OBJECT_NAMES, -- list of output names for transformed columns
    p_src_atrs            ODMR_OBJECT_NAMES, -- list of source columns for transformed columns
    p_topn_bin_counts     ODMR_OBJECT_IDS,  -- topn bin number
    p_topn_other          ODMR_OBJECT_VALUES  ); -- topn "other" value

  PROCEDURE CLIENT_EQ_WIDTH(
    p_input_sample_table  VARCHAR2, -- name of the input sample table
    p_stats_table         VARCHAR2, -- name of the statistics table
    p_out_atrs            ODMR_OBJECT_NAMES, -- list of output names for transformed columns
    p_src_atrs            ODMR_OBJECT_NAMES, -- list of source columns for transformed columns
    p_src_atrs_types      ODMR_OBJECT_NAMES, -- list of source column types for transformed columns
    p_bin_counts          ODMR_OBJECT_IDS,  -- topn bin number
    p_bin_auto            ODMR_OBJECT_IDS,  -- BinGeneration auto
    p_bin_man             ODMR_OBJECT_IDS,  -- BinGeneration manual
    p_bin_num_seq         ODMR_OBJECT_IDS );  -- BinLabels num seq

  PROCEDURE CLIENT_DATE_EQ_WIDTH(
    p_input_sample_table  VARCHAR2, -- name of the input sample table
    p_stats_table         VARCHAR2, -- name of the statistics table
    p_out_atrs            ODMR_OBJECT_NAMES, -- list of output names for transformed columns
    p_src_atrs            ODMR_OBJECT_NAMES, -- list of source columns for transformed columns
    p_bin_counts          ODMR_OBJECT_IDS,  -- topn bin number
    p_bin_auto            ODMR_OBJECT_IDS,  -- BinGeneration auto
    p_bin_man             ODMR_OBJECT_IDS,  -- BinGeneration manual
    p_bin_num_seq         ODMR_OBJECT_IDS );  -- BinLabels num seq

  PROCEDURE CLIENT_TZ_EQ_WIDTH(
    p_input_sample_table  VARCHAR2, -- name of the input sample table
    p_stats_table         VARCHAR2, -- name of the statistics table
    p_out_atrs            ODMR_OBJECT_NAMES, -- list of output names for transformed columns
    p_src_atrs            ODMR_OBJECT_NAMES, -- list of source columns for transformed columns
    p_bin_counts          ODMR_OBJECT_IDS,  --  bin number
    p_bin_auto            ODMR_OBJECT_IDS,  -- BinGeneration auto
    p_bin_man             ODMR_OBJECT_IDS,  -- BinGeneration manual
    p_bin_num_seq         ODMR_OBJECT_IDS );-- BinLabels num seq

  PROCEDURE CLIENT_QTILE(
    p_input_sample_table  VARCHAR2, -- name of the input sample table
    p_stats_table         VARCHAR2, -- name of the statistics table
    p_out_atrs            ODMR_OBJECT_NAMES, -- list of output names for transformed columns
    p_src_atrs            ODMR_OBJECT_NAMES, -- list of source columns for transformed columns
    p_bin_counts          ODMR_OBJECT_IDS,  -- topn bin number
    p_bin_auto            ODMR_OBJECT_IDS,  -- BinGeneration auto
    p_bin_man             ODMR_OBJECT_IDS,  -- BinGeneration manual
    p_bin_num_seq         ODMR_OBJECT_IDS ); -- BinLabels num seq

  PROCEDURE CLIENT_CUSTOM_DATE(
    p_input_sample_table  VARCHAR2, -- name of the input sample table
    p_stats_table         VARCHAR2, -- name of the statistics table
    p_out_atrs            ODMR_OBJECT_NAMES, -- list of output names for transformed columns
    p_src_atrs            ODMR_OBJECT_NAMES, -- list of source columns for transformed columns
    p_bin_date_seq        ODMR_OBJECT_IDS,  -- BinLabels date seq
    p_cust_date_bin_names ODMR_OBJECT_VALUES,
    p_cust_date_low_bnds  ODMR_OBJECT_VALUES );

  PROCEDURE CLIENT_CUSTOM_TS_TZ(
    p_input_sample_table  VARCHAR2, -- name of the input sample table
    p_stats_table         VARCHAR2, -- name of the statistics table
    p_out_atrs            ODMR_OBJECT_NAMES, -- list of output names for transformed columns
    p_src_atrs            ODMR_OBJECT_NAMES, -- list of source columns for transformed columns
    p_bin_seq             ODMR_OBJECT_IDS,  -- BinLabels date seq
    p_bin_names           ODMR_OBJECT_VALUES,
    p_low_bnds            ODMR_OBJECT_VALUES );

  PROCEDURE CLIENT_CUSTOM_NUMERIC(
    p_input_sample_table  VARCHAR2, -- name of the input sample table
    p_stats_table         VARCHAR2, -- name of the statistics table
    p_out_atrs            ODMR_OBJECT_NAMES, -- list of output names for transformed columns
    p_src_atrs            ODMR_OBJECT_NAMES, -- list of source columns for transformed columns
    p_bin_num_seq         ODMR_OBJECT_IDS,  -- BinLabels num seq
    p_cust_num_bin_names  ODMR_OBJECT_VALUES,
    p_cust_num_low_bnds   ODMR_OBJECT_IDS );

  PROCEDURE CLIENT_CUSTOM_CATEGORIC(
    p_input_sample_table  VARCHAR2, -- name of the input sample table
    p_stats_table         VARCHAR2, -- name of the statistics table
    p_out_atrs            ODMR_OBJECT_NAMES, -- list of output names for transformed columns
    p_src_atrs            ODMR_OBJECT_NAMES, -- list of source columns for transformed columns
    p_cust_cat_bin_names  ODMR_OBJECT_VALUES,
    p_is_others           ODMR_OBJECT_IDS,
    p_bin_values          ODMR_OBJECT_VALUES );

  PROCEDURE CLIENT_MV_NUM(
    p_input_sample_table  VARCHAR2, -- name of the input sample table
    p_stats_table         VARCHAR2, -- name of the statistics table
    p_out_atrs            ODMR_OBJECT_NAMES, -- list of output names for transformed columns
    p_src_atrs            ODMR_OBJECT_NAMES, -- list of source columns for transformed columns
    p_mv_num_function     ODMR_OBJECT_VALUES,  -- functions: Mean, Max, Min
    p_mv_num_replace      ODMR_OBJECT_IDS, -- replacement values
    p_num_bins            INTEGER ); -- number of bins to use for histogram

  PROCEDURE CLIENT_MV_CAT(
    p_input_sample_table  VARCHAR2, -- name of the input sample table
    p_stats_table         VARCHAR2, -- name of the statistics table
    p_out_atrs            ODMR_OBJECT_NAMES, -- list of output names for transformed columns
    p_src_atrs            ODMR_OBJECT_NAMES, -- list of source columns for transformed columns
    p_src_atrs_types_mvc IN ODMR_OBJECT_NAMES, -- list of source types for cust. cat
    p_mv_cat_function     ODMR_OBJECT_VALUES,  -- functions: Mode
    p_mv_cat_replace      ODMR_OBJECT_VALUES, -- replacement values
    p_cat_bins            IN NUMBER); -- number of bins to produce histogram

  PROCEDURE CLIENT_MV_DATE(
    p_input_sample_table  VARCHAR2, -- name of the input sample table
    p_stats_table         VARCHAR2, -- name of the statistics table
    p_out_atrs            ODMR_OBJECT_NAMES, -- list of output names for transformed columns
    p_src_atrs            ODMR_OBJECT_NAMES, -- list of source columns for transformed columns
    p_mv_cat_function     ODMR_OBJECT_VALUES,  -- functions: Mode
    p_mv_cat_replace      ODMR_OBJECT_VALUES, -- replacement values
    p_cat_bins            IN NUMBER );-- number of bins to produce histogram

  PROCEDURE CLIENT_MV_TZ(
    p_input_sample_table  VARCHAR2, -- name of the input sample table
    p_stats_table         VARCHAR2, -- name of the statistics table
    p_out_atrs            ODMR_OBJECT_NAMES, -- list of output names for transformed columns
    p_src_atrs            ODMR_OBJECT_NAMES, -- list of source columns for transformed columns
    p_mv_cat_function     ODMR_OBJECT_VALUES,  -- functions: Mode
    p_mv_cat_replace      ODMR_OBJECT_VALUES, -- replacement values
    p_cat_bins            IN NUMBER); -- number of bins to produce histogram

  PROCEDURE CLIENT_OUTLIER(
    p_input_sample_table      VARCHAR2, -- name of the input sample table
    p_stats_table             VARCHAR2, -- name of the statistics table
    p_meta_stats_table_name   VARCHAR2,
    p_out_atrs                ODMR_OBJECT_NAMES, -- list of output names for transformed columns
    p_src_atrs                ODMR_OBJECT_NAMES, -- list of source columns for transformed columns
    p_outlier_type            ODMR_OBJECT_VALUES, -- StandardDeviation, Value, Percent
    p_replace_with            ODMR_OBJECT_VALUES, -- EdgeValues or Nulls
    p_outlier_multiple_value  ODMR_OBJECT_IDS,  -- outlier multiple
    p_outlier_lower_value     ODMR_OBJECT_IDS,  -- outlier lower value
    p_outlier_upper_value     ODMR_OBJECT_IDS,  -- outlier upper value
    p_outlier_lower_percent   ODMR_OBJECT_IDS,  -- outlier lower percent
    p_outlier_upper_percent   ODMR_OBJECT_IDS,  -- outlier upper percent
    p_num_bins                INTEGER );-- number of bins to use for histogram

  PROCEDURE CLIENT_NORMALIZATION(
    p_input_sample_table      VARCHAR2, -- name of the input sample table
    p_stats_table             VARCHAR2, -- name of the statistics table
    p_out_atrs                ODMR_OBJECT_NAMES, -- list of output names for transformed columns
    p_src_atrs                ODMR_OBJECT_NAMES, -- list of source columns for transformed columns
    p_norm_type               ODMR_OBJECT_VALUES, -- MinMax, ZScore, LinearScale, Custom
    p_norm_custom_shift       ODMR_OBJECT_IDS,  -- custom shift
    p_norm_custom_scale       ODMR_OBJECT_IDS,  -- custom scale
    p_num_bins                INTEGER ); -- number of bins to use for histogram

  PROCEDURE CLIENT_CUSTOM(
    p_input_sample_table      VARCHAR2, -- name of the input sample table
    p_stats_table             VARCHAR2, -- name of the statistics table
    p_out_atrs                ODMR_OBJECT_NAMES, -- list of output names for transformed columns
    p_src_atrs                ODMR_OBJECT_NAMES, -- list of source columns for transformed columns
    p_cust_transforms         ODMR_OBJECT_VALUES,
    p_num_bins                INTEGER, -- number of bins to use for histogram
    p_cat_bins                INTEGER, -- number of bins to produce histogram
    p_date_bins               INTEGER); -- number of bins to produce histogram

END;
/
