
-- History ----------------------------
Rem    MODIFIER   (DD/MM/YYYY)  Notes
Rem    dslavov     01/09/2010 - Created
Rem    dslavov     19/01/2011 - New function F_Apply_PLSQL_Transformation added
Rem    dslavov     20/04/2011 - Scripts changed for v3.0 to v3.1
Rem    dslavov     15/09/2011 - F_Apply_PLSQL_Transformation.sql removed ; DMRS_Upgrade_Script_DM3.0_DM3.1_DML.sql removed
---------------------------------------

PROMPT Prerequisites fulfilled.
PROMPT
PROMPT ================================
PROMPT II. DB upgrade
PROMPT ================================

@DMRS_Upgrade_Script_DM3.0_DM3.1.sql;

PROMPT
PROMPT ================================
PROMPT IV. Compile stored procedure/s/
PROMPT ================================

@Pkg_Osdm_Utils.sql;
@Pkg_Osdm_Utils_body.sql;

PROMPT
PROMPT Reporting repository is upgraded.
PROMPT It is compatible for use with current Oracle Data Modeler version.