
Oracle SQL Developer Data Modeleler
Reporting repository upgrade instructions

   General Prerequisites
   ---------------------
1. Make sure you have sufficient privileges and Oracle directory OSDDM_REPORTS_DIR is created. Check the file Reporting_Schema_Permissions.sql.

   Using SQL*Plus
   --------------
1. Move to directory \datamodeler\reports
2. Start SQL*Plus session as owner of the reporting schema repository
3. Type @osddm_upgr.sql and hit Enter
4. Review results in the file named osddm_upgr<DD.MM.YYYY_HH24.MI.SS>.log located in current directory

   Using SQL Developer
   -------------------
1. Start SQL Developer and connect to the reporting schema repository
2. Click on File->Open
3. Open file \datamodeler\reports\osddm_upgrrun.sql
4. File contents will be loaded in SQL worksheet
5. Click on Run Script icon (F5)
6. Results will be shown in Scripts Output window

   Notes: Oracle directory OSDDM_REPORTS_DIR is directory where the reports will be generated, so it has to be existing OS directory on Oracle server with OS read / write permissions.