#!/bin/bash
test_script_path=$(dirname $(readlink -f "$BASH_SOURCE"))
#WARN: When using the source < (...script text) syntax, the $BASH_SOURCE variable in script text will not point to the correct path.
#source <(cat "$test_script_path/../../ifOSThenRun.sh" | sed '$d')
source "$test_script_path/../../_ifOSThenRun.sh"
os='test'
distr_file="$test_script_path/distr/no_file.sh"
if [ "$1" == "test2" ]
then 
  os='test2'
  distr_file="$test_script_path/distr/_test.sh"
fi  
run "$@"