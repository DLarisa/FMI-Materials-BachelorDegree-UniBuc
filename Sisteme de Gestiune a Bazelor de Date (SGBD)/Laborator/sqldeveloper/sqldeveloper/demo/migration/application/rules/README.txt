README for example rules and recognizers
----------------------------------------

1. Folder Contents

1.1 Rules Files
    asp.xml
    java.xml
    ksh.xml
    perl.xml
    sample.sql
    specialized.xml
    sql.xml
1.2 Recognizer Files
  recognizer.xml
1.3 Rules & Recognizer Schema
  scanner.xsd

2. Overview
This folder contains a set of samples for the application
scanning functionality in SQL Developer.

You can now scan any type of text file.  The types of file
to be recognized need to be defined in the recognizer.xml.
By default we just recognize 'C' files.  The recognizer.xml
has several examples of other file types to choose from.

Each of the other xml files are for rules of a particular type
These types correspond to the types defined in the recognizers.
There are two sections in a ruleset.  <required> and <rules>
The <required> element sets up a regular expression that is 
used on the file before scanning to find out if the file 
actually needs to be scanned.  If the expression in this fails
to find anything, the regular expressions in the rules elements 
will not be used for that file.

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
