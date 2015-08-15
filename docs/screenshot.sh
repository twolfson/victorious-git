#!/usr/bin/env bash
# Exit upon first failure and output commands
set -e

# Save the path to our template directory
docs_dir="$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)"
repo_dir="$(dirname "$bin_dir")"
bin_dir="$repo_dir/bin"

# Set up our screenshot folder
"$bin_dir/test-drive.sh"
play_victory_filepath="/tmp/victorious-git-demo/.git/hooks/play-victory.sh"
echo "echo "\!\!FANFARE PLAYS\!\!"" > "$play_victory_filepath"
chmod +x "$play_victory_filepath"
