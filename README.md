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

### i3

| Key                | Action                                       |
|:------------------:|----------------------------------------------|
| <kbd>⌘⇧Q</kbd>     | quit active application                      |
| <kbd>⌘⇧R</kbd>     | restart i3                                   |
| <kbd>⌘⇧E</kbd>     | exit i3                                      |
| <kbd>⌘⏎</kbd>      | open terminal (Alacritty)                    |
| <kbd>⌘D</kbd>      | open application launcher (dmenu)            |
| <kbd>⌘0</kbd>      | lock the machine                             |
| <kbd>⌘P</kbd>      | take screenshot                              |
| <kbd>⌘H</kbd>      | move focus to the left                       |
| <kbd>⌘J</kbd>      | move focus to the bottom                     |
| <kbd>⌘K</kbd>      | move focus to the top                        |
| <kbd>⌘L</kbd>      | move focus to the right                      |
| <kbd>⌘⇧H</kbd>     | move active window to the left               |
| <kbd>⌘⇧J</kbd>     | move active window to the bottom             |
| <kbd>⌘⇧K</kbd>     | move active window to the top                |
| <kbd>⌘⇧L</kbd>     | move active window to the right              |
| <kbd>⌘↹</kbd>      | cycle current <-> previous workspace         |
| <kbd>⌘C</kbd>      | set split direction to horizontal            |
| <kbd>⌘V</kbd>      | set split direction to vertical              |
| <kbd>⌘F</kbd>      | toggle fullscreen for active window          |
| <kbd>⌘⇧F</kbd>     | toggle floating for active window            |
| <kbd>⌘<1-8></kbd>  | go to workspace 1-8                          |
| <kbd>⌘⇧<1-8></kbd> | move window to workspace 1-8                 |
| <kbd>⌘R</kbd>      | toggle resize mode                           |
| <kbd>H</kbd>       | decrease active window width in resize mode  |
| <kbd>J</kbd>       | increase active window height in resize mode |
| <kbd>K</kbd>       | decrease active window height in resize mode |
| <kbd>L</kbd>       | increase active window width in resize mode  |

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
| <kbd>⌃N</kbd>  | N    | open file tree                  |
| <kbd>⌃M</kbd>  | N    | open symbols browser            |
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
| <kbd>⇧J</kbd>  | N    | page down                       |
| <kbd>⇧K</kbd>  | N    | page up                         |
| <kbd>⌃H</kbd>  | N    | navigate left                   |
| <kbd>⌃J</kbd>  | N    | navigate down                   |
| <kbd>⌃K</kbd>  | N    | navigate up                     |
| <kbd>⌃L</kbd>  | N    | navigate right                  |
| <kbd>⌃⎵</kbd>  | N    | toggle folding                  |
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
| <kbd>P-c</kbd> | new window                         |
| <kbd>P-w</kbd> | close window                       |
| <kbd>P-,</kbd> | rename window                      |
| <kbd>P-d</kbd> | detach Tmux                        |
| <kbd>P-t</kbd> | show clock                         |
| <kbd>P-k</kbd> | copy mode (exit with <kbd>q</kbd>) |
| <kbd>P-h</kbd> | swap windows to the left           |
| <kbd>P-l</kbd> | swap windows to the right          |
| <kbd>⌃b</kbd>  | scroll page up in copy mode        |
| <kbd>⌃f</kbd>  | scroll page down in copy mode      |

Prefix (P) is set to <kbd>`</kbd> (back quote).

### Zathura

| Key           | Action                      |
|:-------------:|-----------------------------|
| <kbd>q</kbd>  | quit Zathura                |
| <kbd>]</kbd>  | zoom in                     |
| <kbd>[</kbd>  | zoom out                    |
| <kbd>0</kbd>  | zoom default                |
| <kbd>h</kbd>  | previous page               |
| <kbd>j</kbd>  | scroll down                 |
| <kbd>k</kbd>  | scroll up                   |
| <kbd>l</kbd>  | next page                   |
| <kbd>x</kbd>  | toggle rendering mode       |
| <kbd>c</kbd>  | recolor (Gruvbox the page!) |
| <kbd>r</kbd>  | rotate                      |

## Notes

* <kbd>Key1-Key2</kbd> - press and release <kbd>Key1</kbd>, then press <kbd>Key2</kbd>
* <kbd>Key1Key2</kbd> - press <kbd>Key1</kbd> and then <kbd>Key2</kbd> while holding <kbd>Key1</kbd>
* <kbd>⌘</kbd> - Command
* <kbd>⌥</kbd> - Option (Alt)
* <kbd>⌃</kbd> - Control
* <kbd>⇧</kbd> - Shift
