#!/usr/bin/env bash

# Replace tags in zim
# arg1: string to find
# arg2: string to replace
# arg3 (optional): location of notebook
# 		default is ALL Zim notebooks

# check arg1
if [ -z "$1" ]
then
	echo "First argument is the string to replace"
	exit 1;
fi
# check arg2
if [ -z "$1" ]
then
	echo "First argument is the string to replace"
	exit 1;
fi
# check arg3 (default is Zim folder)
if [ -z "$3" ]
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
	NOTEBOOK=$3
fi

# find
# 	-type f 	files
# 	-exec		execute for each file found
# 	sed			replace 
find "$NOTEBOOK" -type f -exec sed -i -e 's/${1}/${2}/g' {} \;
