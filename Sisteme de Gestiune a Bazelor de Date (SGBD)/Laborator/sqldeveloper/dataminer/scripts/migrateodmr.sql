-- Run this script to migrate an existing ODMRSYS account
-- Successful completion of the script requires there to be no sessions active with the role of ODMRUSER.
-- Active ODMRUSER sessions can result in object locks that block the migration.
-- The following parameter is available for detecting and managing such sessions.
-- 1. Action Flags:
--    R = report only, do not disconnect any sessions
--    D = disconnect only, displays disconnect  only
--    DR or RD = disconnect and report
-- Example:
-- Option 1: Conservative approach, which will require DBA to manually review active sessions and 
-- determine how to end them. The migration process will stop if there are active sessions and a log
-- is produced listing the sessions to be manually reviewed and handled.
-- @migrateodmr.sql R 
-- Option 2: Force migration approach which will disconnect sessions and proceed with migration as 
-- long as all sessions succesfully disconnected.
-- @migrateodmr.sql DR 


set serveroutput on

EXECUTE dbms_output.put_line('Start Data Miner Repository Upgrade Process.');
EXECUTE dbms_output.put_line('');

DEFINE D_SESSION_ACTION = &1

WHENEVER SQLERROR EXIT SQL.SQLCODE;
-- check to insure that no workflows are either queued or active.
-- Abort the process if this condition exists.
@insureWorkflowsInactive.sql

-- disconnect any existing odmruser sessions, or odmrsys sessions
@disconnectODMRSessions.sql &D_SESSION_ACTION T

-- backup user grants
@createusersgrantbackup.sql

-- revoke grants on ODMRUSER role and associated objects
@usergrantshelper.sql REVOKE ODMRUSER

-- run a final check to insure that no sessions were missed (should not be any ODMRUSER roles granted)
@disconnectODMRSessions.sql &D_SESSION_ACTION T

-- update the status of the repository
EXECUTE dbms_output.put_line('Update repository status to NOT_LOADED.');
@updateRepositoryProperty.sql REPOSITORY_STATUS  NOT_LOADED

-- migrate repository
@migrateodmrhelper.sql


-- fail if the versions do not match the target versions provided as parameters
-- only test for repository version as the worfklow schema version upgrade is skipped for some db versions
@validateVersionUpgrade.sql '11.2.1.1.6' '11.2.1.1.1'

-- update the status of the repository
EXECUTE dbms_output.put_line('');
EXECUTE dbms_output.put_line('Update repository status to LOADED.');
EXECUTE dbms_output.put_line('');
@updateRepositoryProperty.sql REPOSITORY_STATUS  LOADED

-- grant ODMRUSER role and associated objects privileges to users previously holding these grants
@usergrantshelper.sql GRANT USE_BACKUP_TABLE

EXECUTE dbms_output.put_line('');
EXECUTE dbms_output.put_line('End of Data Miner Repository Upgrade Process.');
EXECUTE dbms_output.put_line('');

exit;
