#!/bin/sh
gpg --batch --use-agent --decrypt --quiet "$(dirname "$0")/../vault_password.enc"
