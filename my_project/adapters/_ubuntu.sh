##!/bin/bash
source "$(dirname $(readlink -f "$BASH_SOURCE"))/../interfaces/_os_interface.sh"

#Implement the interface methods _os_interface.sh
install (){
  echo "=>$@->$opt_str"  
}

local opt_str=
initOptions(){
  opt_str="$@"
}
#Create your own adapter script for each OS
