#!/usr/bin/env bash

# Script to initialise touchpad controls and scrolling
# Will enable natural scrolling
# Will enable palm detection

# Natural scrolling
SCROLLSPEED=-22
TOUCHPAD="$(xinput | grep 'Touchpad' | grep -oP 'id=(\d+)' | sed 's/id=//g')"
xinput set-prop $TOUCHPAD 279 $SCROLLSPEED $SCROLLSPEED
xinput set-prop $TOUCHPAD 281 1 1
xinput set-prop $TOUCHPAD 292 1 

# palm detection
SYNDAEMONS="$(pgrep syndaemon | wc -l)"
if [ "$SYNDAEMONS" -ne 0 ]
then
    pkill syndaemon
fi
syndaemon -i 0.5 -t -K -R &
