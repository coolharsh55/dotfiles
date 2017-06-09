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
    xclip -selection c -i "$1"
}

copy_sh_script() {
   # shellcheck source=/dev/null
   source "$1" | xclip -selection c
}

copy_python_script() {
    python3 "$1" | xclip -selection c
}

if [[ $name ]]
then
  # get PID of current process to paste into
  pid=$(xdotool getwindowfocus getwindowpid)
  # get process name from PID
  # shellcheck disable=SC2086
  proc_name=$(cat /proc/$pid/comm)
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
  else
    zenity --error --text="Abbreviation not found:\n$name"
  fi
fi
