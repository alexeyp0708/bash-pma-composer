##!/bin/bash

_fail(){
  printf '%s\n' "There is no implementation of the method [${OS}] [${FUNCNAME[1]}] [$0]" >&2
  exit 1
}

