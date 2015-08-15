#!/usr/bin/env bash
# Run our tests and verify each has no output
for test_script in ls test/{hooks.sh,install.sh}; do
  out_filepath="$test_script.out"
  "$test_script" &> "$out_filepath"
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
