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

add_hello_world_commits() {
  #   Add "hello" and "world" files on `master` in 2 consecutive commits
  echo "hello" > hello.txt; git add hello.txt; git commit -m "Added hello file" > /dev/null
  echo "world" > world.txt; git add world.txt; git commit -m "Added world file" > /dev/null
}

add_nonconflicting_branch() {
  #   Add nonconflicting "moon" file on alternative branch
  git checkout HEAD~1 &> /dev/null; git checkout -b dev/nonconflicting.branch &> /dev/null
  echo "moon" > moon.txt; git add moon.txt; git commit -m "Added moon file" > /dev/null
}

add_conflicting_branch() {
  #   Add conflicting "world" file on alternative branch
  git checkout HEAD~1 &> /dev/null; git checkout -b dev/conflicting.branch &> /dev/null
  echo "wurld" > world.txt; git add world.txt; git commit -m "Added wurld file" > /dev/null
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

# A git directory initialized with victorious-git
fixture_git_init --template "$repo_dir/dotgit"

  # when we merge but have no merge conflict
  #   Generate our nonconflicting commits
  add_hello_world_commits
  add_nonconflicting_branch
  #   Perform our merge
  git merge master &> /dev/null
  #   Wait for afplay.out to be written due to forking
  sleep 0.1

    # it doesn't play our victory music
    if test -f afplay.out; then
      echo "\`victorious-git\` played fanfare on a non-conflicting merge" 1>&2
      exit 1
    fi

# A git directory initialized with victorious-git
fixture_git_init --template "$repo_dir/dotgit"

  # when we commit with a merge conflict
  #   Generate our conflicting commits
  add_hello_world_commits
  add_conflicting_branch
  #   Perform our merge, declare this branch the victor, and commit with default text
  git merge master &> /dev/null || true; git checkout HEAD -- world.txt; git commit --no-edit &> /dev/null
  #   Wait for afplay.out to be written due to forking
  sleep 0.1

    # it plays our victory music upon success
    if ! test -f afplay.out; then
      echo "\`victorious-git\` did not play upon merge commit resolution" 1>&2
      exit 1
    fi

# A git directory initialized with victorious-git
fixture_git_init --template "$repo_dir/dotgit"

  # when we commit with a merge conflict but the commit fails (e.g. due to lack of a commit message)
  add_hello_world_commits
  add_conflicting_branch
  #   Force an empty commit message via `cat /dev/null` (empty string) piped to stdin of `git commit -F -` (use stdin as message)
  git merge master &> /dev/null || true; git checkout HEAD -- world.txt; cat /dev/null | git commit -F - &> /dev/null || true
  #   Wait for afplay.out to be written due to forking
  sleep 0.1

    # it does not play our victory music
    if test -f afplay.out; then
      echo "\`victorious-git\` played music upon failing to write a merge commit" 1>&2
      exit 1
    fi

# A git directory initialized with victorious-git
fixture_git_init --template "$repo_dir/dotgit"

  # when we commit with a merge conflict but the commit fails and we make a non-conflicting commit
  add_hello_world_commits
  add_conflicting_branch
  git merge master &> /dev/null || true; git checkout HEAD -- world.txt; cat /dev/null | git commit -F - &> /dev/null || true
  #  Exit our merge state
  git reset --hard &> /dev/null; git checkout master &> /dev/null
  #  Create our non-conflicting commit
  echo "moon" > moon.txt; git add moon.txt; git commit -m "Added moon file" > /dev/null
  #   Wait for afplay.out to be written due to forking
  sleep 0.1

    # it does not play our victory music
    if test -f afplay.out; then
      echo "\`victorious-git\` played music upon writing a non-conflicting commit after ignoring a merge conflict" 1>&2
      exit 1
    fi

# A git directory initialized with victorious-git
fixture_git_init --template "$repo_dir/dotgit"

  # when we rebase without a merge conflict
  add_hello_world_commits
  add_nonconflicting_branch
  #   Perform our rebase
  git rebase master &> /dev/null
  #   Wait for afplay.out to be written due to forking
  sleep 0.1

    # it doesn't play our victory music
    if test -f afplay.out; then
      echo "\`victorious-git\` played fanfare on a non-conflicting merge" 1>&2
      exit 1
    fi

# A git directory initialized with victorious-git
  # when we rebase with a merge conflict
    # it plays our victory music

# A git directory initialized with victorious-git
  # when we cherry-pick without a merge conflict
    # it does not play our victory music

# A git directory initialized with victorious-git
  # when we cherry-pick with a merge conflict
    # it plays our victory music
