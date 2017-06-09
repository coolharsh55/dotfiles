#!/usr/bin/env bash

# author: Harshvardhan Pandit
# selects scripts in ~/bin with prefix line_
# displays them using zenity
# executes selected script

# generate list of line scripts
abbrvs=$(find . -name 'line_*' -printf '%P\n' | sed 's/^line_//g')
# create zenity window with list
name="$(zenity --list --title=LineScripts --column=Script $abbrvs)"
# check for input
if [[ -z $name ]]
then
    exit 0;
fi
# remap selected script into filepath
path="line_${name}"
# shellcheck source=/dev/null
source $path
