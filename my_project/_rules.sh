#!/bin/bash
_rules (){
  #source "$(dirname $(readlink -f "$BASH_SOURCE"))/interfaces/_rules_interface.sh"
  help(){
    cat <<eof
  composer [-y | -f | -q | -v] command [...apps]
  Options:
  [-y] - Automatic yes to prompts. 
  [-f] - Execute forcibly
  [-q] - Quiet. Produces output suitable for logging, omitting progress indicators. 
  [-v] - Verbose. Print more information
  Command:
  [ help ] - Description of commands
  [ init ] - Initialization. To initialize other default distribution scripts
  [ install ] - Installing applications
  [ uninstall ] - Uninstall applications
  [ purge ] - Uninstall applications and all its settings
  [ update ] - Synchronize package sources
  [ upgrade ] - Update the application
eof
  }
      
  validateOptions(){
      local name="${FUNCNAME[1]}"
      local optstring="$(getopt -n $name  -o yfqv  -- "$@")"
      echo "$optstring"
  }
  
  "$@"
}





