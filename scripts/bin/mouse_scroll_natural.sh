#!/usr/bin/env bash

# turn on natural scrolling for connected wireless mouse
# author: Harshvardhan J. Pandit

DEBUG=true;

debug() {
    if [ "$DEBUG" = true ]
    then
        echo "$1";
    fi
}

# Identify wireless mouse
connected_devices=$(xinput list | grep "Mouse" | grep -v "DLL")

# If no mouse is connected, quit
if [[ -z $connected_devices ]]; then
    echo "no wireless mouse is connected"
    exit 1;
fi
# debug "devices = $connected_devices"

# Set natural scrolling for device
while IFS= read -r line; do
    connected_device_id=$(echo $line | sed -n 's/.*id=\([0-9]\+\).*/\1/p')
    debug "device = $connected_device_id"
    # Identify property associated with natural scrolling
    natural_scrolling_property=$(
        xinput list-props "${connected_device_id}" |
        grep "Natural Scrolling" | 
        head -n 1 | 
        sed -n 's/.*(\([0-9]\+\)).*/\1/p'
    )
    debug "scrolling property = $natural_scrolling_property"
    xinput set-prop $connected_device_id $natural_scrolling_property 1
done <<< $connected_devices 
debug "natural scrolling set"
