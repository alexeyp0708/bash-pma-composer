#!/bin/bash

test_composer_script_path=$(dirname $(readlink -f "$BASH_SOURCE"))
source "$test_composer_script_path/../../_composer.sh"
distr_file="${test_composer_script_path}/distr/_test.sh"
test_method_app(){
  echo "test_method_app"
}
test_method_app2(){
  echo "test_method_app2"
}
test_optionsNoVal_app(){
  echo "test_optionsNoVal_app $@"
}
test_optionsNoVal_app2(){
  echo "test_optionsNoVal_app2 $@"
}

execute "$@"
