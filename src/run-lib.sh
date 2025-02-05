#!/bin/bash

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
composer (){
  source <(cat "$(dirname $(readlink -f "$0"))/composer.sh" | sed '$d')
   local str_opts="$(_validate_options "$@")"
  _check_help "$str_opts"
  _external_execute "$str_opts"
}  
check() {
  if [[ "$(type -t "$1")" == "function" ]]
  then
    echo "ok"
  else
    return 1
  fi
}

"$@"