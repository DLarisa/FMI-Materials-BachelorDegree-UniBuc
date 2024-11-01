WHENEVER SQLERROR EXIT SQL.SQLCODE;

EXECUTE dbms_output.put_line('');
EXECUTE dbms_output.put_line('Load translated messages.');
EXECUTE dbms_output.put_line('');

delete ODMRSYS.ODMR$MESSAGES; 
@@instmessages_en.sql
@@instmessages_fr.sql
@@instmessages_de.sql
@@instmessages_it.sql
@@instmessages_es.sql
@@instmessages_pt_br.sql
@@instmessages_ja.sql
@@instmessages_ko.sql
@@instmessages_zh_cn.sql
@@instmessages_zh_tw.sql

