# /home/arg/.dotfiles

## Installation

### New machine setup

* Ubuntu 20.04
  ```bash
  bash <(curl -sLS https://raw.github.com/arg/dotfiles/master/new_ubuntu)
  ```
* MacOS 10.14
  ```bash
  # TODO
  ```

### Dotfiles installation
```bash
bash <(curl -sLS https://raw.github.com/arg/dotfiles/master/install)
```

## Zsh

### Key bindings

| Key | Action                  |
|:---:|-------------------------|
|<kbd>Tab</kbd>| completion |
|<kbd>⌃C</kbd>| clear command line |
|<kbd>⌃R</kbd>| search in history |
|<kbd>⌘←</kbd>| beginning of line |
|<kbd>⌘→</kbd>| end of line |

## iTerm2

### Key bindings

| Key | Action                  |
|:---:|-------------------------|
|<kbd>⌘T</kbd>| new tab |
|<kbd>⌘W</kbd>| close tab |
|<kbd>⌥←</kbd>| previous tab |
|<kbd>⌥→</kbd>| next tab |

## Vim

### Settings

* Buffers are saved automatically after exiting from Insert mode or making changes in Normal mode.

### Key bindings

| Key | Mode | Action             |
|:---:|:----:|--------------------|
|<kbd>i</kbd>| N | enter insert mode |
|<kbd>Escape</kbd>| IVC | exit to normal mode |
|<kbd>⌃H</kbd>| IV | cursor left |
|<kbd>⌃J</kbd>| IV | cursor down |
|<kbd>⌃K</kbd>| IV | cursor up |
|<kbd>⌃L</kbd>| IV | cursor right |
|<kbd>⌃T</kbd>| N | new buffer |
|<kbd>⌃N</kbd>| N | toggle NERDTree |
|<kbd>⌃H</kbd>| N | previous buffer |
|<kbd>⌃L</kbd>| N | next buffer |
|<kbd>Tab</kbd>| N | next buffer |
|<kbd>⌃W</kbd>| N | close buffer |
|<kbd>⌃O</kbd>| N | open file |
|<kbd>⌃F</kbd>| N | search in current file |
|<kbd>⌃G</kbd>| N | search in all files |
|<kbd>⌃D</kbd>| N | duplicate a line |
|<kbd>⌃/</kbd>| NV | toggle line comment |
|<kbd>F3</kbd>| N | go to definition |
|<kbd>F5</kbd>| N | format code |
|<kbd>⌃B</kbd>| N | list of buffers |
|<kbd>⌃U</kbd>| N | toggle UndoTree |
|<kbd>Space</kbd>| N | toggle folding |
|<kbd>⌃X</kbd>| V | cut to clipboard |
|<kbd>⌃C</kbd>| V | copy to clipboard |
|<kbd>⌃V</kbd>| I | paste from clipboard |

## Tmux

Always attach/create session via:

```bash
tmux a -t main
```

### Key bindings

| Key | Action                  |
|:---:|-------------------------|
|<kbd>P-r</kbd>| reload config |
|<kbd>P-n</kbd>| new window |
|<kbd>P-w</kbd>| close window |
|<kbd>P-s</kbd>| search for window |
|<kbd>P-]</kbd>| next window |
|<kbd>P-[</kbd>| previous window |
|<kbd>P-h</kbd>| split window horizontally |
|<kbd>P-v</kbd>| split window vertically |
|<kbd>P-,</kbd>| rename window |
|<kbd>P-:</kbd>| enter command |
|<kbd>P-1</kbd>| open the 1st window |
|<kbd>P-d</kbd>| detach tmux |
|<kbd>P-t</kbd>| show clock |
|<kbd>P-m</kbd>| enable mouse |
|<kbd>P-M</kbd>| disable mouse |
|<kbd>⌥↑</kbd>| scrollback (exit with `q`) |

#### About prefix

Prefix (P) is set to <kbd>`</kbd> (back quote) key.

## Visual Studio Code

### Configuration

Configuration is stored in a separate gist.

### Key bindings

| Key | Action |
|:---:|-------------------------|
|<kbd>⌘T</kbd>| toggle terminal |
|<kbd>⌘P</kbd>| open file |
|<kbd>⌘⇧P</kbd>| execute command |
|<kbd>⌥F</kbd>| format code |
|<kbd>F3</kbd>| go to definition |
|<kbd>⌘J</kbd>| go to symbol |
|<kbd>⌘F</kbd>| search in current file |
|<kbd>⌘R</kbd>| replace in current file |
|<kbd>⌘B</kbd>| toggle sidebar |
|<kbd>F2</kbd>| rename symbol |
|<kbd>⌘F2</kbd>| rename all symbol occurrences |
|<kbd>⌘⌥←</kbd>| previous file |
|<kbd>⌘⌥→</kbd>| next file |
|<kbd>⌘W</kbd>| close file |
|<kbd>⌘⇧F</kbd>| find in files |
|<kbd>⌘⇧R</kbd>| replace in files |
|<kbd>⌘/</kbd>| toggle line comment |
|<kbd>⌘D</kbd>| copy line down |
|<kbd>⌘⌥D</kbd>| copy line up |

## Notes

### Explanation of key bindings

* <kbd>Key1-Key2</kbd> - press and release <kbd>Key1</kbd>, then press <kbd>Key2</kbd>
* <kbd>Key1Key2</kbd> - press <kbd>Key1</kbd> and then <kbd>Key2</kbd> while holding <kbd>Key1</kbd>
* <kbd>⌘</kbd> - Command
* <kbd>⌥</kbd> - Option (Alt)
* <kbd>⌃</kbd> - Control
* <kbd>⇧</kbd> - Shift

