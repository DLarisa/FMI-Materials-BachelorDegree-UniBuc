#!/bin/sh
if test -f ./headless
then
./headless -J-Dide.runner.class=oracle.dbtools.proformatter.FormatCmdRunner "$@" currentDirectory="`pwd`"
else
headless -J-Dide.runner.class=oracle.dbtools.proformatter.FormatCmdRunner  "$@" currentDirectory="`pwd`"
fi
