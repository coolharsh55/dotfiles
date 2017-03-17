#!/bin/bash

# Version: 1.1.1
# Release: November 22, 2016

base_dir="${HOME}/.snippets/"
abbrvs=$(ls $base_dir)
name=$(zenity --list --title=Texpander --column=Abbreviations $abbrvs)

path=$base_dir$name

if [[ $name ]]
then
  pid=$(xdotool getwindowfocus getwindowpid)
  proc_name=$(cat /proc/$pid/comm)

  if [ -e "$path" ]
  then
    clipboard=$(xclip -selection clipboard -o)
    xclip -selection c -i "$path"

    if [[ $proc_name =~ (terminal|terminator) ]]
    then
      xdotool key ctrl+shift+v
    else
      xdotool key ctrl+v
    fi

    echo $clipboard | xclip -selection c
  else
    zenity --error --text="Abbreviation not found:\n$name"
  fi
fi
