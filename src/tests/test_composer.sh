#!/bin/bash
test_composer_script="$(readlink -f "$BASH_SOURCE")"
test_composer_script_path="$(dirname $test_composer_script)"
composer="$test_composer_script_path/fixtures/composer.sh"

[ "$($composer "test_method" "test" "test2")" == "test" ] || echo "execute and _external_execute functions fail [$test_composer_script][$LINENO]"
[ "$($composer "test_method" "app")" == "test_method_app" ] || echo "execute and _internal_execute function fail [$test_composer_script][$LINENO]"
[ "$($composer "test_method" "app" "app2")" == "$(echo -e "test_method_app\ntest_method_app2")" ] || echo "execute and _internal_execute function fail [$test_composer_script][$LINENO]"
[ "$($composer "test_optionsNoVal" -y -v test test2)" == " --y --v test test2" ] || echo "execute and _internal_execute function fail [$test_composer_script][$LINENO]"
[ "$($composer "test_optionsNoVal" -y -v app app2)" == "$(echo -e "test_optionsNoVal_app -y -v\ntest_optionsNoVal_app2 -y -v")" ] || echo "execute and _internal_execute function fail [$test_composer_script][$LINENO]"
[ "$($composer "test_run_composer" app)" == "hello" ] || echo "execute and _internal_execute function fail [$test_composer_script][$LINENO]"
