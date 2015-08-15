#!/usr/bin/env bash
# Exit upon first failure and output commands
set -e

# Save the path to our template directory
bin_dir="$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)"
repo_dir="$(dirname "$bin_dir")"
templatedir="$repo_dir/dotgit"

# Generate a demo folder
demo_dir="/tmp/victorious-git-demo"
if test -d "$demo_dir"; then
  rm -rf "$demo_dir"
fi
mkdir "$demo_dir"
cd "$demo_dir"

# Generate a new repository and install music to it
set -x
git init --template "$templatedir"
"$bin_dir/install-music.sh" "$demo_dir/.git/hooks/victory.mp3"

# Set up merge conflicts
#   Add "hello" and "world" files on `master` in 2 consecutive commits
echo "hello" > hello.txt; git add hello.txt; git commit -m "Added hello file" > /dev/null
echo "world" > world.txt; git add world.txt; git commit -m "Added world file" > /dev/null
#   Add conflicting "world" file on alternative branch
git checkout HEAD~1 &> /dev/null; git checkout -b dev/conflicting.branch &> /dev/null
echo "wurld" > world.txt; git add world.txt; git commit -m "Added wurld file" > /dev/null

# Notify user of their test drive being ready to go
set +x
echo "Your \`victorious-git\` test drive has been set up at \"$demo_dir\""
echo "To trigger a merge conflict and play some fanfare run the following commands:"
echo ""
echo "# Navigate to our test drive directory"
echo "cd \"$demo_dir\""
echo ""
echo "# Introduction to our conflicting branches"
echo "#   via git-extras' git-show-tree https://github.com/tj/git-extras/blob/3.0.0/bin/git-show-tree"
echo "git log --all --graph --decorate --oneline --simplify-by-decoration"
echo ""
echo "# Trigger a merge conflict"
echo "git merge master"
echo ""
echo "# Resolve our merge conflict"
echo "git checkout HEAD -- world.txt"
echo ""
echo "# Commit our merge resolution and listen to that glorious fanfare"
echo "git commit --no-edit"
