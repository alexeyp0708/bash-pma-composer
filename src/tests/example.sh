#!/bin/bash
test_script="$(readlink -f "$BASH_SOURCE")"
test_script_path="$(dirname $test_script)"
ifOSThenRun="$test_script_path/fixtures/ifOSThenRun.sh"

$ifOSThenRun test echo "hello"