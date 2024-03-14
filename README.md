# /home/arg/.dotfiles

![desktop](https://user-images.githubusercontent.com/1044277/167194297-f48bbc21-fd73-4840-8b16-e434b8f21082.png)

<p align="center">
FreeBSD, i3, Fish, Alacritty, Tmux, Neovim, Dmenu, Polybar, Firefox, Thunderbird. Everything gruvboxed.
</p>

## Installation

### New environment bootstrap

Run as `root` on a new environment:

#### Ubuntu 22.04

```bash
bash <(curl -sLS https://raw.github.com/arg/dotfiles/master/ubuntu/bootstrap)
```

#### FreeBSD 13.x

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
