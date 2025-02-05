##!/bin/bash

source "$(dirname $(readlink -f "$BASH_SOURCE"))/_interface.sh"

initOptions(){
  _fail 
}

execute(){
  "$@"
}

