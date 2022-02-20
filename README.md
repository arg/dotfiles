# /home/arg/.dotfiles

## Installation

### New environment bootstrap

Run as `root` on a new environment:

#### Ubuntu 20.04

```bash
bash <(curl -sLS https://raw.github.com/arg/dotfiles/master/ubuntu/bootstrap)
```

#### FreeBSD 13.0

```bash
bash <(curl -sLS https://raw.github.com/arg/dotfiles/master/freebsd/bootstrap)
```

### Dotfiles installation

Run as your regular user:

```bash
bash <(curl -sLS https://raw.github.com/arg/dotfiles/master/dotfiles)
```

## Updating dotfiles

Pull latest changes from GitHub and update configuration files:

```bash
~/.dotfiles$ make update
```

Update configuration files without pulling from GitHub:

```bash
~/.dotfiles$ make configs
```

Update secrets:

```bash
~/.dotfiles$ make secrets
```

:warning: Use `gmake` instead of `make` on BSD systems.

## Key bindings

### Fish

| Key           | Action                   |
|:-------------:|--------------------------|
| <kbd>↹</kbd>  | completion               |
| <kbd>⌃C</kbd> | clear command line       |
| <kbd>⌃D</kbd> | close shell              |
| <kbd>⌃⎵</kbd> | accept suggested command |

### Alacritty

| Key           | Action               |
|:-------------:|----------------------|
| <kbd>⌃P</kbd> | paste from clipboard |
| <kbd>⌥K</kbd> | scroll up            |
| <kbd>⌥J</kbd> | scroll down          |
| <kbd>⌥H</kbd> | scroll to top        |
| <kbd>⌥L</kbd> | scroll to bottom     |


### iTerm2

| Key           | Action       |
|:-------------:|--------------|
| <kbd>⌘T</kbd> | new tab      |
| <kbd>⌘W</kbd> | close tab    |
| <kbd>⌥←</kbd> | previous tab |
| <kbd>⌥→</kbd> | next tab     |

### Vim

| Key            | Mode | Action                          |
|:--------------:|:----:|---------------------------------|
| <kbd>⌃T</kbd>  | N    | new buffer                      |
| <kbd>⌃N</kbd>  | N    | open Netrw                      |
| <kbd>↹</kbd>   | N    | next buffer                     |
| <kbd>⇧↹</kbd>  | N    | previous buffer                 |
| <kbd>⌃W</kbd>  | N    | close buffer                    |
| <kbd>⌃O</kbd>  | N    | open file                       |
| <kbd>⌃G</kbd>  | N    | search in all files             |
| <kbd>⌃F</kbd>  | N    | LSP search in current file      |
| <kbd>⌃T</kbd>  | N    | LSP search in all files         |
| <kbd>⌃/</kbd>  | NV   | toggle line comment             |
| <kbd>⌃S</kbd>  | N    | format code                     |
| <kbd>⌃Q</kbd>  | N    | open terminal                   |
| <kbd>⌃Q</kbd>  | T    | unfocus terminal                |
| <kbd>⌃]</kbd>  | N    | go to definition                |
| <kbd>⌃H</kbd>  | N    | navigate left                   |
| <kbd>⌃J</kbd>  | N    | navigate down                   |
| <kbd>⌃K</kbd>  | N    | navigate up                     |
| <kbd>⌃L</kbd>  | N    | navigate right                  |
| <kbd>⌃P</kbd>  | N    | previous item in list           |
| <kbd>⌃N</kbd>  | N    | next item in list               |
| <kbd>⏎</kbd>   | N    | toggle folding                  |
| <kbd>/-/</kbd> | N    | clear selection                 |
| <kbd>t-n</kbd> | N    | run nearest test                |
| <kbd>t-f</kbd> | N    | test current file               |
| <kbd>t-s</kbd> | N    | run full test suite             |
| <kbd>⌃⎵</kbd>  | I    | show completion suggestions (C) |
| <kbd>↹</kbd>   | I(C) | next completion suggestion      |
| <kbd>⇧↹</kbd>  | I(C) | previous completion suggestion  |
| <kbd>⏎</kbd>   | I(C) | accept completion suggestion    |

Leader key is set to <kbd>⎵</kbd> (space).

### Tmux

| Key            | Action                             |
|:--------------:|------------------------------------|
| <kbd>P-r</kbd> | reload configuration               |
| <kbd>P-c</kbd> | new window                         |
| <kbd>P-w</kbd> | close window                       |
| <kbd>P-,</kbd> | rename window                      |
| <kbd>P-d</kbd> | detach Tmux                        |
| <kbd>P-t</kbd> | show clock                         |
| <kbd>⌥↑</kbd>  | scroll up (exit with <kbd>q</kbd>) |
| <kbd>⌃⇧←</kbd> | swap windows to the left           |
| <kbd>⌃⇧→</kbd> | swap windows to the right          |

Prefix (P) is set to <kbd>`</kbd> (back quote).

## Notes

* <kbd>Key1-Key2</kbd> - press and release <kbd>Key1</kbd>, then press <kbd>Key2</kbd>
* <kbd>Key1Key2</kbd> - press <kbd>Key1</kbd> and then <kbd>Key2</kbd> while holding <kbd>Key1</kbd>
* <kbd>⌘</kbd> - Command
* <kbd>⌥</kbd> - Option (Alt)
* <kbd>⌃</kbd> - Control
* <kbd>⇧</kbd> - Shift
