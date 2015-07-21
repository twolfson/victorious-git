# victorious-git [![Build status](https://travis-ci.org/twolfson/victorious-git.png?branch=master)](https://travis-ci.org/twolfson/victorious-git)

Play fanfare after triumphing over `git` conflicts

This is heavily inspired by @DanaDanger's `victorious-merge`

**Features:**

- Plays fanfare on resolution of `git` conflicts from:
    - [x] `merge`
    - [ ] `rebase` (pending testing)
    - [ ] `cherry-pick` (pending testing)
- Doesn't play fanfare on trivial merge (i.e. no conflicts/conflicts automatically resolved)
- Cross-platform support on GNU/Linux and OS X
- Play custom fanfare
- Support for `git>=1.7` and `git>=2.0`

// TODO: Define `play-victory.sh` to test out new sounds

## Getting Started
### Preface
Before we get to the fun part (runnning this), we should cover what's going on and the reprecussions. We are using a setting in `git` known as `init.templatedir`. As the name implies, this is a folder that is used to initialize all future `.git` folders.

We are overriding the entire `.git/hooks` folder default ([typically full of samples][git-hooks-default]). As a result, we will also be conflicting with per-repo hooks (e.g. some teams like to enforce linting on each commit). So here is your warning:

[git-hooks-default]: https://github.com/git/git/tree/v2.4.6/templates

## `victorious-git` adjusts with your `.git/hooks` folder for all future repositories. Please take caution and be aware that this will adjust future `.git/hooks` interactions, such as before/after commits occur.

### One line install
The following installs `victorious-git` to `~/.config/victorious-git` and sets up a **user-wide** `init.templatedir`.

```bash
(cd /tmp/ && git clone --depth 1 https://github.com/twolfson/victorious-git && cd victorious-git && bin/install.sh)
```

```
# TODO: Download sound
# TODO: Allow sound customization
# TODO: install.sh
target_dir="~/.config/victorious-git/templatedir/"
mkdir -p "$target_dir"
cp hooks/* "$target_dir"
"$target_dir/hooks/play-victory.sh" # Congrats on successful install ;)
```

- TODO: Base off of `sexy-bash-prompt`
- TODO: During installation, install hooks via git-template-dir
    - Prob make `hooks/` our main directory (e.g. our `lib/`)?
- TODO: Include instructions on symlinking `hooks` directory for future updates
- TODO: Allow for overriding with custom sound file during install
- TODO: List out cases we cover (e.g. merge, rebase?, cherry-pick?)
- TODO: Add tests with custom player (effectively `true` or maybe script that writes out to a file?)

## Documentation
_(Coming soon)_

## Examples
_(Coming soon)_

## Contributing
In lieu of a formal styleguide, take care to maintain the existing coding style. Add unit tests for any new or changed functionality. Lint via `npm run lint` and test via `npm test`.

## Donating
Support this project and [others by twolfson][gratipay] via [gratipay][].

[![Support via Gratipay][gratipay-badge]][gratipay]

[gratipay-badge]: https://cdn.rawgit.com/gratipay/gratipay-badge/2.x.x/dist/gratipay.png
[gratipay]: https://www.gratipay.com/twolfson/

## Unlicense
As of Jul 21 2015, Todd Wolfson has released this repository and its contents to the public domain.

It has been released under the [UNLICENSE][].

[UNLICENSE]: UNLICENSE
