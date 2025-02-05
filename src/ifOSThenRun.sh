##!/bin/bash

source "$(dirname $(readlink -f "$0"))/_config.sh"

run(){
  local type="$1"
  shift
  if [ "$type" == "$OS" ]
  then
    if [ -e "$PROVIDER_SCRIPT" ];then source "$PROVIDER_SCRIPT"; fi
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
run "$@"