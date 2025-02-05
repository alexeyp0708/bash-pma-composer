##!/bin/bash

source "$(dirname $(readlink -f "$BASH_SOURCE"))/_debian.sh"

init (){
  apt-get update && apt-get upgrade
}