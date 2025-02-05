##!/bin/bash
source "$(dirname $(readlink -f "$BASH_SOURCE"))/../../_config.sh"

PROVIDER_SCRIPT="$(dirname $(readlink -f "$BASH_SOURCE"))/providers/_test.sh"
RULES_SCRIPT="$(dirname $(readlink -f "$BASH_SOURCE"))/rules.sh"
RUN_LIB_SCRIPT="$(dirname $(readlink -f "$BASH_SOURCE"))/run-lib.sh"
LIB_DIR="$(dirname $(readlink -f "$BASH_SOURCE"))/library"
OS="test"