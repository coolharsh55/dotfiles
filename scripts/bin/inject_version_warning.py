#!/usr/bin/env python3

import sys

def modify_html(filepath):
    with open(filepath, 'r') as file:
        content = file.read()

    div_code = f'''
        <div style="position: fixed; bottom: 0; left: 0; width: 100%; background-color: #ff3333; color: white; padding: 10px; text-align: center; font-size: 1rem; z-index: 999;">
            This version is outdated, see latest published version.
        </div>
        '''

    index = content.find('<h1')
    if index != -1:
        content = content[:index] + div_code + content[index:]

    with open(filepath, 'w') as file:
        file.write(content)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python inject_version_warning.py <html_file>")
        sys.exit(1)

    for filepath in sys.argv[1:]:
        modify_html(filepath)
