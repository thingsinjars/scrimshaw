#!/bin/bash
PROJECT_DIR="$(pwd)"
source ${PROJECT_DIR}/utils.sh
EXIT_STATUS=0;

writeout "Test 1: Is the Postcodes API responding?"
assert_status_code "http://api.postcodes.io/random/postcodes" "200"

writeout "Test 2: Does the Postcodes API return the Queen's address?"
haystack="`curl -s http://api.postcodes.io/postcodes/SW1A1AA `"
needle='"admin_district":"Westminster"'
assert_contains "$haystack" "$needle"
needle='"admin_ward":"St James'"'"'s"'
assert_contains "$haystack" "$needle"

writeout "Test 3: Does the Postcodes API return a valid postcode?"
haystack="`curl -s http://api.postcodes.io/random/postcodes `"
match=[A-Z]{1,2}[0-9][0-9A-Z]?\s?[0-9]..
assert_matches "$haystack" "$match"

result $EXIT_STATUS
