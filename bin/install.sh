#!/usr/bin/env bash
# Exit upon first failure
set -e

# If our template directory already exists, explain and error out
dotgit_source="$PWD/dotgit/"
dotgit_target="~/.config/victorious-git/dotgit/"
if test -d "$dotgit_target"; then
  echo "There is an existing installation of \`victorious-git\`." 1>&2
  echo "To prevent unwanted deletions, please remove or backup your existing install:" 1>&2
  echo "# rm -r \"$dotgit_target\"" 1>&2
  exit 1
fi

# Copy over our dotgit
set -x
mkdir -p "$(dirname "$dotgit_target")"
cp -R "$dotgit_source" "$dotgit_target"
set +x

# Download our music
bin/install-music.sh "$dotgit_target/hooks/victory.mp3"

# Set up our global templatedir
set -x
git config --global init.templatedir "$dotgit_target"
set +x

# Notify the user of success
echo "victorious-git has been successfully installed"

# Play our victory music
"$dotgit_target/hooks/play-victory.sh" "$dotgit_target/hooks/victory.mp3" &
