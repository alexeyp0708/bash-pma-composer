##!/bin/bash
OS="$(cat "/etc/os-release"|grep -Po "(?<=^ID=).+$")"
PROVIDER_SCRIPT="$(dirname $(readlink -f "$BASH_SOURCE"))/providers/_${OS}.sh"
RULES_SCRIPT="$(dirname $(readlink -f "$BASH_SOURCE"))/rules.sh"
RUN_LIB_SCRIPT="$(dirname $(readlink -f "$BASH_SOURCE"))/run-lib.sh"
LIB_DIR="$(dirname $(readlink -f "$BASH_SOURCE"))/library"