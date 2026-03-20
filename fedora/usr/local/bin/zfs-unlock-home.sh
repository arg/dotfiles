#!/bin/sh

set -eu
exec /usr/sbin/zfs load-key zroot/home < "$CREDENTIALS_DIRECTORY/zfs-home.passphrase"
