# AGENTS.md

Personal dotfiles of user `arg` plus home-network infrastructure: Ansible for the Ubuntu server `polaris`, Cloudflare
DNS in Terraform, and the `arg.network` dashboard site.

## Layout

| Path                      | Purpose                                                                                                                                                                              |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `home/`                   | Files mirrored into `$HOME`. `make configs` symlinks each one to the same path under `$HOME` (existing paths are skipped), so editing a file here edits the live config.             |
| `home/.local/bin/`        | Personal Bash scripts.                                                                                                                                                               |
| `home/.homebrew/Brewfile` | macOS Homebrew packages.                                                                                                                                                             |
| `playbooks/`              | Ansible. Run everything from this directory: `ansible.cfg` sets the inventory, SSH key and vault password script.                                                                    |
| `playbooks/server/`       | `setup.yml` imports `setup/<topic>.yml` with a tag per topic. Also `maintenance.yml`, `reboot.yml`, `shutdown.yml`, `ping.yml`, Jinja2 `templates/<topic>/*.j2` and static `files/`. |
| `playbooks/docker/`       | Docker Compose stack lifecycle on `docker_hosts`: `start`, `stop`, `restart`, `upgrade`, `prune`.                                                                                    |
| `playbooks/group_vars/`   | `all.yml` holds global vars. `servers/<topic>.yml` holds one top-level dict per topic. `servers/secrets.yml` is Ansible Vault-encrypted.                                             |
| `terraform/`              | Cloudflare DNS records for `arg.network`.                                                                                                                                            |
| `docs/`                   | Jekyll site (`github-pages` gem) rendered at https://arg.network, a home network dashboard. Its data lives in `_data/*.yml`.                                                         |
| `macos/`                  | Terminal.app profile, iTerm2 plist, `user.css`.                                                                                                                                      |
| `fedora/`, `freebsd`      | Legacy configurations, not used anymore, left for historical reference.                                                                                                              |
| `Makefile`                | Bootstrap script to symlink dotfiles.                                                                                                                                                |

## Commands

### Ansible commands

Run from `~/.dotfiles/playbooks/`.

Check syntax:

```sh
ansible-playbook --syntax-check <playbook>
```

Dry run against the server:

```sh
ansible-playbook <playbook> --check --diff [--tags <tag>]
```

Apply changes to the server:

```sh
ansible-playbook <playbook> [--tags <tag>]
```

## Facts

- **Vault:** the vault password is `playbooks/vault_password.enc`, a GPG message that `bin/gpg_wrapper.sh` decrypts through gpg-agent.
- **Polaris over SSH:** `ssh polaris.arg.network` is key-based. Its login shell is fish, so run Bash through `ssh polaris.arg.network bash -s <<'EOF' … EOF`.

## Code style

**General**

- Indent with 2 spaces. Tabs appear only in `Makefile`, `home/.gitconfig` and `macos/`.
- No comments in code or config files.
- Commit subjects are short and capitalized, with no trailing period and no type prefix (e.g. "Install TreeSitter's CLI").

**Ansible**

- Double-quote every string scalar: `name`, `register`, `when`, `hosts`, paths, and modes (`"0644"`). Leave numbers and `true`/`false` unquoted.
- Use FQCN modules (`ansible.builtin.*`, `ansible.posix.*`, `community.general.*`, `community.docker.*`). Only `import_tasks` is used unqualified.
- Don't start files with `---`.
- Give every task a sentence-case, imperative `name`. `import_tasks` entries are the only tasks without one.
- For a new setup topic, add `server/setup/<topic>.yml` and import it in `server/setup.yml` with `tags: ["<topic>"]`. If it needs vars, put them in `group_vars/servers/<topic>.yml`.
- Don't hardcode the user or home paths. Use `ansible_user`, `home_directory`, `docker_directory` and `scripts_directory` from `group_vars/all.yml`.
- Skip unnecessary work: `register` the result and gate follow-up tasks with `when: "<var>.changed"`.
- Read-only probe tasks set `changed_when: false`, `failed_when: false` and `check_mode: false`.
- Tasks that touch `secrets.*` set `no_log: true`.
- apt package installs must set `install_recommends: false`.
- Install only the packages that were explicitly asked for.
- systemd units and drop-ins go under `{{ systemd.path }}` (`/usr/lib/systemd`), all in one location.
- GitHub release tools go in `packages.github` with a pinned `version`, a `sha256`, and a `{version}` placeholder in `url`. Downloads go to `/tmp`.
- Verbose loops (GitHub packages, registered results) set `loop_control: label:`.

**Neovim** (`home/.config/nvim/init.lua`)

- Lua with double quotes. Sections are wrapped in `{{{ }}}` fold markers. Keymaps carry a `desc`.
- Pin every lazy.nvim plugin by `commit = "<sha>"`, with a trailing comment like `-- v1.2.3+4 (YYYY-MM-DD)` or `-- main@YYYY-MM-DD`.
- When updating a plugin, pick a release published at least a week ago.

**Shell**

- Scripts in `home/.local/bin/` use `#!/usr/bin/env bash` and `[[ … ]]`.
- Shell templates deployed by Ansible use `#!/bin/sh`, usually with `set -eu`.
- Custom fish commands (`e`, `tm`, `archive`, …) declare named args (`-a`) and a description (`-d`). Platform differences are handled with `uname` checks.

## Boundaries

**Allowed without asking**

- Read-only commands: `git status`/`diff`/`log`, `rg`, `ansible-playbook --syntax-check`, `terraform validate`.
- Read-only diagnostics on Polaris over SSH.

**Ask first**

- `ansible-playbook` runs without `--check`. They change the live server.
- Any `playbooks/docker/*.yml` run. Starting the stack is intentionally manual.
- Adding packages to `packages.apt.install`, `packages.github` or the Brewfile.
- `git commit` and `git push`.

**Never**

- Run interactive commands such as `make secrets` (1Password sign-in) or `ansible-vault edit`.
- Print or commit decrypted vault contents.
- Let Docker publish ports past UFW. `files/docker/daemon.json` binds published ports to `127.0.0.1`, and Docker must respect UFW rules.
- Use unpinned Neovim plugins, or GitHub packages without a `sha256`.
