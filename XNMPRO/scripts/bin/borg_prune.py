#!/usr/bin/env python

# BORG PRUNE LIST
# author: Harshvardhan Pandit

# keep backups for:
# hourly for last 7 days
# daily for last 30 days
# weekly for last 3 months
# monthly after that

# get list of backups
# parse timestamps from strings
# sort in descending order

# hourly
# establish date 7 days before
# continue while current stamp is within 7 days:
#   get two timestamps
#   if difference between both is less than an hour:
#     keep the later one (first)

# similar pattern for other time periods
# can write a generic function for the same
def trim_by_period(period, keep_until):
    now = timestamp
    backups = [b for b in backups if b.timestamp < keep_until)
    prune_list = []
    for index in range(0, len(backups) - 1):
        if backups[index].timestamp - backups[index + 1].timestamp < period:
               prune_list.append(backups[index + 1])
        
