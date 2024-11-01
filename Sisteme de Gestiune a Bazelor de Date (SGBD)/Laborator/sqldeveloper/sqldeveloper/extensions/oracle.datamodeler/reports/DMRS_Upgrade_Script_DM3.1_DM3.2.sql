-- Upgrade script for Reporting Schema from DM 3.1 (3.1.0.700) Patch Release to DM 3.1.1 Release or later

--==========ALTER TABLES==========
ALTER TABLE DMRS_DYNAMIC_PROPERTIES ADD (Design_OVID VARCHAR2 (36));

