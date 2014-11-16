#!/bin/bash
PROJECT_DIR="$(pwd)"
source ${PROJECT_DIR}/utils.sh
EXIT_STATUS=0;

writeout "Test 1: Is the Postcodes API responding?"
assert_status_code "http://api.postcodes.io/random/postcodes" "200"

writeout "Test 2: Does the Postcodes API return the Queen's address?"
haystack="`curl -s http://api.postcodes.io/postcodes/SW1A1AA `"
needle='"admin_district":"Westminster","admin_ward":"St James'"'"'s"'
assert_contains "$haystack" "$needle"

result $EXIT_STATUS
