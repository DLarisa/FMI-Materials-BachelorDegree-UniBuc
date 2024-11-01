
  CREATE OR REPLACE PACKAGE "ODMRSYS"."ODMR_UTIL" 
AUTHID CURRENT_USER AS
  FUNCTION create_table_external(
    p_result_table_name IN VARCHAR2,
    p_primary_keys      IN ODMR_OBJECT_NAMES,
    p_indices           IN ODMR_OBJECT_NAMES,
    p_attributes        IN ODMR_OBJECT_NAMES,
    p_src_table         IN VARCHAR2) RETURN NUMBER;

  PROCEDURE create_view_from_spec(
    p_workflowId        IN NUMBER,
    p_result_view_name  IN VARCHAR2,
    p_attributes        IN ODMR_OBJECT_NAMES,
    p_src_table         IN VARCHAR2);

  PROCEDURE create_view_from_spec(
    p_workflowId        IN NUMBER,
    p_result_view_name  IN VARCHAR2,
    p_attributes        IN ODMR_OBJECT_NAMES,
    p_sql               IN ODMR_INTERNAL_UTIL.LSTMT_REC_TYPE);

  PROCEDURE DESCRIBE_SQL_EXPRESSION(
     p_input_sql  IN     CLOB,
     p_col_names  IN OUT ODMR_OBJECT_NAMES,
     p_col_types  IN OUT ODMR_OBJECT_NAMES,
     p_data_legth IN OUT ODMR_OBJECT_IDS,
     p_precision  IN OUT ODMR_OBJECT_IDS,
     p_scale      IN OUT ODMR_OBJECT_IDS );

--  FUNCTION GENERATE_DEFAULT_DATE_BINS(
--    p_input_sql              IN CLOB, -- input data
--    p_input_column_name      IN VARCHAR2,  -- input column to get bins
--    p_bin_count              IN NUMBER-- number of bins
--    ) RETURN VARCHAR2;
--
  FUNCTION GENERATE_DEFAULT_TS_TZ_BINS(
    p_input_sql              IN CLOB, -- input data
    p_input_column_name      IN VARCHAR2,  -- input column to bin
    p_bin_count              IN NUMBER-- number of bins
    ) RETURN VARCHAR2;

  PROCEDURE GENERATE_DEFAULT_BINS(
    p_input_sql              IN CLOB, -- input data
    p_col_names              IN OUT ODMR_OBJECT_NAMES, -- resulting bin names
    p_bin_num_values         IN OUT ODMR_OBJECT_IDS, -- resulting bin values
    p_bin_cat_values         IN OUT ODMR_OBJECT_VALUES, -- resulting bin values
    p_bin_categories         IN OUT ODMR_OBJECT_VALUES, -- resulting bin categories
    p_disinct_values         IN OUT ODMR_OBJECT_VALUES, -- all available distinc values
    p_input_column_name      IN VARCHAR2,  -- input column to get bins
    p_input_column_type      IN VARCHAR2,  -- input column data type
    p_binning_type           IN VARCHAR2,  -- EQWIDTH, QTILE, TOPN
    p_auto                   IN INTEGER,   -- 1 - auto, 0 - manual
    p_bin_count              IN NUMBER );    -- number of bins
  
  FUNCTION CLIENT_TRANSFORM(
    p_input_sample_table IN VARCHAR2, -- name of the input sample table
    p_statistics_table   IN VARCHAR2, -- name of the existing stats table
    p_cat_bins           IN INTEGER, -- number of cat bins to use for histogram
    p_num_bins           IN INTEGER, -- number of num bins to use for histogram
    p_date_bins          IN INTEGER, -- number of num bins to use for histogram
    -- missing statistics
    p_src_columns        IN ODMR_OBJECT_NAMES, -- list of src columns for which statsistics is missing
    p_src_col_types      IN ODMR_OBJECT_NAMES, -- list of src columns for which statsistics is missing
    -- topn
    p_out_atrs_topn      IN ODMR_OBJECT_NAMES, -- list of output names for topn
    p_src_atrs_topn      IN ODMR_OBJECT_NAMES, -- list of source columns for topn
    p_topn_bin_counts    IN ODMR_OBJECT_IDS,  -- topn bin number
    p_topn_other         IN ODMR_OBJECT_VALUES,  -- topn "other" value
    -- topn NC
    p_out_atrs_topn_nc   IN ODMR_OBJECT_NAMES, -- list of output names for topn
    p_src_atrs_topn_nc   IN ODMR_OBJECT_NAMES, -- list of source columns for topn
    p_topn_bin_counts_nc IN ODMR_OBJECT_IDS,  -- topn bin number
    p_topn_other_nc      IN ODMR_OBJECT_VALUES,  -- topn "other" value
    -- eqw
    p_out_atrs_eqw       IN ODMR_OBJECT_NAMES, -- list of output names for eq.width
    p_src_atrs_eqw       IN ODMR_OBJECT_NAMES, -- list of source columns for eq.width
    p_src_atrs_eqw_types IN ODMR_OBJECT_NAMES, -- list of source columns types for eq.width
    p_bin_counts_eqw     IN ODMR_OBJECT_IDS,  -- eqw bin number
    p_bin_auto_eqw       IN ODMR_OBJECT_IDS,  -- BinGeneration auto
    p_bin_man_eqw        IN ODMR_OBJECT_IDS,  -- BinGeneration manual
    p_bin_num_seq_eqw    IN ODMR_OBJECT_IDS,  -- BinLabels num seq
    -- date eqw
    p_out_atrs_date_eqw  IN ODMR_OBJECT_NAMES, -- list of output names for eq.width
    p_src_atrs_date_eqw  IN ODMR_OBJECT_NAMES, -- list of source columns for eq.width
    p_bin_counts_date_eqw IN ODMR_OBJECT_IDS,  -- eqw bin number
    p_bin_auto_date_eqw  IN ODMR_OBJECT_IDS,  -- BinGeneration auto
    p_bin_man_date_eqw   IN ODMR_OBJECT_IDS,  -- BinGeneration manual
    p_bin_num_seq_date_eqw IN ODMR_OBJECT_IDS,  -- BinLabels num seq
    -- TIMESTAMP WITH TIME ZONE   eqw
    p_out_atrs_tz_eqw  IN ODMR_OBJECT_NAMES, -- list of output names for eq.width
    p_src_atrs_tz_eqw  IN ODMR_OBJECT_NAMES, -- list of source columns for eq.width
    p_bin_counts_tz_eqw IN ODMR_OBJECT_IDS,  -- eqw bin number
    p_bin_auto_tz_eqw  IN ODMR_OBJECT_IDS,  -- BinGeneration auto
    p_bin_man_tz_eqw   IN ODMR_OBJECT_IDS,  -- BinGeneration manual
    p_bin_num_seq_tz_eqw IN ODMR_OBJECT_IDS,  -- BinLabels num seq
    -- qtile
    p_out_atrs_qtile     IN ODMR_OBJECT_NAMES, -- list of output names for qtile
    p_src_atrs_qtile     IN ODMR_OBJECT_NAMES, -- list of source columns for qtile
    p_bin_counts_qtile   IN ODMR_OBJECT_IDS,  -- qtile bin number
    p_bin_auto_qtile     IN ODMR_OBJECT_IDS,  -- BinGeneration auto
    p_bin_man_qtile      IN ODMR_OBJECT_IDS,  -- BinGeneration manual
    p_bin_num_seq_qtile  IN ODMR_OBJECT_IDS,  -- BinLabels num seq
    -- cust date.
    p_out_atrs_cus_date  IN ODMR_OBJECT_NAMES, -- list of output names for cust. date
    p_src_atrs_cus_date  IN ODMR_OBJECT_NAMES, -- list of source columns for cust. date
    p_bin_date_seq       IN ODMR_OBJECT_IDS,  -- BinLabels date seq
    p_cust_date_bin_names IN ODMR_OBJECT_VALUES, 
    p_cust_date_low_bnds IN ODMR_OBJECT_VALUES,
    -- cust. timestamp with time zone
    p_out_atrs_cus_ts_tz   IN ODMR_OBJECT_NAMES, -- list of output names for cust. timestamp with time zone
    p_src_atrs_cus_ts_tz   IN ODMR_OBJECT_NAMES, -- list of source columns for cust. timestamp with time zone
    p_bin_ts_tz_seq        IN ODMR_OBJECT_IDS,  -- BinLabels date seq
    p_cust_ts_tz_bin_names IN ODMR_OBJECT_VALUES, 
    p_cust_ts_tz_low_bnds  IN ODMR_OBJECT_VALUES,
    -- cust n.
    p_out_atrs_cusn      IN ODMR_OBJECT_NAMES, -- list of output names for cust. num
    p_src_atrs_cusn      IN ODMR_OBJECT_NAMES, -- list of source columns for cust. num
    p_bin_num_seq_cusn   IN ODMR_OBJECT_IDS,  -- BinLabels num seq
    p_num_bin_names_cusn IN ODMR_OBJECT_VALUES, 
    p_num_low_bnds_cusn  IN ODMR_OBJECT_IDS,
    -- cust c.
    p_out_atrs_cusc      IN ODMR_OBJECT_NAMES, -- list of output names for cust. cat
    p_src_atrs_cusc      IN ODMR_OBJECT_NAMES, -- list of source columns for cust. cat
    p_cat_bin_names_cusc IN ODMR_OBJECT_VALUES, 
    p_is_others_cusc     IN ODMR_OBJECT_IDS,
    p_bin_values_cusc    IN ODMR_OBJECT_VALUES,
    -- miss. val. cat
    p_out_atrs_mvc       IN ODMR_OBJECT_NAMES, -- list of output names for cust. cat
    p_src_atrs_mvc       IN ODMR_OBJECT_NAMES, -- list of source columns for cust. cat
    p_src_atrs_types_mvc IN ODMR_OBJECT_NAMES, -- list of source types for cust. cat
    p_mv_cat_function    IN ODMR_OBJECT_VALUES,  -- functions: Mode
    p_mv_cat_replace     IN ODMR_OBJECT_VALUES,  -- replacement values
    -- miss. val. num
    p_out_atrs_mvn       IN ODMR_OBJECT_NAMES, -- list of output names for cust. cat
    p_src_atrs_mvn       IN ODMR_OBJECT_NAMES, -- list of source columns for cust. cat
    p_mv_num_function    IN ODMR_OBJECT_VALUES,  -- functions: Mean, Max, Min
    p_mv_num_replace     IN ODMR_OBJECT_IDS,  -- replacement values
    -- miss. val. timestamp/date
    p_out_atrs_mv_date     IN ODMR_OBJECT_NAMES, -- list of output names for cust. cat
    p_src_atrs_mv_date     IN ODMR_OBJECT_NAMES, -- list of source columns for cust. cat
    p_mv_date_function     IN ODMR_OBJECT_VALUES,  -- functions: Mean, Max, Min
    p_mv_date_replace      IN ODMR_OBJECT_VALUES,  -- replacement values
    -- miss. val. timestamp with timezone
    p_out_atrs_mv_tz       IN ODMR_OBJECT_NAMES, -- list of output names for cust. cat
    p_src_atrs_mv_tz       IN ODMR_OBJECT_NAMES, -- list of source columns for cust. cat
    p_mv_tz_function       IN ODMR_OBJECT_VALUES,  -- functions: Mean, Max, Min
    p_mv_tz_replace        IN ODMR_OBJECT_VALUES,  -- replacement values
    -- outlier
    p_meta_statistics_table   IN VARCHAR2, -- name of the stats table in the metadata
    p_out_atrs_outlier        IN ODMR_OBJECT_NAMES, -- list of output names for cust. cat
    p_src_atrs_outlier        IN ODMR_OBJECT_NAMES, -- list of source columns for cust. cat
    p_outlier_type            IN ODMR_OBJECT_VALUES, -- StandardDeviation, Value, Percent
    p_replace_with            IN ODMR_OBJECT_VALUES, -- EdgeValues or Nulls
    p_outlier_multiple_value  IN ODMR_OBJECT_IDS,  -- outlier multiple
    p_outlier_lower_value     IN ODMR_OBJECT_IDS,  -- outlier lower value
    p_outlier_upper_value     IN ODMR_OBJECT_IDS,  -- outlier upper value
    p_outlier_lower_percent   IN ODMR_OBJECT_IDS,  -- outlier lower percent
    p_outlier_upper_percent   IN ODMR_OBJECT_IDS,  -- outlier upper percent
    -- normalization
    p_out_atrs_norm      IN ODMR_OBJECT_NAMES,  -- list of output names for Normalization
    p_src_atrs_norm      IN ODMR_OBJECT_NAMES,  -- list of source columns for Normalization
    p_norm_type          IN ODMR_OBJECT_VALUES, -- MinMax, ZScore, LinearScale, Custom
    p_norm_custom_shift  IN ODMR_OBJECT_IDS,    -- custom shift
    p_norm_custom_scale  IN ODMR_OBJECT_IDS,    -- custom scale
    -- custom
    p_out_atrs_custom    IN ODMR_OBJECT_NAMES,  -- list of output names for Custom
    p_src_atrs_custom    IN ODMR_OBJECT_NAMES,  -- list of source columns for Custom
    p_cust_transforms    IN ODMR_OBJECT_VALUES -- custom sql expresions
  ) RETURN VARCHAR2;

  PROCEDURE CLIENT_VALIDATE_SQL(
    p_input_sql              IN CLOB,-- input data
    p_out_column_type        IN OUT VARCHAR2 );

  FUNCTION get_varchar2_byte_length( p_string  VARCHAR2 ) RETURN INTEGER;
  FUNCTION get_clob_byte_length( p_clob  CLOB ) RETURN INTEGER;

  FUNCTION create_table_external2(
    p_result_table_name IN VARCHAR2,
    p_primary_keys      IN ODMR_OBJECT_NAMES,
    p_indices           IN ODMR_OBJECT_NAMES,
    p_attributes        IN ODMR_OBJECT_NAMES,
    p_aliases           IN ODMR_OBJECT_NAMES,
    p_src_table         IN VARCHAR2) RETURN NUMBER;

END ODMR_UTIL;
/
