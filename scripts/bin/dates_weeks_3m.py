#!/usr/bin/env python3
# prints 3months schedule by week, starting monday
# targets Zim

from datetime import datetime
from datetime import timedelta
from dateutil import rrule
import sys

if len(sys.argv) == 2:
    timespan = int(sys.argv[1])
else:
    timespan = 90

now = datetime.now()
monday = now + timedelta(-1 * now.weekday())
until = monday + timedelta(days=timespan)

for dt in rrule.rrule(rrule.WEEKLY, dtstart=monday, until=until):
    end = (dt + timedelta(days=6))
    # print(f'{dt.date()} - {end.date()}')
    print(f'{dt.strftime("%d-%b")} to {end.strftime("%d-%b")}')
