# FreeBSD 14.x

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
0 2 * * * acme /usr/bin/lockf -t 0 /tmp/.acme.sh.cronjob /usr/local/sbin/acme.sh --cron --home /var/db/acme/.acme.sh  >  /var/log/acme.sh.cronjob.log 2>&1
0 1 * * * root /usr/local/bin/sanoid  --cron --verbose --configdir /usr/local/etc/sanoid
```
