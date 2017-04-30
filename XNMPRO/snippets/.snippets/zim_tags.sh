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
if [[ -n "$tag" ]]
then
	echo "@$tag"
fi
