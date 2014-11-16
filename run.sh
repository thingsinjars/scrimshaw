#!/bin/bash
source ./utils.sh
ALL_TEST_EXIT=0

writeout "Scrimshaw"

for s in ./tests/*;do 
	writeout $s
	[ -x $s ] && $s
	ALL_TEST_EXIT=$(($ALL_TEST_EXIT + $?))
done

writeout "Overall result: "

result $ALL_TEST_EXIT
