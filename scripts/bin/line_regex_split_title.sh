#!/usr/bin/env bash
#author: Harshvardhan Pandit
#takes input from the clipboard and uses regex to separate words
#e.g. "ThisWord" will become "This Word"
#and puts the input back in to the clipboard

OS="$(uname)"
if [ "$OS" = "Linux" ]; then
  CLIP_IN="xclip -o -selection clipboard"
  CLIP_OUT="xclip -i -selection clipboard"
elif [ "$OS" = "Darwin" ]; then
  CLIP_IN="pbpaste"
  CLIP_OUT="pbcopy"
else
  echo "Unsupported OS: $OS"
  exit 1
fi

$CLIP_IN | sed -E 's/([a-z])([A-Z])/\1 \2/g' | $CLIP_OUT
