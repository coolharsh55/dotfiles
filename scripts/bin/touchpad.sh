#!/usr/bin/env bash

# Script to initialise touchpad controls and scrolling
# Will enable natural scrolling
# Will enable palm detection

# Uses the following values
SCROLLDISTANCE=-11  # negative value is for natural scrolling
EDGE_SCROLL=1  # C-style integer boolean values
TWO_FINGER_SCROLL=1  # C-style integer boolean values
PALM_DETECTION=1 # boolean

# this controls logging and debug output
log() {
    LOGFLAG=false
    if $LOGFLAG;
    then
        printf "%s\n" "$1"
    fi
}

# Get the touchpad for the device
TOUCHPAD=$(xinput | grep 'Touchpad' | grep -oP 'id=\K(\d+)')
log "TOUCHPAD=$TOUCHPAD"
DEVICE_PROPERTIES=$(xinput list-props "${TOUCHPAD}")
log "DEVICE PROPERTIES \n $DEVICE_PROPERTIES"

PROPERTY_SCROLLDISTANCE=$(echo "${DEVICE_PROPERTIES}" | grep -oP 'Synaptics Scrolling Distance \(\K(\d+)')
log "SCROLLDISTANCE ID=$PROPERTY_SCROLLDISTANCE"
xinput set-prop "$TOUCHPAD" "$PROPERTY_SCROLLDISTANCE" "$SCROLLDISTANCE" "$SCROLLDISTANCE"

PROPERTY_EDGESCROLL=$(echo "${DEVICE_PROPERTIES}" | grep -oP 'Synaptics Edge Scrolling \(\K(\d+)')
log "EDGE_SCROLL ID=$PROPERTY_EDGESCROLL"
xinput set-prop "$TOUCHPAD" "$PROPERTY_EDGESCROLL" "$EDGE_SCROLL" "$EDGE_SCROLL" 0

PROPERTY_TWO_FINGER_SCROLL=$(echo "${DEVICE_PROPERTIES}" | grep -oP 'Synaptics Two-Finger Scrolling \(\K(\d+)')
log "TWO_FINGER_SCROLL ID=$PROPERTY_TWO_FINGER_SCROLL"
xinput set-prop "$TOUCHPAD" "$PROPERTY_TWO_FINGER_SCROLL" "$TWO_FINGER_SCROLL" "$TWO_FINGER_SCROLL"

PROPERTY_PALM_DETECTION=$(echo "${DEVICE_PROPERTIES}" | grep -oP 'Synaptics Palm Detection \(\K(\d+)')
log "PALM_DETECTION ID=$PROPERTY_PALM_DETECTION"
xinput set-prop "$TOUCHPAD" "$PROPERTY_PALM_DETECTION" "$PALM_DETECTION"

# palm detection
syndaemons="$(pgrep syndaemon | wc -l)"
if [ "$syndaemons" -ne 0 ]
then
    pkill syndaemon
fi
syndaemon -i 0.5 -t -K -R &
