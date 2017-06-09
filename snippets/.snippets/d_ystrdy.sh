#!/usr/bin/env bash

# Prints yesterday's date
echo -n $(date +%d-%m-%Y -d "-1 days")
