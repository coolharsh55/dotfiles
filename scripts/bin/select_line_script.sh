#!/usr/bin/env bash

# author: Harshvardhan Pandit
# selects scripts in ~/bin with prefix line_
# displays them using zenity
# executes selected script

# generate list of line scripts
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    abbrvs=$(find -L ~/bin -name 'line_*' -printf '%P\n' | sed 's/^line_//g')
elif [[ "$OSTYPE" == "darwin"* ]]; then
    abbrvs=$(gfind -L ~/bin -name 'line_*' -printf '%P\n' | sed 's/^line_//g')
fi
# create zenity window with list
name="$(zenity --list --height=500 --title=LineScripts --column=Script $abbrvs)"
# check for input
if [[ -z $name ]]
then
    exit 0;
fi
# remap selected script into filepath
path="line_${name}"

if [[ $path == *.py ]] 
then
    python $path
else
    bash $path
fi
