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

# If there is custom music
if test "$VICTORIOUS_GIT_MUSIC_URL" != ""; then
  # Attempt to download it (allow failure)
  echo "Custom music detected. Attempting to download..." 1>&2
  set +e
  wget "$VICTORIOUS_GIT_MUSIC_URL" --output-document "$filepath"

  # If it was successful, exit out
  if test "$?" = "0"; then
    exit 0
  # Otherwise, notify the user of the failure
  else
    echo "Failed to download music. Falling back to default music" 1>&2
  fi

  # Re-enable fast failure
  set -e
fi

# Download our default music
default_music_url="http://www.myinstants.com/media/sounds/ffvi-fanfare.mp3"
wget "$default_music_url" --output-document "$filepath"
