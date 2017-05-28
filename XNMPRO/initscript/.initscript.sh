#!/usr/bin/env bash

# Initscript for XNMPRO

# Find if ClipIt is running, otherwise start it
clipit_is_running="$(ps aux | grep -i clipit | wc -l)"
if [[ clipit_is_running -eq 1 ]]
then
    clipit &
fi

# Mount backup disk if available
# TODO: Check if backup disk is available
udisksctl mount -b /dev/sda2 || true

# Start monitor if connected
~/bin/setup_display --auto >> ~/.display.log 2>&1 || true

# Natural Scrolling
# xinput --set-prop 11 279 -50, -50
synclient VertScrollDelta=-111 HorizEdgeScroll=1 VertEdgeScroll=1
xinput set-prop 10 279 -22 -22
xinput set-prop 10 281 1 1
xinput set-prop 10 292 1


# Adjust keyboard keys
xmodmap ~/.xmodmaprc

# disable touchpad when typing
syndaemon -i 0.5 -t -K -R &

