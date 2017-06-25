#!/usr/bin/env bash

# author: Harshvardhan Pandit
# Tea list

selected=$(
    zenity --list --title=Tea --column=name --text="text" \
    "Irish Cream" \
    "Ginseng & Ginger" \
    "1001 Nights" \
    "Strawberries & Cream" \
    "Nana Mint" \
    "Yogi Tea Lemon & Ginger" \
    "Raspberry & Mint" \
    )

if [[ -z $selected ]]
then
    exit 0;
fi

echo "$selected"

