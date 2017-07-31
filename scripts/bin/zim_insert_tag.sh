#!/usr/bin/env bash

# Create a zenity window with all of tags in Zim

TAGFILE=~/.local/share/zim/tags.list


# check if file exists
if [ ! -f "$TAGFILE" ]
then
	exit 0;
fi

TAGS=$(cat ${TAGFILE})

# show a list using zenity, and get the selected tag
tag=$(zenity --list --title=Tags --column=tag $TAGS)
# if there is a selection, echo it with the @ symbol prefixed
if [[ $tag ]]
then
    # get PID of current process to paste into
    pid=$(xdotool getwindowfocus getwindowpid)
    # get process name from PID
    # shellcheck disable=SC2086
    proc_name=$(cat /proc/$pid/comm)
    # check if path is valid
    # copy existing clipboard into variable
    clipboard=$(xclip -selection clipboard -o)
    
    printf "@$tag" | xclip -selection c

    # if in terminal, paste using terminal shortcut
    # otherwise paste using normal shortcut
    if [[ $proc_name =~ (terminal|terminator) ]]
    then
      xdotool key ctrl+shift+v
    else
      xdotool key ctrl+v
    fi
    
    # if clipboard was orignally empty, restore to empty state
    # otherwise return original contents back to clipboard
    if [ -n "$clipboard" ]
    then
        echo $clipboard | xclip -selection c
    else
        xclip -section c -i /dev/null
    fi
fi

