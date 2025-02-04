##!/bin/bash
this_script_path=$(dirname $(readlink -f "$BASH_SOURCE"))
os=$(cat "/etc/os-release"|grep -Po "(?<=^ID=).+$")
distr_file="${this_script_path}/distr/${os}.sh"
run(){
  local type="$1"
  shift
  if [ "$type" == "$os" ]
  then
    if [ -e "$distr_file" ];then source "$distr_file"; fi
    if [ "$(type -t "execute")" == "function" ]
    then
      execute "$@"
    else
      "$@"
    fi
  else
    return 1
  fi  
}