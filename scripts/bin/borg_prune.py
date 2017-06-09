#!/usr/bin/env python3

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

from collections import namedtuple
from datetime import datetime
import re
import sys

# namedtuples are AWESOME!!!
Backup = namedtuple('Backup', ('name', 'timestamp'))

# list of backups
backups = []
# list of backups that will be removed
backups_remove = []

# read in the backups
# with open ('/home/harsh/Dropbox/backups.txt', 'r') as f:
#     lines = f.readlines()
#     for line in lines:
for line in sys.stdin:
    line = line.strip()
    backup_name, _, timestamp = re.split('(             )', line)
    timestamp = datetime.strptime(timestamp, '%a, %Y-%m-%d %H:%M:%S')
    backups.append(Backup(backup_name, timestamp))

backups.sort(key=lambda x: x[1], reverse=True)
# for backup in backups:
#     print(backup)
# sys.exit(0)

now = datetime.now()

backups_7days = []
backups_30days = []
backups_6months = []
backups_others = []

# extract backups within last 24 hours
for index in range(len(backups)):
    backup = backups[index]
    diff = now - backup.timestamp
    # print(backup.name, diff.days)
    # TODO
    # sort by tiem period
    # day = 0 for hourly
    # day = 7 for daily
    # day = 30 for monthly
    # day = 6 for bi-annually
    if diff.days < 7:
        backups_7days.append(backup)
    elif diff.days < 30:
        backups_30days.append(backup)
    elif diff.days < 180:
        backups_6months.append(backup)
    else:
        backups_others.append(backup)
# print('\n')

def print_backups(name, backups):
    print(name)
    for backup in backups:
        print(backup.name)
    print('\n')

# print_backups('hourly', backups_7days)
# print_backups('daily', backups_30days)
# print_backups('weekly', backups_6months)
# print_backups('monthly', backups_others)


def trim(backups, differentiator):
    trim_these = []
    for i in range(len(backups) - 1):
        diff = backups[i].timestamp - backups[i + 1].timestamp
        # print(backups[i].name, backups[i + 1].name, diff, diff.days, diff.seconds, differentiator(diff))
        if differentiator(diff):
            trim_these.append(backups[i + 1])
            i -= 1
    return trim_these

def print_backups_trim(_, backups):
    for backup in backups:
        print(backup.name)

print_backups_trim('hourly trimmed', trim(
    backups_7days, lambda d: d.seconds < 3600 and d.days == 0))
print_backups_trim('daily trimmed', trim(
    backups_30days, lambda d: d.days == 0 and d.seconds < 6 * 3600))
print_backups_trim('weekly trimmed', trim(
    backups_6months, lambda d: d.days < 7))

# TODO
# print only those backups that need to be trimmed
