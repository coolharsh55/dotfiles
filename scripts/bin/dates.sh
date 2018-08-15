#!/bin/bash

# Prints current date
# echo -n "$(date +%d-%m-%Y)"

formats='today tomorrow yesterday monday tuesday wednesday thursday friday saturday sunday'

# zenity will return selected filename
format=$(zenity --list --title=SnippetExpander --column=Snippets $formats)

# provide date according to requested format
case "$format" in
    "today")
        value="$(date +%Y-%m-%d)"
        ;;
    "yesterday")
        value="$(date -d'-1 days' +%Y-%m-%d)"
        ;;
    "tomorrow")
        value="$(date -d'+1 days' +%Y-%m-%d)"
        ;;
    "monday")
        value="$(date -dnext-monday +%Y-%m-%d)"
        ;;
    "tuesday")
        value="$(date -dnext-tuesday +%Y-%m-%d)"
        ;;
    "wednesday")
        value="$(date -dnext-wednesday +%Y-%m-%d)"
        ;;
    "thursday")
        value="$(date -dnext-thursday +%Y-%m-%d)"
        ;;
    "friday")
        value="$(date -dnext-friday +%Y-%m-%d)"
        ;;
    "saturday")
        value="$(date -dnext-saturday +%Y-%m-%d)"
        ;;
    "sunday")
        value="$(date -dnext-sunday +%Y-%m-%d)"
        ;;
esac

echo -n "$value" | xclip -sel c
xdotool key ctrl+v
