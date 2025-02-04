#!/bin/bash
test_script="$(readlink -f "$BASH_SOURCE")"
test_script_path="$(dirname $test_script)"
ifOSThenRun="$test_script_path/fixtures/ifOSThenRun.sh"
[ "$($ifOSThenRun test echo "hello")" == "hello" ] || echo "ifOSThenRun.sh script fail [$test_script][$LINENO]"  
[ "$($ifOSThenRun no_check_OS echo "hello")" == "" ] || echo "ifOSThenRun.sh script fail [$test_script][$LINENO]"  
[ "$($ifOSThenRun no_check_OS echo "hello")" == "" ] || echo "ifOSThenRun.sh script fail [$test_script][$LINENO]"  
[ "$($ifOSThenRun test2 echo "hello")" == "hello bay" ] || echo "ifOSThenRun.sh script fail [$test_script][$LINENO]"  

( $ifOSThenRun no_check_OS echo "hello" || $ifOSThenRun no_check_OS echo "hello" || $ifOSThenRun no_check_OS echo "hello" )>/dev/null  && echo "ifOSThenRun.sh script fail [$test_script][$LINENO]" 
( $ifOSThenRun test echo "hello" || $ifOSThenRun no_check_OS echo "hello" || $ifOSThenRun no_check_OS echo "hello" )>/dev/null  || echo "ifOSThenRun.sh script fail [$test_script][$LINENO]" 
( $ifOSThenRun no_check_OS echo "hello" || $ifOSThenRun test echo "hello" || $ifOSThenRun no_check_OS echo "hello" )>/dev/null || echo "ifOSThenRun.sh script fail [$test_script][$LINENO]" 
( $ifOSThenRun no_check_OS echo "hello" || $ifOSThenRun no_check_OS echo "hello" || $ifOSThenRun test echo "hello" )>/dev/null || echo "ifOSThenRun.sh script fail [$test_script][$LINENO]" 