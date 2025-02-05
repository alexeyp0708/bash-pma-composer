#!/bin/bash
test_composer_script="$(readlink -f "$BASH_SOURCE")"
test_composer_script_path="$(dirname $test_composer_script)"
composer="$test_composer_script_path/fixtures/composer.sh"

$composer "test_method" "app"