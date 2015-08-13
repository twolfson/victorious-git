#!/usr/bin/env bash
# Run our tests and verify each has no output
./test/hooks.sh &> test/hooks.out
exit_code="$?"
if test "$exit_code" != "0"; then
  echo "hooks.sh had non-zero exit code \"$exit_code\". Here's its output:" 1>&2
  cat test/hooks.out
  exit 1
fi
if test "$(cat test/hooks.out)" != ""; then
  echo "hooks.sh had non-empty output. Here's its output:" 1>&2
  cat test/hooks.out
  exit 1
fi

# Output our success
echo "All tests are passing" 1>&2
exit 0
