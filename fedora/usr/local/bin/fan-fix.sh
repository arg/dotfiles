#!/bin/sh

set -eu

for f in /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference; do
 echo balance_power > "$f"
done
