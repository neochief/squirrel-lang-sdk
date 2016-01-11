#!/usr/bin/env bash

#######################################################################
assert_equals ()          #  If condition false,
{                         #+ exit from script
                         #+ with appropriate error message.
  RED='\033[0;31m'
  NC='\033[0m' # No Color

  E_PARAM_ERR=98
  E_ASSERT_FAILED=99

  if [ -z "$3" ]          #  Not enough parameters passed
  then                    #+ to assert() function.
    return $E_PARAM_ERR   #  No damage done.
  fi

  lineno=$3

  if [[ "$1" != *$2* ]]
  then
    echo -e "$RED"
    echo -e "Assertion failed (File \"$0\", line $lineno)"
    echo "  Actual: $1"
    echo "Expected: $2"
    echo -e "$NC"
    exec 3>&-
    kill $4
    exit $E_ASSERT_FAILED
  # else
  #   return
  #   and continue executing the script.
  fi
} # Insert a similar assert() function into a script you need to debug.
#######################################################################

mkdir -p ../log
rm -f ../log/sqdbg.txt
./../../output/bin/sqdbg test.nut > ../log/sqdbg.txt &
pid=$!
sleep 1
exec 3<>/dev/tcp/localhost/1234


# 1. Create some breakpoint.
printf "ab:7:test.nut\n" >&3
read -r output <&3
assert_equals "$output" "<?xml version='1.0' encoding='utf-8'?><addbreakpoint line=\"7\" src=\"test.nut\"/>" $LINENO $pid


# 2. Ready and run until first breakpoint.
printf "rd\n" >&3
read -r output <&3
# we need to cut off the thread ID before comparison, bacause it's always different.
output=$(echo $output | sed -e 's/thread="[^"]*"/thread=""/g')
expected="<?xml version='1.0' encoding='utf-8'?><break thread=\"\" line=\"7\" src=\"test.nut\" type=\"breakpoint\"><objs><o type=\"r\" ref=\"0\"/><o type=\"a\" ref=\"2\"/><o type=\"a\" ref=\"1\"><e kt=\"i\" kv=\"0\" vt=\"i\" v=\"324\"/><e kt=\"i\" kv=\"1\" vt=\"i\" v=\"23\"/></o></objs><calls><call fnc=\"main\" src=\"test.nut\" line=\"7\"><l name=\"this\" type=\"t\" val=\"0\"/><l name=\"l4\" type=\"a\" val=\"1\"/></call><call fnc=\"main\" src=\"test.nut\" line=\"11\"><l name=\"vargv\" type=\"a\" val=\"2\"/><l name=\"action\" type=\"i\" val=\"1\"/><l name=\"this\" type=\"t\" val=\"0\"/></call></calls></break>"
assert_equals "$output" "$expected" $LINENO $pid

exec 3>&-
kill $pid