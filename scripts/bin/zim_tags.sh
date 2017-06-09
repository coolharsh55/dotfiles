#!/usr/bin/env bash

# Store a list of Zim tags in location
# Meant to be cron-job
# Suggested time period - 30mins
# */30 * * * * ~/bin/zim_tags.sh >/dev/null 2>&1

TAGFILE=~/.local/share/zim/tags.list

# generate file containing tags
# store it in ~/.local/share/zim/tags.list

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
grep -ahor \
	"@\w\+" \
	--include="*.txt" \
	"$NOTEBOOKS" \
	| sed -e 's/^@//g' \
	| sort | uniq \
	> "$TAGFILE";
