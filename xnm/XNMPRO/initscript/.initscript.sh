#!/usr/bin/env bash

# Initscript for XNMPRO

# Find if ClipIt is running, otherwise start it
clipit_is_running="$(pgrep clipit | wc -l)"
if [ "$clipit_is_running" -eq 0 ]
then
    clipit &
fi

# Mount backup disk if available
udisksctl mount -b /dev/sda2 || true

# Start monitor if connected
~/bin/setup_display --auto >> ~/.display.log 2>&1 || true

# Adjust keyboard keys
xmodmap ~/.xmodmaprc
