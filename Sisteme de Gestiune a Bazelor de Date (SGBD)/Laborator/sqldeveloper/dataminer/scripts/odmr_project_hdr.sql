
  CREATE OR REPLACE PACKAGE "ODMRSYS"."ODMR_PROJECT" 
AUTHID CURRENT_USER AS

  /*
  Create a project
  Parameters:
    project_name - project name
    comment - project comment
  Return:
    project id
  Validation:
    if project name conflict, then error
  */
  FUNCTION PROJECT_CREATE(p_project_name IN VARCHAR2, p_comment IN VARCHAR2) RETURN NUMBER;

  /*
  Delete the project and associated workflows (generated models/results will be deleted)
  Parameters:
    project_id - project id
  Validation:
  */
  PROCEDURE PROJECT_DELETE(p_project_id IN NUMBER);

  /*
  Delete the projects and associated workflows (generated models/results will be deleted)
  Parameters:
    project_ids - project ids
  Validation:
  */
  PROCEDURE PROJECT_DELETE(p_project_ids IN ODMR_OBJECT_IDS);

  /*
  Rename the project
  Parameters:
    project_id - project id
    project_name - new project name
  Validation: if name already existed, then error
  */
  PROCEDURE PROJECT_RENAME(p_project_id IN NUMBER, p_project_name IN VARCHAR2);

  /*
  Set/Replace the project comment
  Parameters:
    project_id - project id
    comment - project comment
  */
  PROCEDURE SET_COMMENT(p_project_id IN NUMBER, p_comment IN VARCHAR2);

END ODMR_PROJECT;
/
