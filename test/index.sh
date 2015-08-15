#!/usr/bin/env bash
# Exit on our first error
set -e

# By default, only run our hooks test
#   and allow opt-in to the install tests
test_scripts="test/hooks.sh"
if test "$TEST_INSTALL" != ""; then
  test_scripts="$test_scripts test/install.sh"
else
  echo "Skipping test/install.sh due to empty \`TEST_INSTALL\` environment variable" 1>&2
fi

# Run our tests and verify each has no output
for test_script in $(ls $test_scripts); do
  out_filepath="$test_script.out"
  # Run our test
  echo "Running test: $test_script" 1>&2
  set +e
  "$test_script" &> "$out_filepath"
  set -e

  # Determine if it passed/failed
  exit_code="$?"
  if test "$exit_code" != "0"; then
    echo "$test_script had non-zero exit code \"$exit_code\". Here's its output:" 1>&2
    cat "$out_filepath"
    exit 1
  fi
  if test "$(cat $out_filepath)" != ""; then
    echo "$test_script had non-empty output. Here's its output:" 1>&2
    cat "$out_filepath"
    exit 1
  fi
done

# Output our success
echo "All tests are passing" 1>&2
exit 0
