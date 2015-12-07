#!/usr/bin/env bash
# Exit upon first failure and output our actions
set -e
set -x

# If we are using git@1.9, then do nothing
if test "$GIT_VERSION" = "1.9"; then
  # Assert the git version is correct (e.g. "git version 1.9.5.6")
  git_version="$(git --version)"
  if ! (echo "$git_version" | grep -E "^git version 1.9"); then
    echo "Expected \`git --version\` to be \"1.9\" but it was \"$git_version\"" 1>&2
    exit 1
  fi
# Otherwise, if we are using git@2.x, then use `git` from a new PPA
elif test "$GIT_VERSION" = "2.x"; then
  # Add our new PPA and install git
  # http://blog.avirtualhome.com/git-ppa-for-ubuntu/
  sudo add-apt-repository -y "ppa:pdoes/ppa"
  sudo apt-get -y update
  sudo apt-get install -y git

  # Assert the git version is correct (e.g. "git version 2.5.0")
  git_version="$(git --version)"
  if ! (echo "$git_version" | grep -E "^git version 2."); then
    echo "Expected \`git --version\` to be \"2.x\" but it was \"$git_version\"" 1>&2
    exit 1
  fi
# Otherwise, complain about an unrecognized git
else
  echo "Unrecognized GIT_VERSION \"$GIT_VERSION\". Please either remove it or define it via \`travis-setup.sh\`" 1>&2
  exit 1
fi

# Configure `git` to know who we are
git config --global user.email "todd@twolfson.com"
git config --global user.name "Todd Wolfson (Travis CI)"
