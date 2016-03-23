function writeout {
    echo "___________________________________________________"
    echo -e "$1"
}

declare -a on_exit_items

function on_exit()
{
    for i in "${on_exit_items[@]}"
    do
        # echo "on_exit: $i"
        eval $i
    done
}

function add_on_exit()
{
    local n=${#on_exit_items[*]}
    on_exit_items[$n]="$*"
    if [[ $n -eq 0 ]]; then
        # echo "Setting trap"
        trap on_exit EXIT
    fi
}

function assert_matches()
{
    # bit of a hack to slurp haystacks with spaces
    haystack=`echo $* | rev | cut -d" " -f2- | rev`
    match=`echo $* | rev | cut -d" " -f-1 | rev`
    if [[ $haystack =~ $match ]]; then
        echo -e "\033[0;32mOK\033[0m"
    else 
        EXIT_STATUS=1;
        echo -e "\033[0;31mExpected\033[0m: "$haystack
        echo -e "\033[0;31mTo match\033[0m: "$match
    fi
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
        haystack="`curl -s -o /dev/null -w '%{http_code}' $1`"
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