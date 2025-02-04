#!/bin/bash

this2_script_path=$(dirname $(readlink -f "$BASH_SOURCE"))
source "${this2_script_path}/_ifOSThenRun.sh"
run "$@"