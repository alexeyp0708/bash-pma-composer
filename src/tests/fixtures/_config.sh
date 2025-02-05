##!/bin/bash
source "$(dirname $(readlink -f "$BASH_SOURCE"))/../../_config.sh"

ADAPTER_SCRIPT="$(dirname $(readlink -f "$BASH_SOURCE"))/adapters/_test.sh"
RULES_SCRIPT="$(dirname $(readlink -f "$BASH_SOURCE"))/_rules.sh"
#RUN_LIB_SCRIPT="$(dirname $(readlink -f "$BASH_SOURCE"))/run-lib.sh"
LIB_DIR="$(dirname $(readlink -f "$BASH_SOURCE"))/library"
OS="test"