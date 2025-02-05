#!/bin/bash
# deprecated
source "$(dirname $(readlink -f "$0"))/_config.sh"

path="$LIB_DIR"

if [ -e "$path/_core.sh" ]
then
  source "$path/_core.sh"
fi

if [[ ! -z "$OS" && "$OS" != 'core' && -e "$path/_${OS}.sh" ]]
then
  source "$path/_${OS}.sh"
fi 

source <(cat "$(dirname $(readlink -f "$BASH_SOURCE"))/composer.sh" | sed '$d') 

check() {
  if [[ "$(type -t "$1")" == "function" ]]
  then
    echo "ok"
  else
    return 1
  fi
}
run (){
  local  action options params
  _spilt_options options params "$@"
  eval set -- "$params"
  for action in "$@"
  do
     $action $options
  done
}
"$@"

