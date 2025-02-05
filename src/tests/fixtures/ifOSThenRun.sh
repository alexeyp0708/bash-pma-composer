#!/bin/bash

#WARN: When using the source < (...script text) syntax, the $BASH_SOURCE variable in script text will not point to the correct path.
source <(cat "$(dirname $(readlink -f "$0"))/../../ifOSThenRun.sh" | sed '$d')
#source "./../../ifOSThenRun.sh"
if [ "$1" == "test" ]
then
  PROVIDER_SCRIPT="./provider/no_file.sh"
fi  
if [ "$1" == "test2" ]
then 
  OS='test2'
fi  
run "$@"