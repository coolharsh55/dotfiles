#!/bin/bash

# TEXPANDER
# Snippet expander

# set base directory
# all files in base directory are considered to be individual snippets
base_dir="${HOME}/.snippets/"
# generate list of file names as snippet expanding abbreviations
abbrvs=$(ls "$base_dir")
# create zenity window with filename as lists
# zenity will return selected filename
name=$(zenity --list --title=SnippetExpander --column=Snippets $abbrvs)
# create filepath for selected file
path=$base_dir$name

copy_text_file() {
    if [[ "$(uname)" == "Linux" ]]; then
        xclip -selection c -i "$1"
    elif [[ "$(uname)" == "Darwin" ]]; then
        cat $1 | pbcopy
    fi
}

copy_sh_script() {
   # shellcheck source=/dev/null
   if [[ "$(uname)" == "Linux" ]]; then
        source "$1" | xclip -selection c
    elif [[ "$(uname)" == "Darwin" ]]; then
        source "$1" | pbcopy
    fi
}

copy_python_script() {
    if [[ "$(uname)" == "Linux" ]]; then
        python3 "$1" | xclip -selection c
    elif [[ "$(uname)" == "Darwin" ]]; then
        python3 "$1" | pbcopy
    fi
}

if [[ $name ]]
then
    if [[ "$(uname)" == "Linux" ]]; then
      # get PID of current process to paste into
      pid=$(xdotool getwindowfocus getwindowpid)
      # get process name from PID
      # shellcheck disable=SC2086
      proc_name=$(cat /proc/$pid/comm)
    fi
  # check if path is valid
  if [ -e "$path" ]
  then
    # copy existing clipboard into variable
    # clipboard=$(xclip -selection clipboard -o)

    # Based on file type, do different copy operations
    if [[ $name =~ \.txt$ ]]
    then
        # copy file contents into clipboard
        #xclip -selection c -i "$path"
        copy_text_file "$path"
    elif [[ $name =~ \.py$ ]]
    then
        copy_python_script "$path"
    else
        copy_sh_script "$path"
    fi
    
    if [[ "$(uname)" == "Linux" ]]; then
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
        #if [ -n "$clipboard" ]
        #then
        #    echo $clipboard | xclip -selection c
        #else
        #    xclip -section c -i /dev/null
        #fi
    fi
  else
    zenity --error --text="Abbreviation not found:\n$name"
  fi
fi

echo "done" >> /Users/harsh/log