# Ansible Playbooks

## Requirements

* Python 3

## Installation

Install Ansible either via Homebrew (MacOS) or with:

```sh
python3 -m pip install --user ansible pyghmi
```

## Usage

```sh
ansible-playbook <name> [--tags <tag>]
```

## Vault

* GPG key is required to decrypt vault's key

```sh
EDITOR=nano ansible-vault edit secrets.yml
```
