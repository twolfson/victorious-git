#!/usr/bin/env bash
# Exit upon first failure and output commands
set -e
set -x

# Save the path to our template directory
repo_dir="$PWD"
templatedir="$PWD/dotgit"

# Generate a temporary folder
tmp_dir="$(mktemp -d)"
cd "$tmp_dir"

# Generate a new repository and install music to it
git init --template "$templatedir"
"$repo_dir/bin/install-music.sh" "$tmp_dir/.git/hooks/victory.mp3"

# Set up merge conflicts
#   Add "hello" and "world" files on `master` in 2 consecutive commits
echo "hello" > hello.txt; git add hello.txt; git commit -m "Added hello file" > /dev/null
echo "world" > world.txt; git add world.txt; git commit -m "Added world file" > /dev/null
#   Add conflicting "world" file on alternative branch
git checkout HEAD~1 &> /dev/null; git checkout -b dev/conflicting.branch &> /dev/null
echo "wurld" > world.txt; git add world.txt; git commit -m "Added wurld file" > /dev/null

# Notify user of their test drive being ready to go
set +x
echo "Your \`victorious-git\` test drive has been set up at \"$tmp_dir\""
echo "To trigger a merge conflict and play some fanfare run the following commands:"
echo ""
echo "# Navigate to our test drive directory"
echo "cd \"$tmp_dir\""
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