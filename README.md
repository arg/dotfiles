# /home/arg/.dotfiles

![theme-min](https://user-images.githubusercontent.com/1044277/162889532-264523d3-289c-445d-9bca-186cf08b4fcd.png)

<p align="center">
FreeBSD/Arch, i3, Fish, Alacritty, Tmux, Neovim, Dmenu, Polybar, Firefox, Thunderbird. Everything gruvboxed.
</p>

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
