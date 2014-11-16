Scrimshaw
===

Bare-bones API tests built on cURL
---

Full-blown, feature-rich integration test frameworks are really useful and quite often brilliant but sometimes, you don't want magic. These are simple API tests that use nothing but cURL to verify the data returned from API calls.

You should be able to use these to reassure yourself that your fully functional test framework is doing its job properly. Think of it as a safeguard against flaky tests.

To run the tests:
---

    ./run.sh

Example test:
---

    writeout "Text describing test"
    haystack="`curl -s http://catfacts-api.appspot.com/api/facts?number=0`"
    needle='{"facts": [], "success": "true"}'
    assert_contains "$haystack" "$needle"

  * `writeout`: write out the test name
  * `haystack`: curl command to access endpoint
  * `needle`: text to find in the response
  * `assert_contains`: assert that $needle can be found in $haystack


    writeout "Text describing test"
    assert_status_code "http://catfacts-api.appspot.com/api/facts?number=0" "200"

  * `assert_status_code`: assert that the URL returns the expected response code

Available methods
---

 * `assert_contains "$haystack" "$needle"`
 * `assert_equals "$str1" "$str2"`
 * `assert_status_code "$url" "$code"`
