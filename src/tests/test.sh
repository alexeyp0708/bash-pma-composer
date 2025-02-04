#!/bin/bash
test_script_path=$(dirname $(readlink -f "$BASH_SOURCE"))

$test_script_path/test_composer.sh
$test_script_path/test_ifOSThenRun.sh