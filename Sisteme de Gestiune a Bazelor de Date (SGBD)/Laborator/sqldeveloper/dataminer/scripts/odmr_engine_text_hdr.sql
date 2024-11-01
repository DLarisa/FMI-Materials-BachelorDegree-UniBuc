
  CREATE OR REPLACE PACKAGE "ODMRSYS"."ODMR_ENGINE_TEXT" 
AUTHID CURRENT_USER AS

  FUNCTION dm_policy_tokens(policy_name VARCHAR2,
                            text VARCHAR2) RETURN ODMR_OBJECT_VALUES PIPELINED;

  FUNCTION dm_policy_themes(policy_name VARCHAR2,
                            text VARCHAR2,
                            full_themes NUMBER) RETURN ODMR_OBJECT_VALUES PIPELINED;

  FUNCTION dm_policy_tokens2(policy_name VARCHAR2,
                             text VARCHAR2,
                             stoplist_name VARCHAR2) RETURN DM_NESTED_NUMERICALS PIPELINED;

  FUNCTION dm_policy_themes2(policy_name VARCHAR2,
                             text VARCHAR2,
                             full_themes NUMBER,
                             stoplist_name VARCHAR2) RETURN DM_NESTED_NUMERICALS PIPELINED;

  FUNCTION dm_text_token_features(policy_name VARCHAR2,
                            text VARCHAR2,
                            model_table_name VARCHAR2,
                            attr_name VARCHAR2,
                            maxNumberPerDoc NUMBER,
                            frequency VARCHAR2) RETURN DM_NESTED_NUMERICALS;

  FUNCTION dm_text_theme_features(policy_name VARCHAR2,
                            text VARCHAR2,
                            model_table_name VARCHAR2,
                            attr_name VARCHAR2,
                            full_themes NUMBER,
                            maxNumberPerDoc NUMBER,
                            frequency VARCHAR2) RETURN DM_NESTED_NUMERICALS;

  FUNCTION dm_policy_tokens(policy_name VARCHAR2,
                            text CLOB) RETURN ODMR_OBJECT_VALUES PIPELINED;

  FUNCTION dm_policy_themes(policy_name VARCHAR2,
                            text CLOB,
                            full_themes NUMBER) RETURN ODMR_OBJECT_VALUES PIPELINED;

  FUNCTION dm_policy_tokens2(policy_name VARCHAR2,
                             text CLOB,
                             stoplist_name VARCHAR2) RETURN DM_NESTED_NUMERICALS PIPELINED;

  FUNCTION dm_policy_themes2(policy_name VARCHAR2,
                             text CLOB,
                             full_themes NUMBER,
                             stoplist_name VARCHAR2) RETURN DM_NESTED_NUMERICALS PIPELINED;

  FUNCTION dm_text_token_features(policy_name VARCHAR2,
                            text CLOB,
                            model_table_name VARCHAR2,
                            attr_name VARCHAR2,
                            maxNumberPerDoc NUMBER,
                            frequency VARCHAR2) RETURN DM_NESTED_NUMERICALS;

  FUNCTION dm_text_theme_features(policy_name VARCHAR2,
                            text CLOB,
                            model_table_name VARCHAR2,
                            attr_name VARCHAR2,
                            full_themes NUMBER,
                            maxNumberPerDoc NUMBER,
                            frequency VARCHAR2) RETURN DM_NESTED_NUMERICALS;

  PROCEDURE BUILDTEXT_PROG(p_job_name IN VARCHAR2, p_chain_step IN VARCHAR2);

  PROCEDURE APPLYTEXT_PROG(p_job_name IN VARCHAR2, p_chain_step IN VARCHAR2);

  PROCEDURE BUILDTEXT_REF_PROG(p_job_name IN VARCHAR2, p_chain_step IN VARCHAR2);

END ODMR_ENGINE_TEXT;
/
