function writeout {
    echo "___________________________________________________"
    echo -e "$1"
}

function assert_contains()
{
    if [[ "$1" != *"$2"* ]]; then
        EXIT_STATUS=1;
        echo -e "\033[0;31mExpected\033[0m: '"$2"'"
        echo -e "\033[0;31mGot\033[0m: '"$1"'";
    else 
        echo -e "\033[0;32mOK\033[0m"
    fi
}

function assert_equals()
{
    if [[ "$1" != "$2" ]]; then
        EXIT_STATUS=1;
        echo -e "\033[0;31mExpected\033[0m: '"$2"'"
        echo -e "\033[0;31mGot\033[0m: '"$1"'";
    else 
        echo -e "\033[0;32mOK\033[0m"
    fi
}

function assert_status_code()
{
    if [[ "$1" != "" ]]; then
        haystack="$(curl -s -w %{http_code} $1 -o /dev/null)"
        assert_equals "$haystack" "$2"
    fi
}

function result()
{
    if [ "$1" -eq 0 ]; then
        echo -e "\033[0;32mpassed\033[0m"
    else
        echo -e "\033[0;31mfailed\033[0m"
    fi
    exit $1
}
