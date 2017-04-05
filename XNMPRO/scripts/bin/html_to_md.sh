#!/bin/bash
#author: Harshvardhan Pandit
#email: me@harshp.com

# Convert evernote html documents to markdown format
# store them in current directory with .txt extension

for file in evernote/*.html
do
    # strip extension
    filename=$(basename "$file" ".html")
    echo "$filename"
    # convert using pandoc
    pandoc "$file" -f HTML -t markdown-raw_html-native_divs-native_spans \
       -o "${filename}.txt"
done
