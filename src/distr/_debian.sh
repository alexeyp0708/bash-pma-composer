##!/bin/bash
source "$(dirname $(readlink -f "$BASH_SOURCE"))/../interfaces/_os_interface.sh"
local optstring
initOptions(){
  local optsNoVal optsVal
  local options="$(getopt -n _debian -o yfqv  -- "$@")"
  eval set -- "$options"
  while true
  do 
    case "$1" in
    --) shift ; break ;;
    -f) optsNoVal="$optsNoVal --force-yes";;
    -v) optsNoVal="$optsNoVal -V";;
    -b);;
    *) optsNoVal="$optsNoVal -$1" ;;
    esac
    shift
  done
  optstring="$optsNoVal $optsVal"
}
init (){
  apt-get update && apt-get upgrade
  apt-get -y install sudo
}
install(){
  apt-get  install $optstring "$@"
}
uninstall(){
  apt-get $optstring remove "$@"
}
purge(){
  apt-get $optstring purge "$@"
}
update(){
  apt-get $optstring update
}
upgrade(){
  apt-get $optstring update 
  apt-get $optstring upgrade "$@"
}

