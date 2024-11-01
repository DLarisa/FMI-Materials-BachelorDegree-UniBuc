CREATE OR REPLACE PACKAGE PKG_OSDM_UTILS AS

PROCEDURE Generate_Report(v_rep_id           IN NUMBER,
                          v_obj_ovid         IN VARCHAR2,
                          v_mode             IN NUMBER,
                          v_reports_dir      IN VARCHAR2,
                          v_compress         IN NUMBER, 
                          reportTemplate     IN REPORT_TEMPLATE,
                          v_raw_xml         OUT BFILE, 
                          v_status          OUT NUMBER, 
                          osddm_reports_dir OUT VARCHAR2);

FUNCTION Gather_Constraint_Details_XML(col_attr_ovid IN VARCHAR2, 
                                       namespace     IN VARCHAR2) RETURN CLOB;

FUNCTION Gather_Domain_Constraints_XML(domain_ovid VARCHAR2) RETURN CLOB;

FUNCTION Gather_Constraint_Details_HTML(col_attr_ovid VARCHAR2) RETURN CLOB;

FUNCTION Gather_Domain_Constraints_HTML (domain_ovid VARCHAR2) RETURN CLOB;

END PKG_OSDM_UTILS;
/