#!/usr/bin/env bash
# Exit upon the first failing command
set -e

# Resolve our parameters
filepath="$1"
if test "$filepath" = ""; then
  echo "No filepath was specified for \`$0\`" 1>&2
  echo "Usage: $0 [filepath]" 1>&2
  exit 1
fi

# Load in our settings and their overrides
victorious_git_volume="5"
if test "$VICTORIOUS_GIT_VOLUME" != ""; then victorious_git_volume="$VICTORIOUS_GIT_VOLUME"; fi

# Determine which player is supported and play from it
if which afplay &> /dev/null; then
  afplay -v "$victorious_git_volume" "$filepath" &> /dev/null
elif which mplayer &> /dev/null; then
  mplayer "$filepath" &> /dev/null
else
  echo "No player found for \`victory.mp3\` playback =(" 1>&2
  exit 1
fi
