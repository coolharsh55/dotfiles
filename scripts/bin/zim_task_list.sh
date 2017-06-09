#!/usr/bin/env bash

# Generate task list for zim
# if no arguments, assume all Notebooks

if [ -z "$1" ]
then

	# Get dropbox folder location
	source ~/.env
	NOTEBOOK="${DROPBOX_FOLDER}/Notebooks/"

	# verify it exists
	if [ ! -d "$NOTEBOOK" ]
	then
	    echo "ERROR: Notebook does not exit"
	    exit 1;
	fi
else
	NOTEBOOK=$1
fi

# grep
# -r recursive
# -n line number
# -e pattern

grep -rn "$NOTEBOOK" -e '^\[ \]' | sort

# TODO: pipe this into a python script
# generate a nice report based on where the ToDo are
# level wise
# Put it in each folder's ToDo.html, this is the app directory
# not the Zim folders
# So that there is a master ToDo on the server
