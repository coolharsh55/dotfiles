#!/usr/bin/env bash

# Prints tomorrow's date
echo -n $(date +%d-%m-%Y -d "+1 days")
