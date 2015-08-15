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

# A normal victorious-git installation
rm -r ~/.config/victorious-git/
"$repo_dir/bin/install.sh"

  # when initializing a git directory
  fixture_git_init

    # has a static hooks directory
    if ! test -d .git/hooks; then
      echo "\`git\` folder initialized with normal victorious-git doesn't have a hooks directory" 1>&2
      exit 1
    fi
    if test -h .git/hooks; then
      echo "\`git\` folder initialized with normal victorious-git had a symlink for its hooks directory" 1>&2
      exit 1
    fi

    # has a static hooks
    if ! test -f .git/hooks/post-commit || ! test -f .git/hooks/pre-commit; then
      echo "\`git\` folder initialized with normal victorious-git doesn't have our hooks" 1>&2
      exit 1
    fi
    if test -h .git/hooks/post-commit || test -h .git/hooks/pre-commit; then
      echo "\`git\` folder initialized with normal victorious-git had symlinks as its hooks" 1>&2
      exit 1
    fi

# A symlink victorious-git installation
  # when initializing a git directory
    # has a symlinked hooks directory
    # has a static hooks

# A normal victorious-git installation on an existing install
  # when initializing a git directory
    # has a static hooks directory
    # has a static hooks

# A symlink victorious-git installation on an existing install
  # when initializing a git directory
    # has a symlinked hooks directory
    # has a static hooks
    # has no extra files
