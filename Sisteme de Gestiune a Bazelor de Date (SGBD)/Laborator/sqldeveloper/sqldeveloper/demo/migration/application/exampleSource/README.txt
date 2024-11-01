README for example source files.
---------------------------------

1. Folder Contents

1.1 Rules Files
  Test.java
  example1.asp
  example1.pl
  sample.sql
  sample1.c
  sample2.c
  script.ksh
  scriptnoext
  specialized.example

2. Overview
This folder contains a set of samples for the application
scanning functionality in SQL Developer.

You can now scan any type of text file.  The types of file
to be recognized need to be defined in the recognizer.xml.
By default we just recognize 'C' files.  The recognizer.xml
has several examples of other file types to choose from.

Each one of the source files have some code embedded in them
that is of interest to us.  For example, the sample1.c file 
has DBLIB calls.  The rules files will check this file for the
existence of an appropriate header file.  If it is not found,
then the file will not be scanned.

The specialized.example shows how you can define any type of
rules in xml and use them on your code.

3. Scanning instructions.

Migration -help=scan
	Get help on scanning files
Migration -actions=scan -dir=/code/myproject
	Scan a directory with the default rules in SQL Developer
Migration -actions=scan -dir=/code/myproject -log=/code/scanning.log
	Scan a directory with the default rules in SQL Developer
	and log the output to a file
Migration -actions=scan -dir=/code/myproject -rulesdir=/code/rules
	Scan a directory with the custom rules in SQL Developer
Migration -actions=scan -dir=/code/myproject -rulesdir=/code/rules -log=/code/scanning.log
	Scan a directory with the custom rules in SQL Developer
	and log the output to a file
