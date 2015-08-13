#!/usr/bin/env bash
# Exit upon first failure (aka first failing test)
set -e

# Resolve our test and repo locations
TEST_DIR="$(dirname "${BASH_SOURCE[0]}")"
REPO_DIR="$TEST_DIR/.."
echo "$TEST_DIR"
echo "$REPO_DIR"


# A git directory initialized with victorious-git
  # git init
