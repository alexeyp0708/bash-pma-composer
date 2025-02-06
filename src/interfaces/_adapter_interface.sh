##!/bin/bash

source "$(dirname $(readlink -f "$BASH_SOURCE"))/_interface.sh"
# Initializing formatted options adapter
# args $@ - raw options
# no print
initOptions(){
  _interface_fail 
}

#formatting raw options to adapter options
# args $@ - raw options 
# print - new options
formatOptions(){
   _interface_fail 
}

execute(){
  "_interface_fail@"
}

