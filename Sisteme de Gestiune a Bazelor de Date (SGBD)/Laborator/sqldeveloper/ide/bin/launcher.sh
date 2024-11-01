 #!/bin/bash

#=============================================================================
#  Oracle IDE Application Launch Script
# Copyright (c) 2005, 2011, Oracle and/or its affiliates. All rights reserved. 
#
#  This script is not invoked directly.  Instead, it is sourced
#  (via ". launcher.sh") from a product-specific script that defines
#  variables and overrides functions to provide product-specific
#  information.
#
#  The following variables must be defined when launcher.sh is sourced:
#  -  STARTING_CWD should point to the working directory at the time
#     of script invocation.  This is not necessarily the directory
#     containing the script.
#  -  INVOKED_AS should be the absolute path of the outermost script
#     or symlink that ultimately sources launcher.sh.
#  -  SCRIPT should be the absolute path of the actual product-specific
#     script file, after all symlinks are resolved.
#
#  The .conf file is located using the following algorithm,
#  1) Check if there is a .conf file in the same directory as
#     INVOKED_AS with the same basename as INVOKED_AS.  If it exists,
#     use it.  Otherwise,
#  2) Check if there is a .conf file in the same directory as
#     SCRIPT with the same basename as SCRIPT.  If it exists, use it.
#     Otherwise,
#  3) Error out, reporting that no .conf file could be found.
#
#  If a .conf file is found, launcher.sh cd's into the .conf file's
#  directory before proceeding.
#
#  The following functions may be overridden in the product-specific
#  script (i.e. after sourcing launcher.sh) to provide product-specific
#  information:
#  -  GetFullProductName(), which is used in the launch banner text.
#  -  GetShortProductName(), which is used in prompt, warning, and
#     error messages shown to the user.
#  -  ShowExtraHelp(), which should echo additional help text to the
#     console.  This will be displayed when the -help or --help option
#     is passed to the launcher.
#  -  GetDotJdkFileName(), which is the file in the user's home directory
#     that stores the path to the JDK or JRE used for the product.
#  -  ShowHelp(), if the derived script wants to emit its own help
#  -  ProductHandlesHelp(), return 1 if the product spawned by the 
#     derived script handles help, ShowHelp() will not be called in
#     that case.
#  -  ProductHandlesVerbose(), return 1 if the product spawned by the 
#     derived script handles -verbose, SetVerbose() will not be called in
#     that case.
#  -  DisplayBanner(), if the derived script wants to emit its own banner
#  -  ProductDisplaysBanner(), return 1 if the product spawned by the 
#     derived script displays the banner, DisplayBanner() will not be called
#     in that case.
#
#  For the typical usage of launcher.sh, see product-launcher.template
#  or one of the actual product launchers (e.g. OH/jdev/bin/jdev).
#=============================================================================


#-----------------------------------------------------------------------------
#  Functions that the product-specific launcher may override.  See
#  description above for details.
#-----------------------------------------------------------------------------
GetFullProductName()
{
    echo "Oracle IDE Application"
}

GetShortProductName()
{
    echo "IDE"
}

ShowExtraHelp()
{
    # NOP.  Product-specific launcher can override to add extra help text.
    echo ""
}

# Override and return 1 if product displays the banner
ProductDisplaysBanner()
{
  if [ "X$PRODUCT_DISPLAYS_BANNER" = "X" ]
  then
    return 0
  fi
  return $PRODUCT_DISPLAYS_BANNER
}

DisplayBanner()
{
    cat <<EOF

`GetFullProductName`
 Copyright (c) 1997, 2011, Oracle and/or its affiliates. All rights reserved. 

EOF
}

# Override and return 1 if product handles any help options
ProductHandlesHelp()
{
  if [ "X$PRODUCT_HANDLES_HELP" = "X" ]
  then
    return 0
  fi
  return $PRODUCT_HANDLES_HELP
}

ShowHelp()
{
    cat <<EOF
Commands:

The following commands must appear first:
-verbose               Show java command line options
-conf[igure] <fname>   Use the specified configuration file

The following commands must appear last:
-classic               Use Classic as the Java VM
-hotspot               Use Hotspot client as the Java VM
-server                Use Hotspot server as the Java VM
-client                Use Hotspot client as the Java VM
--<directive>=<value>  Override a directive from the configuration file
-J<flag>               Pass <flag> directly to the runtime system
-migrate               Migrate user settings from a previous installation
EOF
    ShowExtraHelp
}

# Override and return 1 if product handles the -verbose options
ProductHandlesVerbose()
{
  if [ "X$PRODUCT_HANDLES_VERBOSE" = "X" ]
  then
    return 0
  fi
  return $PRODUCT_HANDLES_VERBOSE
}

GetDotJdkFileName()
{
  echo ".`basename "${INVOKED_AS}"`_jdk" 
}



#=============================================================================
#
#  Internal implementation beyond this point - do not override
#
#=============================================================================

#-----------------------------------------------------------------------------
# IncludeConfFile: conf file directive
# Args:
#   1) file name of another conf file to include
#
# A .conf file can specify that it includes another .conf file.  This
# allows common configuration to be shared across IDE products.  Currently,
# this directive can only only be used to include .conf files in the
# same directory as the including .conf file.
#-----------------------------------------------------------------------------
IncludeConfFile()
{
  if ( [ -f "$1" ] )
  then
    . $1
  else
        echo "Unable to find configuration file: $1"
  fi
}

#-----------------------------------------------------------------------------
# SetJavaHome: conf file directive
#-----------------------------------------------------------------------------
SetJavaHome()
{
  APP_JAVA_HOME="$1"
}

#-----------------------------------------------------------------------------
# SetJavaVM: conf file directive
#-----------------------------------------------------------------------------
SetJavaVM() 
{
  APP_JAVA_VM="$1"
}

#-----------------------------------------------------------------------------
# SetDebug: subroutine for setting up jdev to run as a debuggee for a
#           remote debugger.
#-----------------------------------------------------------------------------

SetDebug()
{
  case $APP_JAVA_VM in 
    ojvm)
      EchoIfVerbose "Debugging with -ojvm"
      AddVMOption "-XXdebug"
    ;;
    *)
      EchoIfVerbose "Debugging with -client"
      AddVMOption "-agentlib:jdwp=transport=dt_socket,server=y,address=4000"

      # FYI, Hotspot ignores ctl-C while listening for a connection.
      # If you decide you don't want to attach a debugger, then you'll
      # have to manually kill this process using ps and kill.
      # Alternatively, in a separate terminal, you can
      # "telnet localhost 4000" and that will cause hotspot to exit
      # with a handshake timeout. (acyu 03/08/2006)
    ;;
  esac
}

SetCPUProfile()
{
  my_version=$1

  if [ "X$ORACLE_HOME" = "X" ]
  then
    if [ "X$ADE_VIEW_ROOT" = "X" ]
    then
      echo "-cpuprofile$myversion requires that ORACLE_HOME is set"
      exit
    else
      ORACLE_HOME=$ADE_VIEW_ROOT/oracle
    fi
  fi

  if [ ! -f $ORACLE_HOME/jdev/lib/profiler-agent.jar ]
  then
    echo "Cannot start with -cpuprofile$my_version. ORACLE_HOME must point to"
    echo "JDeveloper installation containing profiler-agent.jar. It was not"
    echo "found in $ORACLE_HOME/jdev/lib."
    exit
  fi

  SetJavaVM server
  EchoIfVerbose "Profiling with -server for JDK $my_version..."
  AddVMOption "-agentpath:$ORACLE_HOME/jdev/lib/profiler1$my_version.so=port=4000,jarpath=$ORACLE_HOME/jdev/lib/profiler-agent.jar,enable=t,refpath=/tmp,startup=connect"
}

SetMemProfile()
{
  my_version=$1

  if [ "X$ORACLE_HOME" = "X" ]
  then
    if [ "X$ADE_VIEW_ROOT" = "X" ]
    then
      echo "-memprofile$myversion requires that ORACLE_HOME is set"
      exit
    else
      ORACLE_HOME=$ADE_VIEW_ROOT/oracle
    fi
  fi

  if [ ! -f $ORACLE_HOME/jdev/lib/profiler-agent.jar ]
  then
    echo "Cannot start with -cpuprofile$my_version. ORACLE_HOME must point to"
    echo "JDeveloper installation containing profiler-agent.jar. It was not"
    echo "found in $ORACLE_HOME/jdev/lib."
    exit
  fi

  SetJavaVM server
  EchoIfVerbose "Profiling with -server for JDK $my_version..."
  AddVMOption "-agentpath:$ORACLE_HOME/jdev/lib/profiler1$my_version.so=port=4000,jarpath=$ORACLE_HOME/jdev/lib/profiler-agent.jar,enable=t,refpath=/tmp,startup=connect,mem"
}


#-----------------------------------------------------------------------------
# AddVMOption: conf file directive
# Args:
#   1) command-line option to include when invoking the JVM
#-----------------------------------------------------------------------------
AddVMOption()
{
  APP_VM_OPTS[${#APP_VM_OPTS[*]}]="$*"
}

#-----------------------------------------------------------------------------
# AddJavaLibFile: conf file directive
# Args:
#   1) pathname of jar/zip file or directory to add to the application
#      classpath
#-----------------------------------------------------------------------------
AddJavaLibFile()
{
  if ( [ -f $1 ] || [ -d $1 ] )
  then
    if [ "X$APP_CLASSPATH" = "X" ]
    then
      APP_CLASSPATH=$1
    else
      APP_CLASSPATH=${APP_CLASSPATH}:$1
    fi
  fi
}

#-----------------------------------------------------------------------------
# SetMainClass: conf file directive
#-----------------------------------------------------------------------------
SetMainClass() 
{
  APP_MAIN_CLASS="$1"
}

#-----------------------------------------------------------------------------
# SetSkipJ2SDKCheck: conf file directive
#-----------------------------------------------------------------------------
SetSkipJ2SDKCheck()
{
  APP_SKIP_J2SE_TEST=$1
}

#-----------------------------------------------------------------------------
#  implementation details
#-----------------------------------------------------------------------------
EchoIfVerbose()
{
  if [ "X${APP_VERBOSE_MODE}" != "X" ]
  then
    echo "$@"
  fi
}

AddAppOption()
{
  APP_APP_OPTS[${#APP_APP_OPTS[*]}]="$*"
}

SetVerbose()
{
  APP_VERBOSE_MODE="true"
}

GetDefaultJDK()
{
  #
  # Search for Java in the following order:
  #  0) $OIDE_JAVA_HOME. This serves as a global override.
  #  1) ../../jdk/bin/java. This is consistent with the shipped
  #     location of Java for Windows, and is the correct place to look
  #     for internal developers building labels of JDEVADF.
  #  2) ../../../jdk/bin/java for SQL Developer in the database shiphome.
  #  3) $JAVA_HOME/bin/java. If JAVA_HOME is set, we should use that
  #     to determine the JDK to use.
  #  4) A java in /usr/java/jdk6*
  #  5) Any java on the PATH.

  # We check environment variables are set before using them.

  if [[ -n "$OIDE_JAVA_HOME" && -f "$OIDE_JAVA_HOME/bin/java" ]]
  then
    tmpvar="$OIDE_JAVA_HOME/bin/java"
  else
    if [ -f "../../jdk/bin/java" ]
    then
      tmpvar="../../jdk/bin/java"
    else
      if [ -f "../../../jdk/bin/java" ]
      then
        tmpvar="../../../jdk/bin/java"
      else
        if [[ -n "$JAVA_HOME" &&  -f "$JAVA_HOME/bin/java" ]]
        then
          tmpvar="$JAVA_HOME/bin/java"
        else
          # See if we can find /usr/java/jdk6*
          jdk=`ls /usr/java 2>/dev/null | grep jdk6 | sort -r | head -1`
          if [ -f "/usr/java/$jdk/bin/java" ]
          then
            tmpvar="/usr/java/$jdk/bin/java"
          else
            tmpvar=`which "java" 2>/dev/null`
          fi
        fi
      fi
    fi
  fi

  #
  # Make sure java is not
  # a symlink to some other bin/java location somewhere, if it is
  # follow it, and follow it as long as the new path ends with /bin/java
  #
  # Once the new path for java has been determined, truncate the /bin/java
  # ending portion of it and set javahome with the trucated path
  #
  if [ -f "$tmpvar" ]
  then
    while [ -h "$tmpvar" ]
    do
        tmpvar2=`ls -ls "$tmpvar"`
        tmpvar2=`expr "$tmpvar2" : '.*-> \(.*\)$'`
        if [ `expr "$tmpvar2" : "\.\/"` -gt 0 -o `expr "$tmpvar2" : "\.\.\/"` -gt 0 -o `expr "$tmpvar2" : ".*/.*"` -le 0 ]
        then
          tmpvar="`dirname "$tmpvar"`/$tmpvar2"
        else
          tmpvar="$tmpvar2"
        fi
    done
    tmpvar=`expr "$tmpvar" : '\(.*\)\/bin\/[^\/]*$'`
    SetJavaHome "$tmpvar"
  fi
}

CheckJavaHome()
{
  if [ "X$APP_JAVA_HOME" != "X" ]; then
    if [ "X$APP_SKIP_J2SE_TEST" != "X" ]; then
      [ -f "${APP_JAVA_HOME}/bin/java" ] && return 1
    else
      [ -f "${APP_JAVA_HOME}/bin/java" ] &&
      [ -f "${APP_JAVA_HOME}/jre/bin/java" ] && return 1
    fi
  fi
  return 0
}

CheckJDK()
{
  # if ide home is not defined then try to define it using
  # the first found java command on the path
  if [ "X$APP_JAVA_HOME" = "X" ] || CheckJavaHome
  then
    GetDefaultJDK
  fi

  # if java wasn't found on the path then ask the user for it
  if CheckJavaHome
  then
    local DOT_JDK_FILE_NAME=`GetDotJdkFileName`
    APP_JAVA_HOME=""
    if [ -f "$HOME/$DOT_JDK_FILE_NAME" ]
    then
      APP_JAVA_HOME=`cat < "$HOME/$DOT_JDK_FILE_NAME"`
    fi
    if [ "X$APP_JAVA_HOME" != "X" ]
    then
      if [ ! -d ${APP_JAVA_HOME} ]
      then
        APP_JAVA_HOME=""
      fi
        fi
    while [ "X$APP_JAVA_HOME" = "X" ]
    do
      echo "Type the full pathname of a J2SE installation (or Ctrl-C to quit), the path will be stored in ~/$DOT_JDK_FILE_NAME"
      read APP_JAVA_HOME
      if [ -f "${APP_JAVA_HOME}/bin/java" ]
      then
                echo ${APP_JAVA_HOME} > "$HOME/$DOT_JDK_FILE_NAME"
        break
      fi
      echo "Error: ${APP_JAVA_HOME}/bin/java not found"
      APP_JAVA_HOME=""
    done
  fi

  APP_JAVA_EXE="${APP_JAVA_HOME}/bin/java"
  if [ -f ${APP_JAVA_EXE} ]
  then
    if ( [ -f "${APP_JAVA_HOME}/jre/bin/java" ] || [ "X${APP_SKIP_J2SE_TEST}" != "X" ] )
    then
      # Uncomment the following two lines to run with -ojvm by default
      #[ "X$APP_JAVA_VM" = "X" -a -d "${APP_JAVA_HOME}/jre/lib/i386/ojvm" ] &&
      #  APP_JAVA_VM="ojvm";
      if [ "X$APP_JAVA_VM" = "X" ]
      then
        JAVA="${APP_JAVA_HOME}/bin/java "
      else
        JAVA="${APP_JAVA_HOME}/bin/java -${APP_JAVA_VM} "
      fi
    else
      echo "Error: Java home ${APP_JAVA_EXE} is not a J2SE SDK."
      echo "Running `GetShortProductName` under a JRE is not supported."
      echo ""
      echo "If the Java VM specified by the SetJavaHome is actually a full J2SDK installation"
      echo "then add 'SetSkipJ2SDKCheck true' to ${APP_CONF_FILE}"
      echo ""
      JAVA=""
      exit 1;
    fi
  else
    echo "Error: No JDK found on PATH"
    echo "Please correct the SetJavaHome directive or add the directive"
    echo "in ${APP_CONF_FILE} or"
    echo "${APP_PLATFORM_CONF_FILE}"
    echo "to point to the JDK installation."
    echo ""
    JAVA=""
    exit 1;
  fi
}



CheckLibraryPath()
{
        #echo "Value of ORACLE_HOME is $ORACLE_HOME"
        #echo "Value of LD_LIBRARY_PATH is $LD_LIBRARY_PATH"

        if [ "X$ORACLE_HOME" = "X" ]
        then
                return
        fi

        if [ `uname -s` = 'HP-UX' ]
        then
                if [ "X$SHLIB_PATH" = "X" ]
                then
                        SHLIB_PATH=$ORACLE_HOME/lib
                else
                        echo $SHLIB_PATH | egrep -e "(^|\:)$ORACLE_HOME/lib($|\:)" > /dev/null
                        if [ $? != 0 ]
                        then
                                SHLIB_PATH=$SHLIB_PATH:$ORACLE_HOME/lib
                        fi
                fi
                export SHLIB_PATH
                #echo $SHLIB_PATH
        else
                if [ "X$LD_LIBRARY_PATH" = "X" ]
                then
                        LD_LIBRARY_PATH=$ORACLE_HOME/lib
                else
                        echo $LD_LIBRARY_PATH | egrep -e "(^|\:)$ORACLE_HOME/lib($|\:)" > /dev/null
                        if [ $? != 0 ]
                        then
                                LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME/lib
                        fi
                fi
                export LD_LIBRARY_PATH
                #echo $LD_LIBRARY_PATH
        fi
}

#  This method should be called from the product-specific launcher to
#  do the .conf file processing and launch the IDE.
LaunchIDE()
{
    LaunchIDE_called=true
    readonly LaunchIDE_called

    #:ValidateArgs:
    {
        if [ "X${STARTING_CWD}" = "X" ]
        then
            echo "ERROR: STARTING_CWD variable not defined."
            exit 1
        fi
        if [ "X${INVOKED_AS}" = "X" ]
        then
            echo "ERROR: INVOKED_AS variable not defined."
            exit 2
        fi
        if [ "X${SCRIPT}" = "X" ]
        then
            echo "ERROR: SCRIPT variable not defined."
            exit 3
        fi
    }
    ProductDisplaysBanner
    HandlesBanner=$?
    if [ "$HandlesBanner" = "0" ]
    then
      DisplayBanner
    fi

    #:SetConfigFiles:
    {
        #  Check INVOKED_AS first.  This allows a launcher to be a
        #  symlink to launch.sh but use its own conf file.
        local invokedDir=`dirname "${INVOKED_AS}"`
        local invokedProdName=`basename "${INVOKED_AS}"`
        local confFile="${invokedDir}/${invokedProdName}.conf"
        if [ -f "${confFile}" ]
        then
            PRODUCT_NAME="${invokedProdName}"
            APP_CONF_DIR="${invokedDir}"
            APP_CONF_FILE="${confFile}"
            cd "${APP_CONF_DIR}"
        else
            #  Check SCRIPT next.  This allows the user to make a
            #  symlink to the launcher script and use its conf file.
            local scriptDir=`dirname "${SCRIPT}"`
            PRODUCT_NAME=`basename "${SCRIPT}"`
            confFile="${scriptDir}/${PRODUCT_NAME}.conf"
            if [ -f "${confFile}" ]
            then
                APP_CONF_DIR="${scriptDir}"
                APP_CONF_FILE="${confFile}"
                cd "${APP_CONF_DIR}"
            fi
        fi

        # Set platform configuration file.
        APP_UNAME_VALUE=`uname`
        APP_PLATFORM_CONF_FILE="${PRODUCT_NAME}-${APP_UNAME_VALUE}.conf"
        if [ -f "${APP_PLATFORM_CONF_FILE}" ]
        then
            APP_PLATFORM_CONF_FILE="${APP_CONF_DIR}/${PRODUCT_NAME}-${APP_UNAME_VALUE}.conf"
        fi
    }

    #:PreProcessArgs:
    {
      while [ $# -gt 0 ]
      do
        case $1 in 
          -conf | -configure)
            if [ $# -gt 1 ]
            then
              #:SetConfFile:
              {
                case $2 in 
                  /*)
                    # Absolute path
                    APP_CONF_FILE="$2"
                  ;;
                  *)
                    # Relative path
                    if [ "$STARTING_CWD" = "" ]
                    then
                      APP_CONF_FILE="$2";
                    else
                      APP_CONF_FILE="$STARTING_CWD/$2"
                    fi
                  ;;
                esac
              }
              shift
            fi
          ;;
          -help | --help)
          {
            ProductHandlesHelp
            HandlesHelp=$?
            if [ "$HandlesHelp" = "0" ]
            then
              ShowHelp
              exit 0;
            else
              break
            fi
          }
          ;;
          -verbose)
          {
            ProductHandlesVerbose
            HandlesVerbose=$?
            if [ "$HandlesVerbose" = "0" ]
            then
              SetVerbose
            else
              break
            fi
          }
          ;;
          --verbose)
            SetVerbose
          ;;
          *)
            break
          ;;
        esac
        shift
      done
    }

    #:Startup:
    {
      APP_MAIN_CLASS="oracle.ide.boot.Launcher"
    }

    #:ReadConfig:
    {
      if [ -f "${APP_CONF_FILE}" ]
      then
        EchoIfVerbose "Reading configuration from: ${APP_CONF_FILE}"
        . "${APP_CONF_FILE}"
      else
        echo "Unable to find configuration file: ${APP_CONF_FILE}"
        exit 1
      fi
    
      if [ -f "${APP_PLATFORM_CONF_FILE}" ]
      then
        EchoIfVerbose "Reading platform specific configuration from: ${APP_PLATFORM_CONF_FILE}"
        . "${APP_PLATFORM_CONF_FILE}"
      fi
    }

    #:ProcessArgs:
    {
      while [ $# -gt 0 ]
      do
        case $1 in 
          --*)
            NEWARG=`echo $1 | sed -e s/--//g`
            NEWOPD=`expr "$NEWARG" : '[^\=]*\=\(.*\)'`
            NEWARG=`expr "$NEWARG" : '\([^\=]*\)\=.*'`
            NEWARG=`echo $NEWARG | tr "[:upper:]" "[:lower:]"`
            case $NEWARG in
              setjavahome)         NEWARG="SetJavaHome" ;;
              setjavavm)           NEWARG="SetJavaVM" ;;
              addvmoption)         NEWARG="AddVMOption" ;;
              addjavalibfile)      NEWARG="AddJavaLibFile" ;;
              setmainclass)        NEWARG="SetMainClass" ;;
              setskipj2sdkcheck)   NEWARG="SetSkipJ2SDKCheck" ;;
            esac
            ${NEWARG} "$NEWOPD"
            EchoIfVerbose "* Added ${NEWARG}"
          ;;
          -J*)
            NEWARG=`echo $1 | sed -e s/-J//g`
            AddVMOption ${NEWARG}
            EchoIfVerbose "* Added VM Option ${NEWARG}"
          ;;
          -debug)
            SetDebug
          ;;
          -uidebug)
            AddJavaLibFile ../lib/jdev-remote.jar
            SetDebug
            AddAppOption $1
            EchoIfVerbose "* Added Application Option $1"
          ;;
          -cpuprofile)
            SetCPUProfile 5
          ;;
          -cpuprofile6)
            SetCPUProfile 6
          ;;
          -cpuprofile5)
            SetCPUProfile 5
          ;;
          -memprofile)
            SetMemProfile 5
          ;;
          -memprofile6)
            SetMemProfile 6
          ;;
          -memprofile5)
            SetMemProfile 5
          ;;
          -classic)
            NEWARG=`echo $1 | sed -e s/-//g`
            SetJavaVM ${NEWARG}
          ;;
          -hotspot)
            NEWARG=`echo $1 | sed -e s/-//g`
            SetJavaVM ${NEWARG}
          ;;
          -client)
            NEWARG=`echo $1 | sed -e s/-//g`
            SetJavaVM ${NEWARG}
          ;;
          -server)
            NEWARG=`echo $1 | sed -e s/-//g`
            SetJavaVM ${NEWARG}
          ;;
          -ojvm)
            NEWARG=`echo $1 | sed -e s/-//g`
            SetJavaVM ${NEWARG}
          ;;
          -conf | -configure)
            if [ $# -gt 1 ]
            then
              # Extra shift
              shift
            fi
          ;;
          -verbose)
          {
            ProductHandlesVerbose
            HandlesVerbose=$?
            if [ "$HandlesVerbose" != "0" ]
            then
              AddAppOption $1
              EchoIfVerbose "* Added Application Option $1"
            fi
          }
          ;;
          --verbose)
            # Skip. Handled in PreProcessArgs
          ;;
          *)
            AddAppOption $1
            EchoIfVerbose "* Added Application Option $1"
          ;;
        esac
        shift
      done
    }

    # Pass the configuration pathname to the IDE
    AddVMOption -Dide.conf=\"${APP_CONF_FILE}\"

    # Pass the starting directory (before any chdir) to the IDE
    AddVMOption -Dide.startingcwd=\"${STARTING_CWD}\"

    CheckJDK
    CheckLibraryPath

    EchoIfVerbose "Working directory is `pwd`"
    EchoIfVerbose "Running Command: ${JAVA} ${APP_VM_OPTS} ${APP_ENV_VARS} -classpath ${APP_CLASSPATH} ${APP_MAIN_CLASS} ${APP_APP_OPTS[@]}"

    ${JAVA} "${APP_VM_OPTS[@]}" ${APP_ENV_VARS} -classpath ${APP_CLASSPATH} ${APP_MAIN_CLASS} "${APP_APP_OPTS[@]}"
    EXITCODE=$?

    # In case java returns with an exit code greater than 0, make sure
    # that we are running with an recognizable JDK version and that we
    # are running with at least 1.4.x
    if [ $EXITCODE -gt 0 ]
    then
            s=`${JAVA} -version 2>&1`
            if [ `expr "$s" : 'java version \"1\.[0-3]'` -gt 0 ]
            then
                    echo "Error: `GetShortProductName` doesn't run with JDK version prior to 1.4.x" 
            fi
            if [ `expr "$s" : 'java version \"1\.[0-6].*\"'` -le 0 ]
            then
                    echo "Error: `GetShortProductName` can't recognize the JDK version"
            fi
    fi
    return $EXITCODE
}
