##!/bin/bash
source "$(dirname $(readlink -f "$BASH_SOURCE"))/../interfaces/_os_interface.sh"
local optstring=' -i'

initOptions(){
  local optsNoVal optsVal
  local options="$(getopt -n _debian -o yfqv  -- "$@")"
  eval set -- "$options"
  while true
  do 
    case "$1" in
    -y) optsNoVal=$(echo $optstring|sed -E 's/(^|\s)-i(\s|$)/\2/'); optsNoVal="$optsNoVal --no-interactive";;
    --) shift ; break ;;
    *) optsNoVal="$optsNoVal -$1" ;;
    esac
    shift
  done
  optstring="$optsNoVal $optsVal"
}

init (){
  echo 
}
