##!/bin/bash

_interface_fail(){
  printf '%s\n' "There is no implementation of the method [${OS}] [${FUNCNAME[1]}] [$(readlink -f "$0")]" >&2
  exit 1
}

