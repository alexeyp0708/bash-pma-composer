##!/bin/bash

_fail(){
  printf '%s\n' "There is no implementation of the method [${os}] [${FUNCNAME[1]}] [$(readlink -f "$0")]" >&2
  exit 1
}

initOptions(){
  _fail 
}

execute(){
  "$@"
}

