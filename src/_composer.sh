##!/bin/bash

#The file is abstract and is designed to expand another file through "source"
#The expanding script should have functions starting from the prefix install_ or uninstall_


composer_script_path=$(dirname $(readlink -f "$BASH_SOURCE"))
os="$(cat "/etc/os-release"|grep -Po "(?<=^ID=).+$")"
distr_file="${composer_script_path}/distr/_${os}.sh"

_fail(){
  printf '%s\n' "Error: $1" >&2 
  exit ${2-1}
}
  
_check_help(){
  if [ "$(echo "$@" |grep -P -o "\-\- [']?help[']?(?:\s|$)")" ]
  then
   _required help
   exit 0
  fi  
}

_required(){
    local required="$(dirname $(readlink -f "$distr_file"))/required.sh"
    $required "$@"
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
  _required validateOptions "$@"
}

_external_execute() {
  source "$distr_file"
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

_internal_execute(){
  local command method options params
  _spilt_options options params "$@"
  eval set -- "$params"
  command=$1
  shift
  for app in "$@"
  do
    method=${command}_$app
    $method $options
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
    if [[ "$(type -t "${command}_$app")" == "function" ]]
    then
        internal="$internal $app" 
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
    _internal_execute $options -- $command $internal
  fi
}

composer (){
   local str_opts="$(_validate_options "$@")"
  _check_help "$str_opts"
  _external_execute "$str_opts"
}



