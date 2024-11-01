-- drops all objects created by workflows in all user accounts
-- Parameters:
-- 1. Action Flags:
--    R = report only, do not drop any objects
--    D = drop only, displays drop command only
--    DR or RD = drop and report
-- Example:
-- @dropUserTablesViews.sql DR
set serveroutput on
set verify off

EXECUTE dbms_output.put_line('');
EXECUTE dbms_output.put_line('Drop User objects created by Workflows');
EXECUTE dbms_output.put_line('');

DECLARE
  action varchar2(30) := '&1';
  report BOOLEAN := TRUE;
  droptable BOOLEAN := TRUE; 
  countObjects integer := 0;
  countObjectsDropped integer := 0;
  countObjectsFailedToDrop integer := 0;
  sql_text varchar2(256);
  Dynamic_Cursor integer;
  dummy integer;
  v_err_msg  VARCHAR2(4000);
  TYPE OBJ_ARRAY IS TABLE OF VARCHAR2(30);
  v_users OBJ_ARRAY;
  v_objs OBJ_ARRAY;
  v_isTable OBJ_ARRAY;
BEGIN
  DBMS_OUTPUT.ENABLE(NULL);
  CASE action
    WHEN 'R' THEN report := TRUE;
    WHEN 'DR' THEN report := TRUE;
    WHEN 'RD' THEN report := TRUE;
    ELSE report := FALSE;
  END CASE;

  CASE action
    WHEN 'D' THEN droptable := TRUE;
    WHEN 'DR' THEN droptable := TRUE;
    WHEN 'RD' THEN droptable := TRUE;
    ELSE droptable := FALSE;
  END CASE;

  EXECUTE IMMEDIATE
'SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/ClassificationBuild/Models/NaiveBayesModel''
PASSING x.WORKFLOW_DATA
COLUMNS Name   VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/ClassificationBuild/Models/DecisionTreeModel''
PASSING x.WORKFLOW_DATA
COLUMNS Name   VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/ClassificationBuild/Models/CSupportVectorMachineModel''
PASSING x.WORKFLOW_DATA
COLUMNS Name   VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/ClassificationBuild/Models/CGeneralizedLinearModel''
PASSING x.WORKFLOW_DATA
COLUMNS Name   VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/RegressionBuild/Models/RSupportVectorMachineModel''
PASSING x.WORKFLOW_DATA
COLUMNS Name   VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/RegressionBuild/Models/RGeneralizedLinearModel''
PASSING x.WORKFLOW_DATA
COLUMNS Name   VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/ClusteringBuild/Models/OClusterModel''
PASSING x.WORKFLOW_DATA
COLUMNS Name   VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/ClusteringBuild/Models/KMeansModel''
PASSING x.WORKFLOW_DATA
COLUMNS Name   VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/AssociationBuild/Models/AprioriModel''
PASSING x.WORKFLOW_DATA
COLUMNS Name   VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/FeatureExtractionBuild/Models/NonNegativeMatrixFactorModel''
PASSING x.WORKFLOW_DATA
COLUMNS Name   VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/AnomalyDetectionBuild/Models/AnomalyDetectionModel''
PASSING x.WORKFLOW_DATA
COLUMNS Name   VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID' BULK COLLECT INTO v_users, v_objs;
  FOR i in 1..v_users.COUNT LOOP
    IF (v_objs(i) IS NOT NULL) THEN
      IF report THEN
        DBMS_OUTPUT.PUT_LINE
         ('Owner.Object: ' || '"' || v_users(i) || '"."' ||
          v_objs(i) || '"  Object Type: ' || 'Model' );
      END IF;
      IF droptable  THEN
        BEGIN
          DBMS_DATA_MINING.DROP_MODEL('"'||v_users(i)||'"."'||v_objs(i)||'"'); -- delete existing model
          sql_text := 'drop ' || 'model' || ' '  || '"' || v_users(i) || '"."' ||
              v_objs(i) || '" ';
          DBMS_OUTPUT.PUT_LINE(sql_text);
          countObjectsDropped := countObjectsDropped + 1;      
        EXCEPTION WHEN OTHERS THEN
          v_err_msg := SUBSTR(DBMS_UTILITY.FORMAT_ERROR_STACK(), 1, 4000);
          DBMS_OUTPUT.PUT_LINE ('Drop failed: ' || 'Owner.Object: ' || '"' || v_users(i) || '"."' ||
          v_objs(i) || '"  Object Type: ' || 'Model' || ' Error: ' || v_err_msg );
          countObjectsFailedToDrop := countObjectsFailedToDrop + 1;
        END;
      END IF;
      countObjects := countObjects + 1;
    END IF;
  END LOOP;

  EXECUTE IMMEDIATE
'SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/DataSource/CacheSettings/OutputTable''
PASSING x.WORKFLOW_DATA
COLUMNS Name   VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/CreateTable/CacheSettings/OutputTable''
PASSING x.WORKFLOW_DATA
COLUMNS Name   VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/UpdateTable/CacheSettings/OutputTable''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/DataProfile/CacheSettings/OutputTable''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/Transformation/CacheSettings/OutputTable''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/Aggregation/CacheSettings/OutputTable''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/Join/CacheSettings/OutputTable''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/BuildTextRef/CacheSettings/OutputTable''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/BuildText/CacheSettings/OutputTable''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/ApplyText/CacheSettings/OutputTable''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/Sample/CacheSettings/OutputTable''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID' BULK COLLECT INTO v_users, v_objs;
  FOR i in 1..v_users.COUNT LOOP
    IF (v_objs(i) IS NOT NULL) THEN
      IF report THEN
        DBMS_OUTPUT.PUT_LINE
         ('Owner.Object: ' || '"' || v_users(i) || '"."' ||
          v_objs(i) || '"  Object Type: ' || 'Table' );
      END IF;
      IF droptable  THEN
        BEGIN
          sql_text := 'drop ' || 'table' || ' '  || '"' || v_users(i) || '"."' ||
              v_objs(i) || '" purge';
          DBMS_OUTPUT.PUT_LINE(sql_text);
          Dynamic_Cursor := dbms_sql.open_cursor;
          dbms_sql.parse(Dynamic_Cursor, sql_text, dbms_sql.native);
          dummy := dbms_sql.execute(Dynamic_Cursor);
          dbms_sql.close_cursor(Dynamic_Cursor);
          countObjectsDropped := countObjectsDropped + 1;      
        EXCEPTION WHEN OTHERS THEN
          v_err_msg := SUBSTR(DBMS_UTILITY.FORMAT_ERROR_STACK(), 1, 4000);
          DBMS_OUTPUT.PUT_LINE ('Drop failed: ' || 'Owner.Object: ' || '"' || v_users(i) || '"."' ||
          v_objs(i) || '"  Object Type: ' || 'Table' || ' Error: ' || v_err_msg );
          countObjectsFailedToDrop := countObjectsFailedToDrop + 1;
          dbms_sql.close_cursor(Dynamic_Cursor);
        END;
      END IF;
      countObjects := countObjects + 1;
    END IF;
  END LOOP;

  EXECUTE IMMEDIATE
'SELECT DISTINCT p.USER_NAME, xtab.isTable, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/CreateTable''
PASSING x.WORKFLOW_DATA
COLUMNS isTable   VARCHAR2(30) PATH ''@Table'',
        Name      VARCHAR2(30) PATH ''@TableName'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID' BULK COLLECT INTO v_users, v_isTable, v_objs;
  FOR i in 1..v_users.COUNT LOOP
    IF (v_objs(i) IS NOT NULL) THEN
      IF report THEN
        IF (v_isTable(i) = 'true') THEN
          DBMS_OUTPUT.PUT_LINE
           ('Owner.Object: ' || '"' || v_users(i) || '"."' ||
            v_objs(i) || '"  Object Type: ' || 'Table' );
        ELSE
          DBMS_OUTPUT.PUT_LINE
           ('Owner.Object: ' || '"' || v_users(i) || '"."' ||
            v_objs(i) || '"  Object Type: ' || 'View' );
        END IF;
      END IF;
      IF droptable  THEN
        BEGIN
          IF (v_isTable(i) = 'true') THEN
            sql_text := 'drop ' || 'table' || ' '  || '"' || v_users(i) || '"."' ||
                v_objs(i) || '" purge';
          ELSE
            sql_text := 'drop ' || 'view' || ' '  || '"' || v_users(i) || '"."' ||
                v_objs(i);
          END IF;
          DBMS_OUTPUT.PUT_LINE(sql_text);
          Dynamic_Cursor := dbms_sql.open_cursor;
          dbms_sql.parse(Dynamic_Cursor, sql_text, dbms_sql.native);
          dummy := dbms_sql.execute(Dynamic_Cursor);
          dbms_sql.close_cursor(Dynamic_Cursor);
          countObjectsDropped := countObjectsDropped + 1;      
        EXCEPTION WHEN OTHERS THEN
          v_err_msg := SUBSTR(DBMS_UTILITY.FORMAT_ERROR_STACK(), 1, 4000);
          DBMS_OUTPUT.PUT_LINE ('Drop failed: ' || 'Owner.Object: ' || '"' || v_users(i) || '"."' ||
          v_objs(i) || '"  Object Type: ' || 'Table/View' || ' Error: ' || v_err_msg );
          countObjectsFailedToDrop := countObjectsFailedToDrop + 1;
          dbms_sql.close_cursor(Dynamic_Cursor);
        END;
      END IF;
      countObjects := countObjects + 1;
    END IF;
  END LOOP;

  EXECUTE IMMEDIATE
'SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/ColumnFilter/CacheSettings/OutputTable''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/RowFilter/CacheSettings/OutputTable''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/Apply/CacheSettings/OutputTable''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/ModelDetails/CacheSettings/OutputTable''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/TestDetails/CacheSettings/OutputTable''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/FilterDetails/CacheSettings/OutputTable''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/Transformation/SampleSettings/OutputTable''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/DataProfile/StatisticTable''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/Sample/StatisticTable''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/BuildText/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Token/Token/StatisticTable''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/BuildText/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Theme/Token/StatisticTable''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID' BULK COLLECT INTO v_users, v_objs;
  FOR i in 1..v_users.COUNT LOOP
    IF (v_objs(i) IS NOT NULL) THEN
      IF report THEN
        DBMS_OUTPUT.PUT_LINE
         ('Owner.Object: ' || '"' || v_users(i) || '"."' ||
          v_objs(i) || '"  Object Type: ' || 'Table' );
      END IF;
      IF droptable  THEN
        BEGIN
          sql_text := 'drop ' || 'table' || ' '  || '"' || v_users(i) || '"."' ||
              v_objs(i) || '" purge';
          DBMS_OUTPUT.PUT_LINE(sql_text);
          Dynamic_Cursor := dbms_sql.open_cursor;
          dbms_sql.parse(Dynamic_Cursor, sql_text, dbms_sql.native);
          dummy := dbms_sql.execute(Dynamic_Cursor);
          dbms_sql.close_cursor(Dynamic_Cursor);
          countObjectsDropped := countObjectsDropped + 1;      
        EXCEPTION WHEN OTHERS THEN
          v_err_msg := SUBSTR(DBMS_UTILITY.FORMAT_ERROR_STACK(), 1, 4000);
          DBMS_OUTPUT.PUT_LINE ('Drop failed: ' || 'Owner.Object: ' || '"' || v_users(i) || '"."' ||
          v_objs(i) || '"  Object Type: ' || 'Table' || ' Error: ' || v_err_msg );
          countObjectsFailedToDrop := countObjectsFailedToDrop + 1;
          dbms_sql.close_cursor(Dynamic_Cursor);
        END;
      END IF;
      countObjects := countObjects + 1;
    END IF;
  END LOOP;

  EXECUTE IMMEDIATE
'SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/BuildText/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Token/Token/FeatureTable''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/BuildText/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Theme/Token/FeatureTable''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/ApplyText/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Token/Token/FeatureTable''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/ApplyText/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Theme/Token/FeatureTable''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/Transformation/InputStatisticTable''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/Transformation/TransformedStatisticTable''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/ClassificationBuild/Results/ClassificationResult/TestMetrics''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/ClassificationBuild/Results/ClassificationResult/ConfusionMatrix''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/ClassificationBuild/Results/ClassificationResult/Lifts/Lift''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/ClassificationBuild/Results/ClassificationResult/ROCs/ROC''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID' BULK COLLECT INTO v_users, v_objs;
  FOR i in 1..v_users.COUNT LOOP
    IF (v_objs(i) IS NOT NULL) THEN
      IF report THEN
        DBMS_OUTPUT.PUT_LINE
         ('Owner.Object: ' || '"' || v_users(i) || '"."' ||
          v_objs(i) || '"  Object Type: ' || 'Table' );
      END IF;
      IF droptable  THEN
        BEGIN
          sql_text := 'drop ' || 'table' || ' '  || '"' || v_users(i) || '"."' ||
              v_objs(i) || '" purge';
          DBMS_OUTPUT.PUT_LINE(sql_text);
          Dynamic_Cursor := dbms_sql.open_cursor;
          dbms_sql.parse(Dynamic_Cursor, sql_text, dbms_sql.native);
          dummy := dbms_sql.execute(Dynamic_Cursor);
          dbms_sql.close_cursor(Dynamic_Cursor);
          countObjectsDropped := countObjectsDropped + 1;      
        EXCEPTION WHEN OTHERS THEN
          v_err_msg := SUBSTR(DBMS_UTILITY.FORMAT_ERROR_STACK(), 1, 4000);
          DBMS_OUTPUT.PUT_LINE ('Drop failed: ' || 'Owner.Object: ' || '"' || v_users(i) || '"."' ||
          v_objs(i) || '"  Object Type: ' || 'Table' || ' Error: ' || v_err_msg );
          countObjectsFailedToDrop := countObjectsFailedToDrop + 1;
          dbms_sql.close_cursor(Dynamic_Cursor);
        END;
      END IF;
      countObjects := countObjects + 1;
    END IF;
  END LOOP;

  EXECUTE IMMEDIATE
'SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/Test/Results/ClassificationResult/TestMetrics''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/Test/Results/ClassificationResult/ConfusionMatrix''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/Test/Results/ClassificationResult/Lifts/Lift''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/Test/Results/ClassificationResult/ROCs/ROC''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/RegressionBuild/Results/RegressionResult/TestMetrics''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/RegressionBuild/Results/RegressionResult/ResidualPlot''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/Test/Results/RegressionResult/TestMetrics''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/Test/Results/RegressionResult/ResidualPlot''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/ClassificationBuild/Models/CGeneralizedLinearModel/CGeneralizedLinearAlgo/GLMS_DIAGNOSTICS_TABLE_NAME''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''text()'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/RegressionBuild/Models/RGeneralizedLinearModel/RGeneralizedLinearModelAlgo/GLMS_DIAGNOSTICS_TABLE_NAME''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''text()'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID' BULK COLLECT INTO v_users, v_objs;
  FOR i in 1..v_users.COUNT LOOP
    IF (v_objs(i) IS NOT NULL) THEN
      IF report THEN
        DBMS_OUTPUT.PUT_LINE
         ('Owner.Object: ' || '"' || v_users(i) || '"."' ||
          v_objs(i) || '"  Object Type: ' || 'Table' );
      END IF;
      IF droptable  THEN
        BEGIN
          sql_text := 'drop ' || 'table' || ' '  || '"' || v_users(i) || '"."' ||
              v_objs(i) || '" purge';
          DBMS_OUTPUT.PUT_LINE(sql_text);
          Dynamic_Cursor := dbms_sql.open_cursor;
          dbms_sql.parse(Dynamic_Cursor, sql_text, dbms_sql.native);
          dummy := dbms_sql.execute(Dynamic_Cursor);
          dbms_sql.close_cursor(Dynamic_Cursor);
          countObjectsDropped := countObjectsDropped + 1;      
        EXCEPTION WHEN OTHERS THEN
          v_err_msg := SUBSTR(DBMS_UTILITY.FORMAT_ERROR_STACK(), 1, 4000);
          DBMS_OUTPUT.PUT_LINE ('Drop failed: ' || 'Owner.Object: ' || '"' || v_users(i) || '"."' ||
          v_objs(i) || '"  Object Type: ' || 'Table' || ' Error: ' || v_err_msg );
          countObjectsFailedToDrop := countObjectsFailedToDrop + 1;
          dbms_sql.close_cursor(Dynamic_Cursor);
        END;
      END IF;
      countObjects := countObjects + 1;
    END IF;
  END LOOP;

  EXECUTE IMMEDIATE
'SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/ColumnFilter/ColumnFilterResults''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@DataQualityOutput'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/ColumnFilter/ColumnFilterResults''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@AttrImportanceOutput'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/ClassificationBuild/Models/NaiveBayesModel/Performance/Balanced''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@WeightsTable'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/ClassificationBuild/Models/DecisionTreeModel/Performance/Balanced''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@WeightsTable'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/ClassificationBuild/Models/CSupportVectorMachineModel/Performance/Balanced''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@WeightsTable'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/ClassificationBuild/Models/CGeneralizedLinearModel/Performance/Balanced''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@WeightsTable'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID' BULK COLLECT INTO v_users, v_objs;
  FOR i in 1..v_users.COUNT LOOP
    IF (v_objs(i) IS NOT NULL) THEN
      IF report THEN
        DBMS_OUTPUT.PUT_LINE
         ('Owner.Object: ' || '"' || v_users(i) || '"."' ||
          v_objs(i) || '"  Object Type: ' || 'Table' );
      END IF;
      IF droptable  THEN
        BEGIN
          sql_text := 'drop ' || 'table' || ' '  || '"' || v_users(i) || '"."' ||
              v_objs(i) || '" purge';
          DBMS_OUTPUT.PUT_LINE(sql_text);
          Dynamic_Cursor := dbms_sql.open_cursor;
          dbms_sql.parse(Dynamic_Cursor, sql_text, dbms_sql.native);
          dummy := dbms_sql.execute(Dynamic_Cursor);
          dbms_sql.close_cursor(Dynamic_Cursor);
          countObjectsDropped := countObjectsDropped + 1;      
        EXCEPTION WHEN OTHERS THEN
          v_err_msg := SUBSTR(DBMS_UTILITY.FORMAT_ERROR_STACK(), 1, 4000);
          DBMS_OUTPUT.PUT_LINE ('Drop failed: ' || 'Owner.Object: ' || '"' || v_users(i) || '"."' ||
          v_objs(i) || '"  Object Type: ' || 'Table' || ' Error: ' || v_err_msg );
          countObjectsFailedToDrop := countObjectsFailedToDrop + 1;
          dbms_sql.close_cursor(Dynamic_Cursor);
        END;
      END IF;
      countObjects := countObjects + 1;
    END IF;
  END LOOP;

  EXECUTE IMMEDIATE
'SELECT DISTINCT USER_NAME, Name 
FROM (
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/BuildTextRef/Stoplists/Stoplist''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@DBName'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/BuildText/Stoplists/Stoplist''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@DBName'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/ApplyText/Stoplists/Stoplist''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@DBName'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID)' BULK COLLECT INTO v_users, v_objs;
  FOR i in 1..v_users.COUNT LOOP
    IF (v_objs(i) IS NOT NULL) THEN
      IF report THEN
        DBMS_OUTPUT.PUT_LINE
         ('Owner.Object: ' || '"' || v_users(i) || '"."' ||
          v_objs(i) || '"  Object Type: ' || 'Stoplist' );
      END IF;
      IF droptable  THEN
        BEGIN
          ctx_ddl.DROP_STOPLIST('"'||v_users(i)||'"."'||v_objs(i)||'"');
          sql_text := 'drop ' || 'stoplist' || ' '  || '"' || v_users(i) || '"."' ||
              v_objs(i) || '" ';
          DBMS_OUTPUT.PUT_LINE(sql_text);
          countObjectsDropped := countObjectsDropped + 1;      
        EXCEPTION WHEN OTHERS THEN
          v_err_msg := SUBSTR(DBMS_UTILITY.FORMAT_ERROR_STACK(), 1, 4000);
          DBMS_OUTPUT.PUT_LINE ('Drop failed: ' || 'Owner.Object: ' || '"' || v_users(i) || '"."' ||
          v_objs(i) || '"  Object Type: ' || 'Stoplist' || ' Error: ' || v_err_msg );
          countObjectsFailedToDrop := countObjectsFailedToDrop + 1;
        END;
      END IF;
      countObjects := countObjects + 1;
    END IF;
  END LOOP;

  EXECUTE IMMEDIATE
'SELECT DISTINCT USER_NAME, Name 
FROM (
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/BuildText/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Token/Token/Lexer''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/BuildText/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Theme/Token/Lexer''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/ApplyText/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Token/Token/Lexer''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/ApplyText/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Theme/Token/Lexer''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/BuildTextRef/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Token/Token/Lexer''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/BuildTextRef/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Theme/Token/Lexer''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Name'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID)' BULK COLLECT INTO v_users, v_objs;
  FOR i in 1..v_users.COUNT LOOP
    IF (v_objs(i) IS NOT NULL) THEN
      IF report THEN
        DBMS_OUTPUT.PUT_LINE
         ('Owner.Object: ' || '"' || v_users(i) || '"."' ||
          v_objs(i) || '"  Object Type: ' || 'Lexer' );
      END IF;
      IF droptable  THEN
        BEGIN
          ctx_ddl.DROP_PREFERENCE('"'||v_users(i)||'"."'||v_objs(i)||'"');
          sql_text := 'drop ' || 'lexer' || ' '  || '"' || v_users(i) || '"."' ||
              v_objs(i) || '" ';
          DBMS_OUTPUT.PUT_LINE(sql_text);
          countObjectsDropped := countObjectsDropped + 1;      
        EXCEPTION WHEN OTHERS THEN
          v_err_msg := SUBSTR(DBMS_UTILITY.FORMAT_ERROR_STACK(), 1, 4000);
          DBMS_OUTPUT.PUT_LINE ('Drop failed: ' || 'Owner.Object: ' || '"' || v_users(i) || '"."' ||
          v_objs(i) || '"  Object Type: ' || 'Lexer' || ' Error: ' || v_err_msg );
          countObjectsFailedToDrop := countObjectsFailedToDrop + 1;
        END;
      END IF;
      countObjects := countObjects + 1;
    END IF;
  END LOOP;

  EXECUTE IMMEDIATE
'SELECT DISTINCT USER_NAME, Name 
FROM (
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/BuildText/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Token/Token''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Policy'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/BuildText/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Theme/Token''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Policy'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/ApplyText/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Token/Token''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Policy'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/ApplyText/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Theme/Token''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Policy'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/BuildTextRef/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Token/Token''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Policy'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID
UNION ALL
SELECT DISTINCT p.USER_NAME, xtab.Name
FROM ODMRSYS.ODMR$WORKFLOWS x,
XMLTable(XMLNamespaces(default ''http://xmlns.oracle.com/odmr11''),
''/WorkflowProcess/Nodes/BuildTextRef/TransformedAttributes/MapTextTransformedSource/Key/TransformationElement/Theme/Token''
PASSING x.WORKFLOW_DATA
COLUMNS Name VARCHAR2(30) PATH ''@Policy'') xtab,
ODMRSYS.ODMR$PROJECTS p
WHERE p.PROJECT_ID = x.PROJECT_ID)' BULK COLLECT INTO v_users, v_objs;
  FOR i in 1..v_users.COUNT LOOP
    IF (v_objs(i) IS NOT NULL) THEN
      IF report THEN
        DBMS_OUTPUT.PUT_LINE
         ('Owner.Object: ' || '"' || v_users(i) || '"."' ||
          v_objs(i) || '"  Object Type: ' || 'Policy' );
      END IF;
      IF droptable  THEN
        BEGIN
          ctx_ddl.DROP_POLICY('"'||v_users(i)||'"."'||v_objs(i)||'"');
          sql_text := 'drop ' || 'policy' || ' '  || '"' || v_users(i) || '"."' ||
              v_objs(i) || '" ';
          DBMS_OUTPUT.PUT_LINE(sql_text);
          countObjectsDropped := countObjectsDropped + 1;      
        EXCEPTION WHEN OTHERS THEN
          v_err_msg := SUBSTR(DBMS_UTILITY.FORMAT_ERROR_STACK(), 1, 4000);
          DBMS_OUTPUT.PUT_LINE ('Drop failed: ' || 'Owner.Object: ' || '"' || v_users(i) || '"."' ||
          v_objs(i) || '"  Object Type: ' || 'Policy' || ' Error: ' || v_err_msg );
          countObjectsFailedToDrop := countObjectsFailedToDrop + 1;
        END;
      END IF;
      countObjects := countObjects + 1;
    END IF;
  END LOOP;
  
  DBMS_OUTPUT.PUT_LINE
   ('Total Number of Objects: ' || countObjects );
  DBMS_OUTPUT.PUT_LINE
   ('Total Number of Objects Dropped: ' || countObjectsDropped );
  DBMS_OUTPUT.PUT_LINE
   ('Total Number of Objects Failed to Drop: ' || countObjectsFailedToDrop );

EXCEPTION
WHEN OTHERS THEN
  v_err_msg := SUBSTR(DBMS_UTILITY.FORMAT_ERROR_STACK(), 1, 4000);
  DBMS_OUTPUT.PUT_LINE ('Drop failed: ' || 'All User objects"' || ' Error: ' || v_err_msg );
END;
/