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

# A git directory initialized with victorious-git
fixture_git_init --template "$repo_dir/dotgit"

  # has our fixtures
  if ! ls .git/hooks/post-commit || ! ls .git/hooks/pre-commit; then
    echo "\`git\` folder initialized with our template doesn't have our hooks" 1>&2
    exit 1
  fi
