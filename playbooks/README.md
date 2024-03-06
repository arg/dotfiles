# Ansible Playbooks

## Requirements

* Python 3

## Installation

```sh
python3 -m pip install --user ansible pyghmi
```

## Usage

```sh
ansible-playbook <name>
```

## Vault

* GPG key is required to decrypt vault's key

```sh
ansible-vault edit secrets.yml
```
