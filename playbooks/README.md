# Ansible Playbooks

## Requirements

* Python 3

## Installation

Install Ansible either via Homebrew (macOS) or with:

```sh
python3 -m pip install --user ansible
```

## Usage

```sh
ansible-playbook <name> [--tags <tag>]
```

### Fresh server installation

Install Ubuntu Server with `arg` user account and SSH server enabled. Then run the following commands:

```sh
ssh-copy-id -i ~/.ssh/network.pub <user>@<server>
ansible-playbook server/setup.yml -K
ansible-playbook server/reboot.yml
ansible-playbook docker/start.yml
```

These commands will configure the server, reboot it, and start Docker (assuming server's IP address is already added to
`inventory.yml`).

## Vault

* GPG key is required to decrypt vault's key

```sh
EDITOR=nano ansible-vault edit group_vars/servers/secrets.yml
```
