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

## Getting Started
- TODO: Base off of `sexy-bash-prompt`
- TODO: During installation, install hooks via git-template-dir
    - Prob make `hooks/` our main directory (e.g. our `lib/`)?
- TODO: Include instructions on symlinking `hooks` directory for future updates
- TODO: Allow for overriding with custom sound file during install
- TODO: List out cases we cover (e.g. merge, rebase?, cherry-pick?)

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
