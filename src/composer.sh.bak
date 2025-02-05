#!/bin/bash

source "$(dirname $(readlink -f "$0"))/_config.sh"
_fail(){
  printf '%s\n' "Error: $1" >&2 
  exit ${2-1}
}
  
_check_help(){
  if [ "$(echo "$@" |grep -P -o "\-\- [']?help[']?(?:\s|$)")" ]
  then
   _rules help
   exit 0
  fi  
}

_rules(){
    local rules="$RULES_SCRIPT"
    $rules "$@"
}
# _spilt_options name_opts name_params ...optionsAndParams 
_spilt_options(){
    local -n optsVar="$1"
    local -n paramsVar="$2"
    shift 2
    optsVar="$(echo "$@"|grep -P -o '^.*(?= --)')"
    paramsVar="$(echo "$@"|grep -P -o '(?<=-- ).*$')"
}

_validate_options(){
  _rules validateOptions "$@"
}

_external_execute() {
  source "$ADAPTER_SCRIPT"
  local command  options params
  _spilt_options options params "$@"
  eval set -- "$params"
  command=$1
  shift
  if [ ! -z "$options" ] 
  then
     initOptions $options 
  fi
  $command "$@"
}

_check_action(){
    local actions="$RUN_LIB_SCRIPT";    
    $actions check "$1"
}

_internal_execute(){
  local actions="$RUN_LIB_SCRIPT";  
  $actions run "$@"
}

_internal_execute_bak(){
  local lib="$RUN_LIB_SCRIPT";
  local command method options params
  _spilt_options options params "$@"
  eval set -- "$params"
  for method in "$@"
  do
    $lib $method $options
  done
}

execute(){
  local command  options params internal external app
  local str_opts="$(_validate_options "$@")"
  _check_help "$str_opts"
  _spilt_options options params "$str_opts"
  eval set -- "$params"
  command=$1
  shift
  for app in "$@"
  do
    if [[ "$(_check_action ${command}_$app)" == "ok" ]]
    then
        internal="$internal ${command}_$app" 
    else
        external="$external $app"
    fi
  done
  
  if [[ ! -z "$external" || -z "$@" ]]
  then
    _external_execute $options -- $command $external
  fi
  if [ ! -z "$internal" ]
  then
    _internal_execute $options -- $internal
  fi
}
composer(){
   local str_opts="$(_validate_options "$@")"
  _check_help "$str_opts"
  _external_execute "$str_opts"
}

#WARN:There should be no  lines after the command.
execute "$@"