#!/usr/bin/env bash
# Exit upon first failure
set -e

# If our template directory already exists, explain and error out
bin_dir="$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)"
repo_dir="$(dirname "$bin_dir")"
dotgit_source="$repo_dir/dotgit"
dotgit_target="~/.config/victorious-git/dotgit"
dotgit_target_expanded="$HOME/.config/victorious-git/dotgit"
templatedir_target="~/.config/victorious-git/templatedir"
templatedir_target_expanded="$HOME/.config/victorious-git/templatedir"
if test -d "$dotgit_target_expanded" || test -d "$templatedir_target_expanded"; then
  echo "There is an existing installation of \`victorious-git\`." 1>&2
  echo "To prevent unwanted deletions, please remove or backup your existing install:" 1>&2
  echo "# rm -r \"$dotgit_target_expanded\" \"$templatedir_target_expanded\"" 1>&2
  exit 1
fi

# Copy over our dotgit
set -x
mkdir -p "$(dirname "$dotgit_target_expanded")"
cp -R "$dotgit_source" "$dotgit_target_expanded"

# Download our music
set +x
bin/install-music.sh "$dotgit_target_expanded/hooks/victory.mp3"

# Generate an absolute path symlink to the expanded dir
# DEV: We need an absolute path as the post-template `.git/hooks/`
#   will not be in `~/.config/victorious-git`
mkdir "$templatedir_target_expanded"
ln -s "$dotgit_target_expanded/hooks" "$templatedir_target_expanded/hooks"

# Set up our global templatedir
set -x
git config --global init.templatedir "$templatedir_target"

# Notify the user of success
set +x
echo "victorious-git has been successfully installed"

# Play our victory music
"$templatedir_target_expanded/hooks/play-victory.sh" "$templatedir_target_expanded/hooks/victory.mp3" &
