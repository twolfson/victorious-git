#!/usr/bin/env bash
# Exit upon first failure and output our actions
set -e
set -x

# Get our current `git version`
git --version

# If we are using git@1.7, then remove the existing git and install the Ubuntu default
  # TODO: Assert the git version is correct
# Otherwise, if we are using git@1.8, then do nothing
  # TODO: Assert the git version is correct
# Otherwise, if we are using git@2.x, then remove the existing git and install `git` via new PPA
  # TODO: Assert the git version is correct
# Otherwise, complain about an unrecognized git