#!/usr/bin/env bash

# Create a zenity window with all of tags in Zim

# Get dropbox folder location
source ~/.env
NOTEBOOKS="${DROPBOX_FOLDER}/Notebooks/"

# verify it exists
if [ ! -d "$NOTEBOOKS" ]
then
    echo "ERROR: Notebook does not exit"
    exit 1;
fi

# get tags from notebook by parsing any word starting with @
# 1. grep
# grep options
# 	-a 	treat binary files as text
# 		for some reason, grep thinks that zim files are
# 		binary and prints messages that pollute the output
# 	-h 	does not print filenames
# 	-o 	outputs only matched characters
# 	-r 	recursively digs in subdirectories
# 2. sed
# replace the '@' character so that I don't have to type it
# in the gui/list/zenity
# 3. sort & uniq
# ensure that there is only one instance of a tag
TAGS=$(\
	grep -ahor \
	"@\w\+" \
	--include="*.txt" \
	"$NOTEBOOKS" \
	| sed -e 's/^@//g' \
	| sort | uniq)

# show a list using zenity, and get the selected tag
tag=$(zenity --list --title=Tags --column=tag $TAGS)
# if there is a selection, echo it with the @ symbol prefixed
if [[ -n "$tag" ]]
then
	echo "@$tag"
fi
