#!/usr/bin/env python
# author: Harshvardhan J. Pandit

import subprocess
content = subprocess.run("xclip -sel c -o", shell=True, capture_output=True)
content = content.stdout.decode().strip().title()
subprocess.run(f"echo \"{content}\" | xclip -sel c -i", shell=True)
