#!/usr/bin/env bash

pkill waybar
while pgrep -u $UID -x waybar >/dev/null; do sleep 1; done
waybar &
