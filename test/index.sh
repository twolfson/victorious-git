#!/usr/bin/env bash
# Exit upon first failure (aka first failing test suite)
set -e

# Run our tests and verify each has no output
./test/hooks.sh | tee hooks.out
if test "$(cat hooks.out)" != ""; then
  echo "hooks.sh had non-empty output. Exiting tests now" 1>&2
  exit 1
fi

# Output our success
echo "All tests are passing" 1>&2
exit 0
