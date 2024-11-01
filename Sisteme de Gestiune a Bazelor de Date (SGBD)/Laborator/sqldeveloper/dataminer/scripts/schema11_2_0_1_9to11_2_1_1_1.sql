-- schema11_2_0_1_9to11_2_1_1_1.sql is used by the migration process to migrate the XML Schema from 11.2.0.1.9 to 11.2.1.1.1
-- Usage @schema11_2_0_1_9to11_2_1_1_1.sql
-- Example: @schema11_2_0_1_9to11_2_1_1_1.sql
WHENEVER SQLERROR EXIT SQL.SQLCODE;

ALTER session set current_schema = "SYS";
/

EXECUTE dbms_output.put_line('Start Data Miner XML Schema migration from 11.2.0.1.9 tp 11.2.1.1.1');

DECLARE
  patch        VARCHAR2(30);
  ver_num      VARCHAR2(30);
  db_ver       VARCHAR2(30);
  valid        NUMBER := 0;
  XMLDiff      XMLType;
  schema_data  CLOB;
  schema_char  VARCHAR2(4000);
  pos          NUMBER;
  startPos     NUMBER;
  endPos       NUMBER;
  v_schema_31  NUMBER;
BEGIN
  SELECT XMLSerialize(CONTENT SCHEMA AS CLOB) INTO schema_data
  FROM DBA_XML_SCHEMAS WHERE schema_url = 'http://xmlns.oracle.com/odmr11/odmr.xsd' AND owner = 'ODMRSYS';
  pos := INSTR(schema_data, '"CacheSettings"', 1, 1);
  startPos := INSTR(schema_data, '"Random"', pos, 1);
  endPos := INSTR(schema_data, '>', startPos, 1);
  schema_char := SUBSTR(schema_data, startPos, endPos-startPos);
  v_schema_31 := INSTR(schema_char, 'minOccurs', 1, 1);
  IF (v_schema_31 = 0) THEN -- migration only for 3.0 XML schema
    SELECT version INTO db_ver FROM product_component_version WHERE product LIKE 'Oracle Database%';
    IF (INSTR(db_ver, '11.2.0.2') > 0 OR INSTR(db_ver, '11.2.0.1') > 0 OR INSTR(db_ver, '11.2.0.0') > 0) THEN
      BEGIN
        SELECT PROPERTY_STR_VALUE INTO patch FROM ODMRSYS.ODMR$REPOSITORY_PROPERTIES WHERE PROPERTY_NAME = 'MAINTAIN_DOM_PATCH_INSTALLED';
      EXCEPTION WHEN NO_DATA_FOUND THEN
        patch := 'FALSE';
      END;
      IF (patch = 'TRUE') THEN
        valid := 1;
      ELSE
        valid := 0;
        dbms_output.put_line('No workflow schema migration for database version 11.2.0.2.0 and older without the maintain dom patch');
      END IF;
    ELSE
      valid := 1;  -- allow migration if database >= 11.2.0.3.0
    END IF;
  END IF;
  BEGIN
    SELECT PROPERTY_STR_VALUE INTO ver_num FROM ODMRSYS.ODMR$REPOSITORY_PROPERTIES WHERE PROPERTY_NAME = 'WF_VERSION';
    dbms_output.put_line('Current xml schema version in database: ' || to_char(ver_num));
  EXCEPTION WHEN NO_DATA_FOUND THEN
    ver_num := '11.2.0.1.9'; -- if it doesn't exist, assume 11.2.0.1.9
    dbms_output.put_line('Schema version did not exist in properties so it will be added : ' || to_char(ver_num));
    INSERT INTO ODMRSYS.ODMR$REPOSITORY_PROPERTIES (PROPERTY_NAME, PROPERTY_STR_VALUE, "COMMENT") VALUES ('WF_VERSION', ver_num, 'Supported workflow version');
    COMMIT;
  END;
  IF (ver_num = '11.2.0.1.9' AND valid = 1 AND v_schema_31 = 0) THEN -- migration from 11.2.0.1.9 and database >= 11.2.0.3.0 and 
    XMLDiff := XMLType(
    '<xd:xdiff xsi:schemaLocation="http://xmlns.oracle.com/xdb/xdiff.xsd http://xmlns.oracle.com/xdb/xdiff.xsd" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xdb="http://xmlns.oracle.com/xdb" xmlns:xd="http://xmlns.oracle.com/xdb/xdiff.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <?oracle-xmldiff operations-in-docorder="true" output-model="snapshot" diff-algorithm="global"?>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:element[14]/xs:complexType[1]/xs:sequence[1]/xs:choice[1]/xs:element[1]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:element[14]/xs:complexType[1]/xs:sequence[1]/xs:choice[1]/xs:element[2]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:element[14]/xs:complexType[1]/xs:sequence[1]/xs:element[1]/xs:complexType[1]/xs:choice[1]/xs:element[1]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:element[14]/xs:complexType[1]/xs:sequence[1]/xs:element[1]/xs:complexType[1]/xs:choice[1]/xs:element[2]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:element[14]/xs:complexType[1]/xs:sequence[1]/xs:element[1]/xs:complexType[1]/xs:choice[1]/xs:element[3]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:element[62]/xs:complexType[1]/xs:sequence[1]/xs:choice[1]/xs:element[1]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:element[62]/xs:complexType[1]/xs:sequence[1]/xs:choice[1]/xs:element[2]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:element[62]/xs:complexType[1]/xs:sequence[1]/xs:element[1]/xs:complexType[1]/xs:choice[1]/xs:element[1]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:element[62]/xs:complexType[1]/xs:sequence[1]/xs:element[1]/xs:complexType[1]/xs:choice[1]/xs:element[2]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:element[62]/xs:complexType[1]/xs:sequence[1]/xs:element[1]/xs:complexType[1]/xs:choice[1]/xs:element[3]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:element[68]/xs:complexType[1]/xs:choice[1]/xs:element[1]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:element[68]/xs:complexType[1]/xs:choice[1]/xs:element[2]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:element[68]/xs:complexType[1]/xs:choice[1]/xs:element[3]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:element[68]/xs:complexType[1]/xs:choice[1]/xs:element[4]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:update-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[6]/xs:sequence[1]/xs:element[1]/xs:complexType[1]/xs:sequence[1]/xs:choice[1]/xs:element[1]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:update-node>
  <xd:update-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[6]/xs:sequence[1]/xs:element[1]/xs:complexType[1]/xs:sequence[1]/xs:choice[1]/xs:element[2]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:update-node>
  <xd:update-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[6]/xs:sequence[1]/xs:element[1]/xs:complexType[1]/xs:sequence[1]/xs:choice[1]/xs:element[3]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:update-node>
  <xd:update-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[6]/xs:sequence[1]/xs:element[1]/xs:complexType[1]/xs:sequence[1]/xs:choice[1]/xs:element[4]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:update-node>
  <xd:update-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[6]/xs:sequence[1]/xs:element[1]/xs:complexType[1]/xs:sequence[1]/xs:choice[1]/xs:element[5]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:update-node>
  <xd:update-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[6]/xs:sequence[1]/xs:element[1]/xs:complexType[1]/xs:sequence[1]/xs:choice[1]/xs:element[6]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:update-node>
  <xd:update-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[6]/xs:sequence[1]/xs:element[1]/xs:complexType[1]/xs:sequence[1]/xs:choice[1]/xs:element[7]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:update-node>
  <xd:update-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[6]/xs:sequence[1]/xs:element[1]/xs:complexType[1]/xs:sequence[1]/xs:choice[1]/xs:element[8]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:update-node>
  <xd:update-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[6]/xs:sequence[1]/xs:element[1]/xs:complexType[1]/xs:sequence[1]/xs:choice[1]/xs:element[9]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:update-node>
  <xd:update-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[6]/xs:sequence[1]/xs:element[1]/xs:complexType[1]/xs:sequence[1]/xs:choice[1]/xs:element[10]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:update-node>
  <xd:update-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[6]/xs:sequence[1]/xs:element[1]/xs:complexType[1]/xs:sequence[1]/xs:choice[1]/xs:element[11]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:update-node>
  <xd:update-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[6]/xs:sequence[1]/xs:element[1]/xs:complexType[1]/xs:sequence[1]/xs:choice[1]/xs:element[12]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:update-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[22]/xs:choice[1]/xs:element[1]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[22]/xs:choice[1]/xs:element[2]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[22]/xs:choice[1]/xs:element[3]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[53]/xs:choice[1]/xs:element[1]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[53]/xs:choice[1]/xs:element[2]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:update-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[59]/xs:complexContent[1]/xs:extension[1]/xs:sequence[1]/xs:choice[1]/xs:element[1]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:update-node>
  <xd:update-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[59]/xs:complexContent[1]/xs:extension[1]/xs:sequence[1]/xs:choice[1]/xs:element[2]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:update-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[66]/xs:sequence[1]/xs:choice[1]/xs:element[1]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[66]/xs:sequence[1]/xs:choice[1]/xs:element[2]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[84]/xs:choice[1]/xs:element[1]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[84]/xs:choice[1]/xs:element[2]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[84]/xs:choice[1]/xs:element[3]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[85]/xs:sequence[1]/xs:element[1]/xs:complexType[1]/xs:choice[1]/xs:element[1]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[85]/xs:sequence[1]/xs:element[1]/xs:complexType[1]/xs:choice[1]/xs:element[2]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[85]/xs:sequence[1]/xs:element[1]/xs:complexType[1]/xs:choice[1]/xs:element[3]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[87]/xs:sequence[1]/xs:element[1]/xs:complexType[1]/xs:choice[1]/xs:element[1]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[87]/xs:sequence[1]/xs:element[1]/xs:complexType[1]/xs:choice[1]/xs:element[2]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[87]/xs:sequence[1]/xs:element[1]/xs:complexType[1]/xs:choice[1]/xs:element[3]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[90]/xs:sequence[1]/xs:element[1]/xs:complexType[1]/xs:choice[1]/xs:element[1]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[90]/xs:sequence[1]/xs:element[1]/xs:complexType[1]/xs:choice[1]/xs:element[2]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[90]/xs:sequence[1]/xs:element[1]/xs:complexType[1]/xs:choice[1]/xs:element[3]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[104]/xs:sequence[1]/xs:choice[1]/xs:element[1]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[104]/xs:sequence[1]/xs:choice[1]/xs:element[2]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[104]/xs:sequence[1]/xs:element[1]/xs:complexType[1]/xs:choice[1]/xs:element[1]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[104]/xs:sequence[1]/xs:element[1]/xs:complexType[1]/xs:choice[1]/xs:element[2]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[104]/xs:sequence[1]/xs:element[1]/xs:complexType[1]/xs:choice[1]/xs:element[3]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[121]/xs:choice[1]/xs:element[1]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[121]/xs:choice[1]/xs:element[2]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[126]/xs:sequence[1]/xs:choice[1]/xs:element[1]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[126]/xs:sequence[1]/xs:choice[1]/xs:element[1]/xs:complexType[1]/xs:choice[1]/xs:element[1]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[126]/xs:sequence[1]/xs:choice[1]/xs:element[1]/xs:complexType[1]/xs:choice[1]/xs:element[2]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[126]/xs:sequence[1]/xs:choice[1]/xs:element[1]/xs:complexType[1]/xs:choice[1]/xs:element[3]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[126]/xs:sequence[1]/xs:choice[1]/xs:element[1]/xs:complexType[1]/xs:choice[1]/xs:element[4]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[126]/xs:sequence[1]/xs:choice[1]/xs:element[2]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[126]/xs:sequence[1]/xs:choice[1]/xs:element[2]/xs:complexType[1]/xs:choice[1]/xs:element[1]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[126]/xs:sequence[1]/xs:choice[1]/xs:element[2]/xs:complexType[1]/xs:choice[1]/xs:element[2]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[126]/xs:sequence[1]/xs:choice[1]/xs:element[2]/xs:complexType[1]/xs:choice[1]/xs:element[3]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[126]/xs:sequence[1]/xs:choice[1]/xs:element[3]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[126]/xs:sequence[1]/xs:choice[1]/xs:element[3]/xs:complexType[1]/xs:choice[1]/xs:element[1]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[126]/xs:sequence[1]/xs:choice[1]/xs:element[3]/xs:complexType[1]/xs:choice[1]/xs:element[2]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[126]/xs:sequence[1]/xs:choice[1]/xs:element[4]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[126]/xs:sequence[1]/xs:choice[1]/xs:element[4]/xs:complexType[1]/xs:choice[1]/xs:element[1]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[126]/xs:sequence[1]/xs:choice[1]/xs:element[4]/xs:complexType[1]/xs:choice[1]/xs:element[2]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[126]/xs:sequence[1]/xs:choice[1]/xs:element[5]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[126]/xs:sequence[1]/xs:choice[1]/xs:element[5]/xs:complexType[1]/xs:choice[1]/xs:element[1]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[126]/xs:sequence[1]/xs:choice[1]/xs:element[5]/xs:complexType[1]/xs:choice[1]/xs:element[2]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[126]/xs:sequence[1]/xs:choice[1]/xs:element[6]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[126]/xs:sequence[1]/xs:choice[1]/xs:element[7]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[126]/xs:sequence[1]/xs:choice[1]/xs:element[7]/xs:complexType[1]/xs:choice[1]/xs:element[1]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[126]/xs:sequence[1]/xs:choice[1]/xs:element[7]/xs:complexType[1]/xs:choice[1]/xs:element[2]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[126]/xs:sequence[1]/xs:choice[1]/xs:element[7]/xs:complexType[1]/xs:choice[1]/xs:element[3]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[126]/xs:sequence[1]/xs:choice[1]/xs:element[7]/xs:complexType[1]/xs:choice[1]/xs:element[4]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[126]/xs:sequence[1]/xs:choice[1]/xs:element[7]/xs:complexType[1]/xs:choice[1]/xs:element[5]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[126]/xs:sequence[1]/xs:choice[1]/xs:element[7]/xs:complexType[1]/xs:choice[1]/xs:element[6]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[126]/xs:sequence[1]/xs:choice[1]/xs:element[7]/xs:complexType[1]/xs:choice[1]/xs:element[7]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[126]/xs:sequence[1]/xs:choice[1]/xs:element[7]/xs:complexType[1]/xs:choice[1]/xs:element[8]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[126]/xs:sequence[1]/xs:choice[1]/xs:element[7]/xs:complexType[1]/xs:choice[1]/xs:element[9]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[127]/xs:choice[1]/xs:element[1]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[127]/xs:choice[1]/xs:element[2]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[127]/xs:choice[1]/xs:element[3]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[127]/xs:choice[1]/xs:element[4]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[127]/xs:choice[1]/xs:element[4]/xs:complexType[1]/xs:sequence[1]/xs:element[1]/xs:complexType[1]/xs:choice[1]/xs:element[1]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[127]/xs:choice[1]/xs:element[4]/xs:complexType[1]/xs:sequence[1]/xs:element[1]/xs:complexType[1]/xs:choice[1]/xs:element[2]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:complexType[127]/xs:choice[1]/xs:element[4]/xs:complexType[1]/xs:sequence[1]/xs:element[1]/xs:complexType[1]/xs:choice[1]/xs:element[3]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:element[76]/xs:complexType[1]/xs:choice[1]/xs:element[1]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:element[76]/xs:complexType[1]/xs:choice[1]/xs:element[2]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:element[78]/xs:complexType[1]/xs:choice[1]/xs:element[1]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
  <xd:append-node xd:node-type="attribute" xd:parent-xpath="/xs:schema[1]/xs:element[78]/xs:complexType[1]/xs:choice[1]/xs:element[2]" xd:attr-local="minOccurs">
    <xd:content>0</xd:content>
  </xd:append-node>
</xd:xdiff>
');
    -- migrate the workflow schema using the diff
    DBMS_XMLSCHEMA.INPLACEEVOLVE(
       'http://xmlns.oracle.com/odmr11/odmr.xsd', 
       XMLDiff, 
       1);
    -- uptick the WF_VERSION
    UPDATE ODMRSYS.ODMR$REPOSITORY_PROPERTIES SET PROPERTY_STR_VALUE = '11.2.1.1.1' WHERE PROPERTY_NAME = 'WF_VERSION';
    COMMIT;
    dbms_output.put_line('Workflow schema migration from version 11.2.0.1.9 to version 11.2.1.1.1 succeeded');
  ELSIF (ver_num = '11.2.0.1.9' AND v_schema_31 > 0) THEN -- already in 3.1 XML schema, so no migration needed, just update the WF_VERSION
    -- uptick the WF_VERSION
    UPDATE ODMRSYS.ODMR$REPOSITORY_PROPERTIES SET PROPERTY_STR_VALUE = '11.2.1.1.1' WHERE PROPERTY_NAME = 'WF_VERSION';
    COMMIT;
    dbms_output.put_line('Workflow schema is version 11.2.1.1.1, so no migration is needed');
  ELSE
    dbms_output.put_line('Workflow schema migration from version 11.2.0.1.9 to version 11.2.1.1.1 not required.');
  END IF;  
EXCEPTION WHEN OTHERS THEN
  ROLLBACK;
  dbms_output.put_line('Workflow schema migration from version 11.2.0.1.9 to version 11.2.1.1.1 failed: '||DBMS_UTILITY.FORMAT_ERROR_STACK());
  RAISE_APPLICATION_ERROR(-20000, 'Workflow schema migration from version 11.2.0.1.9 to version 11.2.1.1.1 failed. Review install log.');
END;
/


ALTER session set current_schema = "ODMRSYS";
/
DECLARE
  ver_num   VARCHAR2(30);
BEGIN
  SELECT PROPERTY_STR_VALUE INTO ver_num FROM ODMRSYS.ODMR$REPOSITORY_PROPERTIES WHERE PROPERTY_NAME = 'WF_VERSION';
  IF (ver_num = '11.2.1.1.1') THEN
    UPDATE ODMRSYS.ODMR$WORKFLOWS x
      SET x.WORKFLOW_DATA = updateXML(x.WORKFLOW_DATA, '/WorkflowProcess/@Version', ver_num, 'xmlns="http://xmlns.oracle.com/odmr11"')
    WHERE XMLExists('declare default element namespace "http://xmlns.oracle.com/odmr11";
      $p/WorkflowProcess' PASSING x.WORKFLOW_DATA AS "p");
    COMMIT;
    dbms_output.put_line('Migrated workflows version have been updated to version 11.2.1.1.1');
  END IF;
EXCEPTION WHEN OTHERS THEN
  ROLLBACK;
  dbms_output.put_line('Migrated workflows version update failed: '||DBMS_UTILITY.FORMAT_ERROR_STACK());
  RAISE_APPLICATION_ERROR(-20000, 'Migrated workflows version update failed. Review install log.');
END;
/

EXECUTE dbms_output.put_line('End Data Miner XML Schema migration from 11.2.0.1.9 to 11.2.1.1.1');
