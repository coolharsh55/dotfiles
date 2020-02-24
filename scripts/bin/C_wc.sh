#!/usr/bin/env bash
#word count from clipboard
#author: coolharsh55

xclip -sel c -o | wc -w
