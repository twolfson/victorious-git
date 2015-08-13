#!/usr/bin/env bash
# Exit upon first failure and output our actions
set -e
set -x

# If we are using git@1.7, then remove the existing git and install the Ubuntu default
if test "$GIT_VERSION" = "1.7"; then
  # Remove `git-core@1.8` PPA (Travis CI uses this by default)
  # https://launchpad.net/ubuntu/+source/git
  sudo apt-get install -y ppa-purge
  sudo ppa-purge -y "ppa:git-core/v1.8"

  # Assert the git version is correct (e.g. "git version 1.7.*")
  # TODO: Get actual git version output
  git_version="$(git --version)"
  if ! (echo "$git_version" | grep -E "^git version 1.7"); then
    echo "Expected \`git --version\` to be \"1.7\" but it was \"$git_version\"" 1>&2
    exit 1
  fi
# Otherwise, if we are using git@1.8, then do nothing
elif test "$GIT_VERSION" = "1.8"; then
  # Assert the git version is correct (e.g. "git version 1.8.5.6")
  # TODO: Test assertion failures all at the end
  git_version="$(git --version)"
  if ! (echo "$git_version" | grep -E "^git version 1.8"); then
    echo "Expected \`git --version\` to be \"1.8\" but it was \"$git_version\"" 1>&2
    exit 1
  fi
# Otherwise, if we are using git@2.x, then use `git` from a new PPA
elif test "$GIT_VERSION" = "2.x"; then
  # Add our new PPA and install git
  # http://blog.avirtualhome.com/git-ppa-for-ubuntu/
  sudo add-apt-repository -y "ppa:pdoes/ppa"
  sudo apt-get -y update
  sudo apt-get install -y git

  # Assert the git version is correct (e.g. "git version 2.*.*")
  # TODO: Get actual git version output
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
