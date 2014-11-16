#!/bin/bash
PROJECT_DIR="$(pwd)"
source ${PROJECT_DIR}/utils.sh
EXIT_STATUS=0;

writeout "Test 1: Is the Cat Facts API responding?"
assert_status_code "http://catfacts-api.appspot.com/api/facts?number=0" "200"

writeout "Test 2: Does the Cat Facts API return a successful empty response?"
haystack="`curl -s https://catfacts-api.appspot.com/api/facts?number=0`"
needle='{"facts": [], "success": "true"}'
assert_equals "$haystack" "$needle"

writeout "Test 3: Does the Cat Facts API return a successful non-empty response?"
haystack="`curl -s http://catfacts-api.appspot.com/api/facts?number=1`"
needle='{"facts": ["'
assert_contains "$haystack" "$needle"
needle='"], "success": "true"}'
assert_contains "$haystack" "$needle"

result $EXIT_STATUS
