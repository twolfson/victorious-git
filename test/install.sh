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

# Override sound player to prevent sound from successful installs
export PATH="$test_dir/test-files/bin:$PATH"

# A normal victorious-git installation
if test -d ~/.config/victorious-git; then rm -r ~/.config/victorious-git/; fi
"$repo_dir/bin/install.sh" &> /dev/null

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
if test -d ~/.config/victorious-git; then rm -r ~/.config/victorious-git/; fi
"$repo_dir/bin/install-symlink.sh" &> /dev/null

  # when initializing a git directory
  fixture_git_init

    # has a symlinked hooks directory
    if ! test -d .git/hooks; then
      echo "\`git\` folder initialized with symlink victorious-git doesn't have a hooks directory" 1>&2
      exit 1
    fi
    if ! test -h .git/hooks; then
      echo "\`git\` folder initialized with symlink victorious-git doesn't use a symlink for its hooks directory" 1>&2
      exit 1
    fi

    # has a static hooks
    if ! test -f .git/hooks/post-commit || ! test -f .git/hooks/pre-commit; then
      echo "\`git\` folder initialized with symlink victorious-git doesn't have our hooks" 1>&2
      exit 1
    fi
    if test -h .git/hooks/post-commit || test -h .git/hooks/pre-commit; then
      echo "\`git\` folder initialized with symlink victorious-git had symlinks as its hooks" 1>&2
      exit 1
    fi

# A normal victorious-git installation on an existing install
if test -d ~/.config/victorious-git; then rm -r ~/.config/victorious-git/; fi
"$repo_dir/bin/install.sh" &> /dev/null

  # it complains to the user and exits
  if "$repo_dir/bin/install.sh" &> /dev/null; then
    echo "Normal installation on an existing installation didn't fail" 1>&2
    exit 1
  fi

# A symlink victorious-git installation on an existing install
if test -d ~/.config/victorious-git; then rm -r ~/.config/victorious-git/; fi
"$repo_dir/bin/install-symlink.sh" &> /dev/null

  # it complains to the user and exits
  if "$repo_dir/bin/install-symlink.sh" &> /dev/null; then
    echo "Symlink installation on an existing installation didn't fail" 1>&2
    exit 1
  fi
