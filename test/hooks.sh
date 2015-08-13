#!/usr/bin/env bash
# Exit upon first failure (aka first failing test)
set -e

# Resolve our test and repo locations
test_dir="$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)"
repo_dir="$(dirname "$test_dir")"

# Define test helpers
fixture_git_init() {
  tmp_dir="$(mktemp -d)"
  cd "$tmp_dir"
  git init $* > /dev/null
}

# Prepend our with a custom "afplay" for testing
export PATH="$test_dir/test-files/bin:$PATH"

# A git directory initialized with victorious-git
fixture_git_init --template "$repo_dir/dotgit"

  # has our fixtures
  if ! ls .git/hooks/post-commit > /dev/null || ! ls .git/hooks/pre-commit > /dev/null; then
    echo "\`git\` folder initialized with our template doesn't have our hooks" 1>&2
    exit 1
  fi

  # when we commit
  echo "hello" > hello.txt; git add hello.txt; git commit -m "Added hello file" > /dev/null

    # it does not make any noise
    if test -f afplay.out; then
      echo "\`victorious-git\` played fanfare on a non-merge commit" 1>&2
      exit 1
    fi

  # when we commit with a merge conflict
    # it plays our victory music upon success

  # when we commit with a merge conflict but the commit fails (e.g. due to lack of a commit message)
    # it does not play our victory music

# TODO: Test with rebase
# TODO: Test with cherry pick
