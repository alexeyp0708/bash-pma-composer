##!/bin/bash

source "$(dirname $(readlink -f "$BASH_SOURCE"))/_interface.sh"

# Description commands and options 
# print - text
help(){
  _fail
}
# arg $@: [...options] [...commands] . Example -o --long_option -v "value" --value "value"  command subcommand  
# print: [...valid_options] -- [...valid_commands]. Example -o --long_option -v "value" --value "value" -- command subcommand  
validateOptions(){
  _fail
}