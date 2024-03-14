# Ubuntu Server 22.04

## Cron jobs

### arg

```
# Backup to B2
0 6 * * * backup archives b2
0 7 * * * backup backups b2
0 8 * * * backup documents b2
0 9 * * * backup literature b2
0 10 * * * backup photos b2
0 11 * * * backup videos b2
# Backup to Google Drive
0 12 * * * backup documents gdrive
0 13 * * * backup literature gdrive
# Backup to Google Photos
0 14 * * * backup photos gphotos
# Backup to Hetzner
0 17 * * * backup archives hetzner
0 18 * * * backup backups hetzner
0 19 * * * backup documents hetzner
0 20 * * * backup literature hetzner
0 21 * * * backup photos hetzner
0 22 * * * backup videos hetzner
```

### root

```
45 23 * * * zfs-auto-snapshot --quiet --syslog --label=daily --prefix=cron --skip-scrub --recursive --keep=30 archive
```

## ZFS tweaks

### Disable frequent snapshots creation

```sh
zfs set com.sun:auto-snapshot:frequent=false <dataset>
```

### Disable `zfs-auto-snapshot` completely

```sh
zfs set com.sun:auto-snapshot=false <dataset>
```
