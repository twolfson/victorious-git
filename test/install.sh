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

# A fresh victorious-git installation
  # when initializing a git directory
    # has a hooks directory
    # has hooks

# A normal victorious-git installation
  # when initializing a git directory
    # has a static hooks directory
    # has a static hooks

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
