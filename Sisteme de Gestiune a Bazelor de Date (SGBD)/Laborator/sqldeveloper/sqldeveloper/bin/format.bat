@echo off
headless  -J-Dide.runner.class=oracle.dbtools.proformatter.FormatCmdRunner %* currentDirectory="'%CD%'"
