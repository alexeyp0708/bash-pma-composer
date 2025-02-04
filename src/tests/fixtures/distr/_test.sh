##!/bin/bash
source "$(dirname $(readlink -f "$BASH_SOURCE"))/../../../interfaces/_os_interface.sh"
local optsNoVal
initOptions(){
  local options="$(getopt -n _test -o yfgv  -- "$@")"
  eval set -- "$options"
  while true
  do 
    case "$1" in
    --) shift ; break ;;
    *) optsNoVal="$optsNoVal -$1" ;;
    esac
    shift
  done
}
test_method(){
  echo "$1" 
}
test_optionsNoVal(){
  echo "$optsNoVal $@" 
}

execute(){
  "$@ bay"
}