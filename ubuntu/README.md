# Ubuntu 24.04+ server setup

I use Ansible to setup/configure my Ubuntu 24.04+ servers.

## Prerequisites

Install [Ansible](https://www.redhat.com/en/ansible-collaborative) and [Sshpass](https://sourceforge.net/projects/sshpass/) on your local machine:

```bash
brew install ansible sshpass
```

## Ubuntu 24.04+ installation

1. Download Ubuntu Server from https://ubuntu.com/download/server
2. Create a bootable USB drive using [Balena Etcher](https://etcher.balena.io) (MacOS) or [Rufus](https://rufus.ie/) (Windows). Both tools are free.
3. Boot from the USB drive and install Ubuntu Server:
   - Create `arg` user

## Server setup

Run the following command from `~/.dotfiles/playbooks/` directory:

```bash
ansible-playbook --ask-pass --ask-become-pass server/setup.yml
```

Make sure to enter your `arg` user password when prompted.
