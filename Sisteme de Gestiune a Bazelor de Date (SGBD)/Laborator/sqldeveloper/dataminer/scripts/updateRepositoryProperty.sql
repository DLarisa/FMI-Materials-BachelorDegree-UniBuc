-- updateRepositoryProperty.sql is used by the migration/installation process to update a repository property value
-- Usage @updateRepositoryProperty.sql <P1> <P2>
--    P1: Property Name
--    P2: Property Value
-- Example: @updateRepositoryProperty.sql 'VERSION'  '11.2.0.1.4'
DEFINE PROPERTY_NAME = &&1
DEFINE PROPERTY_VALUE = &&2

UPDATE ODMRSYS.ODMR$REPOSITORY_PROPERTIES
 SET PROPERTY_STR_VALUE = '&PROPERTY_VALUE'
 WHERE PROPERTY_NAME = '&PROPERTY_NAME';

COMMIT;
