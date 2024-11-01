--------------------------------------------------------------------------------
-- Revokes select privs on SH data from user.
-- 
-- Parameters:
-- 1. User account - account to drop views and tables on
-- Example:
-- @revokeSHGrants.sql DMUSER
--------------------------------------------------------------------------
--

-- User Account substitution variable
DEFINE USER_ACCOUNT = &&1

EXECUTE dbms_output.put_line('');
EXECUTE dbms_output.put_line('Revoke Data Miner demo data access to SH schema objects');
EXECUTE dbms_output.put_line('');

-- Revoke grants to SH tables/views
REVOKE SELECT ON sh.customers FROM "&USER_ACCOUNT"
/
REVOKE SELECT ON sh.sales FROM "&USER_ACCOUNT"
/
REVOKE SELECT ON sh.products FROM "&USER_ACCOUNT"
/
REVOKE SELECT ON sh.supplementary_demographics FROM "&USER_ACCOUNT"
/
REVOKE SELECT ON sh.countries FROM "&USER_ACCOUNT"
/ 
REVOKE SELECT ON sh.cal_month_sales_mv FROM "&USER_ACCOUNT"
/ 
REVOKE SELECT ON sh.channels FROM "&USER_ACCOUNT"
/ 
REVOKE SELECT ON sh.costs FROM "&USER_ACCOUNT"
/
REVOKE SELECT ON sh.FWEEK_PSCAT_SALES_MV FROM "&USER_ACCOUNT"
/
REVOKE SELECT ON sh.promotions FROM "&USER_ACCOUNT"
/
REVOKE SELECT ON sh.times FROM "&USER_ACCOUNT"
/
