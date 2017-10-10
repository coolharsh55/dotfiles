#!/usr/bin/env bash

# checks SSL certificate expiry
# dependency - openssl, grep, python (tested with 3)
# author: Harshvardhan Pandit
# email: me at harshp dot com

websites=(
    "harshp.com"
    "ethicscanvas.org"
    "portal.elsltd.com"
    "irishwatertesting.com"
)

for website in ${websites[*]}
do
    echo $website
    echo | openssl s_client -showcerts -servername $website -connect $website:443 2>/dev/null | openssl x509 -inform pem -noout -text | grep 'Not After' | python -c '''
import sys
line = sys.stdin.next()
line = line.strip()
line = line[12:]
from datetime import datetime, timedelta
expiry = datetime.strptime(line, "%b %d %H:%M:%S %Y GMT")
now = datetime.now()
diff = expiry - now
if diff.days < 7:
    print("Something is wrong with the cert renewal")
else:
    print("Everything looks okay for another {} days.".format(diff.days))
'''
done
