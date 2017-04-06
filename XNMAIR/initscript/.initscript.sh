#!/usr/bin/env bash

# Initscript for XNMAIR

# Find if ClipIt is running, otherwise start it
clipit_is_running="$(ps aux | grep -i clipit | wc -l)"

if [[ clipit_is_running -eq 1 ]]
then
    clipit &
fi

# Mount backup disk if available
# TODO: Check if backup disk is available
#udisksctl mount -b /dev/sda2 || true

# Start monitor if connected
setup_display -s || true

# Adjust keyboard keys
xmodmap ~/.xmodmaprc

# Natural scrolling
synclient VertScrollDelta=-111 HorizEdgeScroll=1 VertEdgeScroll=1
