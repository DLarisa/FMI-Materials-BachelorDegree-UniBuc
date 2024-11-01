
  CREATE OR REPLACE PACKAGE "ODMRSYS"."ODMR_ENGINE_TRANSFORMS_SEC" 
AS
/*
  PROCEDURE delete_sql_expression(
    p_workflowId IN NUMBER,
    p_nodeId IN VARCHAR2);
*/
  PROCEDURE get_column_filter_settings(
    p_workflowId IN NUMBER,
    p_nodeId IN VARCHAR2,
    p_nullsPercent OUT NUMBER,
    p_uniquePercent OUT NUMBER,
    p_constantPercent OUT NUMBER,
    p_cutOff OUT NUMBER,
    p_topN OUT NUMBER,
    p_numberOfRows OUT NUMBER,
    p_targetAttr OUT VARCHAR2,
    p_generate_ai OUT NUMBER,
    p_dataQualityOutput OUT VARCHAR2,
    p_attrImportanceOutput OUT VARCHAR2);

  PROCEDURE get_column_filter_attributes(p_workflowId IN NUMBER,
                                         p_nodeId IN VARCHAR2,
                                         p_automaticFilterEnable OUT VARCHAR2,
                                         p_attributes IN OUT NOCOPY ODMR_OBJECT_NAMES,
                                         p_automaticFilterings IN OUT NOCOPY ODMR_OBJECT_NAMES,
                                         p_outputs IN OUT NOCOPY ODMR_OBJECT_NAMES);

  PROCEDURE update_column_filter_results(
    p_workflowId IN NUMBER,
    p_nodeId IN VARCHAR2,
    p_dataQualityOutput IN VARCHAR2,
    p_generate_ai IN NUMBER,
    p_attrImportanceOutput IN VARCHAR2,
    p_results IN OUT NOCOPY ODMR_ENGINE_TRANSFORMS.FRLOOKUPTYPE);

  PROCEDURE get_sample_settings(
    p_workflowId IN NUMBER,
    p_nodeId IN VARCHAR2,
    p_statisticTable OUT VARCHAR2,
    p_numberOfRows OUT NUMBER,
    p_percentOfTotal OUT NUMBER,
    p_randomSeed OUT NUMBER,
    p_targetAttr OUT VARCHAR2,
    p_targetDataType OUT VARCHAR2,
    p_stratifiedType OUT VARCHAR2,
    p_stratifiedSeed OUT NUMBER,
    p_caseId OUT VARCHAR2,
    p_caseIdDataType OUT VARCHAR2,
    p_targetValues IN OUT NOCOPY ODMR_OBJECT_VALUES,
    p_valueCounts IN OUT NOCOPY ODMR_OBJECT_IDS);

  PROCEDURE update_sample_data(p_workflowId   IN NUMBER,
                               p_nodeId       IN VARCHAR2,
                               p_column       IN VARCHAR2,
                               p_stats_table  IN VARCHAR2,
                               p_sql_lstmt    IN OUT NOCOPY ODMR_INTERNAL_UTIL.LSTMT_REC_TYPE);

  PROCEDURE delete(
    p_workflowId IN NUMBER,
    p_nodeId      IN VARCHAR2,
    p_db_objects  IN OUT NOCOPY ODMR_INTERNAL_UTIL.DB_OBJECTS);

  PROCEDURE get_xform_sample_table_info(
    p_workflowId  IN NUMBER,
    p_nodeId      IN VARCHAR2,
    p_use_full    OUT VARCHAR2,
    p_num_bins    OUT INTEGER,
    p_cat_bins    OUT INTEGER,
    p_date_bins   OUT INTEGER,
    p_attributes  IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_attr_types  IN OUT NOCOPY ODMR_OBJECT_NAMES);

--  PROCEDURE get_xform_output_attrs(
--    p_workflowId      IN NUMBER,
--    p_nodeId          IN VARCHAR2,
--    p_out_names       IN OUT NOCOPY ODMR_OBJECT_NAMES,
--    p_source_columns  IN OUT NOCOPY ODMR_OBJECT_NAMES,
--    p_attr_types      IN OUT NOCOPY ODMR_OBJECT_NAMES,
--    p_topn_bin_count  IN OUT NOCOPY ODMR_OBJECT_IDS,
--    p_topn_other      IN OUT NOCOPY ODMR_OBJECT_NAMES,
--    p_eqw_bin_count   IN OUT NOCOPY ODMR_OBJECT_IDS,
--    p_eqw_bin_auto    IN OUT NOCOPY ODMR_OBJECT_NAMES,
--    p_eqw_bin_man     IN OUT NOCOPY ODMR_OBJECT_NAMES,
--    p_eqw_bin_range   IN OUT NOCOPY ODMR_OBJECT_NAMES,
--    p_eqw_bin_num_seq IN OUT NOCOPY ODMR_OBJECT_NAMES,
--    p_qtile_bin_count   IN OUT NOCOPY ODMR_OBJECT_IDS,
--    p_qtile_bin_auto    IN OUT NOCOPY ODMR_OBJECT_NAMES,
--    p_qtile_bin_man     IN OUT NOCOPY ODMR_OBJECT_NAMES,
--    p_qtile_bin_range   IN OUT NOCOPY ODMR_OBJECT_NAMES,
--    p_qtile_bin_num_seq IN OUT NOCOPY ODMR_OBJECT_NAMES
--    );

  PROCEDURE get_topn_xform_columns(
    p_workflowId      IN NUMBER,
    p_nodeId          IN VARCHAR2,
    p_out_names       IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_source_columns  IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_attr_types      IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_topn_bin_count  IN OUT NOCOPY ODMR_OBJECT_IDS,
    p_topn_other      IN OUT NOCOPY ODMR_OBJECT_VALUES
    );

  PROCEDURE get_eqw_xform_columns(
    p_workflowId      IN NUMBER,
    p_nodeId          IN VARCHAR2,
    p_out_names       IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_source_columns  IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_attr_types      IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_eqw_bin_count   IN OUT NOCOPY ODMR_OBJECT_IDS,
    p_eqw_bin_auto    IN OUT NOCOPY ODMR_OBJECT_IDS,
    p_eqw_bin_man     IN OUT NOCOPY ODMR_OBJECT_IDS,
    p_eqw_bin_num_seq IN OUT NOCOPY ODMR_OBJECT_IDS
    );

  PROCEDURE get_ts_tz_xform_columns(
    p_workflowId      IN NUMBER, 
    p_nodeId          IN VARCHAR2, 
    p_out_names       IN OUT NOCOPY ODMR_OBJECT_NAMES, 
    p_source_columns  IN OUT NOCOPY ODMR_OBJECT_NAMES, 
    p_attr_types      IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_eqw_bin_count   IN OUT NOCOPY ODMR_OBJECT_IDS, 
    p_eqw_bin_auto    IN OUT NOCOPY ODMR_OBJECT_IDS,
    p_eqw_bin_man     IN OUT NOCOPY ODMR_OBJECT_IDS,
    p_eqw_bin_num_seq in out nocopy odmr_object_ids 
    );

  PROCEDURE set_cust_ts_tz_xform_cols(
    p_workflowId          IN NUMBER, 
    p_nodeId              IN VARCHAR2, 
    p_out_name            IN VARCHAR2, 
    p_cust_num_bin_names  in odmr_object_values, 
    p_cust_num_low_bnds   IN ODMR_OBJECT_VALUES
    );

  PROCEDURE set_cust_date_xform_cols(
    p_workflowId          IN NUMBER, 
    p_nodeId              IN VARCHAR2, 
    p_out_name            IN VARCHAR2, 
    p_cust_num_bin_names  in odmr_object_values, 
    p_cust_num_low_bnds   IN ODMR_OBJECT_VALUES 
    );

  PROCEDURE get_date_xform_columns(
    p_workflowId      IN NUMBER, 
    p_nodeId          IN VARCHAR2, 
    p_out_names       IN OUT NOCOPY ODMR_OBJECT_NAMES, 
    p_source_columns  IN OUT NOCOPY ODMR_OBJECT_NAMES, 
    p_attr_types      IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_eqw_bin_count   IN OUT NOCOPY ODMR_OBJECT_IDS, 
    p_eqw_bin_auto    IN OUT NOCOPY ODMR_OBJECT_IDS,
    p_eqw_bin_man     IN OUT NOCOPY ODMR_OBJECT_IDS,
    p_eqw_bin_num_seq IN OUT NOCOPY ODMR_OBJECT_IDS 
    );

  PROCEDURE get_qtile_xform_columns(
    p_workflowId        IN NUMBER,
    p_nodeId            IN VARCHAR2,
    p_out_names         IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_source_columns    IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_attr_types        IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_qtile_bin_count   IN OUT NOCOPY ODMR_OBJECT_IDS,
    p_qtile_bin_auto    IN OUT NOCOPY ODMR_OBJECT_IDS,
    p_qtile_bin_man     IN OUT NOCOPY ODMR_OBJECT_IDS,
    p_qtile_bin_num_seq IN OUT NOCOPY ODMR_OBJECT_IDS
    );

  FUNCTION update_xform_statistics_data(
    p_workflowId  IN NUMBER,
    p_nodeId      IN VARCHAR2,
    p_stats_table IN VARCHAR2) RETURN VARCHAR2;

  PROCEDURE get_cust_num_xform_cols(
    p_workflowId          IN NUMBER,
    p_nodeId              IN VARCHAR2,
    p_out_names           IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_source_columns      IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_attr_types          IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_cust_num_bin_num_seq IN OUT NOCOPY ODMR_OBJECT_IDS,
    p_cust_num_bin_names  IN OUT NOCOPY ODMR_OBJECT_VALUES,
    p_cust_num_low_bnds   IN OUT NOCOPY ODMR_OBJECT_IDS );

  PROCEDURE set_cust_num_xform_cols(
    p_workflowId          IN NUMBER, 
    p_nodeId              IN VARCHAR2, 
    p_out_name            IN VARCHAR2, 
    p_cust_num_bin_names  IN ODMR_OBJECT_VALUES, 
    p_cust_num_low_bnds   IN ODMR_OBJECT_IDS,
    p_binning_type        IN VARCHAR2);

  PROCEDURE get_cust_date_xform_cols(
    p_workflowId          IN NUMBER, 
    p_nodeId              IN VARCHAR2, 
    p_out_names           IN OUT NOCOPY ODMR_OBJECT_NAMES, 
    p_source_columns      IN OUT NOCOPY ODMR_OBJECT_NAMES, 
    p_attr_types          IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_cust_date_num_seq   IN OUT NOCOPY ODMR_OBJECT_IDS,
    p_cust_date_bin_names IN OUT NOCOPY ODMR_OBJECT_VALUES, 
    p_cust_date_low_bnds  IN OUT NOCOPY ODMR_OBJECT_VALUES );

  PROCEDURE get_cust_ts_tz_xform_cols(
    p_workflowId          IN NUMBER, 
    p_nodeId              IN VARCHAR2, 
    p_out_names           IN OUT NOCOPY ODMR_OBJECT_NAMES, 
    p_source_columns      IN OUT NOCOPY ODMR_OBJECT_NAMES, 
    p_attr_types          IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_cust_date_num_seq   IN OUT NOCOPY ODMR_OBJECT_IDS,
    p_cust_date_bin_names IN OUT NOCOPY ODMR_OBJECT_VALUES, 
    p_cust_date_low_bnds  IN OUT NOCOPY ODMR_OBJECT_VALUES );

  PROCEDURE set_cust_cat_xform_cols(
    p_workflowId          IN NUMBER, 
    p_nodeId              IN VARCHAR2, 
    p_out_name            IN VARCHAR2, 
    p_cust_cat_bin_names  IN ODMR_OBJECT_VALUES, 
    p_cust_cat_bin_values IN ODMR_OBJECT_VALUES,
    p_is_other            IN ODMR_OBJECT_IDS
    );

  PROCEDURE get_cust_cat_xform_cols(
    p_workflowId          IN NUMBER,
    p_nodeId              IN VARCHAR2,
    p_out_names           IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_source_columns      IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_attr_types          IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_bin_names           IN OUT NOCOPY ODMR_OBJECT_VALUES,
    p_is_others           IN OUT NOCOPY ODMR_OBJECT_IDS,
    p_bin_values          IN OUT NOCOPY ODMR_OBJECT_VALUES 
    );

  PROCEDURE clear_modified_flag (
    p_workflowId IN NUMBER,
    p_nodeId     IN VARCHAR2,
    p_attributes IN ODMR_OBJECT_NAMES);

  PROCEDURE clear_column_modified_flag (p_workflowId IN NUMBER, 
                                 p_nodeId     IN VARCHAR2,
                                 p_attribute  IN VARCHAR2);

  PROCEDURE get_output_columns_src(
    p_workflowId  IN NUMBER, 
    p_nodeId      IN VARCHAR2, 
    p_attributes  IN OUT NOCOPY ODMR_OBJECT_NAMES);

  PROCEDURE get_output_columns_xformed(
    p_workflowId  IN NUMBER, 
    p_nodeId      IN VARCHAR2, 
    p_attributes  IN OUT NOCOPY ODMR_OBJECT_NAMES);

  PROCEDURE set_mv_cat_columns(
    p_workflowId          IN NUMBER, 
    p_nodeId              IN VARCHAR2, 
    p_out_name            IN VARCHAR2, 
    p_value               IN VARCHAR2,
    p_function            IN VARCHAR2);

  PROCEDURE get_mv_cat_columns(
    p_workflowId        IN NUMBER, 
    p_nodeId            IN VARCHAR2, 
    p_out_names         IN OUT NOCOPY ODMR_OBJECT_NAMES, 
    p_source_columns    IN OUT NOCOPY ODMR_OBJECT_NAMES, 
    p_attr_types        IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_mv_cat_function   IN OUT NOCOPY ODMR_OBJECT_VALUES, -- Statistics or Value
    p_mv_cat_replace    IN OUT NOCOPY ODMR_OBJECT_VALUES); -- Mode or some value

  PROCEDURE get_mv_num_columns(
    p_workflowId        IN NUMBER, 
    p_nodeId            IN VARCHAR2, 
    p_out_names         IN OUT NOCOPY ODMR_OBJECT_NAMES, 
    p_source_columns    IN OUT NOCOPY ODMR_OBJECT_NAMES, 
    p_attr_types        IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_mv_num_function   IN OUT NOCOPY ODMR_OBJECT_VALUES, -- Statistics or Value
    p_mv_num_replace    IN OUT NOCOPY ODMR_OBJECT_IDS); -- Min, Max, etc,  or some value

  PROCEDURE set_mv_num_columns(
    p_workflowId          IN NUMBER, 
    p_nodeId              IN VARCHAR2, 
    p_out_name            IN VARCHAR2, 
    p_value               IN NUMBER,
    p_function            IN VARCHAR2);

  PROCEDURE set_mv_date_columns(
    p_workflowId          IN NUMBER, 
    p_nodeId              IN VARCHAR2, 
    p_out_name            IN VARCHAR2, 
    p_value               IN VARCHAR2,
    p_function            IN VARCHAR2);

  PROCEDURE get_mv_date_columns(
    p_workflowId        IN NUMBER, 
    p_nodeId            IN VARCHAR2, 
    p_out_names         IN OUT NOCOPY ODMR_OBJECT_NAMES, 
    p_source_columns    IN OUT NOCOPY ODMR_OBJECT_NAMES, 
    p_attr_types        in out nocopy odmr_object_names,
    p_mv_date_function   IN OUT NOCOPY ODMR_OBJECT_VALUES, -- Statistics or Value
    p_mv_date_replace   in out nocopy odmr_object_values,
    p_mv_date_replace_tz in out nocopy odmr_object_values
    );

  PROCEDURE set_outlier_columns(
    p_workflowId          IN NUMBER, 
    p_nodeId              IN VARCHAR2, 
    p_out_name            IN VARCHAR2, 
    p_out_type            IN VARCHAR2,     -- StDev or Percent
    p_sigma               IN NUMBER,
    p_lower_percent       IN NUMBER,
    p_upper_percent       IN NUMBER,
    p_lower               IN NUMBER,
    p_upper               IN NUMBER,
    p_replace_with        IN VARCHAR2    --Edges or Nulls
  );

  PROCEDURE get_outlier_columns(
    p_workflowId              IN NUMBER, 
    p_nodeId                  IN VARCHAR2, 
    p_out_names               IN OUT NOCOPY ODMR_OBJECT_NAMES, 
    p_source_columns          IN OUT NOCOPY ODMR_OBJECT_NAMES, 
    p_attr_types              IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_outlier_type            IN OUT NOCOPY ODMR_OBJECT_VALUES, -- StandardDeviation, Value, Percent
    p_replace_with            IN OUT NOCOPY ODMR_OBJECT_VALUES,
    p_outlier_multiple_value  IN OUT NOCOPY ODMR_OBJECT_IDS,
    p_outlier_lower_value     IN OUT NOCOPY ODMR_OBJECT_IDS,
    p_outlier_upper_value     IN OUT NOCOPY ODMR_OBJECT_IDS,
    p_outlier_lower_percent   IN OUT NOCOPY ODMR_OBJECT_IDS,
    p_outlier_upper_percent   IN OUT NOCOPY ODMR_OBJECT_IDS );

  PROCEDURE set_norm_columns(
    p_workflowId          IN NUMBER, 
    p_nodeId              IN VARCHAR2, 
    p_out_name            IN VARCHAR2, 
    p_norm_type           IN VARCHAR2,     -- MinMax, ZScore, LinearScale
    p_shift               IN NUMBER,
    p_scale               IN NUMBER);

  PROCEDURE get_norm_columns(
    p_workflowId              IN NUMBER, 
    p_nodeId                  IN VARCHAR2, 
    p_out_names               IN OUT NOCOPY ODMR_OBJECT_NAMES, 
    p_source_columns          IN OUT NOCOPY ODMR_OBJECT_NAMES, 
    p_attr_types              IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_norm_type               IN OUT NOCOPY ODMR_OBJECT_VALUES, -- MinMax, ZScore, LinearScale
    p_norm_custom_shift       IN OUT NOCOPY ODMR_OBJECT_IDS,
    p_norm_custom_scale       IN OUT NOCOPY ODMR_OBJECT_IDS );

  FUNCTION get_xform_statistics_data(
    p_workflowId  IN NUMBER, 
    p_nodeId      IN VARCHAR2)
    RETURN VARCHAR2;

  PROCEDURE get_custom_xform_cols(
    p_workflowId          IN NUMBER, 
    p_nodeId              IN VARCHAR2, 
    p_out_names           IN OUT NOCOPY ODMR_OBJECT_NAMES, 
    p_source_columns      IN OUT NOCOPY ODMR_OBJECT_NAMES, 
    p_attr_types          IN OUT NOCOPY ODMR_OBJECT_NAMES,
    p_cust_transforms     IN OUT NOCOPY ODMR_OBJECT_VALUES);

END ODMR_ENGINE_TRANSFORMS_SEC;
/
