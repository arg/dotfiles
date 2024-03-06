#!/usr/bin/env bash

print_error () {
  echo $1
  echo "Status: *******************************************************************************"
  /sbin/zpool status
  echo "List: *********************************************************************************"
  /sbin/zpool list
  exit 1
}

pool_statuses=$(/sbin/zpool list -H -o name,health,capacity)

error_statuses=$(grep -v 'ONLINE' <<< $pool_statuses)
if test -n "$error_statuses"; then
  print_error "Some pools are in error state"
fi

capacities=$(awk '{print $3}' <<< $pool_statuses | cut -d'%' -f1)
for capacity in $capacities; do
  if test $capacity -ge 80; then
    print_error "Some pools are approaching their maximum capacity"
  fi
done

printf "%s: %s (%s)\n" $pool_statuses | awk 'ORS=", "' | sed 's/,\s$/\n/'
