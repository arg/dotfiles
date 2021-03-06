# /home/arg/.dotfiles

## Installation

### New environment bootstrap

Should be run as `root` after installing the new environment.

#### Ubuntu 20.04

```bash
bash <(curl -sLS https://raw.github.com/arg/dotfiles/master/ubuntu/bootstrap)
```

#### FreeBSD 12.2

```bash
bash <(curl -sLS https://raw.github.com/arg/dotfiles/master/freebsd/bootstrap)
```

### Dotfiles installation

Should be run as a regular user after reboot.

```bash
bash <(curl -sLS https://raw.github.com/arg/dotfiles/master/dotfiles)
```

## Updating dotfiles

To update configs:

```bash
~/.dotfiles$ make update
```

To update secets:

```bash
~/.dotfiles$ make secrets
```

:warning: Use `gmake` instead of `make` on BSD systems.

## Key bindings

### Fish

| Key            | Action                   |
|:--------------:|--------------------------|
| <kbd>Tab</kbd> | completion               |
| <kbd>⌃C</kbd>  | clear command line       |
| <kbd>→</kbd>   | accept suggested command |

### Alacritty

| Key              | Action               |
|:----------------:|----------------------|
| <kbd>⌃V</kbd>    | paste from clipboard |
| <kbd>⇧⇞</kbd>    | scroll up            |
| <kbd>⇧⇟</kbd>    | scroll down          |
| <kbd>⇧Home</kbd> | scroll to top        |
| <kbd>⇧End</kbd>  | scroll to bottom     |


### iTerm2

| Key           | Action                  |
|:-------------:|-------------------------|
| <kbd>⌘T</kbd> | new tab                 |
| <kbd>⌘W</kbd> | close tab               |
| <kbd>⌥←</kbd> | previous tab            |
| <kbd>⌥→</kbd> | next tab                |

### Vim

| Key               | Mode | Action                 |
|:-----------------:|:----:|------------------------|
| <kbd>i</kbd>      | N    | enter insert mode      |
| <kbd>Escape</kbd> | IVC  | exit to normal mode    |
| <kbd>⌃T</kbd>     | N    | new buffer             |
| <kbd>⌃N</kbd>     | N    | open Netrw             |
| <kbd>Tab</kbd>    | N    | next buffer            |
| <kbd>⇧Tab</kbd>   | N    | previous buffer        |
| <kbd>⌃W</kbd>     | N    | close buffer           |
| <kbd>⌃O</kbd>     | N    | open file              |
| <kbd>⌃F</kbd>     | N    | search in current file |
| <kbd>⌃G</kbd>     | N    | search in all files    |
| <kbd>⌃T</kbd>     | N    | search in tags         |
| <kbd>⌃D</kbd>     | N    | duplicate a line       |
| <kbd>⌃/</kbd>     | NV   | toggle line comment    |
| <kbd>⌃L</kbd>     | N    | fix code with Ale      |
| <kbd>Space</kbd>  | N    | toggle folding         |
| <kbd>/-/</kbd>    | N    | clear selection        |
| <kbd>t-n</kbd>    | N    | run nearest test       |
| <kbd>t-f</kbd>    | N    | test current file      |
| <kbd>t-s</kbd>    | N    | run full test suite    |

### Tmux

| Key            | Action                             |
|:--------------:|------------------------------------|
| <kbd>P-r</kbd> | reload config                      |
| <kbd>P-c</kbd> | new window                         |
| <kbd>P-w</kbd> | close window                       |
| <kbd>P-,</kbd> | rename window                      |
| <kbd>P-1</kbd> | open the 1st window                |
| <kbd>P-d</kbd> | detach tmux                        |
| <kbd>P-t</kbd> | show clock                         |
| <kbd>⌥↑</kbd>  | scroll up (exit with <kbd>q</kbd>) |
| <kbd>⌃⇧←</kbd> | swap windows to the left           |
| <kbd>⌃⇧→</kbd> | swap windows to the right          |

Note: prefix (P) is set to <kbd>`</kbd> (back quote) key.

## Notes

### Explanation of key bindings

* <kbd>Key1-Key2</kbd> - press and release <kbd>Key1</kbd>, then press <kbd>Key2</kbd>
* <kbd>Key1Key2</kbd> - press <kbd>Key1</kbd> and then <kbd>Key2</kbd> while holding <kbd>Key1</kbd>
* <kbd>⌘</kbd> - Command
* <kbd>⌥</kbd> - Option (Alt)
* <kbd>⌃</kbd> - Control
* <kbd>⇧</kbd> - Shift
