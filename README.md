# victorious-git [![Build status](https://travis-ci.org/twolfson/victorious-git.png?branch=master)](https://travis-ci.org/twolfson/victorious-git)

Play fanfare after triumphing over `git` conflicts

This is heavily inspired by @DanaDanger's `victorious-merge`

**Features:**

- Plays fanfare on resolution of `git` conflicts from:
    - [x] `merge`
    - [x] `rebase`
- Doesn't play fanfare on trivial merge (i.e. no conflicts/conflicts automatically resolved)
- Cross-platform support on GNU/Linux and OS X
- Play custom fanfare
- Support for `git>=1.7` and `git>=2.0`
- MailChimp newsletter to receive updates
    - http://eepurl.com/bwaPZj

![Screenshot](docs/screenshot.png)

Fanfare: http://www.myinstants.com/media/sounds/ffvi-fanfare.mp3

## Warning
Before we get to the fun part (runnning this), we should cover what's going on and the reprecussions. We are using a setting in `git` known as `init.templatedir`. As the name implies, this is a folder that is used to initialize all future `.git` folders.

We are overriding the entire `.git/hooks` folder default ([typically full of samples][git-hooks-default]). As a result, we will also be conflicting with per-repo hooks (e.g. some teams like to enforce linting on each commit). So here is your warning:

[git-hooks-default]: https://github.com/git/git/tree/v2.4.6/templates

**`victorious-git` adjusts with your `.git/hooks` folder for all future repositories.**

**Please take caution and be aware that this will adjust future `.git/hooks` interactions, such as before/after commits occur.**

## Installation
### One line install
The following installs `victorious-git` to `~/.config/victorious-git` and sets up a **user-wide** `init.templatedir`.

```bash
(cd /tmp/ && (test -d victorious-git || git clone --depth 1 https://github.com/twolfson/victorious-git) && cd victorious-git/ && bin/install.sh)
```

By default, we will play the [Final Fantasy VI fanfare][ff-fanfare].

Alternative sounds can be downloaded during installation via `VICTORIOUS_GIT_MUSIC_URL`. Here's an example with [The Legend of Zelda's item get][zelda-item-get]:

[ff-fanfare]: http://www.myinstants.com/instant/ff-vi-fanfare/
[zelda-item-get]: http://www.myinstants.com/instant/zelda-item-get/

```bash
export VICTORIOUS_GIT_MUSIC_URL="http://www.myinstants.com/media/sounds/139-item-catch.mp3"
(cd /tmp/ && (test -d victorious-git || git clone --depth 1 https://github.com/twolfson/victorious-git) && cd victorious-git/ && bin/install.sh)
```

If you would like to update an existing installation's sounds, please see the [Music section](#music).

#### Test drive
Feeling uncertain about installing `victorious-git`? Give it a test drive. The following script will set up a temporary `git` directory using `--template` (no global installation):

```bash
(cd /tmp/ && (test -d victorious-git || git clone --depth 1 https://github.com/twolfson/victorious-git) && cd victorious-git/ && bin/test-drive.sh)
# Creates new git repo at `/tmp/victorious-git-demo/`
# Sets up branches ready to be conflicts
# Outputs commands to let you pull the switch (e.g. `git merge`, `git commit`)
```

### Symlink installation
By using symlinks, we can retroactively apply changes to `victorious-git` bound repositories (e.g. upgrades, changing music).

**This is very dangerous because it effectively makes all `.git` repositories share the same `hooks/` folder. This means adding a hook in `~/repo1/.git/hooks/prepare-commit-msg` will add the hook to `~/repo2/.git/hooks`.**

```bash
# Navigate to a temporary location
cd /tmp/

# Clone our repository
git clone --depth 1 https://github.com/twolfson/victorious-git
cd victorious-git/

# Run our symlink install script
bin/install-symlink.sh
```

### Adding `victorious-git` to existing repositories
To integrate `victorious-git` in existing `git` repositories, we can use the following commands:

```bash
# Inside of our repository (e.g. `victorious-git`)
# Delete our existing `git` hooks
rm -r .git/hooks/

# Reinitialize the repository (leverages template directory)
# This will not destroy `git` history
git init

# Proof that hooks are installed
ls .git/hooks/
```

## Configuration
### Music
Upon installation, you should hear our sound play once. You can listen to the current sound via:

```bash
~/.config/victorious-git/dotgit/hooks/play-victory.sh ~/.config/victorious-git/dotgit/hooks/victory.mp3
```

If you would like to update the installed music, this can be done via:

```bash
music_url="http://www.myinstants.com/media/sounds/139-item-catch.mp3"
wget "$music_url" --output-document ~/.config/victorious-git/dotgit/hooks/victory.mp3
```

### Volume
`victorious-git` attempts to use `afplay` and falls back to `mplayer` for its music playback. To determine if you are using `afplay`, run:

```bash
# This will have output if we are using `afplay`
which afplay
```

If `afplay` is being used, its volume can be set via `VICTORIOUS_GIT_VOLUME`. By default, this is 5.

```bash
export VICTORIOUS_GIT_VOLUME=10
# Adjusts our `afplay -v 5` to `afplay -v 10`
```

To set this permanently for your user, it can be added to your `~/.bashrc`. This includes `zsh`/`fish`/etc users as all our scripts invoke `bash` via a shebang (`#!`).

```bash
echo "export VICTORIOUS_GIT_VOLUME=10" >> ~/.bashrc
```

## Development
We strongly recommend performing all development via `tests`. It becomes cumbersome to setup and re-setup different `git` scenarios without them.

Here are some common techniques:

If you would like to inspect the state of a test fixture (e.g. a debugger), then you can place an `exit` as well as echo out the `tmp_dir` in `fixture_git_init`.

If you would like to compare different states of `git` folders, then run `ls` against the respective folders you want to inspect (e.g. `.git/rebase`).

If you would like to see which `git` hooks run in a scenario, then add in all possible variations with an `echo` and see which ones run.

## Testing
Tests can be run via the following command:

```bash
test/index.sh
```

By default, we disable `test/install.sh` which runs installation tests as the current user. That test suite has the potential to destroy existing setups.

To run the install test, use the `TEST_INSTALL` environment variable:

```bash
TEST_INSTALL=TRUE test/index.sh
```

## Contributing
In lieu of a formal styleguide, take care to maintain the existing coding style. Add unit tests for any new or changed functionality. See the [Testing section](#testing) on how to run tests.

## Donating
Support this project and [others by twolfson][gratipay] via [gratipay][].

[![Support via Gratipay][gratipay-badge]][gratipay]

[gratipay-badge]: https://cdn.rawgit.com/gratipay/gratipay-badge/2.x.x/dist/gratipay.png
[gratipay]: https://www.gratipay.com/twolfson/

## Attribution
This project is inspired by @DanaDanger's  `victorious-merge`.

The linked sound clips are not owned, hosted, nor licensed by this repository. By downloading them, you are agreeing that they are exclusively for personal use and the maintainers of this repository are not legally responsible for any consequences.

## Unlicense
As of Jul 21 2015, Todd Wolfson has released this repository and its contents to the public domain.

It has been released under the [UNLICENSE][].

[UNLICENSE]: UNLICENSE
