#!/usr/bin/env bash

# Prints current date
selected=$(
    zenity --list --title=Tea --column=name --text="text" \
        "$(date +%d/%m/%Y)" \
        "$(date +%Y-%m-%d)" \
    
    )

if [[ -z $selected ]]
then
    echo -n $(date +%Y-%m-%d)
    exit 0;
fi

echo "$selected"

