--------------------------------------------------------------------------------
-- Drops views created in users account that are based on the
-- SH sample schema as well as the INSUR_CUST_LTV_SAMPLE table that is loaded via script.
-- Also revokes select privs on SH data from user.
-- 
-- Parameters:
-- 1. User account - account to drop views and tables on
-- Example:
-- @dropDemoData.sql DMUSER
--------------------------------------------------------------------------
--


-- User Account substitution variable
DEFINE USER_ACCOUNT = &&1

@@dropSHDemoData.sql "&USER_ACCOUNT"
/

@@revokeSHGrants.sql "&USER_ACCOUNT"
/
